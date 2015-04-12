require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'webmock/rspec'

require 'pry'

if ENV['COVERAGE']
  require 'coveralls'
  require 'simplecov'
  Coveralls.wear!

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    add_filter '.bundle/'
    add_filter 'spec'
  end
end

if ENV['CODECLIMATE_REPORT']
  WebMock.disable_net_connect!(allow: 'codeclimate.com')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ec2_meta'

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'
end
