# frozen_string_literal: true

require_relative 'lib/moments/version'

Gem::Specification.new do |spec|
  spec.name        = 'moments'
  spec.version     = Moments.gem_version
  spec.authors     = ['Tim Rudat']
  spec.email       = ['timrudat@gmail.com']
  spec.summary     = 'Handles time differences.'
  spec.description = ''
  spec.homepage    = 'https://github.com/excpt/moments'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1', '< 3'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.86.0'
end
