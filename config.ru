# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

APP_MAX = 10_000

require_relative './lib/tyrael/cassandra'
require_relative './lib/tyrael/mongodb'
require_relative './lib/tyrael/redis'

class TyraelApp < Rack::App
  error StandardError, NoMethodError do |ex|
    { error: ex.message }
  end

  get 'keyspace' do
    Tyrael::Cassandra.new.ensure_keyspace_exists
  end

  get 'cassandra' do
    Tyrael::Cassandra.call
  end

  get 'mongodb' do
    Tyrael::Mongodb.call
  end

  get '/redis' do
    Tyrael::Redis.call
  end
end

run TyraelApp
