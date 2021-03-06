# GraphQL with Dart

This article is about using the [graphql](https://pub.dev/packages/graphql) package for standalone dart applications, or alternatively, 
using it for a Flutter application where you want to go lower level and not use the 
[graphql_flutter](https://pub.dev/packages/graphql_flutter) higher level package. The example program here is a Dart CLI program. Check out the code (described below) to see a reasonably straightforward implementation of query, mutation and subscription requests.

The intent here is to provide very simple working code that contains examples of how to use a query, a mutation and a subscription in a standalone Dart application. 

## A Graphql server

See the top level [README.md](../README.md) has instructions on  running the graphql server that is included in this repo.

## Schema

Here is the schema that the server implements;

```graphql

  # query for one or all users
  type Query {
    user(id: ID): User  
    users: [User!]! 
  }

  # create and delete a user
  type Mutation {
    createUser(data: CreateUserInput): User!
    deleteUser(id: ID!): User!
  }

  # subscribe to createUser events
  type Subscription {
    user: UserSubscriptionPayload 
  }

  # data required to create a user
  input CreateUserInput {
    name: String!
    email: String!
  }

  # definition of a User
  type User {
    id: ID!
    name: String!
    email: String!
  }

  # definition of the subscription return data
  type UserSubscriptionPayload {
    data: User!
  }
```

## Dart Application 

The main function is in bin/main.dart. It does the following:

- creates the graphql client with a WebSocketLink(required for subscriptions). The alternative is an HttpLink if the app doesn't need subscriptions. A WebSocketLink works for all operations, but a difference is that the WebSocketLink holds a connection open and will reconnect to the server if the connection is lost. If you don't need to subscribe and you don't want the app holding a persistent connection then user HttpLink which supports queries and mutations.

- subscribes to createUser events and listens for them
- creates four users and prints the results. the subscription events should fire also and print something.
- queries for a list of users then prints them
- issues an erroneous query to test error handling.

The rest of the code is in lib. It is structured in separate files each containing one of the concerns.

### lib/user.dart

Contains a definition of the **User** type and its constructors.

### lib/query.dart

This file contains two functions:

  - query :  a function to dispatch a generic query request
  - getUsers : dispatches the specific query for a list of users.

### lib/mutate.dart

This file contains two functions
  
  - mutate : a function to dispatch a generic mutation request
  - createUser : dispatches the specific 'createUser' operation.

### list/subscribe.dart

This file contains two functions

  - subscription : a function to dispatch a generic subscription request
  - subscribeUsers : dispatches the subscription to listen for crated users.

## Running the code

  - Have Dart installed in the command line path.
  - cd info dart-example
  - get dependencies with 'pub get'
  - run the program '>dart bin/main.dart

That should get some output showing what happened.

## Restarting the server

if you run the program twice in a row, you will get 'duplicate email' warnings since the server
already has the users created. That's a good test, but if you want to rerun from scratch just restart
the server.

