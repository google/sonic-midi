Gem::Specification.new do |s|
  s.name        = 'sonic-midi'
  s.version     = '0.1.0'
  s.date        = '2017-09-14'
  s.summary     = "Dual Sonic Pi Midi music generator"
  s.description = "Command-line tool to generate Midi music also playable in Sonic Pi"
  s.authors     = ["David Airapetyan"]
  s.email       = 'davidair@google.com'
  s.files       = Dir['lib/**/*.rb']
  s.executables << "sonic_midi"
  s.homepage    = 'http://rubygems.org/gems/sonic-midi'
  s.license     = 'Apache-2.0'

  s.add_dependency 'commander', '~> 4'
  s.add_dependency 'midilib', '~> 2'
  s.add_dependency 'sonic-pi-cli', '~> 0'

end
