require "mongo"

module Bnetd
  class DbConnector
    def initialize(host, port, database)
      @client = Mongo::Client.new(["#{host}:#{port}"], database: database)
    end

    def insert(collection, data)
      @client[collection].insert_one(data)
    end
  end
end
