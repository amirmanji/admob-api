# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'admob-api/version'

Gem::Specification.new do |spec|
  spec.name          = 'admob-api'
  spec.version       = AdMobApi::VERSION
  spec.authors       = ['mako2x']
  spec.email         = ['arekara3nen@gmail.com']
  spec.description   = %q{A Ruby interface to the Admob API}
  spec.summary       = %q{A Ruby interface to the Admob API}
  spec.homepage      = 'https://github.com/mako2x/admob-api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_dependency             'httpclient'
  spec.add_dependency             'hashie'
  spec.add_dependency             'quarter_time'
end
