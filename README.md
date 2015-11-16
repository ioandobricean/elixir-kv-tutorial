# KV - Key Value project


##Built a complete Elixir application, with its own supervision tree, configuration, tests and more.

###The application works as a distributed key-value store. 
###The key-value pairs are organized into buckets and those buckets are distributed across multiple nodes. 

There is simple client that allows us to connect to any of those nodes and send requests such as:

```
CREATE shopping
OK

PUT shopping milk 1
OK

PUT shopping eggs 3
OK

GET shopping milk
1
OK

DELETE shopping eggs
OK
```

[Tutorial for learning Elixir language](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
