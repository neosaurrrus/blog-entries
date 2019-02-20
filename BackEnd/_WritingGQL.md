# Editing your Schema

Make sure you define your objects in schema.graphql first:

```js
type Cat {
    name: String!
}
type Query {
    cats: [Cat]!
}
```

However where does the information come from? This is in the Query.js

# Creating resolvers in Query.js

```js
const Query = {
    cats(parent, args, ctx, info) {
        return [{name: 'Benji'}, {name: 'Max'}]
    }
};
```

Now if we do the following query we should see some cat names:

```js
query{
  cats {
    name
  }
}
``` 

And we do:

```js
{
  "data": {
    "cats": [
      {
        "name": "Benji"
      },
      {
        "name": "Max"
      }
    ]
  }
}
```

So let's look at a *Mutation*

In schema.graphql, add the following mutation:

```js
type Mutation {
    createCat(name: String!) : Cat
}
```




## Connecting up the Database

We have a bunch of files in our setup, it can be confusing so lets refresh:

`datamodel.graphql` - Prisma/DB Schema we edit
`prisma.graphql` - gets automatically generated from datamodel.graphql and contains lots of auto-created queries and mutations.
`schema.graphql` - public facing api. What people can actually interface with.


## datamodel.graphql

This is how we might add something to the schema:

```js 
type Item {
  id: ID! @id
  title: String!
  price: Int!
  createAt: DataTime! //prisma specific
}
```

Whenever we update the schema, we **have to** redeploy Prisma so that it is updated: `npm run deploy`

## prisma.graphql

If you have a look at this file after deployment, you will see that it is is updated. Prisma automatically creates queries for the item we just produced.

## schema.graphql

Here we can specify the queries we want to be public facing. Lets go with a simple create mutation and a simple view all:

```js
# import * from './generated/prisma.graphql'

type Mutation {
    createItem(title: String, description: String, price: Int, image: String, largeImage: String): Item!
}

type Query {
    items: [Item]!
}
```

Note the fancy way we can import prisma.graphql to have access to the code within. This allows us to write very short simple lines of code.

## Resolvers

Now we got a proper DB hookup. We need to write our resolvers. Let's add to the Mutation.js resolver file:

```js
 const Mutations = {
    async createCat(parent, args,ctx,info){
        //TODO Check if logged in
        const cat = await ctx.db.mutation.createCat({
            data: {
                ...args
            }
        }, info)
        return item;
    }
};

```

and here is a Query that looks at the DB:

```js
const Query = {
    async items(parent, args,ctx,info){
        const items = await ctx.db.query.items();
        return items;
    }
};

module.exports = Query;
```
