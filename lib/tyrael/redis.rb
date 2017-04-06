# frozen_string_literal: true

module Tyrael
  class Redis
    def self.call
      new.call
    end

    def call
      push_or_pop
    end

    private

    attr_reader :redis

    def push_or_pop
      if range_size < APP_MAX
        redis.rpush(:test_key, 'val')
      else
        redis.lpop(:test_key)
      end

      range_size.to_s
    end

    def redis
      @redis ||= ::Redis.new
    end

    def range_size
      redis.lrange(:test_key, 0, 100).size
    end
  end
end
