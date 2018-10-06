require './lib/alghemy/version'

Gem::Specification.new do |s|
  s.name        = "alghemy"
  s.version     = Alghemy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Mervin Reinhardt'
  s.email       = 'm.reinahrdt@gmx.co.uk'

  s.homepage    = 'https://github.com/JC-Morph/alghemy'
  s.summary     = %q{Transmute your data with ease.}
  s.description = %q{A Ruby DSL for manipulating data with artistic purpose.}
  s.license     = 'GPL-3.0'

  # Included files
  s.files = Dir['lib/**/*.rb', 'license', 'readme.md']
  s.executables << 'alghemy'

  # Gem dependencies
  s.add_runtime_dependency 'dry-container'
  s.add_runtime_dependency 'listen', '~> 3.0'
  s.add_runtime_depency 'wdm', '>= 0.1.0'

  # Prevent pushing to RubyGems.org
  s.metadata["allowed_push_host"] = '' if s.respond_to?(:metadata)
end
