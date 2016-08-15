# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gutsy/version'

Gem::Specification.new do |spec|
  spec.name          = "gutsy"
  spec.version       = Gutsy::VERSION
  spec.authors       = ["Max Fierke"]
  spec.email         = ["max.fierke@iorahealth.com"]

  spec.summary       = "Generates heroics-powered API client gem wrappers from JSON Schema"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/IoraHealth/gutsy"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.executables << 'gutsy'

  spec.add_runtime_dependency "heroics", "~> 0.0.17"
  spec.add_runtime_dependency "json_schema", "~> 0.13"
  spec.add_runtime_dependency "activesupport", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
