# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'zero-fix18'
  s.version = ZeroFix18::VERSION.dup

  s.authors  = ['Gibheer', 'Stormwind']
  s.email    = 'gibheer@gmail.com'
  s.license  = '3-clause BSD'
  s.summary  = 'Ruby 1.8 fixes for zero'
  s.description = 'This little gem shall it make possible to run zero with ruby 1.8.'
  s.homepage = 'http://github.com/libzero/zero-fix18'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(README.md)

  s.rubygems_version = '1.8.24'
end
