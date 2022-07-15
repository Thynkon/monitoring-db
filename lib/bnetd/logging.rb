require "logger"

# Reference: https://stackoverflow.com/a/23508304
module Bnetd
  module Logging
    class << self
      attr_writer :logger

      def logger
        unless @logger
          @logger = Logger.new($stdout)
          @logger.formatter = proc do |severity, datetime, _progname, msg|
            "[#{datetime}] #{severity} : #{msg}\n"
          end
        end

        @logger
      end
    end

    # Addition
    def self.included(base)
      class << base
        def logger
          Logging.logger
        end
      end
    end

    def logger
      Logging.logger
    end
  end
end
