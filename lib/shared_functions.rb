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

def repa(array, x)
  result = []
  (1..x).each do
    result.concat(array)
  end
  return result
end

def rep(value, times)
  return Array.new(times, value)
end

def clone(array)
  return [].replace(array)
end

Q = 0.25
H = 0.5
F = 1
