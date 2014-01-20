# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transmogriffy/version'

Gem::Specification.new do |spec|
  spec.name          = "transmogriffy"
  spec.version       = Transmogriffy::VERSION
  spec.authors       = ["W. Andrew Loe III"]
  spec.email         = ["andrew@andrewloe.com"]
  spec.description   = %q{Import tickets from Lighthouse into Github.}
  spec.summary       = %q{Import tickets from Lighthouse into Github.}
  spec.homepage      = "https://github.com/loe/transmogriffy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  spec.add_runtime_dependency "json"
end
