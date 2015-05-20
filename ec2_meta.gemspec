# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ec2_meta/version'

Gem::Specification.new do |spec|
  spec.name          = 'ec2_meta'
  spec.version       = Ec2Meta::VERSION
  spec.authors       = ['daisuke.hirakiuchi']
  spec.email         = ['devops@leonisand.co']
  spec.licenses      = ['MIT']

  spec.summary       = 'AWS Metadata API client library'
  spec.description   = 'AWS Metadata API client library. This gem is available only on AWS EC2 instance.'
  spec.homepage      = 'https://github.com/leonis/ec2_meta'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rspec-mocks', '~> 3.2'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'rubocop', '~> 0.30'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'yardstick', '~> 0.9'
end
