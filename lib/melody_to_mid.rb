#! /usr/bin/env ruby

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'midilib/sequence'
require 'midilib/consts'
include MIDI

##
# Converts a programmatically-defined melody to Midi.
class MelodyToMidi

  ##
  # Adds a single note of a specified pitch, volume and duration to track at position time_offset.
  # Make sure to call track.recalc_delta_from_times() after all notes have been added.
  private def add_note(track, note, time_offset, duration, volume)
    event = NoteOn.new(0, note, volume, 0)
    event.time_from_start = time_offset
    track.events << event
    event = NoteOff.new(0, note, volume, 0)
    event.time_from_start = time_offset + duration
    track.events << event
  end

  ##
  # Adds a melody to track.
  # The melody is specified as an an array containg up to three sub-arrays:
  # - List of pitches (as MIDI notes. eg: 60 is C4)
  # - List of durations (as fractions of a measure. eg: 0.25 is a quarter)
  # - (Optional) list of volumes (0..5 range)
  private def add_to_track(track, melody)
    time_offset = 0
    (0..melody[0].length-1).each do |i|
      note = melody[0][i].to_i
      duration = (480 * melody[1][i]).to_i
      volume = 127
      if melody.length >= 3
        volume = ((127 * melody[2][i]) / 5).to_i
      end
      if note != 0
        add_note(track, note, time_offset, duration, volume)
      end
      time_offset += duration
    end
  end

  ##
  # Adds a melody to the track.
  # The melody object can optionally contain sub-melodies if specified as a dictionary.
  # For example, it can be of the form {m1: ..., m2: ..., m3: ...}
  # Alternatively, the melody object can be a single melody (see add_to_track for details).
  private def process_melody(track, melody)
    if melody.respond_to?(:key)
      melody.values().each do |m|
        add_to_track(track, m)
      end
    elsif melody.respond_to?(:length)
      add_to_track(track, melody)
    end
    track.recalc_delta_from_times()
  end

  ##
  # Creates a Midi file from a ruby program defining a melody.
  # It writes its output to the path specified by +output_file+.
  #
  # +melody_file+ is expected to contain the following functions:
  #   melody() - contains a melody (see process_melody for details)
  #   mybpm() - optional, sets the BPM (or default to 60 if not specified)
  def make_midi(melody_file, output_file)
    seq = Sequence.new()

    require_relative 'shared_functions'
    load melody_file

    track = Track.new(seq)
    seq.tracks << track
    bpm = 60
    if defined? mybpm
      bpm = mybpm()
    end
    track.events << Tempo.new(Tempo.bpm_to_mpq(bpm))
    track.events << MetaEvent.new(META_SEQ_NAME, 'Sequence Name')

    track = Track.new(seq)
    seq.tracks << track

    track.name = 'Melody Track'
    track.instrument = GM_PATCH_NAMES[0]

    track.events << Controller.new(0, CC_VOLUME, 127)
    track.events << ProgramChange.new(0, 1, 0)

    process_melody(track, melody())

    File.open(output_file, 'wb') { |file| seq.write(file) }
  end
end
