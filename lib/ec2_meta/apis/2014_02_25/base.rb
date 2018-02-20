# frozen_string_literal: true

module Ec2Meta
  module Api20140225
    module Base
      def self.extended(obj)
        obj.extend Ec2Meta::Api20140225::MetaData
      end
    end
  end
end
