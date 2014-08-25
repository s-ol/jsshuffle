# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsshuffle/version'

Gem::Specification.new do |spec|
  spec.name          = "jsshuffle"
  spec.version       = JsShuffle::VERSION
  spec.authors       = ["S0lll0s / Sol Bekic"]
  spec.email         = ["s0lll0s@blinkenshell.org"]
  spec.summary       = %q{A library to just-in-time randomly obfuscate JS}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.6"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "rkelly-remix", "~> 0.0.6"

  spec.add_development_dependency "execjs", "~> 2.2.1"
end
