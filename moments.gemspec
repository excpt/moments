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
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5'

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'github_changelog_generator', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.1'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.57'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.25'
  spec.add_development_dependency 'timecop', '~> 0.9.8'
end
