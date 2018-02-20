# frozen_string_literal: true

require 'logger'

require 'ec2_meta/version'
require 'ec2_meta/client'
require 'ec2_meta/loader'
require 'ec2_meta/cache'
require 'ec2_meta/fetcher'
require 'ec2_meta/null_logger'
require 'ec2_meta/apis/path.rb'

require 'ec2_meta/apis/2014_02_25/base'
require 'ec2_meta/apis/2014_02_25/meta_data'

module Ec2Meta
  # Your code goes here...
  class << self
    attr_reader :options

    def client(options = {})
      opts = {
        logger: ::Ec2Meta::NullLogger.new
      }.merge(options)

      Client.new(opts)
    end
  end
end
