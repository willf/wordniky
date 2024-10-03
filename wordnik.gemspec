# frozen_string_literal: true

module Wordnik
  VERSION = '1.0.0-beta.1'
end

Gem::Specification.new do |s|
  s.name        = 'Wordniky'
  s.version     = Wordnik::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Will Fitzgerald']
  s.email       = ['willf@noreply.github.com']
  s.homepage    = 'https://github.com/willf/wordniknik'
  s.summary     = 'A ruby wrapper for the Wordnik API'
  s.description = 'This gem provides a simple interface to the Wordnik API.'

  s.rubyforge_project = 'Wordniky'

  s.add_dependency 'json'

  s.add_development_dependency 'faraday'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'yard'

  s.files         = Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.test_files    = Dir.glob('spec/**/*')
  s.metadata      = { 'source_code_uri' => 'https://github.com/willf/wordniky' }

  s.required_ruby_version = '>= 3.0.0'
end
