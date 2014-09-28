# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "line_up/version"

Gem::Specification.new do |spec|
  spec.name          = "line_up"
  spec.version       = LineUp::VERSION
  spec.authors       = ["Michael Crismali"]
  spec.email         = ["michael.crismali@gmail.com"]
  spec.summary       = %q{Makes it easy to reorder ActiveRecord records}
  spec.description   = %q{Makes it easy to reorder ActiveRecord records}
  spec.homepage      = "https://github.com/crismali/line_up"
  spec.license       = "Apache"

  spec.files         = Dir["lib/**/*", "LICENSE", "README.md"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0.0"
  spec.add_dependency "activesupport", ">= 4.0.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
