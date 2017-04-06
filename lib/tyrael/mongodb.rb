# frozen_string_literal: true

module Tyrael
  class Mongodb
    DOC = { name: 'Tyrael', hobbies: %w(hiking tennis fly fishing) }.freeze

    def self.call
      new.call
    end

    def call
      insert
      collection.drop if collection_count > APP_MAX
      collection_count.to_s
    end

    private

    def mongodb
      @mongodb ||= Mongo::Client.new('mongodb://127.0.0.1:27017/test')
    end

    def collection
      mongodb[:test_collection]
    end

    def insert
      collection.insert_one(DOC)
    end

    def collection_count
      collection.count
    end
  end
end
