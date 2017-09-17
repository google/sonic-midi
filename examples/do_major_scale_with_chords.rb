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

def mybpm()
  return 60
end

def mysynth()
  return :piano
end

def m1()
  notes = [60, 62, 64, 65, 67, 69, 71, 72]
  times = rep(Q, notes.length)
  return notes, times
end

def m2()
  notes = [64, 0, 64]
  times = [Q, 6 * Q, Q]
  return notes, times
end

def m3()
  notes = [67, 0, 67]
  times = [Q, 6 * Q, Q]
  return notes, times
end

def melody()
  return { m1: m1(), m2: m2(), m3: m3() }
end

