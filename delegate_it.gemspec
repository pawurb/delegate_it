# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'delegate_it/version'

Gem::Specification.new do |gem|
  gem.name          = "delegate_it"
  gem.version       = DelegateIt::VERSION
  gem.authors       = ["pawurb"]
  gem.email         = ["p.urbanek89@gmail.com"]
  gem.summary       = %q{ A drop in replacement for ActiveSupport delegate method in non Rails projects. }
  gem.description   = %q{ delegate_it gem provides an easy way to use ActiveSupport like delegate method in your non Rails projects. }
  gem.homepage      = "http://github.com/pawurb/delegate_it"
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "coveralls"
end
