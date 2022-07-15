require "mongo"

module Bnetd
  class DbConnector
    include Logging

    def initialize(host, port, database)
      logger.info("Connecting to mongodb database => #{database} as #{host}@#{port}")
      @client = Mongo::Client.new(["#{host}:#{port}"], database: database)
    end

    def insert(collection, data)
      logger.info("Inserting data into #{collection}")
      @client[collection].insert_one(data)
      logger.info("Data successfully inserted")
    end
  end
end
