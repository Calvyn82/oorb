# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oorb/version'

Gem::Specification.new do |spec|
  spec.name          = "oorb"
  spec.version       = Oorb::VERSION
  spec.authors       = ["Calvyn82"]
  spec.email         = ["claytonflesher@gmail.com"]

  spec.summary       = %q{Command line app to convert input to OCR Optimized Regular Expressions}
  spec.description   = %q{Command line app to covnert input to OCR Optimized Regular Expressions}
  spec.homepage      = "https://github.com/Calvyn82/oorb"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["oorb"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
