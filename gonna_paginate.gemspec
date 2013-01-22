# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'padrino-pagination/version'

Gem::Specification.new do |gem|
  gem.name          = "gonna_paginate"
  gem.version       = Padrino::Pagination::VERSION
  gem.authors       = ["sumskyi", "kucaahbe"]
  gem.email         = ["sumskyi@gmail.com"]
  gem.description   = %q{pagination for padrino}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'padrino', '>= 0' # TODO check versions
end
