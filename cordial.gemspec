# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cordial/version"

Gem::Specification.new do |spec|
  spec.name          = "cordial"
  spec.version       = Cordial::VERSION
  spec.authors       = ["Andrew Hood"]
  spec.email         = ["andrewhood125@gmail.com"]

  spec.summary       = "Cordial API Client"
  spec.description   = "Wraps the Cordial REST API for use inside Ruby applications."
  spec.homepage      = "https://github.com/MeUndies/cordial"

  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.16"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "dotenv", "~> 2.4"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "webmock", "~> 3.4.0"
end
