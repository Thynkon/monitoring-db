#!/usr/bin/env ruby

require 'packetgen'
require 'optparse'
require 'concurrent'
require_relative './parser'
require_relative './db_connector'

Options = Struct.new(:interface)
parser = Parser.new(ARGV)
options = parser.parse

database_name = options[:database_name]

database_host = '127.0.0.1'
database_host = options[:database_host] unless options[:database_host].nil?

database_port = 27_017
database_port = options[:database_port] unless options[:database_port].nil?

interface = options[:interface]

ports = options[:ports]

pool = Concurrent::ThreadPoolExecutor.new(
  min_threads: [2, Concurrent.processor_count].max,
  max_threads: [2, Concurrent.processor_count].max,
  max_queue: [2, Concurrent.processor_count].max * 5,
  fallback_policy: :caller_runs
)

ports.each do |port|
  pool.post do
    connector = DbConnector.new(database_host, database_port, database_name)
    PacketGen.capture(iface: interface, filter: "src port #{port}") do |raw_packets|
      connector.insert(:nic_protocol_traffic, {
                         ip: raw_packets.ip.src,
                         pkt_len: raw_packets.ip.length,
                         ts: Time.new.utc.to_i,
                         port: port,
                         iface: interface
                       })
    end
  end
end

pool.shutdown
pool.wait_for_termination
