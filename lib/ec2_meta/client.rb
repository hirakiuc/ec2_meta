# frozen_string_literal: true

module Ec2Meta
  class Client
    def initialize(options = {})
      @options = {
        api_version: '2014-02-25'
      }.merge(options)

      load_api_module
    end

    private

    def fetcher
      return @fetcher if @fetcher
      @fetcher = Fetcher.new(@options)
    end

    def load_api_module
      extend ApiLoader.api_module(@options[:api_version])
    end
  end
end
