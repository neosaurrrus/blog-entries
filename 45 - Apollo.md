# Using appollo and a simple query and mutation.

# Why Apollo Client?

On the front-end, Apollo Client lets us:

- Perform GraphQL Mutations
- Fetch GraphQL Queries
- Cache GraphQL Data
- Manage Local State
- Handles Error and Loading UI States

So all in all it is pretty cool way of getting the front end talking to the backend.

## How do we get the Apollos?

Apollo is quite modular and thus can be installed to just handle the individual use cases listed above. However if you just want the whole thing you can install Apollo Boost which combines it all in a pre-configured way.

We also want to get `next-with-apollo` which exposes Apollo Client via a prop. As you can guess, this allows apollo to work with NextJs.

## Configuring Apollo

To configure Apollo, we need to make a file, we will call it withData.js and populate it accordingly:

```js
import withApollo from 'next-with-apollo';
import ApolloClient from 'apollo-boost';
import { endpoint } from '../config';

function createClient({ headers }) {
  return new ApolloClient({
    uri: process.env.NODE_ENV === 'development' ? endpoint : endpoint,
    request: operation => {
      operation.setContext({
        fetchOptions: {
          credentials: 'include',
        },
        headers,
      });
    },
  });
}

export default withApollo(createClient);
```

Lots of wierd code there let me explain some of it:

1.  `import { endpoint }` is just getting the backend location `const endpoint = "http://localhost:4444"`
2.  `function createClient({headers}) { ...` - We take the header for authentication duties later
3. `uri: process.env.NODE_ENV === 'development' ? endpoint: endpoint` uses the endpoint
4. `request: operation => { .... ` this line is effectively setting up middleware which runs everytime we make a request.
5. `credentials: include` - we specifiy that any logged in cookies will come with the request. Useful for the backend.
6. `export default withApollo(createClient)` - We export a function to create a client.

Also we need import this code into our `_app.js` file to make sure it is being used through our app.

```js
import {ApolloProvider} from 'react-apollo'
import withData from '../lib/withData'
```

Then we wrap the root component in ApolloProvider to ensure it is used:

```js

<ApolloProvider client={this.props.apollo}>
    <Page>
        <Component />
    </Page>
</ApolloProvider>

//and at the end...

export default withData(myApp)
```

Lastly we need to get any existing page information with a a `static getInitialProps` function:

```js
static async getInitialProps({ Component, ctx}){
    let pageProps = {};
    //if there is page props, lets get them
    if(Component.getInitialProps){
        pageProps = await Component.getInitialProps(ctx);
    }
    pageProps.query = ctx.query
    return {pageProps}
}
render() {
    const { Component, pageProps} = this.props
//rest of the code as before
}
```

This effectively looks at the page and looks for any queries to fetch on the backend. Once it does this it renders the page to us.

This is all about ensuring we have server-side rendering working. You can find more information about this in Next or Apollo documentation.

Now we have Apollo installed and integrated with our App. We can use it to interact with our GraphQL backend. I assume this is something you have set up as follows else things will go bad fast.

# Basic Query #1 - Querying all Items

The whole point of setting up Apollo is to get GraphQL information onto the React front-end. Let's explore this by looking at an item component to return Item values.

This has the following key steps:

1. Make a page to show all items
2. Make a component on that page
3. Write a GQL query in that component
4. In the Render method make a render prop that uses the query.
5. Create an Item component to show data about each item.
6. Style the result using styled components as needed.

So lets look at each step in detail:

1.  Make an items.js page.

We can effectively have duplicate pages by importing and exporting the original so our items page can be duplication of the home page by doing the following:

```js 
import Home from './index'
export default Home
```

2. Make an items.js component

We want the home/items page to show our items. For that we want to create a component called `items.js`. Apart from React, it needs {Query} from 'react-apollo':

`import {Query} from 'react-apollo'`

For now, make a div with placeholder text and add it to Index.js to check it is working.

3. Write a query

Back in the items.js component, we first need to be able to use GQL tags by importing the library:
   
`import gql from 'graphql-tag'`;

Then we can write our first query, this just returns all fields in the item:

```js
const ALL_ITEMS_QUERY = gql`
    query ALL_ITEMS_QUERY {
        items {
            id
            title
            price
            description
            image
            largeImage
        }
    }
`
```

To implement this visually, we need to use a Render Prop. A render prop uses a function to return a value within the render method. Normally by accessing something outside the render method via a Prop. It can only contain a function that returns something. This is an example:

```js
<Query query={ALL_ITEMS_QUERY}>
    {payload => {
        console.log(payload);
        return <p>Hello I am the child of query</p>
    }}
<Query/>
```

The payload contains alot of things. But what we most care about can be found in `data` but also `error` and `loading` to a lesser degree. We should check for Loading and Error prior to rendering the result.

Lets flesh that out with some proper values from the payload:

5. Make an Item Component:

As opposed to rendering all items in the items component we should delegate that to an Item component for each item.

```js
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Link from 'next/link'
import Title from './styles/Title'
import ItemStyles from './styles/ItemStyles'
import PriceTag from './styles/PriceTag'
import formatMoney from '../lib/formatMoney'

class Item extends Component {
    render() {
        const {item} = this.props
        return (
           <ItemStyles>
               {item.image && <img src={item.image} alt={item.title} />}
               <Title>
                    <Link href={{
                        pathname:'/item',
                        query: {id: item.id}
                    }}
                    >
                        <a>{item.title}</a> 
                    </Link>
                </Title>
                <PriceTag>{formatMoney(item.price)}</PriceTag>
                <p>{item.description}</p>
                <div className="buttonList">
                    <Link href={{
                        pathname: 'update',
                        query: { id: item.id}
                    }}
                    >
                        <a>Edit</a>
                    </Link>
                    <button>Add to Cart</button>
                    <button>Delete</button>
                </div>
           </ItemStyles>
        );
    }
}

Item.propTypes = {
    item: PropTypes.object.isRequired
};

export default Item;
```

6. Styling the components

The example above already includes the styled components. The CSS that is import of course is something to look at based on what you are trying to do style-wise

## Conclusion

The steps above exposes item properties on the page, there are two Links, one to view more about the item and another to go to a edit page. These are routes that will we will look at later on.

# Mutation - Creating Item using Apollo Client and GraphQL

If you have ever made a Create route in a CRUD application, the way you would do it via React, Apollo and GQL isn't too different in structure.  The basic architecture is:

- A *Create page* that contains..
  - A *CreateItem component* which contains...
    - A form to gather the data
    - A query that is sent to the DB
    - A function that sends the query using the form data

Here are the key steps of how we create this achitecture:

1. Create a Create Page to hold a CreateItem component we create.
2. Create the form to gather inputs for the new Item, getting its values from state
3. Create an event handler to let State be changed by the form inputs.
4. Write a mutation query that uses the input contents
5. Wrap the form in a mutation render prop that passes the mutation 
6. Handle errors during the mutation attempt.
7. Handle loading state during the mutation attempt.
8. Handle the submit to actually manage the successful response.


Phew, thats quite a few steps but lets go slow and figure it out step by step:

## 1. Create a Create page and CreateItem component

First of all we need a create page which will house the CreateItem component.

In NextJS, we create a create.js file in the pages folder. This will house the CreateItem component:

```js
import CreateItem from '../components/CreateItem';

const Create = props => (
    <div>
        <CreateItem/>
    </div>
)

export default Create
```

This page just exists to hold the CreateItem component which we have to make for the above to make sense. This component requires to import a few things

`{Mutation} from 'react-apollo` - Allows us actually performing the mutation.
`gql from 'graphql-tag'` - Lets us write a GQL query and have our component understand it.
`Form from './styles/Form'` - Our styled component for the form, we wont discuss this much really.

So our basic skeleton will look like this:

```js
import React, { Component } from 'react';
import { Mutation } from 'react-apollo'
import Form from './styles/Form'

class CreateItem extends Component {
    render() {
        return (
            <Form>
            </Form>
        );
    }
}

export default CreateItem;
```
How we have the basic skeleton, lets flesh it out with a form

## 2. Create the form to gather inputs for the new Item, using values from State

Obviously, the fields we want here really depends on what you are trying to make. In my case it is for an ecommerce site so this is how I populated the form tag with the first field:

```js
<label htmlFor="title">
    Title
    <input type="text" id="title" name="title" placeholder="Title" required value={this.state.title}/>
</label>
```

Whats that last bit about state? Though we are going to be sending the information to a database, we want to use React state to collate and hold the values prior to performing our mutation. The state I need looks like this:

```js
state = {
    title: '',
    description: '',
    image: '',
    largeImage: '',
    price: 0
}
```

Based on that, I think you see how the rest of the form would look like.

So far, this will mean that our title form field will be blank no matter what the user does and will remain so as we currently have no way to change State. So lets fix that...

## 3. Create an event handler to let State be changed by the form inputs

When the user changes an input we want to update State with what the user did. First of all we want to add a property to our input tag:

`onchange={this.handleChange}`

We need a corresponding function (or instance property) to read and update State accordingly:

```js
handleChange = (event) => {
 this.setState({title: e.target.value})
}
```

This works great for updating the title, you *could* have multiple ones for each of the fields or we can be a little smarter and make it work for all fields by getting the property we want to update in state:

```js 
handleChange = (event) => {
    const { name, type, value } = event.target;
    const val = type === 'number' ? parseFloat(value) : value
    this.setState({ [name]: event.target.value })
}
```

Some explanation:

`name` and `type` give us the input name and type respectively.

The value of the input is always provided as a string. So we have a line where we check for that and turn it into a number.

Lastly, we use *computed property names* to use the `name` variable when choosing which property to update in State.

Ok, now that you have a form, the last action is to submit the form. 

`<button type="submit">Submit</button>`

By default it will just send the contents as a query in the URL bar but we need to be smarter and intercept the submit and push State up to the server via our GQL query. To do that we need to modify the form property:

```jsx
<Form onSubmit = {event => {
    preventDefault();
    //Do the mutation
}}>
```

Unfortunately, React is a bit rubbish at understanding what "do the mutation" means so let's help it out a bit. We need to:

- Write a mutation query
- Let the form tag we just wrote use that query.


## 4. Write a mutation query that uses the input contents

Assuming you have the backend sorted (see previous posts) our mutation makes the following shape:

```js
const CREATE_ITEM_MUTATION = gql`
    mutation CREATE_ITEM_MUTATION(
        $title: String!
        $price: Int!
        $description: String!
        $image: String
        $largeImage: String
    ) {
        createItem(
            title: $title
            price: $price
            description: $description
            image: $image
            largeImage: $largeImage
        ){
            id
        }
    }
`;
```

So the above query takes in arguments for each of the fields we want. We now need to get the Form to use it.

## 5. Wrap the form in a mutation component that passes the mutation

To expose the mutation, we make a Mutation component. This consists of:

- Props so the component knows what query and variables to use
- A function that takes in the mutation, and loading and error properties to handle those states.

```js
<Mutation mutation={CREATE_ITEM_MUTATION} variables={this.state}>
    {(createItem, { loading, error }) => (
        //function code goes here!
    )}
</Mutation>
```

So what is the function code we need? That is the form itself, so we can move the closing parts of the above to the bottom of our component!

That should work but we ought to handle errors in some way:

## 6. Handle errors during the mutation attempt

We dont go too into error handling here (that is probably its own post!) but let's assume you have a component set up to handle errors when interacting with GraphQL that retrives and formats either a:

- Network Error
- Singular GraphQL error

Let's import that into our createItem component (assuming its called Error):

`import Error from './Error'`

We put an Error component as the first thing that happens after the Form submits:

`<Error error={error}/>`

That should do the trick and i'll make a note to write about Apollo error handling!

## 7. Handle loading state during the mutation attempt

The process should be fast, but sometimes it isn't due to network or server issues so we need to handle that for a good user experience which translates into:

- When loading, disable the form
- Some sort of loading animation

So to do the loading we need to use the loading property as a boolean to disable our fieldset like so:

`<fieldset disabled={loading} aria-busy={loading}>`

Very Clever!

The boolean nature also allows us to show/hide an element which could be our cool loading animation. Won't go into that though, you can be creative.

## 8. Handle the submit function to do something upon success

Assuming there are no errors and it loads. The mutation should complete. When it comes we might want to do something, such as redirect to the Item's Show page. To do this we need to modify the function to become an async function and then redirect accordingly.

To route the browser to another page to need to import next router like so:

`import Router from 'next/router';`

And then when that access to the *push* method to redirect like so:

```js
Router.push({
    pathname: "/",
    query: {id: res.data.createItem.id}
})
```

The modified function looks like this:

```jsx
<Form onSubmit = {async event => {
    //stop the form from submitting
    preventDefault();
    // call the mutation
    const res = await createItem();
    //Bring them to the items show page.
    Router.push({
        pathname: "/item",
        query: {id: res.data.createItem.id}
    })
}}>

```

So the final code will look like this:

```js
import React, { Component } from 'react';
import { Mutation } from 'react-apollo'
import Router from 'next/router'
import gql from 'graphql-tag'
import Error from './ErrorMessage'
import formatMoney from '../lib/formatMoney'
import Form from './styles/Form'


//Mutation Query
const CREATE_ITEM_MUTATION = gql`
          mutation CREATE_ITEM_MUTATION($title: String!, $price: Int!, $description: String!, $image: String, $largeImage: String) {
            createItem(title: $title, price: $price, description: $description, image: $image, largeImage: $largeImage) {
              id
            }
          }
`;

class CreateItem extends Component {

    state = {
        title: '',
        description: '',
        image: '',
        largeImage: '',
        price: 0
    }

    handleChange = (event) => {
        const { name, type, value } = event.target;
        const val = type === 'number' ? parseFloat(value) : value
        this.setState({ [name]: event.target.value })
    }


    render() {

        return (
        <Mutation mutation={CREATE_ITEM_MUTATION} variables={this.state}>
            {(createItem, { loading, error }) => (
                <Form 
                    onSubmit={async event => {
                        //stop form from submitting
                        event.preventDefault();
                        //Call the mutation
                        const res = await createItem();
                        console.log(res)
                        //Bring them to the Item Show Page
                        Router.push({
                            pathname: "/item",
                            query: { id: res.data.createItem.id }
                        })
                    }}
                >
                    <Error error={error} />
                    <fieldset disabled={loading} aria-busy={loading}>
                        <label htmlFor="title">
                            Title
                            <input type="text" id="title" name="title" placeholder="Title" required value={this.state.title} onChange={this.handleChange} />
                        </label>
                        <label htmlFor="price">
                            price
                            <input type="number" id="price" name="price" placeholder="price" required value={this.state.price} onChange={this.handleChange} />
                        </label>

                        <label htmlFor="description">
                            <textarea id="description" name="description" placeholder="Enter a Description" required value={this.state.description} onChange={this.handleChange} />
                        </label>
                        <button type="submit">Submit</button>
                    </fieldset>
                </Form>
            )}
        </Mutation>
        )
    }
}

export default CreateItem;
```

## Conclusion

That was alot of steps but hopefully it has been broken down into bite size pieces. I hope that performing the other CRUD operations will be straightforward once we got this pattern down.







# Apollo/GraphQL/Prisma - Can't spell CRUD without U


In the last post we created an Item via a form submission, a GraphQL mutation and a backend I barely referred to.

This time we will write the frontend code to update an item AND create the schema changes on the back end.



# Backend with GraphQL and Prisma

Ok the backend we need to:

- Add a query to the schema for a single item to get all its info
- Add a mutation to the schema to change said info
- Provide resolvers for the Query
- Provide a resolver for the Mutation
- Test them out

## Schema - Adding our Edit Item Mutation

So we open up our `schema.graphql` file and add the following line to the mutations:

`updateItem(id:ID!, title: String, description: String, price: Int) : Item!`


## Schema - Add our Single Item Query 

In the Query section we add the following:

`item(where: ItemWhereUniqueInput!) : Item`

ItemWhereUniqueInput comes from prisma but is the same as `Id:Id!`

## Write our Single Item Query Resolver

1. Query

In `Query.js` we need to create our resolver however...

We dont actually need to resolve anything special we can just forward it to the database as it is: 

`item: forwardTo('db')`

## Write our Update Item Mutation

So the mutation needs to do the following steps:

- Take a copy of the updates
- Remove the ID from the updates (so ID doesnt get updated)
- Run the update method

Those steps are shown below:

```js
updateItem(parent, args, ctx,info){
    const updates = { ...args };
    delete updates.id;
    return ctx.db.mutation.updateItem(
        {
        data: updates,
        where: {
            id: args.id
            }
        }, info)
}
```

We can look at the `prisma.graphql` file to understand what arguments are needed for the updateItem method.

## Test them out

You can test it via the GraphQL playground:

This is an example ID query:

```js
{
  item(where: { id: "5c5944eb799ab50007f968a3" }) {
    title
  }
}
```

# Front End: The Edit page and Component

As when creating an item, we need to first make a page to hold a component that does the clever bit. However since we have already written a createItem page and component we can leverage accordingly.

## Making the Update Item page

This is fairly staightforward in nextJS. New page in pages, and copy the code from the create page but just refer to an `<UpdateItem>` component we are about to make. Don't forget to import it!

However, one difference is that when we go to the page we need to know which ID we want to return the data for, and later, change the values.

In our app.component we had a line which exposes the query to the user:

`pageProps.query = ctx.query`

This means that it will be availible as a prop when we call our component:

`<UpdateItem id={props.query.id}/>`

Note that its just `props.query.id` as we are using a stateless function:

```js
import UpdateItem from '../components/UpdateItem'

const Sell = ({query}) => (
    <div>
        <UpdateItem id={query.id} />
    </div>
);

export default Sell;
```

Another way would be to wrap our export with a `withRouter` method.

# Making the Update Item Component

Ok, this is where the Front End magic happens. Again lets break it out into small tasks.

## 1. Rename where it says CreateItem

We already have a CreateItem component so lets take a copy of it and then rename instances of `CreateItem` to `UpdateItem`.

We also have the `CREATE_ITEM_MUTATION` which needs to be renamed to `UPDATE_ITEM_MUTATION`

## 2. Blank out state

As opposed to priming state for a new item, we only want State to hold the updated properties so lets keep state as a blank object: `state = {}`

## 3. Write query to pull the item using the item ID

So we need to query the Database for the item with the same ID as was passed to the URL.

```js
const SINGLE_ITEM_QUERY = gql`
    query SINGLE_ITEM_QUERY($id: ID!){
        item(where: {id:$id}){
            id
            title
            description
            price
        }
    }
`;
```

## 4. Add the query component to the render method.

As before, we need to run the Query we have just created in the render method. The logic is as follows:

```js
<Query query={SINGLE_ITEM_QUERY} variables={{
    id: this.props.id
}}
    {({data, loading}) => {
        if (loading) return <p> Loading....</p>
        if (!data.item) return <p> No item found for ID: {this.props.id}</p>
        return (
            // ???
        )
    }}
</Query>
```

So what does it return? The mutatation that will update the item which in turn returns the form to do so! Scary stuff, but will show you at the end what it all looks like...

## 5. Change the input fields to pull from the item query not state

As opposed to when we created the item, we dont want to have state mirror the inputs. This is because we only want to have items that have changed in our state to then pass to our mutation to update the values.

First change the `value={this.state.<whatever>` property for each input field to `defaultValue={data.item.<whatever>}`

This 'breaks the link to state unless a change happens to the value.


### 6. Write function to query item data from backend

We have the remnants of the create item query so we just need to modify it slightly for update item:

```js
const UPDATE_ITEM_MUTATION = gql`
    mutation UPDATE_ITEM_MUTATION($id: ID!, $title: String!, $description: String!, $price: Int!){
        updateItem(id:ID!, title: $title, description: $description, price: $price){
            id
            title
            description
            price
        }
    }
`
```

Hopefully the pattern is fairly familar and would heavily depend on what properties are involved.

## 6. Write the Update Item mutation

We have the renamed create item mutation we need to change. Last time we just wrote the function in-line, this time lets call a function on submit which is a little neater I think:

```js
<Mutation mutation={UPDATE_ITEM_MUTATION} variables={this.state}>
{(updateItem, {loading, error}) => (
    <Form onsubmit={event => this.updateItem(event, updateItem)}>
    
)

}
```

So the function on the component looks like this:

```js
updateItem = (event, updateItemMutation) => {
    event.preventdefault();
    console.log("Updating Item");
    console.log(this.state);
    const res = await updateItemMutation({
        variables: {
            id: this.props.id,
            ...this.state            
        }
    })
    console.log(updated)
}
```

## 7. Clever last touches

We can use the loading boolean Apollo provides to change the *Save Changes* button to a *Saving Changes* button dynamically with this one clever trick.

`<button type="submit">{loading? 'Saving' : 'Save'} Changes</button>`
