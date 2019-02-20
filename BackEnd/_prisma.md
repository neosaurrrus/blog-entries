# What is Prisma?

What is Prisma? Well [this page](https://www.prisma.io/blog/introducing-prisma-1ff423fd629e) explains it better than I could.

I think you need to know what Graphql is and how it works to really appreciate what Prisma is doing but essentially it is a layer that sits in front of your data and automatically generates methods that allow you to work with your data model quickly.

## Running it locally on Windows 10.

I forgot to write this bit as I was going. So this is based on my memory of it abotu a week later but the very basic version is:

1. Install Docker, if you are using Home edition there is an older version which uses Oracle Virtualbox rather than Hyper-V.
2. Using CMDer, `npm install docker-compose`. I had some issues with the default IP addresses being available. so in the `docker-compose.yml` file I changed them. I also needed to refer to the machines own IP rather than localhost. Probably easily fixable but... I didn't.
3. That should get the local side of things sorted so `prisma init` in a folder you want it in and follow the instructions.


## Launching our prisma server

1. Launch docker, this launches the VM which holds the server
2. USing CMDer run "prisma deploy --env-file variables.env" (you can stick this in scripts to save you hassle.)

## Playing with the schema

The graphql schema is found in `datamodel.prisma` you can change this based on GraphQL rules

## Some basic commands 

Just as a reference to myself here are some basic graphql commands:

*Find with arguments*
`{
  users (where: {
    name_contains : "John"})
    {
    name
    email
  }
}`
  
*Create User*
```
mutation {
  createUser(data: {
    name: "John"
    email: "john@gmail.com"
  }){
    name
    email
  }
}
```

```
{
  usersConnection {
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
    aggregate {
      count
    }
  }
}
```

## Using Environment variables

Its a good idea.


