module Ec2Meta
  class NullLogger
    def debug(_progname = nil, &_block)
    end

    def debug?
      false
    end

    def error(_progname = nil, &_block); end

    def error?
      false
    end

    def fatal(_progname = nil, &_block)
    end

    def fatal?
      false
    end

    def info(_progname = nil, &_block)
    end

    def info?
      false
    end
  end
end
