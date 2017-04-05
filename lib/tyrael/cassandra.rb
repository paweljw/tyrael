# frozen_string_literal: true

module Tyrael
  class Cassandra
    def self.call
      new.call
    end

    def call
      count_future = session.execute_async('SELECT COUNT (*) FROM tyrael;')
      count_future.on_success do |rows|
        puts rows.inspect
      end
      count_future.join
    end

    def ensure_keyspace_exists
      cluster.connect.execute('CREATE KEYSPACE IF NOT EXISTS tyrael ' \
        "WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3}")
      'OK'
    end

    private

    def cluster
      @cassandra ||= ::Cassandra.cluster(hosts: ['::1'], username: 'cassandra',
                                         password: 'password123', compression: :snappy)
    end

    def session
      @session ||= cluster.connect('tyrael')
    end
  end
end
