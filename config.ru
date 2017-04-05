# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative './lib/tyrael/cassandra'
require_relative './lib/tyrael/mongodb'
require_relative './lib/tyrael/redis'

class TyraelApp
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /mongodb/
      [200, { 'Content-Type' => 'text/plain' }, [Tyrael::Mongodb.call]]
    when /keyspace/
      [200, { 'Content-Type' => 'text/plain' }, [Tyrael::Cassandra.new.ensure_keyspace_exists]]
    when /cassandra/
      [200, { 'Content-Type' => 'text/plain' }, [Tyrael::Cassandra.call]]
    when /redis/
      [200, { 'Content-Type' => 'text/plain' }, [Tyrael::Redis.call]]
    else
      [404, { 'Content-Type' => 'text/plain' }, ["I'm Lost!"]]
    end
  end
end

run TyraelApp.new
