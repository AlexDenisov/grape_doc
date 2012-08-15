# -*- encoding: utf-8 -*-
require File.expand_path('../lib/grape_doc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Denisov"]
  gem.email         = ["1101.debian@gmail.com"]
  gem.description   = %q{Documentation generator for Grape API}
  gem.summary       = %q{Documentation generator for Grape API}
  gem.homepage      = "https://github.com/AlexDenisov/grape_doc"
  gem.files         = `git ls-files`.split($\)
  gem.executables << "grape_doc"
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "grape_doc"
  gem.require_paths = ["lib"]
  gem.version       = GrapeDoc::VERSION
  gem.add_runtime_dependency 'grape', '~> 0.2', '>= 0.2.1'
  gem.add_runtime_dependency 'json', '~> 1.7', '>= 1.7.4'
  gem.add_development_dependency 'rspec', '~> 2.11'
end
