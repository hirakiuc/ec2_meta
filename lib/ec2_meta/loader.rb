# frozen_string_literal: true

module Ec2Meta
  class NotSupported < StandardError; end

  class ApiLoader
    def self.api_module(api_version)
      raise 'require valid api_version' if api_version.nil? || api_version.empty?

      api_namespace = Ec2Meta.const_get('Api' + api_version.delete('-'))
      api_namespace.const_get('Base')
    rescue NameError
      raise NotSupported, "Not Supported the api_version: #{api_version}"
    end
  end
end
