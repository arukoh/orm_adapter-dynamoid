# -*- encoding: utf-8 -*-
require File.expand_path('../lib/orm_adapter-dynamoid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = "arukoh"
  gem.email         = "arukoh10@gmail.com"
  gem.description   = "Adds dynamoid (https://github.com/Veraticus/Dynamoid) adapter to orm_adapter (https://github.com/ianwhite/orm_adapter/) which provides a single point of entry for using basic features of popular ruby ORMs."
  gem.summary       = "Adds dynamoid ORM adapter to the orm_adapter project"
  gem.homepage      = "https://github.com/arukoh/orm_adapter-dynamoid"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "orm_adapter-dynamoid"
  gem.require_paths = ["lib"]
  gem.version       = OrmAdapter::Dynamoid::VERSION
  
  gem.add_dependency "orm_adapter"
  gem.add_dependency "dynamoid", ">= 0.4.1"

  gem.add_development_dependency "rake", ">= 0.8.7"
  gem.add_development_dependency "rspec", ">= 2.4.0"
end
