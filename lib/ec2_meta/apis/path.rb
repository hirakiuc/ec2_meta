module Ec2Meta
  module Api
    class Path < BasicObject
      attr_reader :prefix

      def initialize(fetcher, prefix = [])
        @_fetcher = fetcher
        @prefix = (prefix.is_a?(::String) ? [prefix] : prefix)
      end

      private

      def fetch(path)
        fetcher.fetch(request_path(path))
      end

      def request_path(path)
        path_prefix = prefix.empty? ? '' : '/' + prefix.join('/')
        path_prefix + '/' + path
      end

      def new_prefix(part)
        prefix.dup << part
      end

      def fetcher
        @_fetcher
      end
    end
  end
end
