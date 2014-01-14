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
 - [riak_json_ruby_client](https://github.com/basho-labs/riak_json_ruby_client) and
   [riak_json-active_model](https://github.com/dmitrizagidulin/rj-activemodel) gems installed locally.
   (See [rj-activemodel Installation section](https://github.com/dmitrizagidulin/rj-activemodel#installation) for instructions on both)

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

## Screenshots
Forums:
![](https://www.dropbox.com/s/u3txl1jcfh02yxg/Screenshot%202014-01-14%2016.15.50.png "Forums index view")

Threaded messages in a discussion:
![](https://www.dropbox.com/s/pzexiaaqgfpb9bs/Screenshot%202014-01-14%2016.20.22.png "Discussion show view")
