Setting up a graph QL server can be pretty complex. This is my guide to getting it up and running for a simple app. 

# Backend

I'll skip over the inital bits.

## The very basics
- Created Folders
- npm init
- installed express
- got basic express
- set up git and github

## GraphQL setup.
- installed graphql and express-graphql
- imported them
- set up first route = app.use("graphql", graphqlHTTP)

### Schema setup

- Make folder and file called schema
- import graphql

The schema sets out:

1. What types the database should contain.
2. The relationships between them, 
3. Defining root queries, a description how how user can access the graph

We cant just use JS Objects and Strings to define it. We need to use GraphQL versions so we need to get access to them from graphql to use them:

`import { GraphQLObjectType,GraphQLString,GraphQLSchem} from "graphql"`


### Defining a Type

You can make a type like so:

```js
driverType = new GraphQLObjectType({
    name:"Driver",
    fields: () => ({
        id: {type: GraphQLString},
        firstName: {type: GraphQLString},
        lastName: {type: GraphQLString},
        nationality: {type: GraphQLString}
    })
});
```


### Defining a Root Query

A Root Query exists to give users (such as a front end) a way to talk to GraphQL. To do this we need to define:

1. What type we are looking for
2. Any arguments the user needs to provide so we can find the relevant thing such as an id
3. A resolver function that actually does the job of going to the DB and grabbing the information.

An example looks like this:

```js
const RootQuery = new GraphQLObjectType({
    name: "RootQueryType",
    fields: {
        driver:{
            type: driverType,
            args: {id: {type: GraphQLString}}, //what they need to provide
            resolve(parent, args){
                //code to get data from DB /or whatever
            }
        }
    }
});
```

Once you have done this, finally you have to export the schema to be used elsewhere:

`export default new GraphQLSchema({query: RootQuery})`

(I like to have the schema in a seperate const, for the sake of clarity)

### Building the Resolve Function

The resolve part of the RootQuery does the magic of going to a DB or other data source and retrieing the data to resolve the query.

It doesnt have to be a DB, lets take the following array:

```js
const drivers = [
    {
        id: "1",
        firstName: "Lewis",
        lastName: "Hamilton",
        nationality: "British"
    },
    {
        id: "2",
        firstName: "Valteri",
        lastName: "Bottas",
        nationality: "Finnish"
    },
    {   
        id: "3",
        firstName: "Sebastian",
        lastName: "Vettel",
        nationality: "German"
    }
];
```

For this we can write the following resolver function when we query a driver:

```js
 resolve(parent, args){
                //code to get data from DB /or whatever
                return drivers.find( (driver) => {
                    if (driver.id === args.id) return driver
                })
```

### Finishing the Schema

Lastly you want to export the query: `export default schema;`

And then we can use the schema in our endpoint in our app.ejs:

```js
app.use("/graphql", graphqlHTTP({
    schema
}));
```

If all has gone to plan, you should get a message saying basically: `Must provide query string`

So it can find the schema now, but now it wants a query string hmmm

## Providing a query String

So when it says that you need a query string, what it is saying is that you haven't asked it any question yet so it doesnt know what to do. So lets make a query.

We cant (easily) query it by just going to the URL, we need to talk to it in the right way. This is likely to be our front-end application but we have a tool to avoid us having to write a whole front end just to test a query. Enter **Graphiql**

if we add `graphiql:true` to the graphqlHTTP object, when we goto the url we instead will see a graphiQl tool that we can use.

GraphQL Playground is a standalong desktop application you can also install to do the same thing if you point it as the same endpoint.

Here, this is a typical query we could do:

```js
{
    driver(id:"1"){ //Note: it must be double quotes
        firstName
    }
}

//if it goes well it should return something like:
{
  "data": {
    "driver": {
      "firstName": "Lewis"
    }
  }
}
```

Graphiql is pretty cool, also note the ability to view docs which guides you to the types of queries are possible, what arguments are needed.

### Making a Proper ID

The ID is currently a string, but really we should be using the ID field. This is easy enough as it just requires a type of `GraphQLID` which is part of graphQL.

Once you have it imported, we need to change the reference in the type and also the resolver to have it working.

## Creating a 2nd Type

Now lets specify some Formula 1 teams. This requires three things:

1. A Teams Array
2. Teams Object Type 
3. Teams Resolver 

This looks like this: 

```js
const teams = [
    {
        name: "Mercedes",
        founded: 1954.
        id: '1'
    },
    {
        name: "Ferrari",
        founded: 1947,
        id: '2'
    }
]

const teamType = new GraphQLObjectType({
    name: "Team",
    fields: () => ({
        id: {
            type: GraphQLID
        },
        name: {
            type: GraphQLString
        },
        founded: {
            type: GraphQLInt
        }
    })
});

// Part of the RootQueries
teams: {
            type: teamType,
            args: {
                id: {
                    type: GraphQLID
                }
            }, //what they need to provide
            resolve(parent, args) {
                //code to get data from DB /or whatever
                return teams.find((team) => {
                    if (team.id === args.id) return team;
                });
            }
        }
```

### Hooking up Drivers to Teams - Type Relations

So far so good, lets begin hooking up some relationships and make this a graph.

So, for non-F1 fans out there. A few of our drivers will belong to one team, and some to another. We need to hook it up accordingly so that relationship is shown.

1. Add the relationship to each driver array object via ids:

```js
{
    id: "1",
    teamId: "1",
    firstName: "Lewis",
    lastName: "Hamilton",
    nationality: "British"
}
```

2. Add the team as a field in the driverType. The type it will be is a ... teamType! This is where we use the parent argument to provide the teamID. Here is the new driver type:

```js
const driverType = new GraphQLObjectType({
    name:"Driver",
    fields: () => ({
        id: {type: GraphQLID},
        firstName: {type: GraphQLString},
        lastName: {type: GraphQLString},
        nationality: {type: GraphQLString},
        team: {
                type: teamType,
                resolve(parent, args){
                     return teams.find((team) => {
                         if (team.id === parent.teamId) return team;
                     });
                }

            }
    })
});
```
y
FYI, in case you wondered...you make fields a function due to a quirk of JS i am going to explain badly. If it were just an object, it would not  be able to reference the other types and then error out. By making it a function it doesnt run till the schema file has been read top to bottom.
If it all went to plan you should be use to use the following query and get the results shown:

```js
//Query
{
  driver(id: "2"){
    firstName
    team{
      name
    }
  }
}
//Results
{
  "data": {
    "driver": {
      "firstName": "Valteri",
      "team": {
        "name": "Mercedes"
      }
    }
  }
}
```

Pretty cool! We should probably get the drivers if we query teams too...So lets do that. 

But wait. Whereas Drivers only driver for one team, a team may have multiple drivers and how do we say we need multiple `driverType`'s?

**We need a GraphQLList**

So thats another thing to import from GraphQL.

Once you have done that you can set that as the type like so:

`drivers: {type: new GraphQLList(driverType)}`

We need to say what this list of driverTypes will consist of, so it needs a resolver function. Since we want all the drivers for a given team, our resolver will look like this:

```js
resolve(parent, args){
                     return teams.find((team) => {
                         if (team.id === parent.teamId) return team;
                     });
                }
```

So lets test it out!

```js
{
  team(id:"1"){
    name
    drivers{
      firstName
    }
  }
}

// This will return...

{
  "data": {
    "team": {
      "name": "Mercedes",
      "drivers": [
        {
          "firstName": "Lewis"
        },
        {
          "firstName": "Valteri"
        }
      ]
    }
  }
}
```

### Returning all things

So far we have looked at returning a given item when giving an id as an argument. But its fairly common to want to return all of a given Type. So lets set up some queries that do just that.

If we look at our root queries, we can add a drivers query as follows:

```js
drivers: {
    type: new GraphQLList(driverType),
    resolve(parent, args)
        return drivers
    }
}
```

This pattern can be used for Teams in a similar way. Its that easy!





# Moving from Arrays to a Database

Ok, we have used an array for Drivers and Teams, but really we want to have a database to keep things more permanently. There is a douzen ways of doing this but I am going to install a local mongoose database. 

## Installing Mongodb

mLab is probably easier but I do alot fo work offline so it is more useful for me. Since this is highly variable i'll do the short version of this.

1. `npm install -g mongodb
2. Try and get it working with `mongod`. If it fails because of saying data/db not found then, it might be a permissioning issue like I had. Can grant permissions or use sudo.
3. While we are on the subject we might as well install mongoose which will give us some easier methods to interact with our DB.

4. in App.js (or in a seperate file) do something like this:

```js
const mongo = require('mongodb').MongoClient;
const mongoose = require("mongoose");
const url = 'mongodb://localhost:27017/formula1';

mongoose.connect(url);
//need code to check connection here
```

## The Mongodb Models

We need to define the data stored within Mongodb. So lets make a schema for 2 mongodb models for team and driver.

In a folder called models we can create a js file for both `driver.js` and `team.js`.

1. First each of them requires mongoose so lets require that: `const mongoose = require('mongoose')`

2. A model consists of a schema and a collection name, so lets make the schema:

```js
const driverSchema = new mongoose.Schema({
    firstName: String,
    lastName: String,
    nationality: String,,
    teamId: String
})
```

3. Lets create the model: `const driverModel = mongoose.model('Driver', driverSchema);`

4. Finally export it: `module.exports = driverModel`

I think you get the idea of how the teams model would look like.

If you are eagle-eyed you'd notice the lack of ID. This is because mongodb will handle that for these items.

## Using our models

If we go back to the schema.js, i.e the graphql schema. We can use these models instead of the placeholder arrays, and we need to change our resolver functions to query the database. Once we import them of course.

But wait... they wont be able to query anything useful from a blank database will they? Hmm we better change that...

## Mutations

Mutations are all about making a change. Creating, Updating or Deleting pretty much. Like our RootQuery we need to define our mutations.

Here is now we would do an addTeam mutation:

```js
const Mutation = new GraphQLObjectType({
    name: 'Mutation',
    fields: {
        addTeam: {
            type: teamType, //What are we making?
            args: {         //What details are you providing?
                name: {type: GraphQLString},
                founded: {type: GraphQLInt}
            }, 
            resolve(parent, args){
                let team = new Team({ //Use the Team model defined in the DB plugging in arg values
                    name: args.name,
                    founded: args.founded
                })
                return team.save(); //Save it to DB and provide the result back
            }
        }
    }
});
```

Boom, we are now creating teams on the Database through GraphQL. Lets make some drivers...

```js
addDriver: {
            type: driverType,
            args: {
                firstName: {type: GraphQLString},
                lastName: {type: GraphQLString},
                nationality: {type: GraphQLString},
                teamId:   {type: GraphQLID}
            },
            resolve(parent,args){
                let driver = new Driver({
                    firstName: args.firstName,
                    lastName: args.lastName,
                    nationality: args.nationality,
                    teamId: args.teamId
                })
                return driver.save();
            }
        }
```

So we got the mutations working with the database. However the queries' resolve function also need updating so lets do that...

## Query Resolve functions using a database

So we have two different types of resolve function:

- Find One Driver/Team
- Find All Driver/Team

Here is where mongoose makes life easier:

Find all:

`resolve(parent, args) {return Driver.find()}`

Find one:

`resolve(parent, args){return Driver.findById(args.id)}`


## Non-null values

Right now when we do a mutation, you don't have to provide certain fields. This obviously isnt good when all friends are required

We can enforce by using a GraphQL feature called `GraphQLNonNull`

First we grab it from GraphQL, as you can see we are grabbing a lot:

```js
const {
    GraphQLObjectType,
    GraphQLString,
    GraphQLSchema,
    GraphQLID,
    GraphQLInt,
    GraphQLList,
    GraphQLNonNull
} =  graphql;
```

Once we got it working it is a case of wrapping our Add mutation arguments with it like so:



# Front-end magic!

Ok, so we have a database with a graphql server where we can mutate and query items.

Normally we want to use that information in a web app which exists on the front end.

We will be using React as our framework. We will first aim to create:

- A driver list component to show our drivers
- An add driver component to add a driver


These will need to talk to graphql to be able do this. Enter Apollo:

By default Javascript doesnt understand graphql. Apollo is a mechanism to be able to talk to graphql and a few other goodies along the way.

Apollo uses React so we need to get React up and running first

## Our React Platform - NextJS

There is alot of ways to get React up and running, for a little bit of a change this time around I will be using NextJS so lets get that up and running. I could write this up but really the [next docs](https://nextjs.org/docs/) does a pretty good job of the basic setup so lets assume you have a home page up and running.

## The basics
Since I have other posts about React, this might be a light till we get to the GraphQL bits

My Component Structure in React is like this:

- App (Our Parent Container)
    - DriversList (Lists our drivers)
    - TeamsList (Lists out Teams)

Both of these just contain an unordered lsit with a placeholder item.

## Enter Apollo

Apollo will be our GraphQL client that will be link between React and GraphQL. Lets get it installed first of all, again you are best referring to the Apollo Docs for this. Perhaps even do the little tutorial they have?

`npm install apollo-boost react-apollo graphql`

## Setting up Apollo in our App

1. Lets import Apollo:

`import ApolloClient from 'apollo-boost'`

2. Set up Apollo to use the GraphQL endpoint:

```js
const client = new ApolloClient({
    uri: "http://localhost:5000/graphql/"
})
```
3. Add Apollo Provider which makes React work with it

First import it:

`import { ApolloProvider } from 'react-apollo'`

Then wrap our JSX code within <ApolloProvider> tags. Here is our whole component:

## Errors!

Now I am not sure if this is my setup or not but I had to do a few more things to get it working.

1. Install `node-fetch` (I think globally)
2. Import it and tweak the client set up like so:

```js
const client = new ApolloClient({
        uri: "http://localhost:4000/graphQL",
        fetch: fetch

})
```

I assume this is a Next thing but I have no idea. Must learn some more...

## Our first Apollo Query

So we have our DriversList component, we want it to return the drivers we have.

1. Import libraries
2. Make Query
3. Bind Query to the Component

So this will look like this:

```js
import { gql } from 'apollo-boost'
import { graphql } from 'react-apollo'

const GET_DRIVERS_QUERY = gql`
    {
        drivers {
            id
            firstName
            lastName
            nationality

        }
    }
`

//Skipping the Class Component bit, not relavent

export default graphql(GET_DRIVERS_QUERY)(DriverList);
```

However we will now have a problem, the fetch wont work as the server doesnt trust where the request is coming from. Makes sense, we cant get the whole internet poke the DB, it would get upset. 

`Access to fetch at 'http://localhost:5000/graphQL' from origin 'http://localhost:3000' has been blocked by CORS policy`

Lets sort it out by going to the server.

## Sorting out CORS

So what can I do to make the backend love frontend?

```js
const cors = require('cors')

//allow cross-origin requests
app.use(cors())
```

There you go. Seems wierd, must investigate further.

Anyhow, if you stick a console for this.props you will be happy to notice you get back two objects. One is a fairly blank one that is when the request is still loading, the second is once loading is complete. Note the loading property is a boolean for this

## Displaying the data Apollo

So we got the Data object ready to go how do we put in on the screen? Lets find out..

1. Make a function in the DriverList component that checks for loading and outputs accordingly.

```js
 showDrivers(){
        let data = this.props.data
        if (data.loading){
            return <div> Fetching Drivers</div>
        } else {
            return data.drivers.map (driver => {
            return <li key={driver.id}> {driver.firstName} {driver.lastName}</li>
            })
        }
    }
```

2. You can call this function where you want the results in the render method:

`{this.showDrivers()}`

**You can do this for Teams in a similar way so I wont do that here**

## Looking up a Team for our Add Driver form

So we can query using Apollo to show our Drivers. So lets say we want to add a driver... that will require a form but we have an issue. We want to select a team for each driver but the issue is that unless the user knows the ID of the Team its unlikely to go well. So we want the form to have a list of existing teams, which, requires us to query the teams in the database.

The process for this goes as follows:

1. Import gql from apollo-boost
2. Import graphql from react-apollo
3. Make the GET_TEAMS_QUERY
4. Bind the component with the query `graphql(GET_TEAMS_QUERY)(AddDriver)`
5. Make a function in the component that
    - If loading - returns `<option>Loading...</option>`
    - If not loading - map through the array returning an option for each team with a key and value of the ID, which will allow the association to be make on the backend `


That will get us a drop down with the teams in the database.


## Submitting data to our backend!

OK now lets send the data to the backend.

1. Declare a state for the input form - `state{}`
2. Configure the inputs to be managed from state - `<input type="text" name="firstName" onChange={this.handleChange}/>`
3. Create a Add Driver mutation:

```js
const CREATE_DRIVER_MUTATION = gql`
    mutation {
        addDriver(firstName: "", lastName: "", nationality: "", teamId:"") {
            name
        }
    }
`
```

4. Bind 2 queries via compose:

At the start add:
 `import {graphql, compose} from 'react-apollo'`

At then end use compose to contain both query and mutation:

```js
export default compose(
    graphql(GET_TEAMS_QUERY, {name:"GET_TEAMS_QUERY"}),
    graphql(CREATE_DRIVER_MUTATION, {name:"CREATE_DRIVER_MUTATION"}),
)(AddDriver);
```
This will now rename the data object returned in the query to the query/mutation name so that will need to be changed in the code.

`let data = this.props.GET_TEAMS_QUERY`

5. Attach an an event handler to the form submission to perform a mutation using what we have in state.

To do this we need query variables and modify our mutation:

```js
const CREATE_DRIVER_MUTATION = gql`
    mutation($firstName: String!, $lastName: String!, $nationality:String!, $teamId:ID!) {
        addDriver(firstName: $firstName, lastName: $lastName, nationality: $nationality, teamId:$teamId) {
            firstName
            lastName
            nationality
            team{
                name
            }
        }
    }
`
```

Then in the submit form we call the mutation passing in some variables:

```js
submitForm = (event) =>{
        event.preventDefault();
        this.props.CREATE_DRIVER_MUTATION({
            variables:{
                firstName: this.state.firstName,
                lastName: this.state.lastName,
                nationality: this.state.nationality,
                teamId: this.state.teamId
            }
        })  
    }
```


If it all works... nothing will happen unless you refresh the page. So that sucks so let's refresh the query by rerunning the GET_ALL_DRIVERS. To do this Apollo gives us a refetch command we can add when doing running a query/mutation, we whack it as another part the query like so.

```js
submitForm = (event) =>{
        event.preventDefault();
        this.props.CREATE_DRIVER_MUTATION({
            variables:{
                firstName: this.state.firstName,
                lastName: this.state.lastName,
                nationality: this.state.nationality,
                teamId: this.state.teamId
            },
            refetchQueries: [{query: GET_DRIVERS_QUERY}]
        })  
    }
```

And yeah, we need this component to have access to the query it wants to refetch.

Hmmm, we are starting to get alot of duplicate queries in our components, that is asking for trouble so let's look at sorting this out.


## Exporting queries into thier own file

So, our AddDrivers component has the following queries:

- CREATE_DRIVER_MUTATION
- GET_DRIVERS_QUERY
- GET_TEAMS_QUERY

Since we have other components that also rely on those queries we should get a single source of truth for these. Luckily... we got the skills for that.

1. Make a folder called queries and make a file called queries.js
2. import gql from apollo-boost
3. Move our queries and components into the file but make sure to export them: `export {GET_DRIVERS_QUERY, GET_TEAMS_QUERY, CREATE_DRIVER_MUTATION}`
4. Import the queries as required like so: `
5. You can get rid of the gql import from apollo boost as the component doesnt need it anymore

That is the general idea, you can apply this to all other components as needed.

## Making our Drivers Details Page.

I want to launch a component to get more details about a drive. Lets call it `driverDetails.js`

It needs a single query returning more details but for now lets get the basics up and running. As always I like a placeholder to make sure its all wired up as needed:

```js
import React, { Component } from 'react';
import { graphql, compose } from 'react-apollo'


class DriverDetails extends Component {
    render() {
        return (
            <div>
                <p>This is driver details.</p>
            </div>
        );
    }
}

export default DriverDetails;
```

## Our GET_DRIVER_QUERY

Our query needs to pass in an ID which then is used to pick a driver. Our query will look like this:

```js
const GET_DRIVER_QUERY = gql`
    query($id: ID){
        driver(id:$id) {
            id
            firstName
            lastName
            nationality
            team{
                name
                drivers{
                    firstName
                    lastName
                }
            }
        }
    }
`
```

We want to return the team they drive for, but then the drivers that drive for that team too. Its complex one but this is where GraphQL shines.

Export GET_DRIVER_QUERY and then

1. Import it into our new component
2. Bind the Component to the query

To test it is all working you can throw the component onto a page.

Now we need to work on passing the ID to the component so it can do its query magics.

To do this we need:

1. Listen for a click on a driver
2. Find out the Id of the driver we clicked on.
3. Pass the id as a prop to the DriverDetails component.
4. Show the driver details.



1. We have the <li>'s being created so we need to attach an event listener to each one:

```js
<li key={driver.id}  onClick={(event)=>{
 this.setState({selected: driver.id})
}}>
```

2. The event will set the state property 'selected' to the driver ID we better initialise that:

`state = {selected: ""}`

3. `<DriverDetails driverId={this.state.selected}/>`

So if we add a console.log(this.props.driverid) on the driverDetails component we should get the relevent id back, all being well.

4. Finally we now can pass the id as a variable for the GET_DRIVER_QUERY:

```js
export default graphql(GET_DRIVER_QUERY, {
    options: (props) => {
        return {
            variables: {
                id: props.driverId
            }
        }
    }
})(DriverDetails);
```

Now if we console.log(this.props) we will see that we get a data object back! Now its just a case of populating the component with the values we want!

Not so fast...

Lets do this in a managed way and check we have a result before proceeding:

```js
displayDriverDetails= () => {
        const { driver } = this.props.data;
        if (driver) {
            const filteredDrivers = driver.team.drivers.map(d => {
                if(driver.id!==d.id) return <li key={d.id}>{d.firstName} {d.lastName}</li>
            })
    
            return (
                <div>
                    <h3>{driver.firstName} {driver.lastName}</h3>
                    <h4>Nationality: {driver.nationality}</h4>
                    <h4>Team: {driver.team.name}</h4>
                    <b>Other Teammates:</b>
                    <p>{filteredDrivers}</p>

                </div>
            );
            } else {return <p>No driver selected</p>};
    };
    render(){
        return (
            <div>
                {this.displayDriverDetails()}
            </div>
        )
    }  
```

Cool, this is pretty much all we need!

## Making an Add Team Component

This will be similar to Adding a driver so let's recap...

To do this we need to:

1. Make a GraphQL Mutation to add teams
2. Create a form for getting the relavent data
3. Set up state and control the form inputs through state.
4. On submission, perform the mutation
5. Bind the mutation to the component.


1. The GraphQL Mutation looks like this:

```js
const CREATE_TEAM_MUTATION = gql`
  mutation($name: String!, $founded: Int!) {
    addTeam(name: $name, founded: $founded) 
    {
      name
      founded
    }
  }
`;
```
Don't forget to export!

2. The form we will use looks like this:

```js
<form>
    <div class="field">
        <label>Team Name:</label>
        <input
        name="name"
        type="text"
        onChange={this.handleChange}
        />
    </div>
    <div class="field">
        <label>Founded:</label>
        <input
        name="founded"
        type="number"
        onChange={this.handleChange}
        />
    </div>
    <button>Add</button>
</form>
```

3. State will be blank but the handleChange function will look like this:

```js
handleChange = (event) => {
        let { name, value, type} = event.target
        if (type==="number") value = Number(value)
        this.setState({
            [name]: value
        })
    }
```
Note that by default the value returned from inputs are strings so the founded year needs to be coerced into a number.

4. Lets make the submit function like so:

```js
submitForm = (event) =>{
        event.preventDefault();
        this.props.CREATE_TEAM_MUTATION({
            variables:{
                name: this.state.name,
                founded: this.state.founded
            },
            refetchQueries: [{query: GET_TEAMS_QUERY}]
        })  
    }
```

5. We need to bind CREATE_TEAM_MUTATION to the component like so:

`export default graphql(CREATE_TEAM_MUTATION)(AddTeam)`

All the above should work but it doesnt because...

1. I forgot the form submit
2. The export required using compose, no idea why
3. The component that showed teams was upset about the refetched query. Until I made it pull the query from the queries file, which is the same as the Add Team component so thats probably why. 

Good work!

## Delete Driver path

So this one we will do end-to end. From backend to Front..

1. Create the mutation in the GraphQL schema:

```js
deleteDriver: {
            type: driverType,
             args: { 
                 id: {type: GraphQLID} 
            },
            resolve(parent, args) {
                return Driver.findByIdAndDelete(args.id);
            }
        }
```

2. Test the query in graphiql:

```js
mutation{
  deleteDriver(id:"5c93c96d2fc116136416d497"){
    firstName
    id
  }
}
```

3. Add the mutation to the frontend queries file (probably should split it to a mutations file at some point!)

```js
const DELETE_DRIVER_MUTATION = gql`
  mutation(id: ID!) {
    deleteDriver(
      id:$id!
    ){
        id
        firstName
        lastName
        nationality
    }
  }
`;
```

4. Make a component that lists all the drivers with a delete button with a placeholder action:

```js
    drivers() {
        let data = this.props.GET_DRIVERS_QUERY
        if (data.loading) {
            return <div>Fetching Drivers</div>
        } else {
            return data.drivers.map(driver => {
                return <li key={driver.id}> {driver.firstName} {driver.lastName} - {driver.nationality} - {driver.team.name} <button value={driver.id} onClick={this.delete}>Delete</button></li> 
            })
        }
    }
```
That return li is looking a little chunky, would be good to refactor that at some point.

5. Write the query that performs the deletion:

```js
    delete = (event) => {
        let value = event.target.value
        this.props.DELETE_DRIVER_MUTATION({
            variables: {
                id: value
            },
            refetchQueries: [{ query: GET_DRIVERS_QUERY }]
        })
    }
```

Cool, you can assume the delete Team mutation and component is quite similar... too similar for bothering writing about. Especially since I just copy/pasted the above mostly!

## Updating Driver details

Ok, lets look at the big scary boss monster of CRUD... updating something that already exists.

Ok chill it isnt that hard, lets break it down into the high level steps.

1. Write an update driver GraphQL mutation
2. Test it out on Graphiql
3. Add the mutation to our queries component (still need to split that out)
4. Writes a component that:
   - Has a driver form 
   - Populate the form with details found for that particular driver
   - On submission runs the update mutation.

Ok lets do it. But lets do it for teams for a change...

1. The Update Driver mutation should look like...

```js
updateTeam: {
            type: teamType,
            args: {  //What details are you providing?
                id: { type: GraphQLID },
                name: { type: new GraphQLNonNull(GraphQLString) },
                founded: { type: new GraphQLNonNull(GraphQLInt) }
            },
            resolve(parent, args) {
                let team = new Team({ //Use the Team model defined in the DB pluging in arg values
                    name: args.name,
                    founded: args.founded
                })
                return Team.findOneAndUpdate(args.id, {
                    name: args.name,
                    founded: args.founded
                });
            }
        }
```


2. We can test it out with the following:

```js
mutation{
  updateTeam(id:"5c9a6b3e014d9816b5989e7f", name:"Ud", founded:2993){
    name
    id
    founded
  }
}
```

One trap I noticed is that the returned values will be the old ones. However if you do a teams query it will be updated. I am guessing it takes a moment to update on the DB and hence graphql reports the first values. I don't think it matters for us right now.

3. Lets make an update component.

The way I will do this is via three functions:

- getTeams - Runs a query to get all the teams, allows the selecting of a specific team
  
- setTeam - Runs a query to populate state/form with the selected Team's details. This allows editing, when the form is submitted it will run...

- UpdateTeam - Runs the mutation to update the DB with the entry in state.

The component code in full:

```js
import React, { Component } from 'react';
import { graphql, compose} from 'react-apollo'
import { UPDATE_TEAM_MUTATION, GET_TEAMS_QUERY, GET_TEAM_QUERY } from '../queries/queries'

class UpdateTeam extends Component {


    state = {
        name:  null,
        founded:  null,
        teamId: null
    }
    handleChange = (event) => {
        let { name, value, type} = event.target
        if (type==="number") value = Number(value)
        this.setState({
            [name]: value
        })
    }

    getTeams() { //List all teams as an option to select
        let data = this.props.GET_TEAMS_QUERY;
        if (data.loading) {
            console.log("Loading teams")
        } else {
        return this.props.GET_TEAMS_QUERY.teams.map(team => {
                return (<option name="teamId" key={team.id} value={team.id}>{team.name}</option>)
            })
        }
    }

    setTeam = (event) => { //Populate state which the selected team.
        event.preventDefault();
        let selectedTeam = this.props.GET_TEAMS_QUERY.teams.find(team => {
            return team.id === this.state.teamId
        })
        if (!selectedTeam) return;
        this.setState({
            teamId: selectedTeam.id,
            name: selectedTeam.name,
            founded: selectedTeam.founded
        })
    }
    updateTeam = (event) => {  //Update the DB with the form's entries for the team.
        event.preventDefault();
        this.props.UPDATE_TEAM_MUTATION({
            variables: {
                id: this.state.teamId,
                name: this.state.name,
                founded: this.state.founded
            }, refetchQueries: [{ query: GET_TEAMS_QUERY }]
        })
    }
    render() {
        return (
        <div>
            <form onSubmit={this.setTeam}>
                <div className="field">
                    <label>Team</label>
                    <select onChange={(e) => {
                        this.setState({
                            teamId: e.target.value,
                        })
                    }}>
                        <option name="select" key={"default"} value={"none"}>Select Team</option>
                        {this.getTeams()}
                    </select>
                    <button>Select</button>
                </div>
            </form>
            <form onSubmit={this.updateTeam}>
                <div className="field">
                    <label>Team Name:</label>
                    <input
                        name="name"
                        type="text"
                        value={this.state.name}
                        onChange={this.handleChange}
                    />
                </div>
                <div className="field">
                    <label>Founded:</label>
                    <input
                        name="founded"
                        type="number"
                        value={this.state.founded}
                        onChange={this.handleChange}
                    />
                </div>
                <button>Update</button>
            </form>
        </div>    
        );
    }
}

export default compose(
    graphql(GET_TEAMS_QUERY, { name: "GET_TEAMS_QUERY" }),
    graphql(UPDATE_TEAM_MUTATION, { name: "UPDATE_TEAM_MUTATION" }),
    graphql(GET_TEAM_QUERY, { name: "GET_TEAM_QUERY" })
)(UpdateTeam);
```

I think you get the general idea for doing the same for drivers.