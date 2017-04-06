# Tyrael

* `docker-compose up --build`
* `guard`

## Endpoints

* `/keyspace` - creates Cassandra keyspace and table
* `/cassandra` - inserts into Cassandra or truncates above APP_MAX
* `/mongodb` - inserts into MongoDB or drops collection above APP_MAX
* `/redis` - inserts into Redis or flushes above APP_MAX
