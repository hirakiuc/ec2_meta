# frozen_string_literal: true

module Ec2Meta
  class Cache
    def initialize
      @cache = {}
    end

    def write(key, value)
      @cache[key.to_s] = value
    end

    def read(key)
      @cache[key.to_s]
    end

    def fetch(key)
      return read(key) if exist?(key)

      raise ArgumentError, 'require block' unless block_given?

      value = yield
      write(key, value)
    end

    def exist?(key)
      @cache.key?(key.to_s)
    end

    def delete(key)
      @cache.delete(key)
    end

    def clear
      @cache.clear
    end
  end
end
