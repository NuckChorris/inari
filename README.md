# Hermes

Hermes is an experimental [json:api][jsonapi]-to-[GraphQL][graphql] proxy server, allowing json:api clients to interact with a GraphQL server.

[jsonapi]: http://jsonapi.org/
[graphql]: http://graphql.org/

## Why?

Even though GraphQL is completely dominating the JavaScript ecosystem at this point, json:api is still in use by many in the Ember.js ecosystem.  I was getting tired of having to build my own solutions for things which the GraphQL ecosystem already had, such as schema stitching, subresource pagination, heterogenous storage, or complexity analysis.

In the end, it's significantly easier to build a proxy server (named Hermes!) and gradually switch to GraphQL.

## How?

GraphQL provides thorough introspection, so most of the schema can be directly loaded from the upstream GraphQL servers.  For the most part, json:api and GraphQL can be directly converted for querying.  For modifying data, however, json:api has implicit actions on a resource (create/read/update/delete) while GraphQL has a more flexible mutations system.

The goal is to create a config with as much implicitly pulled from the GraphQL server as possible, like this:

```elixir
use Hermes.Router

resource User,
  create: fn obj ->
    {:createMessage, struct(UserInput, obj)}
  end,
  update: fn obj ->
    {:updateMessage, struct(UserInput, obj)}
  end
```
