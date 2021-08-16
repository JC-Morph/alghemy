require './lib/alghemy/version'

Gem::Specification.new do |s|
  s.name        = 'alghemy'
  s.version     = Alghemy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'JC Morph'
  s.email       = 'jc_morph@caramail.com'

  s.homepage    = 'https://github.com/JC-Morph/alghemy'
  s.summary     = %q{Transmute your data with ease.}
  s.description = %q{A Ruby DSL for manipulating data with artistic purpose.}
  s.license     = 'GPL-3.0'

  # Included files
  s.files       = Dir['lib/**/*.rb', 'license', 'readme.md']
  s.executables << 'alghemy'
end
