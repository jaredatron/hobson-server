# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hobson-server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jared Grippe"]
  gem.email         = ["jared@deadlyicon.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hobson-server"
  gem.require_paths = ["lib"]
  gem.version       = Hobson::Server::VERSION

  gem.add_runtime_dependency 'ohm', '>=1.0.2'
  gem.add_runtime_dependency 'activemodel'

  gem.add_development_dependency 'rspec'
end
