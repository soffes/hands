# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hands/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Sam Soffes']
  gem.email         = ['sam@soff.es']
  gem.description   = 'Simple library for various poker hands calculations.'
  gem.summary       = 'Simple library for various poker hands calculations.'
  gem.homepage      = 'http://github.com/soffes/hands'
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'hands'
  gem.require_paths = ['lib']
  gem.version       = Hands::VERSION

  gem.required_ruby_version = '>= 1.9.2'
end
