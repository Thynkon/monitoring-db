#!/usr/bin/env ruby

require 'packetgen'
require 'mongo'
require 'optparse'
require_relative './parser.rb'

Options = Struct.new(:interface)
parser = Parser.new(ARGV)
options = parser.parse

database_name = options[:database_name]

database_host = "127.0.0.1"
database_host = options[:database_host] if !options[:database_host].nil?

database_port = 27017
database_port = options[:database_port] if !options[:database_port].nil?

interface = options[:interface]

ports = options[:ports]
if ports.length >= 5
  STDERR.puts "You can only listen up to 5 ports!"
  STDERR.puts "Exiting..."
  exit 1
end

client = Mongo::Client.new(["#{database_host}:#{database_port}"], database: database_name)
nic_protocol_traffic = client[:nic_protocol_traffic]

ports.each do |port|
  thread = Thread.new do
    PacketGen.capture(iface: interface, filter: "src port #{port}") do |raw_packets|
      result = nic_protocol_traffic.insert_one(
        {
          ip: raw_packets.ip.src,
          pkt_len: raw_packets.ip.length,
          ts: Time.new.utc.to_i,
          port: port,
          iface: interface,
        }
      )
    end
  end

  thread.join
end
