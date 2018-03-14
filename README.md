# Inari

Inari is an experimental [json:api][jsonapi]-to-[GraphQL][graphql] proxy server, allowing json:api clients to interact with a GraphQL server.

[jsonapi]: http://jsonapi.org/
[graphql]: http://graphql.org/

## Why?

Even though GraphQL is completely dominating the JavaScript ecosystem at this point, json:api is still in use by many in the Ember.js ecosystem.  I was getting tired of having to build my own solutions for things which the GraphQL ecosystem already had, such as schema stitching, subresource pagination, heterogenous storage, or complexity analysis.

In the end, it's significantly easier to build a proxy server (named Inari!) and gradually switch to GraphQL.

## How?

### Mapping Schemas

GraphQL provides thorough introspection, so most of the schema can be directly loaded from the upstream GraphQL servers.  For the most part, json:api and GraphQL can be directly converted for querying.  For modifying data, however, json:api has implicit actions on a resource (create/read/update/delete) while GraphQL has a more flexible mutations system.

The goal is to create a config with as much implicitly pulled from the GraphQL server as possible, like this:

```elixir
use Inari.Router

resource User,
  create: fn obj ->
    {:createMessage, struct(UserInput, obj)}
  end,
  update: fn obj ->
    {:updateMessage, struct(UserInput, obj)}
  end
```

### Generating GraphQL

To avoid excessive string-mangling, Inari builds up a GraphQL AST while parsing the json:api request and then serializes that into a string which is sent to an upstream GraphQL endpoint.

The AST consists of four-tuples (quads) of the node type, the name for the node, a type-specific arguments object, and a list of children.  The node type and child list are required, and must never be nil.  The arguments can be any type, and the name is . The following is a list of AST node types:

```elixir
@type t :: {atom(), binary() | nil, any(), [t]}
# Represents a whole GraphQL document
{:document, nil, nil, children}
# A query with no name (anonymous query)
# "query { ... }"
{:query, nil, nil, children}
# A query with a name
# "query name { ... }"
{:query, name, nil, children}
# A field with a name and optionally an alias and list of field args
# "alias: name(arguments) { ... }"
{:field, name, {alias, arguments}, children}
# A fragment with a name and type
# "fragment name on type { ... }"
{:fragment, name, type, []}
# Using a fragment by name
# "...fragment"
{:spread, name, nil, []}
# Enumerated type usage
# "VALUE"
{:enum, value, nil, nil}
```

### Converting responses to json:api

Conversion from GraphQL response objects (nested tree) to json:api (flattened tree) is done by always requesting the `__typename` on every single object.  With that, Inari can figure out which resource every object represents, and flattening the associations can be done by recursing into the tree.  Not every GraphQL resource has an `id`, however, which presents an issue for json:api which mandates its presence.  To solve this, the Inari server can be provided a function to generate an id for a GraphQL object.
