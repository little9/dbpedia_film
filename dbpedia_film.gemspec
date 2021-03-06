# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbpedia_film/version'

Gem::Specification.new do |spec|
  spec.name          = "dbpedia_film"
  spec.version       = DbpediaFilm::VERSION
  spec.authors       = ["Jamie Little"]
  spec.email         = ["jamielittle@outlook.com"]
  spec.license       = 	"Apache-2.0"
  spec.summary       = "A gem for getting film metadata from DBPedia"
  spec.homepage      = "https://github.com/little9/dbpedia_film/"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "sparql"

end
