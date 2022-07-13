class Parser
  def initialize(opts)
    @options = opts
    @args = {}
  end

  private
  def set_options!
    @opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: #{$0} [options]'

      opts.on('-dDATABASE', '--database-name=DATABASE', 'The name of your mongodb database') do |d|
        @args[:database_name] = d
      end

      opts.on('-HHOST', '--database-host=DATABASE', 'The host of your mongodb database') do |h|
        @args[:database_host] = h
      end

      opts.on('-iINTERFACE', '--interface=INTERFACE', 'The interface name to get stats from') do |i|
        @args[:interface] = i
      end

      opts.on('-pPORT', '--port=PORT', 'The port this script must listen to') do |p|
        if @args[:ports].nil?
          @args[:ports] = [p]
        else
          @args[:ports].push(p)
        end
      end

      opts.on('-PPORT', '--database-portPORT', 'The port of your mongodb database') do |p|
        @args[:database_port] = p
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end
  end

  public
  def parse()
    set_options!

    @opt_parser.parse!(@options)
    if @args[:database_name].nil?
      raise  RequiredArgmentException.new "You must specify the name of your mongodb database!"
    end

    if @args[:interface].nil?
      raise RequiredArgmentException.new "You must specify a network interface to listen on!"
    end

    if @args[:ports].nil? or @args[:ports].empty?
      raise RequiredArgmentException.new "You must specify at least a port to listen on!"
    end

    return @args
  end
end
