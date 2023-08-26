require './lib/alghemy/version'

Gem::Specification.new do |s|
  s.name        = 'alghemy'
  s.version     = Alghemy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'JC Morph'
  s.email       = 'jc_morph@caramail.com'

  s.homepage    = 'https://github.com/JC-Morph/alghemy'
  s.summary     = %q{Transmute your data with ease.}
  s.description = %q{A Ruby library for manipulating files with artistic purpose.}
  s.license     = 'GPL-3.0'

  # Included files
  s.files       = Dir['lib/**/*.rb', 'license', 'readme.md']
  s.executables << 'alghemy'

  s.add_dependency 'bandoleer',   '~> 0.2.1'
  s.add_dependency 'canister',    '~> 0.9.1'
  s.add_dependency 'fuzzy_match', '~> 2.1.0'
  s.add_dependency 'listen',      '~> 3.8.0'
  s.add_dependency 'paint',       '~> 2.3.0'
  s.add_dependency 'pxlsrt',      '~> 1.8.2'
end
