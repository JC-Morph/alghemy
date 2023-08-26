# frozen_string_literal: true

require './lib/alghemy/version'

Gem::Specification.new do |s|
  s.name     = 'alghemy'
  s.version  = Alghemy::VERSION
  s.platform = Gem::Platform::RUBY
  s.author   = 'JC-Morph'
  s.email    = 'jc_morph@caramail.com'
  s.license  = 'GPL-3.0'

  s.homepage    = 'https://github.com/JC-Morph/alghemy'
  s.summary     = 'Transmute your data with ease.'
  s.description = 'A Ruby library for manipulating files with artistic purpose.'

  s.files = Dir['lib/**/*.rb', 'license', 'readme.md']
  s.executables << 'alghemy'

  # Dependencies
  s.add_dependency 'bandoleer',   '~> 0.2.1'
  s.add_dependency 'canister',    '~> 0.9.1'
  s.add_dependency 'fuzzy_match', '~> 2.1.0'
  s.add_dependency 'listen',      '~> 3.8.0'
  s.add_dependency 'paint',       '~> 2.3.0'
  s.add_dependency 'pxlsrt',      '~> 1.8.2'

  # Metadata
  s.metadata['homepage_uri']    = s.homepage
  s.metadata['source_code_uri'] = s.homepage
  s.metadata['rubygems_mfa_required'] = 'true'

  s.required_ruby_version = '>= 3.0.0'
  s.signing_key = Gem.default_key_path
  s.cert_chain  = [Gem.default_cert_path]
end
