module Wordnik
  VERSION = "0.0.1"
end


Gem::Specification.new do |s|
  s.name        = "Wordnik"
  s.version     = Wordnik::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Will Fitzgerald"]
  s.email       = ["willf@noreply.github.com"]
  s.homepage    = "https://github.com/willf/wordnik"
  s.summary     = %q{A ruby wrapper for the Wordnik API}
  s.description = %q{This gem provides a simple interface to the Wordnik API.}

  s.rubyforge_project = "Wordnik"

  s.add_dependency 'json'
  s.add_dependency 'faraday'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'autotest'
  s.add_development_dependency 'autotest-rails-pure'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'ruby-prof'


  s.files         = Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.test_files    = Dir.glob("spec/**/*")
  s.metadata      = { "source_code_uri" => "https://github.com/willf/wordnik" }

  s.required_ruby_version = '>= 3.0.0'
end
