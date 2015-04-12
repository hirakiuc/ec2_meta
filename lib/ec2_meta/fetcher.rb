require 'net/http'
require 'timeout'

module Ec2Meta
  class MetaNotFound < StandardError; end

  class Fetcher
    API_HOST = '169.254.169.254'.freeze
    API_VERSION = '2014-02-25'.freeze

    def initialize(options = {})
      @options = options
    end

    def fetch(path)
      res = http_client.get(request_path(path))
      fail MetaNotFound if res.code == '404'
      res.body
    rescue Timeout::Error => e
      logger.error 'Can\'t fetch EC2 metadata from EC2 METADATA API.'
      logger.error 'ec2_meta gem is only available on AWS EC2 instance.'
      raise e
    rescue MetaNotFound => e
      raise e
    rescue => e
      logger.error "Can't fetch EC2 metadata from EC2 METADATA API.(#{e.message})"
      logger.error e.backtrace.join("\n")
      raise e
    end

    private

    def logger
      @options[:logger]
    end

    def http_client
      return @http_client unless @http_client.nil?

      @http_client = Net::HTTP.new(API_HOST)
      @http_client.open_timeout = @options[:open_timeout] || 2.0
      @http_client.read_timeout = @options[:read_timeout] || 2.0

      @http_client
    end

    def request_path(path)
      '/' + API_VERSION + path
    end
  end
end
