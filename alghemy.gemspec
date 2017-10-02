require_relative 'lib/alghemy/version'

Gem::Specification.new do |s|
  s.name        = "alghemy"
  s.version     = Alghemy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Mervin Reinhardt'
  s.email       = 'm.reinahrdt@gmx.co.uk'

  s.homepage    = 'https://github.com/JC-Morph/alghemy'
  s.summary     = %q{Transmute your data with ease.}
  s.description = %q{A Ruby library for manipulating data with artistic purpose.}
  s.license     = 'GPL-3.0'

  # Included files
  s.files = Dir['lib/**/*.rb', 'license', 'readme.md']
  s.executables << 'alghemy'

  # Gem dependencies
  s.add_runtime_dependency 'listen', '~> 3.0'

  # Prevent pushing to RubyGems.org
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = ''
  end
end
