require "packetgen"

module Bnetd
  class NetworkSniffer
    def initialize(interface: "lo")
      @interface = interface
    end

    def capture(filter:)
      PacketGen.capture(iface: @interface, filter: filter) { |p| yield p }
    end
  end
end
