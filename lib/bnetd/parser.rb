class Parser
  def self.parse(options)
    args = {}

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: #{$0} [options]'

      opts.on('-dDATABASE', '--database-name=DATABASE', 'The name of your mongodb database') do |d|
        args[:database_name] = d
      end

      opts.on('-HHOST', '--database-host=DATABASE', 'The host of your mongodb database') do |h|
        args[:database_host] = h
      end

      opts.on('-iINTERFACE', '--interface=INTERFACE', 'The interface name to get stats from') do |i|
        args[:interface] = i
      end

      opts.on('-pPORT', '--port=PORT', 'The port this script must listen to') do |p|
        if args[:ports].nil?
          args[:ports] = [p]
        else
          args[:ports].push(p)
        end
      end

      opts.on('-PPORT', '--database-portPORT', 'The port of your mongodb database') do |p|
        args[:database_port] = p
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end
