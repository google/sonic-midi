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

if ARGV.length != 2
  puts 'Usage: melody_to_mid_param melody.rb output.mid'
end

$LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'lib')

require 'midilib/sequence'
require 'midilib/consts'
include MIDI

seq = Sequence.new()


melody_file = ARGV[0]
output_file = ARGV[1]

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

music = melody()

delta_time = 0
(0..music[0].length-1).each do |i|
  note = music[0][i].to_i
  duration = (480 * music[1][i]).to_i
  if note == 0
    delta_time = duration
  else
    track.events << NoteOn.new(0, note, 127, delta_time)
    track.events << NoteOff.new(0, note, 127, duration)
    delta_time = 0
  end
end

File.open(output_file, 'wb') { |file| seq.write(file) }
