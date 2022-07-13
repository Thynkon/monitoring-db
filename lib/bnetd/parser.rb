require "optparse"
module Bnetd
  class Parser
    def initialize(opts)
      @options = opts
      @args = {
        database_host: "127.0.0.1",
        database_port: 27_017,
      }
    end

    private

    def set_options!
      @opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: #{$0} [options]'

        opts.on("-d", "--database-name=DATABASE", "The name of your mongodb database") do |d|
          @args[:database_name] = d
        end

        opts.on("-H", "--database-host=DATABASE", "The host of your mongodb database") do |h|
          @args[:database_host] = h
        end

        opts.on("-i", "--interface=INTERFACE", "The interface name to get stats from") do |i|
          @args[:interface] = i
        end

        opts.on("-p", "--port=PORT", "The port this script must listen to") do |p|
          if @args[:ports].nil?
            @args[:ports] = [p]
          else
            @args[:ports].push(p)
          end
        end

        opts.on("-P", "--database-port=PORT", Integer, "The port of your mongodb database") do |p|
          @args[:database_port] = p
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end
    end

    public

    def parse!
      set_options!

      @opt_parser.parse!(@options)
      if @args[:database_name].nil?
        raise Bnetd::RequiredArgumentException, "You must specify the name of your mongodb database!"
      end

      if @args[:interface].nil?
        raise Bnetd::RequiredArgumentException, "You must specify a network interface to listen on!"
      end

      if @args[:ports].nil? || @args[:ports].empty?
        raise Bnetd::RequiredArgumentException, "You must specify at least a port to listen on!"
      end

      @args
    end
  end
end
