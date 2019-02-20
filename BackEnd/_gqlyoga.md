# What is graphQL-Yoga?

Last time I looked at Prisma which essentially was a GraphQL Database Interface, handling some of the manually wiring we'd normally do.

It's all well and good querying, and doing CRUD operations but if we want to do more with our data...you'll see we need something like Yoga.

Yoga is build on top of Express and Apollo Server but with extra GraphQL chops.


[https://github.com/prisma/graphql-yoga](It's GitHub Page)

We are also using prisma-binding for allow JS talking to Prisma when not using the playground.

## Setting up Prisma-bindings

Got decent instruction on the GitHub but here is what I did.

1. In the src folder, create db.js
2. Add the following lines:

```js
const { Prisma } = require ('prisma-binding');

const db = new Prisma ({
    typeDefs: 'src/generated/prisma.graphql',
    endpoint: process.env.PRISMA_ENDPOINT,
    secret: process.env.PRISMA_SECRET,
    debug: true
});

module.exports = db;
```

## Setting up GraphQL Yoga Server

1. In src createServer.js and add the following:

```js
const { GraphQLServer} = require('graphql-yoga');
const Mutation = require('./resolvers/Mutation')
const Query = require('./resolvers/Query')
const db = require('./db')


// Create the GraphQL server

function createServer() {
    return new GraphQLServer({
        typeDefs: 'src/schema.graphql',
        resolvers: {
            Mutation,
            Query
        },
        resolverValidationOptions: {
            requireResolversForResolveType: false,
        },
        context: req =>  ({...req, db})
    })
}

module.exports = createServer;
```

2. Create db.js file and enter the following:

```js
//This file connects to the Prisma DB. It lets us query it with JS
const { Prisma } = require ('prisma-binding');

const db = new Prisma ({
    typeDefs: 'src/generated/prisma.graphql',
    endpoint: process.env.PRISMA_ENDPOINT,
    secret: process.env.PRISMA_SECRET,
    debug: true
});

module.exports = db;
```

Note that you need Prisma-binding installed.

3. Hook it up in index.js and get node started:

```js
require('dotenv').config({path: 'variables.env'})
const createServer = require('./createServer');
const db = require('./db');
const server = createServer();

//TODO Use Express middleware to handle cookies (JWT)
//TODO Use Express middleware to populate current user

server.start({
    cors: {
        credentials: true,
        origin: process.env.FRONTEND_URL
    }
}, info => {
    console.log(`Server is go on ${info.port}` );
})
```
