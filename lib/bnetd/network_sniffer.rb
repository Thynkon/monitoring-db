require "packetgen"

module Bnetd
  class NetworkSniffer
    include Bnetd::Logging

    def initialize(interface: "lo")
      @interface = interface
    end

    def capture(filter:)
      logger.info("Listening on #{@interface}")
      PacketGen.capture(iface: @interface, filter: filter) do |p|
        logger.info("Captured packet: len => #{p.ip.length}, ip => #{p.ip.src}, port => #{p.tcp.sport}")
        yield p
      end
    end
  end
end
