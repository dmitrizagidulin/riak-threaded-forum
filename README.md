Riak Threaded Forum
===================

A proof of concept threaded discussion forum 
using [RiakJson](https://github.com/basho-labs/riak_json) ([Riak](https://github.com/basho/riak) + 
[Solr](https://github.com/basho/yokozuna) + 
[RiakJson Ruby Client](https://github.com/basho-labs/riak_json_ruby_client))

## Dependencies
 - Ruby 1.9+
 - Rails 4
 - Riak 2.0+ (with Search and [RiakJson](https://github.com/basho-labs/riak_json) enabled)
 - [riak_json_ruby_client](https://github.com/basho-labs/riak_json_ruby_client) gem installed locally
 - [riak_json-active_model](https://github.com/dmitrizagidulin/rj-activemodel) gem installed locally

## Unit testing
Make sure a RiakJson server is listening at ```http://localhost:8098``` 
(required for integration tests).

Seed the collections with required records:
```
rake db:seed
```
Run all tests:
```
rake test
```
Just the unit tests:
```
rake test TEST=test/models/*
```