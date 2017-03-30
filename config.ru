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
      [200, {"Content-Type" => "text/html"}, [Tyrael::Mongodb.call]]
    when /cassandra/
      [500, {"Content-Type" => "text/html"}, [Tyrael::Cassandra.call]]
    when /redis/
      [500, {"Content-Type" => "text/html"}, [Tyrael::Redis.call]]
    else
      [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
    end
  end
end

run TyraelApp.new
