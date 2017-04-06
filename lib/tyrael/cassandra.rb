# frozen_string_literal: true

module Tyrael
  class Cassandra
    def self.call
      new.call
    end

    def call
      if placements_count > APP_MAX
        empty_placements
      else
        insert_placement
      end
      placements_count.to_s
    end

    def ensure_keyspace_exists
      session(nil).execute('CREATE KEYSPACE IF NOT EXISTS tyrael ' \
        "WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3}")
      ensure_table_exists
      'OK'
    end

    def ensure_table_exists
      cql = <<CASSIE
      CREATE TABLE IF NOT EXISTS placements (
        url text PRIMARY KEY,
        visited_at timestamp,
      );
CASSIE
      session(nil).execute(cql)
    end

    private

    def cluster
      @cassandra ||= ::Cassandra.cluster(hosts: ['::1'], username: 'cassandra',
                                         password: 'password123', compression: :snappy)
    end

    def session(keyspace)
      @session ||= {}
      @session[keyspace] ||= cluster.connect('tyrael')
    end

    def placements_count
      session('tyrael').execute('SELECT COUNT (*) FROM placements;').first['count']
    end

    def empty_placements
      session('tyrael').execute('TRUNCATE placements;')
    end

    def insert_placement
      session('tyrael').execute('INSERT INTO placements (url, visited_at) ' \
        "VALUES ('#{SecureRandom.uuid})', toTimestamp(now()));")
    end
  end
end
