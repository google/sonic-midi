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


##
# Plays a single melody in SonicPi.
def play_melody(m)
  in_thread do
    set_volume! 5
    if defined? mybpm
      use_bpm mybpm()
    end
    if defined? mysynth
      use_synth mysynth()
    end
  
    (0..m[0].length-1).each do |i|
      if m.length > 2
        set_volume! m[2][i]
      end
      if m[0][i] != 0
        play m[0][i]
      end
      sleep m[1][i]
    end
  end
end

##
# Plays a melody in SonicPi, optionally supporting multiple sub-melodies in parallel.
def sonic_play
  melody = melody()
  if melody.respond_to?(:key)
    melody.values().each do |m|
      play_melody(m)
    end
  elsif melody.respond_to?(:length)
    play_melody(melody)
  end
end
