----CHAPTER 17

# Introducting React Concepts

After playing around with with a RESTful application, I decided it was time to learn a different way of doing things. Enter `React` which you might have heard about.

I have been learning from various sources the main ones are:

[Stephen Grider's Modern React with Redux](https://www.udemy.com/react-redux/learn/v4/overview)
[Wesbos' course React for Beginners](www.reactforbeginners.com)

Stephen I think is great at introducing concepts and explaining them. Wes takes you through the end-to-end process in a 'real life' way with some helpful tips along the way.

This first post is just a summary of some of the key parts of React, and explore some newbie errors before we go into using them in anger.

By the way,make sure you have a good grasp of ES6 before getting into React for two reasons:

1. The syntax will make more sense
2. Things you may think of as part of React are really just leveraging whats already in ES6.
   

## The Building Blocks of React

Before we get into building something cool, we need to understand some core concepts of React:

- Setting up React
- JSX
- Rendering
- React Application Structure
- Imports and Exporting Components
- Components
- State


## How do we set up React?

In short, you don't.

In slightly longer, setting up React can be complicated. Create-React-App is one tool that makes it easier to develop a React app. We can *eject* from when we are production ready but that's a topic for later on.

Both Stephen Grider and Wes Bos recommend a pre-configured environment to get familar with React first so that's what I did.


## JSX : What is it and how can it show stuff on the page?


JSX is a way introduced in React of writing easily legible HTML in a otherwise JS file. It isn't technically required but writing in pure JS gets messy fast. One drawback is that JSX doesnt run on a browser by default so we need to make use of *Transpiling* tools, namely `Babel` and `Webpack`,  to turn it into JS the browser can understand. 

The index.js file references a script called `bundle.js` file will parse your jsx code and bundle it all into one big file with all the magic to make it run.

If you view the source of bundle.js you will appreciate that it's sensible to rely on *Create-React-App* while you are getting the hang of React itself. 

You can make a JSX file as you would any other file in your IDE. But there is a few things to be aware of...


## The JSX rendering minefield

Let's take the following JSX example:

```jsx
const App = () => {
	return <div> Hi </div>;
}
React.render(App) 
```

Will it work? No.


### Error 1: React is not defined

If we simply do `React.render(App)`. It wont know what React is as the JSX has no reference to it.

To solve this, we ensure we need to explicitly reference React via a module. To do this, at the top we need to add:

`import React from 'react' 

In plain english, this means go grab the react package as an object called React. So lets try it again..


### Error (well ... warning) 2: React.Render is deprecated. Please use ReactDOM.render from ('react-dom") instead

React used to be one package, however now it is split into several parts because as React has become more popular, all it's features may not apply. 

For this we need ReactDOM which is focused on iteracting with the DOM. We need to import that to get rid of the warning:

`import ReactDOM from 'react-dom'`

and change the render statement to use ReactDOM:

`ReactDOM.render(App)`

Alright it should work now right?

### Error 3: Uncaught error: Invariant Violation: ReacDOM.render(): Invalid Component Element. Instead of passing a component class, make sure to instantiate it by passing it to React.createElement


Yep, still not working…

The 'App' function we used is actually a defined class of `component`, it cant be added to the DOM, it is effectively a blueprint to create an instance.

We can make an instance by using tags: `<App></App>`. This can be self closed by doing `<App />` instead which gives us this:

`ReactDOM.render(<App />)`

So maybe one way of looking at JSX is that we can make our own HTML tags that can store data and pass it to each other.  Anyhow, it has to work now right?!


### Error 4: Target container is not a DOM element

Ok, so this is quite straightforward. The render method needs a RENDER TARGET, a place in the DOM to put the React application. To do this, there is a second argument we need to add. For this example, we will say there is a div in our HTML with the class "container".

```jsx
ReactDOM.render(<App /> , document.querySelector(".container");
```

And now….. it will work!  So there better be a good reason for going through all that effort right?....right?




## React Application Structure

A good react app is split into self-contained, non-code repeating snippets called Containers.

There is a little bit of Art to determine how to split things into components but one key rule is **One Component per file** This allows a clear speration of concerns, a team of developers can focus on a particular component in a relatively safe way.

An example a video player app might consist of components for:

	• Search,
	• The Video player
	• Video Details
	• An unordered list of other videos
	• Items within that list.
	
You will want a container component to keep them all within which is traditionally defined as `index.js`. The rest can typically kept in a components folder.

Here is an example file structure of what I mean:

    -src
        - index.js
            - Components
                - search_bar.js
                - video_detail.js
                - video_list_item.js

But like I say, it’s a little bit of an art that depends on what you are doing, just aim for clarity and consistancy whatever you do.

## Importing and Exporting Components

Once you have your JS files containing a component, how do you use them? First make sure your component file has the following:

1. Import React (and other dependancies)
2. Write your component in a function
3. Export the function using the following line: `export default <component>`

In your Index.js, import the component as you would with any other package:

`import <component> from <file reference><js file>`

Don't forget the file reference, in the video player example above the import file will look like:

```jsx
import videoPlayer from './components/video_detail'
```

Now we can add the component in Index using JSX tags: `<videoPlayer />`

## The two types of Components

If we step back, we have thus far created components that are functions like:

```jsx
const App = () => {
	return <div> Hi </div>;
}
```

This is a functional component. It is a component that just spews out JSX. When more internal logic and decision making is required, e.g event handling, we use class-based components. This uses Es6 classes like so:

`class Search extends React.Component {	}`

When we use classes we still need it to output JSX, we do this via adding a Render Method:

```jsx
class Search extends React.Component {
	render() {             //render method
		return <input />;   
	}
}
```

Put simply, use functional components for simple stuff that renders out,  class-based components for extra smarts.

### A simple way of handling an event in a Class-based component

There is two steps to do this:

1. Declare an event handler - something that is ran when the event happens

2. Pass the event handler to the element we want to monitor the event.

Something like this:

```jsx
class Search extends React.Component {
	render() {             //render method
		return <input onChange={this.onInputChange} />;   
	}
	onInputChange(event){ 
		console.log(event.target.value); //whatever is typed is logged
	}
}
```

The react docs explains more about different events.

## This is where State comes in

State is one of the hardest things to understand about React

State is a plain Javascript object that is used to record and react to events. Every class-based component has a state object and a change to state causes the component to rerender plus any children.

To use state we first we need to initialise:

```jsx
class Search extends React.Component {
	constructor(props) {
		super(props);
		this.state = {searchTerm: ' ' };
	}
```

Second, we can change the state by using the setState method:

```jsx
	onInputChange(event){ 
		  this.setState({ searchTerm: event.target.value })
		}
}
```

Always use the setState method, do not manually update the state object, else react wont know about the change.

### Why do we do this?

Since state updates when it sees a change, the properties of the state object are good to use in the render method:

```jsx
render() {   
	return <div>
		     <input onChange={this.onInputChange} />;  
		     Value of the input: {this.state.searchTerm}
		</div>
};
```

This will result in a display that automatically updates as the user makes changes


This is cool! However this is not the right way around. The Input controlls the state. However the input should be updated by the state,  so how do we do that?



## Proper Controlled Components

In this technique, the state controls the value of element. It is best shown first…

```jsx
<input value={this.state.searchTerm} onChange={event => this.setState({ term: event.target.value}) />
```

The sequence of events is now different: 

1. when the component is rendered for the first time the state tells the input what its value is, which is probably blank.

2. When the user triggers the event, the event causes setState to update the searchTerm in state.

3. The change of state causes the component to rerender which then changes the value to whatever it is in State.

It's the Circle of State, you can add your own Lion King GIF here.

## Conclusion

So that's the first key concepts of React, we will talk about them some more and encounter new ones as we go into using them in anger.


------- Chapter 18 -----

In our last post I just talked about React and some of the concepts behind it. Going forward, I will be working on [React For Beginners by Wes Bos](www.reactforbeginners.com) highlighting the key things I learnt on the way. Highly recommended.

I like to learn the same thing over and over, getting deeper each time so expect some repetition as I figure things out some more.


# Initial Set up

There are a couple of things we need to do in order to follow along with Wes' Course:

- Node version 9.x.x (newer causes issues)
- React Dev Tools browser extension (google for either Firefox or Chrome). You can tell it is working by going to a site that uses react. There you can poke around and see how the components exist on the page.

There are also some package dependancies to install but a simple `npm install` will grab all of them. Let's have a quick over view of the dependancies in package.JSON:

- Stylus, for stying
- React-Scripts, performs transpiling of React to allow it to run. Makes getting starting alot easier but we can 'eject' from it later. 
- Firebase, that is our database connection
- prop-types, used to be part of React but now is its own package. used for passing and formatting data.
- re-base, connects to Firebase
- React and React-dom, are the core react packages
- react-router-dom, montiors changes and allows URLs
- react-transition-group, provides sweet animations.

We will go over them in more detail when we need to leverage them. There is also a scripts section which does some of the initial setting up for using Create-React-App.

    Tip: If the install goes wrong, its a good idea to delete the node modules folder.

Get the server running with `npm start`

There is alot of "just go with it" at this stage. Hopefully we can make sense of it going forward.

# Steps to make our first component

You can use index.js to write our components as long as we reemmber to refactor it out to its own file afterwards.

1. We import React (`import React from 'react'`)
2. We make a class based StorePicker component
3. Add a render method that returns what we want to output.
4. Open public folder and open the HTML file to see where we are mounting the application, in this case, the target div has a class of `main`.
5. We import the render method from React DOM: `import {render} from 'react-dom'`
6. Add the render output after the compoment:
    `render(<StorePicker />,document.querySelector('#main'));`
7. Once we are happy with it, we can export the component code to its own file
    - Create a JS file in components, its a good idea to mirror the component name
    - Cut out the class and paste it into the new file
    - Import react in the component file.
    - Export the component: `export default StorePicker`
    - In `Index.js` import StorePicker, note that the path will be `'.components/storePicker'`

And there you go, that is the basic component making loop! Here is the finished Index.js file:

```jsx
import React from 'react';
import {render} from 'react-dom';
import StorePicker from './components/storePicker'

render(<StorePicker />, document.querySelector('#main'))
```

And here is the StorePicker component so far:

```jsx
import React from 'react';
class StorePicker extends React.Component {
    render(){
        return <p>Hey</p>    }
}

export default StorePicker;
```

## Using JSX to make the component do more than say 'hey'

Now we have the component set up, lets look at how we can use it more practically. But there are some gotchas:

- **className** is needed instead of class. Class is used elsewhere in JSX.
- If you have a set of statement it could look messy so you might try to do it on a seperate line from return:
        
    ```js
    return 
    <form>Etc</form>
    <p> more stuff</p>
    ```

    This will fail as JS will add an invisible semicolon after the return. A workaround is to use brackets which forces it to leave the semicolon till after it has evaluated the brackets:

    ```js
    return (
    <form>Etc</form>
    <p> more stuff</p>
    )
    ```

- A render method can only return one element. The element can have child elements but it doesn't allow sibling elements. A workaround is to use a `<React.Fragment>     </React.Fragment>` tag which lets us bundle up elements. Blank tags `<>` will be useful but coming soon...

- Comments are done via {/* Comment */}. The curly braces denote JS by the way. It counts as an additional element so be carefuol where you put it.

Anyhow lets make StorePicker into a more useful kind of form:

```js
class StorePicker extends React.Component {
    render(){
        return (
            <form className="store-selector">
                <h2> Please enter a store </h2>
                <input type="text" required placeholder="Store Name" />
                <button type="submit">Visit Store </button>
            </form>
    }
}
```

## Styling for our first component

Styling components is quite an in-depth topic. We could add a link to a stylesheet on the index.html.

*Componentised CSS* involves importing CSS that relates to a component so it is seperated. There is some debate on this but for now we can go a middle way and import CSS on the Index.js:

`import './css/style.css'


Create-React-App is smart enough to turn the CSS into a style tag so it will hot reload while we are developing our app.

In my next post I will talk about putting a bunch of react components together.

----

--------- Chapter 19 --------











PART3: Learning React Part 3: Putting our Components together

# Introduction

This is part 3 of my React Learning series. Using knowledge gleaned from [React For Beginners by Wes Bos](www.reactforbeginners.com) 

 Last time we explored:

- Setting up the tutorial environment from React for Beginners.
- How to create a component
- How to import and export it
- How to use JSX
- How to apply a basic style to index.js

Now lets look at stringing a few components together onto a page.

## App - The Parent Component

We first need a root or parent component to centralise and share data, methods across the three sibling components as follows:

- **App**
    - Menu
    - Order
    - Inventory

At this point its probably worth mentioning that the course is working on making a restaurant site with three panels (Menu, Order and Inventory) but I'll try to use generic examples where possible.

Anyhow, that is 4 components we need to make. We make them in the components folder and for convention we give them a capital first letter.

### To make the App component we do the following

1. Create the `App.js` file
2. Import React
3. Create App Class
4. Add Render Method
5. Export App Class
   
So this makes the code look like this:

```js
import React from 'react';

class App extends React.Component{
    render() {
        return (
            {/* Divs containing other components can go here*/}
        )
    }
}

export default App;
```

This is a frequent pattern so I will spare you the process for the other components.

# The index.js

For now we can just import App and replace the storePicker to render like so:

```js
render(<App />, document.querySelector("#main"));
```

# Back to App.js

Since this is parent component, we need to include the child components. We can do this by nesting divs inside a parent div. With some styling, we will end up with something like this:

```js
class App extends React.Component{
    render() {
        return (
            <div className="lukies-awesome-store">
                <div className="menu">
                    <Header />
                </div>
                <Inventory />
                <Order />
            </div>
        )
    }
}
```

In conclusion, we now have a bunch of components:

- An App Component which is the one referred to in index.html. This in turn contains:
    - A Header Component
    - An Order Component
    - An Inventory Component

Right now they are siloed, in the next post we will look at how they can pass information to each other and how that information itself is kept.




-------------------------Chapter 20









Learning React Part 4:  Props and Routing 

In the last post we set up a bunch of components, now we need to look at how they can talk to each other. This relies on Props and State.

# Props

When you have an image tag you will use multiple attributes like: `<img class="etc" src="url" alt="something">` So that the image tag has the information it needs.

In React, **props** are those attributes, and a way to get data into that component. So if we want to pass data from App to Header we can do this via props.

In `header.js` we have the following snippet of code:

```js
<h3 className="tagline">
    <span>Great tasting stuff</span>
</h3>
```

If we want to pass in a new tagline from `App.js` we can change the Header component tag to include a prop:

`<Header tagline="Terrible Food" />`

If you now look in React Dev Tools you will see the tagline prop when you select Header.

### How do you use the prop?

```js
<h3 className="tagline">
    <span>{this.props.tagline}</span>
</h3>
```

**A component is an object**, so we can just pull information from the *props* object within it. JSX needs to use curly braces when we need to speak in pure JS by the way.

# Stateless Functional Components

I mentioned functional components in an earlier post. As a recap, if all a component is doing is rendering something then it doesnt need to have all the functionality of a class based component.

Don't use a sledgehammer when a regular one will do I guess. It is just a regular function, however `this` wont work the same way so we can just pass it to the function:

```jsx
const Header = props => (
    <span>{props.tagline}</span>
)
```

# React Router

Routing is all about pointing to certain urls with certain content. If you have used Express you may have already had experience in setting up a route to render a certain view for instance.

You need a router to do something depending on the URL the browser uses.

The routing doesn't come build into react, there are a couple of different routers out there. The two most popular are:

-React Router
-Next.js

We are using React Router for this example.

## Setting up the router

Since everything is a component in React, we need to set up a `Router.js` component

If you recall when we had a list of dependancies we had one called `react-router-dom` this is what we are going to use here. It has a number of components since it handles routing for React Native too.

For our purposes we need:

- BrowserRouter
- Switch
- Route

## Route

The route component takes in several props, the ones we most care about are:

`path` - This states the URL path this applies to (e.g "/")

`exact` - specifies that the path needs to be an exact match

`component` - What component to use, this needs {};



# Building our router component

First we import them: `{BrowserRouter, Route, Switch} from 'react-router-dom'`. We also need to import React for JSX.

Then lets build our router function, this can be a stateless functional component:

```js
const Router = () => (  {/* Clever way of returning */}
    <BrowserRouter>
        <Switch>
            <Route exact path="/" component={storePicker}/>
            <Route path="/store/:storeId" component={App}/>
            <Route component={NotFound}/> {/* Our 404 type page */}
        </Switch>
    </BrowserRouter>
)
```

At the end remember to:

1. Make sure you have imported any components you are routing to.
2. Add `export default Router` to export it!


When we are done, in our `app.js` lets import router by doing: ` import Router from "/.components/Router" ` Make sure to also use the Router tag in place of any placeholder you might use.

Create any new components you have made, such as the `NotFound` component.

You now should have a working router! Note that in the props, when we look at a component, we get some new props such `params` which is useful when it comes to routing.

## Sidenote : What is export default anyhow?

When we specify `export default <function>`, the corresponding `import` will take that function if we dont specify.

However we can have a file with a bunch of functions and pull out what we need with destructuring. For example if you have a `helpers.js` file with functions they can be exported with the export command:

    export function example(){
        return someFunctionality
    }

in the file we need the function we can import it:

`import { example } from "../helpers"`

**Random Note: use defaultValue when setting a default value on an input, as opposed to value. React doesnt like it otherwise**

## Conclusion 

We now can have a basic multipage react application with different components being loaded based on the URL via React Router

We can also pass values from the parent component to the children via Props

In the next section we delve into Events and how things can change based upon user input.


ChAPTER 21 - Events and Refs

Events are how React functions when something happens, such as a button being clicked or a form being submitted. They are used quite a bit in JS, you might know that.

One main difference in React is they are done inline:

`<button onClick={this.handleClick}>Click Me</button>`

Where handleClick is a function availble to the component. there are alot of 'on' events to choose from. Note you *do not* include paranthesis, else it will run on mount.

## Submitting a Form

Like the button, we include an event on the form tag:

`<form onSubmit={this.handleSubmit}>`

Let's assume the handleSubmit method is just a console.log("Hi") for now. We should expect 'Hi' right?

Nope, because **the default behavior is to refresh the page**

We can pass the `event` object to the method to allow handleSubmit to stop the refreshing behaviour with the following method:

`event.preventDefault();`

Now we will see the console.log as the page wont refresh.

## Taking an input and Routing based on that

In this example, let's assume we want a form that goes to a user profile based on an input's value. 

<form onSubmit={this.goToProfile}>

The method currently looks like this:

```js
goToProfile(event){
    event.preventDefault()

}
```

We need to do two things:

1. Get the text from the input
2. Change the page to  /profile/INPUTVALUE


## Getting the text from an input properly

We don't want to just pick it up from the DOM, the DOM should be result, not take part in performing a task. Well there is two ways we can do this. First is `state` which we will get to and generally is the prefered method, but another way is `refs` which we will use this time around.

## Refs

A ref, *references* a DOM element so a method can do things with it. This has had many forms over the years but this implementation is the most modern...at tiem of writing:


1. Add a prop on the input tag: `ref={this.myInput}`

2. Create a ref at the start of the component: `myInput = React.createRef();`


That's how we ref nowadaya. Now we can reference the dom node in any methods on the component. Yay!

Wait no we can't...just doing this within a method however will cause an error! It won't be able to find the 'this' that has myInput. This is quite wierd. `this` should be the component right?

## "this" and Binding Methods

Let's take a slight aside...

Well react has `binding methods`, these built-in methods bind this to the component, normally this is what we use.  However a component's own unique methods *dont have that binding by default because the components extend React.Component* This does not automagically pass to methods we make ourselves in a component.

A solution to this is to bind our own methods, there is two ways to do this:

A constructor function - hopefully you recall from ES6 classes we can make a constructor function and define our methods in there:

```js
constructor(){
    super();
    this.goToProfile = this.goToProfile.bind(this)
}
```

Wow that is confusing, but it makes sure that the goToProfile's 'this' is the 'this' of the constructor which is the component...ouch my poor head!

A new way (which is probably going to be old by the time you see it) is `changing the method to a property that is an arrow function`

Old Method: `goToProfile(event) {}`

New Property: `goToProfile = (event) => {};`

The arrow function binds `this`

In short, if you want to access `this` inside a custom method, turn it into a property with a fat arrow function. Something like this:

```js
nameRef = React.createRef();
createProfile = event => {
        event.preventDefault();
        const profile = {
            name: this.nameRef.value.value
            //Etc. Now nameRef can be picked up and used... why is it value value? Read on...
}
```

## getting a value from an input 

Now the component is capturing details about the input when there is a form submit via a ref.

When the goToProfile method is run, we have asked it to `console.log(this)`, the `this` here is the component. But we can drill deeper:

- `this.myInput` will return the reference
- `this.myInput.current` will return the input for which the ref was placed.
- `this.myInput.current.value` will return the value of the input

As you can see there is quite a few layers involved here! It's a good idea to put this into a variable when we use to to go to that URL.

## Change the URL without refreshing the page using Push State and React Router

Now we can access the data from the form submission we can use it to direct us to the relevent URL.

To do this we use a React Router method called `push`. We have access to React Router since StorePicker is a child of the Router component, so when we look in react dev tools we can see the props that are given by React Router. Push method is actually in an object called `history`, so the command we want is:

    this.props.history.push(`/profiles/${profileName}`)

Note the backticks, and dollar sign. We are using a template string here.

And success we will route to `/profiles/profileName` where profileName is the variable recording the value of the input which is the value of the ref which is on the component.... that simple!

Note how fast it is, react router just needs to swap out the component, and doesnt need to load the whole page. Thats pretty cool!
























CHAPTER 22, Understanding State using Forms!

This is part 6 of my React Learning series. Using knowledge gleaned from [Wes Bos' React for Beginners](www.reactforbeginners.com). Last time we explored:

- Events
- Binding Methods
- Form submissions
- Changing URLs in React Router

Before we delve further into user input we need to look at `State`.

State is a really fundemental concept in React. At its core, it is a simple thing, lets say it outloud together:

`State is an object that holds data for a component that is availible to itself and child components`

This acts as the single source of truth for all parts of the application to refer to. Whenever State changes, React *reacts* to the change and updates components that use that information. In this post we will use a User Profile creation as our example data we want to put into state.

The process for adding things to state can be broken down into a few steps:

1. Generate some data we will want to put into State. This will come from a form submission event in our example.
2. Set up the state in the App component. An object where we want to put the required data.
3. Build a method that inputs into the state. This is done on the same component that holds the state
4. Pass that method to the component that will produce the data we want to input

# Building a profile form to submit

This is essentially a recap of our work in using references in my previous post.

1. The form we build should be a component for easy reuse so lets do that. You can copy an existing component and tweak. Remember to export it, and import and add the form to the component(s) that require it.
2. The component will return a form, build that according the data you wish to capture. Don't forget a button to submit! Some example fields are:
    - name
    - price
    - status
3. Add an `onSubmit` method: `onSubmit={this.createProfile}`
4. Add a createProfile property on the component, passing through event : `createProfile = (event) => {...}`. You can use a method but you must bind it.
5. In the property. Add the preventDefault method to stop the refresh on submit: `event.preventDefault()`
6. Add refs props to your form fields: `ref={this.nameRef}` for example.
7. Add the refs to the component: `nameRef = React.createRef();`. Note that there will be a bunch of references youll need to create..
8. In the `createProfile` property we want the refs to be passed to state, so you might want to combine the refs into an object:

    const profile = {
        name: this.nameRef.value.value;
        etc.
    }
    (Note that everything will be a string when plucking values in this way, so you might need to convert depending on what you are capturing)

So if you have done that right, you will have a form that spits out an object containing the values that were set... but were should they go? They should go into `the State`

# Setting up State in the root App Component

The `profile` object the form creates needs to be sent into State. As this particular information will be used in several components, we have to add it to the App Component. The app component is the parent of all components so state can be shared with its child components. You can use local State for local data.

So on the app.js, we define what we want the empty state to look like. We can either:

1. Use the `constructor()` method and define it.
2. Use a property to set it up.

Let's go with number 2 and our empty state in App will look like this:

    state = {
        profiles: {}
    }

## Building a method to Add to state

Now in order to update state, we first need to have a method *that must live in the same component*. This method must do three things:

1. Make a copy of the existing state to avoid mutations.. We can make a variable and spread for this: `const profiles = {...this.state.person}`
2. Add the profile to the profiles object: people[`profile${Date.now()}`] = profile
3. Add the new profiles object into state using a method call setState:

`this.setState({profile: profile})`

**The finished method should look like this:**

```js
addProfile = person => {
    const profiles = {...this.state.profiles}
    profiles[`profile${Date.now()}`] = profile; //Profile here is the output of the form
    this.setState({profiles}) // this setsState for the profiles property.
};
```

## Passing the method to where the data is produced

Now we have a method, how does our form,which is several levels down have access to this method? See the ....'diagram' below

- App (Method Source)
    - Profiles
        - Add Profile form (Needs to use method)

 Well thats a job for our old friend props! We add these props to each component

 `<Profiles addProfile={`this.addProfile`}>` - In App.js it is a component property

`<AddProfileForm addProfile={`this.props.addProfile`}>` - In Profile.js, its part of props.

## Use the method we passed down through props

In the AddProfileForm component, in the createProfile Property we add the following line:

`this.props.addProfile(person)` - This will run the property from App.js.

And there you go, the data in the submitted form should appear in the App.js State Object!

## Finishing Touches and Conclusion

Once submitted, since the page doesnt refresh, you can reset the form doing `event.currentTarget.reset()`

There are quite a few steps in updating a central state from an individual form component but by breaking the job into small pieces you can avoid panic:

1. The App component needs a state object created.
2. The App component needs a method created that updates a part of its state with a given input.
3. A form component is created to get the data with which to update state with.
4. The inputs are given refs which are set up in the component.
5. The User fills out inputs and clicks submit button.
6. The submission triggers the onSubmit event which calls a property on the component
7. The property gets the forms inputs via the ref and creates an object bundling them together
8. The property runs the App Component's updateState property method that was passed from the App Component via props.

Just take each little bit at a time and you'll be fine. Of course it doesn't just apply to forms but thats for another post...







CHAPTER 23 - Displaying our State.

This is part 7 of my React Learning series. Using knowledge gleaned from [Wes Bos' React for Beginners](www.reactforbeginners.com). Last time we explored:

- Setting up a State Object
- Building a form with refs that submits data we wanted to put into State
- Created a method in the App component that updated the State
- Passed the method down via Props to allow the submission function to use it.

So in the last post te put things into state, lets look at how to get data from an input into the State. We probably want to display that somewhere so lets get the data from State to our Eyeballs.

This follows these basic steps.

1. Build a component which will be a template to display our data
2. Set up a loop to make multiple components for each entry in an object or array.
3. Add a unique key for each entry to ensure React can reference it correctly.
4. Use props to pass data from the state to the display component
5. Use the props in the display component to populate the render method.

# The setup example

Let's assume we have an object in our state which is called `profiles` and contains user profiles *objects* called `user321` or someother unique id. We want to show all of them on a page.

# Building the component with placeholder data

Displaying a bunch of profiles sounds like a job for multiple Divs but we should be smarter than just building them on the original page. We should build a component for the profiles each containing a div, makes it nice and reusable.

Let's call it `Profile.js`. We can copy an existing component and make the class and export default 'Profile'

In the render method we can return a div for each profile, lets do that with just a placeholder inside:

`<div classname="single-profile"> PROFILE GOES HERE </div>`

# Looping through our Profiles Object

Remember to Import the component. I forget that a lot.

Beore we get into loops, Its a good idea to add a profile tag: `<Profile/>` and we should see our profile placeholder if all goes well.
 
Now we need to loop through our Profiles Object and render out each one, JSX does not have any native logic capability so we can use JS.

As it is an object we don't get to use the Array helpers of ES6 normally but we can use `Object.keys(this.state.profiles)` which makes an array of the keys.

So we can do something like this: `Object.keys(this.state.profiles).map(key => <Profile</>)`
which will return each profile key....almost there! But there is a little niggle...


# Adding a unique key

However you will probably notice an error in the console...

`Each child in an array or iterator should have a unique 'key' prop.`

React wants each element to be uniquely identifiable, this helps it be very performant as it uses the key to find things quick. As our keys are unique, we can add a key property to each `Profile` tag like so `<Profile key={key}/>` 

This need for unique names is something to be considered when constructing our objects.

# Passing data from State to the Profile component

Now we have a component rendering for each object, we need that component to use information from the State. To do this we use.... yup, **props**. So that profile component now looks like this: `<Profile key={key} details={this.state.profiles[key]}/>`. The *details* tag is an abitary one, we can choose anything as long as we are consistant.

That will make each component have a prop called `details` where all the information from the object lives. From there we can populate the render method of the Profile component with whatever we would like. There are some gotchas though with JSX:

To use the **img** tag you lose the quotes: `<img src={this.props.details.image}>` 
Same goes for the **alt** property.

Otherwise its just a case of populating the template with the props. A pro tip is to create a variable or two as `this.props.details.xxxx` is quite long thing to type each time!

    const image = this.props.details.image;
    const name = this.props.details.name;

Or we can be extra smart and use destructuring:

`const { image, name } = this.props.details;`

# Conclusion

The process for placing state content into a component that renders it is pretty much all about props, however we need to make sure when we loop through items we do it in a way that allows React to see it as unique. Nothing too taxing, but obviously there is alot of different scenarios this could apply to. But here is what we did:

1. Build the component
2. In the containing component, map through the Object.Keys if its an object to make multiple components
3. Give each component a unique key.
4. Pass in State data via props
5. Populate the component's render method with whatever data you want to give it.

Now that we have gone through one way of adding and retriving from state, in my next post we can look at another way of doing so.






October 22 this is where we are at.






CHAPTER 24 - Adding more things to state and Displaying 

This is part 8 of my React Learning series. Using knowledge gleaned from [Wes Bos' React for Beginners](www.reactforbeginners.com). Last time we:

- Built a component to display data
- In the containing component, mapped through the array (Object.Keys if its an object) to make multiple components
- Gave each component a unique key.
- Passed in State data via props
- Populate the component's render method with whatever data you want to give it.

Let's look again at how we add things to state, this time via a onClick event.

# The setup

This time we are using the example of a shopping basket, with a number of grocery items that has be added to it. We have three specific components involved:

1.  Grocery - A div for each item, Where we also have an 'Add' button for each item
2.  Order - Where we can see what we have ordered with total for that order.
3.  App - The parent component with a state that contains two objects: 
        - `grocery` which displays a specific item on sale
        - `order` which will contain the order for the user. Currently blank.

So the general idea is to:

1. Create a function to add the associated grocery to the order, multiple times if needed.
2. Display the order on the Order component, totting up the prices as required.
3. On the Groceries component, configure a button with an event method to handle the click to add to the order.

# Making an Add to Order function

As we are updating the state on the app component, we want to have the method here as well.
The method must do three things:

1. Take a copy of the relevent part of state
2. In this copy, add a grocery to the order or increment the current grocery by 1;
3. Update the state

## Taking a copy of state

This just relies on using the spread operator:

`const order = {...this.state.order}`

## Add to Order or Increment By 1

This uses a little trick where the OR statement runs the first condition if the item exists or else makes it exist by adding a 1.

`order[key] = order[key] +1 || 1;`

## Use setState to Update the State

`this.setState({ order })`

Note that order is used to update order in the State, thats `order:order` which shortens in ES6 to `order`

Here is the method in it's entirety:

```js
addToOrder = key => {
    const order = {...this.state.order}
    order[key] = order[key] +1 || 1;
    this.setState({order});
}
```

# Passing the Method and Key to the Button's Component

The button we want to add lives in the grocery component which shows details about the particular grocery (name, price.. etc)

As app is the parent of the grocery component we need to first pass the method into props: `addToOrder={this.addToOrder}`

Now we have a slight quandry, the method needs the object key passed into it. As the component is created without visabiity of its own key, how do we get that? `The answer is that we need to pass it through as a prop as well...`

`index={key}`

## Setting the Event on the Button

First lets create the event on the button: `<button onClick={this.handleClick}>`

Second, lets create that handleClick function property on the component:

`handleClick = () => {this.props.addToOrder(this.props.index)}`

Some people might like to put the function on the method inline on the button, but I like seperating it out for clarity.

Cool, if everything has gone to plan we should be able to see items being added to the App state when we click that button. Now for the other side of the equation, displaying what we have just placed into state.

# Displaying the State object on our Order form

Now that we have the state getting updated when we hit our button, we probably should show the result of that somewhere. Much of this going to involve dealing with edge cases that may or not apply in your scenario. Essentially we need to pass in the relevent prop and display the data as we loop through each key.

Our order form in this example, needs to show the following things:

1. The item(s) we have ordered
2. How many of each item we have ordered
3. The price of that item mutiplied by the amount.
4. The whole total.
5. Check if the grocery item becomes sold out and react accordingly.

## Getting the Props

So before we do anything else, in App.js  we need a prop to pull in the `groceries` and `order` objects:

- The `groceries` object contains the name, price and status of each grocery
- The `order` object contains how many of each item has been ordered.

We need both to figure out things so pull them into the Order component like so:

`<Order groceries={this.state.groceries} order={this.state.order}/>`

You might be tempted to add all of the state as thats the only objects in it, but in the sprit of modularity, we cannot be sure that will always be the case so its good practise to be explicit in what you are taking as props.

## Working with the Prop Data

In the Order.js file we can build some variables we could use:

**An array of Object Keys**
`const orderIds = Object.keys(this.props.order)` - gives us an array of each key in the order object. If we display that using `{orderIds}` we should each order item appear.

**A total of all items**
We have to check a few things as we figure out the total via the Reduce array helper method:

```js
    const total = orderIds.reduce((prevTotal, key) => {
        const grocery = this.props.groceries[key] // What
        const count = this.props.order[key];      // How many
        const isAvailable = grocery && grocery.status === "available" // Makes sure it exists and isnt sold out.
        if(isAvailable){
            return prevTotal + (grocery.price * count);
        }
        return prevTotal
    },0 )
```

Remember to actually display, and style the total somewhere: `{total}`

## Loop over the OrderIds

1. In the JSX we are returning, make a <ul> to contain the OrderIds we will display.
2. In the UL, map over the orderIds to return an list item for each item ordered: `OrderIds.map(key => <li>{key} </li>)`

The JSX will look something like this:

```js
<ul>
    {orderIds.map(key => <li>{key}</li>)}
</ul>
```

## Render Functions

By now your render function is starting to get a little long, which is a sign too much is going on in your component. We could make a component for the code but if its not quite big enough we can shunt some of the code to a function inside the component, removing it from `render`

For example we can take the logic for each list item above and put it into a function on the component like so:

```js
renderOrder(key) => {
    return <li>{key}</li>
}
```

Now the unordered list can look like this: `<ul>{orderIds.map(this.renderOrder)}</ul>`

It's a fairly basic example but its something to bear in mind as a middle ground between putting everything in render and making another component.

Presumably you will want to show more than just the key for each order, but that's a detail you can figure out for your own needs! Some extra details may include:

- The grocery name
- The count of orders for that grocery
- The price of (grocery.price * count)
- Check if the grocery is still availible and change the list item should it become unavailible during the order.

Once you start adding that complexity, using a Render method starts making more sense.

## Add keys to each List item

As we have created multiple similar list items, React will get a little upset and warn us about the lack of unique keys for the list items.

This is fairly straightforward to sort since our Grocery Object keys are unique:

`<li key={key}> {key} </li>`

## Conclusion

As long as we set up the props and manage the amount of code in our render function there is little React specific knowledge required for displaying State data. Having a good grasp of JS though will make life easier when it comes to getting the right bit of data from our props and displaying it effeciently. the rest is up to what exactly you want to display with your State data.




------- 
CHAPTER 25: React Persistance with Firebase.

This is part 9 of my React Learning series. Using knowledge gleaned from [Wes Bos' React for Beginners](www.reactforbeginners.com).

We have made a fairly clever CRUD app, where state and props are used to react and update the UI accordingly. So far our React apps have been volitile, as in if we refresh the page or close the browser we lose what we did. What would be great if there was an easy way of mirroring our state to a database. Lucky* for us then, there is!

(*By luck I actually mean thanks to all the awesome people who build such things for the rest of us to use!)

# Introducing Firebase

Firebase is Real-time database from Google. It uses *Websockets* which allows real time changes as opposed to having to refresh via Ajax or somesuch.

First thing we need to get up Firebase, which requires a Google account. I'm going to assume you are cool with that.

Then go to [firebase.google.com](firebase.google.com) and select Add Project.

Give it a unique name and then create it, which will take abotu 30 seconds.

You will be presented with a landing page wit all sorts of toys, Analytics, Authentication, etc. That is quite a few blog posts worth but for now, lets go see about a Database... by clicking Database.

**Choosing a Database**
At time of writing there is Real-time Database and a beta Cloud Firestore as database options. Let's go with `Real-time Database` as we dont need anything fancy right now.

**Security Rules**
By default, the database will want to start in `locked mode`, which stops any read or writes. For now we can use `test mode` which allows all reads and writes. In a production App we wouldnt want to do this obviously, but it will make life easier for now.

**Connection details**
Now we have an empty database, how do we get it to it in our code? From the `Project Overview` link, you should see a `Add Firebase to your Web App Button` which will generate a code snippet we can use.

Kepe that code handy for a second, we first need a file in our app that lets us use that information...

# All about the base.js

We want to create a file called base.js' in our `src` directory which will handle the database connection

It requires the following imports:

1. Re-base, a helpful library to  mirror our state
`import Rebase from "re-base" `

2. Firebase, the main library for Firebase to Databasify (I am making that a word) any other data other than state: `import firebase from "firebase"`

To begin using firebase we need to use the `initializeApp` method with the `apiKey, authDomain and DatabaseURL` as properties. Which we can grab from that code snippet I told you to hold onto about a minute ago.

We can put that into a const like so:

```js
const firebaseApp = firebase.initializeApp({
    apiKey: "blah",
    authDomain: "blah",
    databaseURL: "blah",
})
```

Secondly we need to setup our *Rebase bindings*:

`const base = Rebase.createClass(firebaseApp.database())`

Lastly we need to export firebaseApp as a named export: `export {firebaseApp}`

And base as our default: `export default base`;

# Getting our state to mirror into our Database

Head on over to our App.js and import our base.js:

`import base from '../base`

 Here we need to use a `lifecycle method` called `componentDidMount`. This performs a set of instructions when the component is first loaded onto the page. There is alot of lifecycle methods and worth discussing another time. But for now lets roll with the following method:

```js
 componentDidmount(){ 
    this.ref=base.syncState(`$this.props.match.params.storeId/groceries`, {
         context: this,
         state: "groceries"
    })
}
```

**Lets explain that a little**

`this.ref` - alows us to reference this particular binding should we need to do something with it later.

`syncState` - A rebase method. A two way binding between any property on your component's state adn any endpoint in Firebase. It takes an string argument to specify an endpoint, i.e. to which bit of the database to sync to. Plus an object of further options, `context` and `state`

For the endpoint we want to use the store we generated. We got the store ID from props, and is actually provided by React router, and the `/groceries` makes sure we only sync that part of the state.

`context` - The component we want to sync the state for.

`state` - The property you want to sync with Firebase.

It's a fair bit to take in, but don't be afraid to read the [docs for Re-base](https://github.com/tylermcginnis/re-base)

Thats it! It might look gnarly but thats a short amount of code to quite a powerful action. If we browse to the database on the firebase console, we should see the state/groceries mirrored there. Plus, as it is a two way sync, we can change values on either end and see the change replicate near instantly!

## Doing some cleanup

There is a slight gotcha...

Everytime the component mounts, we set up the sync for a given store. However we never stop it not syncing, it will quite happily continue to watch for changes for that store till the end of time. Or till we run out of memory...

To stop this, we can use another lifecycle method, `componentWillUnmount`. Which runs whenever the component is closed for whatever reason. We can use that to remove our binding:

```js
componentWillUnmount(){
    base.removeBinding(this.ref);
}
```

...and thats why we needed `this.ref`!

## Final Thoughts

I have used Mongo previously, Firebase has a pretty slick way of working too. I think there is a definite series on other Firebase uses worth doing. Probably will forget though.






CHAPTER 26: Using React with localStorage.

Now we have some grocery store items saving in a remote database, we can leverage localStorage to store the user's order so that it isnt just completely lost when they refresh or close the browser.

Lets break it down the basic questions we will need to answer on the way:

- *What* is localStorage
- *When* to save to localStorage
- *What* to save to localStorage 
- *How* to save to localStorage
- *How* to retrieve from localStorage
- *When* to display from localStorage

I think I am going to get really tired of writing localStorage by the end of this post.

# What is localStorage?

*localStorage* or `window.localStorage` is a read-only property that provides access to a Storage object that is saved between browser sessions for that site. It is the sister of *sessionStorage* which, as the title says, exists while the page session does. As it uses object notation, it wants things as a key value pair.

This [MDN Article](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) explains it in more detail.

## How can we use localStorage?

Playing with localStorage is fairly simple:

We can *Add* by doing a `setItem`:

`localStorage.setItem("myName", "James")`

We can *Read* by doing `getItem`:

`localStorage.getItem("myName")`

We can Remove by doing `removeItem`:

`localStorage.removeItem("myName")`

You can remove everything with a `clear`

`localStorage.clear()`

# WHEN to use localStorage

Whenever a user changes thier order we want to send the new value to localStorage. Since React updates a component whenever we make a change to it's state, there is a lifecycle method we can use called `componentDidUpdate()`

# WHAT to save to localStorage

We can't just save just one order object as we are using a different set of orders per store so we need to include the store as the key, and the relevent order as the property. Handily, this is a param provided to us via react router:

```js
componentDidUpdate(){ 
    localStorage.setItem(this.props.match.params.storeId, this.state.order)
    }
```

## Slight gotcha here... Of Objects and Strings ##

localStorage wants the key and property to be a string, however `this.state.order` is an object so you will instead see `[Object object]` how do we fix that?

`JSON.stringify(this.state.order)`

And conversely, we need to do `JSON.parse` to bring it back as an object at a later point.

You should now have your order going into localStorage.

# Reading the localStorage on Mount

While we can get things into localStorage, when we refresh the page, the order in state is blank again. Thats because the `componentDidMount()` method, triggers an `componentDidUpdate()` to nothing. To fix this we need to reinstate localStorage as part of the component mounting:

1. First pick up the localStorage string from params: `const localStorageRef = localStorage.getItem(params.storeId);`

2. Secondly, set the state while converting it to an object `this.setState({ order: JSON.parse(localStorageRef)})`

## Asynchronous issues

Now that we have the order being read on mounting we will encounter an issue.

localStorage is now carrying an order which refers to groceries which, in our previous post, is coming from Firebase. since Firebase is cloud-hosted, it will never be ready before the data from localStorage needs it. It will say something like `cannot read Status of undefined`

**How do we fix that?**

The update that contains the information from Firebase only takes a moment to arrive so here it is a case of holding off working on the values till it has loaded. The offending line is in the Order Component:

`const isAvailiable = grocery.status === "availiable";`

We can change that to:

`const isAvailiable = grocery && grocery.status === "availiable"`

However, for the split second it takes for the data to arrive, the order will display the messae saying the item is unavailible which is messy, so a smarter way is to simply say:

`if(!grocery) return null`

This wont render anything till we have the database of groceries ready to go.

## Conclusion

Using localStorage is a fairly straightforward process, there is just a few gotchas you need to be aware of. The worse of which is the timing ascpect around accessing the database. A good understanding of lifecycle methods in React helps with this...perhaps thats a post for another time.





Chapter 26: Editing And Deleting Items from State


This is part 11of my React Learning series. Using knowledge gleaned from [Wes Bos' React for Beginners](www.reactforbeginners.com).

So far we have our application beign able to Create and Read. Let's look at Updating and Deleting to getthe whole CRUD thing going on

Coming from a REST API point of view, When we create an Edit form, we have four main steps:

1. Get the data that currently exists for an item.
2. Show the data for the user to look at
3. Allow the user to edit the data they are being shown.
4. Put the changed data back to replace what was orginally there.

React is a similar story, we can use a component, props and state to get up a two way data flow to keep things up to date. The joy of react is doing this 'live', seeing those values change the moment the user changes them as opposed to needing a submit action.

## Setting up our Edit Component

First of all, lets see about making a component to show the item details we want to edit. Of course, since we are being awesome React devs, we will build a single Edit component inside of our Inventory component and loop through our Groceries object, each time populating the Edit component with existing data for each Grocery.

1. Make a new class based component called EditGroceryForm
2. Import React
3. Export the `EditGroceryForm` class function you made
4. For now, lets set the render method to just return a placeholder like `<p> hey </p>`

We will flesh it out some more once we have it integrated into our Inventory component.

## Adding the State data and Edit Form to our Inventory

There are core things we need in our Inventory component, the state data for our groceries and an edit form for each of them  

1. The parent *inventory* component currently does not have access to the groceries object in state so we need to pass in the prop: `groceries={this.state.groceries}`

2. Remember to import the EditGroceryForm into our Inventory Component.

3. Map through the groceries object and return the EditGroceriesForm component:

`{Object.keys(this.props.groceries).map( key => <EditGroceryForm grocery={this.props.groceries[key]} key={key}/>)}`

Some things to note in the above:

- We need to need a prop to pass through each grocery.
- We need a second prop to pass through the key called index
- We add a key to make sure each component is unique

If all goes to plan, we should have multiple components rendered. However we probably want to show something more helpful than a paragraph tag so lets flesh it out some more...

## Setting up the Inputs

So for an edit form to work we do need some inputs. For each grocery we have the following fields:

- name (input)
- price (input)
- status (select)
- desc (textarea)
- image (input)

If you have already created an add form, it might be useful to copy from there and tweak it.

**The really important bits**
- Each of the form elements should have a name property: e.g `name='price'`
- The value property should be pulled in from props: e.g `value={this.props.grocery.price}`

However we will get the following warning at this point: *Failed Prop type. You provided a 'value' prop to a form field without an onChange handler*. Basically will stop us from editting the field as soon as we try to update the field, it will replace it with the entry in State. So **we need to change state to change the input** which we can do with an onChange event.

## The onChange event

First add the event to the form fields: `onChange={this.handleChange}`

Then we want to make a method that will:

1. Get the value that was entered (but not displayed)
2. Create a copy of the current grocery from state
3. Figure out what value has changed
4. Update the copy with the new value.

```js
handleChange = event => {
        const updatedGrocery = { 
            ...this.props.grocery,
            [event.currentTarget.name]: event.currentTarget.value
        }
    }
}
```

Lets explain that last line a little:

- The `event.currentTarget.value` gives us the value of whatever input triggered the event...

- The `event.currentTarget.name` will tell us what the name propery of the target was. However wrapping it in the square brackets allows us to use it as a dynamic *computed property name* so it will change the property based on the name value of the input. This is a little wierd but allows all the inputs to need only this one method.

That was a little frightening, but we have one last thing to do, update the state with the updated Object we have just made.

## Updating the state

Back in our **App** component we can make a property for the function that updates the grocery. This requires two arguments:

1. `key` - the key for the particular grocery we want to update
2. `updatedGrocery` - the new grocery we want to replace it with... which should sound familar...

This will perform three jobs:

1. Take a copy of the state: `const groceries = [...this.state.groceries]`
2. Update the copy : `groceries[key] = updatedGrocery`
3. Set the updated copy to state: `this.setState({ groceries })`

This is what you should end up with:

```js
updateGrocery = (key, updatedGrocery) => {
    const groceries = {...this.state.groceries}
    groceries[key] = updatedGrocery
    this.setState ({groceries})
};
```

Now we have the property, we can pass it to the Inventory using Props: `updateGrocery = this.updateGrocery` In our **Inventory** component we again need to pass it into our **EditGroceryForm component**. However we should now have the updateGrocery method availiable in our EditGroceryForm component.

However, for the property to work it needs to know the key, the EditGroceryForm component doesnt know what key it is referring to unless we pass that through as a prop. Since we already have a key, lets call it index: `index = {key}`

So now we have access to it, lets use the method to complete our event:

```js
handleChange = event => {
        const updatedGrocery = { 
            ...this.props.grocery,
            [event.currentTarget.name]: event.currentTarget.value
        }
    this.props.updateGrocery(this.props.index, updatedFish)
    }
```

We now have the input changing state which changes itself based on the user's input! 

# Edit - Overview

Using inputs to change values is actually fairly straightforward conceptually:

1. Set up an input
2. Make an event to capture the user's input
3. The user's input updates the state
4. The state updates the input.

However, to do it requires a fair amount of props and props flying around so its something that can easily go wrong if you dont take it step by step.

# Appetite for Destruction

So we looked at sorting out an edit form. This means that so far, we have been able to:

- Create an item
- Read an item
- Update an Item.

So you can assume the last thing will be...

**Delete an Item**

This one isnt too tough as its similar to the process we had before, but even easier. The basic steps are:

1. Make a method that deletes a certain property from the groceries object.
2. Create a button to trigger the method
3. Pass the method down to where the button is

# Our delete method

The delete method is created on our app.js as that is where our state is. It needs to do the following.

1. Take in a key so we can find the right item to delete.
2. Make a copy of the state.
3. Set the value of the item to null
4. Save the modified variable to state.

You might wonder why we dont just delete the item?  Well as we are using Firebase, it will have trouble syncing something that doesnt exist so its best to keep the key but with no value.

So to delete a grocery the method should look like this:

```js
deleteGrocery = key => {
    const groceries = {...this.state.groceries};
    groceries[key] = null;
    this.setState({groceries})
}
```

We can test it in the console by using $r to select the app component and running: `$r.deleteGrocery('grocery1')` (assuming 'grocery1' is the key)

# Hooking that method to a button

We have the method but we need a way for the user to run it. A button with an event should do the trick!

We can use the edit form before to add a button as follows:

`<button onClick={ () => this.props.deleteGrocery(this.props.index)}> Delete </button>`

Here we use an inline function to just do it on one line.

Now the last thing to do is pass the deleteGrocery method down to the EditGroceryForm component where the button lives.

I think have talked about props enough but here is the gist of what we want:

- `deleteGrocery={this.deleteGrocery}` ... from App JS
- `deleteGrocery={this.props.deleteGrocery}` ... from elsewhere.

If you have your props, button and method correct. It should all work!

# Deleting Wrap Up

You should have your deleting sorted. Generally it is easier than editting as you dont need to worry aboout swapping it with another value. Just remember to be aware of circumstances where you can actually delete and where its best to leave a 'null stub'




Chapter 27 - Proptypes

We have used props a lot so far. They are pretty key to getting things to work well so it would be good to have some checks on what is getting passed.

This is what propTypes are for.



# My First PropType

First of all if we want to use PropTypes we need to import it:

`import PropTypes from "prop-types"`

If you don't do that, little will happen.


Right, lets take the following *functional component* as an example:

```js
const Greeting = props => (
    <p> Hello my name is {props.name} </p>
);
```

Here we need:

1. `props.name` to exist
2. `props.name` to be a string.

We can add a propType to a functional component by adding a property called propTypes to the Greeting object **after we have defined it**:

```js
Greeting.propTypes = {
    name: Proptypes.string.isRequired
}
```

So now we have added a check which fails if we dont pass in the prop or if it isnt a string. This produces a warning you can view in the console. Really handy if you are forgetful like me!

# Adding a Proptype to a class-based component

You can add propTypes to a class based component. Whereas in a functional component we added a property afterwards. We can define our proptype inside:

(Again, first import PropTypes else you will be upset...)

```js
class Tree extents React.Component {
    static propTypes = {

    }
}
```

# Other Uses of Proptypes

This is just scratching the surface of proptypes. One useful proptye is `shape`.


We can always look at the React documentation to see all the other ways we can use proptypes.

One additional caveat is that when we eject into production we wont have them as they are a development tool.








Chapter 28 Authentication!

In our app we have:

- Menu - where users can choose what to order
- Order - where users can see what they have ordered
- Inventory - which dictates what is availiable to order

In a real-life app, we might want to restrict the Inventory to an owner. This is what we are going to do in this post using Firebase Authentication to use Github, Twitter and Facebook login.

The process consists of the following parts.

1. Set up Authentication Providers with Firebase
2. Produce our login handling component and Build an `authenticate` method to request authentication from the relevent signin provider
3. Build an 'authhandler` method to do stuff once we have the results from the authenticate method.
4. Set up logic within the Inventory component to display relevent component
5. Implement Firebase rules to effectively lock it down in the backend.

So lets get started...

# Part 1 - Setting up our Authentication Providers

This section is all about setting things on the backend, in our case the back-end is actually Firebase and the services we want to authenticate with.

For each sign in provider there is two main steps:

- Configure Firebase with API details from a sign-in provider
- Obtain API keys and configure  settings on the sign-in provider's developer site.

## Facebook Authentication

1. Go to [your Firebase console](https://firebase.google.com) and go to `Authentication`
2. Select `set up sign in method`
3. First set up Facebook, it will want an `App ID` and `App Secret`. Also note that it provides a `URL` to return back to after the authentication attempt. To get this we need to go to the [Facebook Developers site](https://developers.facebook.com)

4. Select `My Apps` and then `Create a New App`
5. Once you have created the App you want to go to `settings` and `basic` to retrieve the App ID and App Secret. An App Secret is really important so be careful about where you store that info.

6. YOu may need to add Facebook Login to your App, just next through the options. The option to add Facebook login should be easily found.
7. Goto `settings for Facebook Login` and *enable Browser OAuth login*
8. Copy the URL we referred to in step 3 and paste it into the field called *Valid OAuth redirect URIs*

9. Go back to Firebase and click `save` on the Facebook setup prompt

## Twitter Authentication

1. Follow steps 1-3 as before but this time select Twitter.
2. Go to apps.twitter.com and `create a new application`
3. In the form add the callback URL you get from Firebase, fill out the ret as you see fit.
4. You should then have access to the API key and API secret to paste into Firebase.

## Github Authentication

This is fairly straightforward:

1. Follow steps 1-3 as before but this time select Github.
2. This time the url is [https://github.com/settings/developers]
3. Register a new OAuth application, and paste the Authorization callback URL from firebase
4. The Client Id and Client Secret will be now availiable to add to Firebase.

As you can see its a fairly similar process for most sign in providers once you navigate through thier various developer sites.

# Part 2 - Login Component and Authentication Method

The first half of the proces is setting up the app to send a sign in request 

Now we have Firebase ready to use a sign-in provider we need to provide the code to use it on a login page of some sort.

The steps to do this are:

1. Set up a test Login Component
2. Configure the parent Inventory Component and create an authentication method
3. Pass the authentication method to the login via props
4. Configure the login component to use the authentication method.

In the second part we will look at what we do once we have attempted authentication.

## Setting up and Testing the Login Component

The login component will exist to render some buttons to allow sign in to various providers. As it will do little else we can just make it a *stateless functional component*.

Lets just keep it simple to test it works:

```js
import React from 'react'
const Login = props => (
    <button>Github Login</button>
);
export default Login;
```

In our Inventory component let's see if we can get the login to render by first importing our Login component:

`import Login from "./Login"`

And then insert another return at the start of the render method, effectively redirecting the Inventory component to display the login component only for now:

`return <Login />`

Once we are happy nothing dumb will stop this from working lets delve into the methods we need on the button.

## Making the button do something...almost

When we want to click on the button, we want it to begin the authentication process for the signin provider we want. For the rest of this post, ill focus on getting Github signin working and trust you can logic out doing the same for other sign-in providers. 

So let's change our button in the login component to:

1. Call a method in props called authenticate. This doesnt exist but it will soon. 
2. *Assuming we will have more than one type of sign in button*... as a parameter for this method we will take the name of the provider with a capital letter. Why a capital? I'll explain that too in a bit, I promise.

Now our Github sign-in button in the Login component looks like this:

`<button onClick={() => props.authenticate('Github')}> Sign in with GitHub </button>`

Note in a functional component, we reference props by passing the parameter through as opposed to using `this`

Also, don't forget to add the PropTypes, something like:

`Login.propTypes = { authenticate: Proptypes.func.isRequired}` 

## Building the Authenticate method

As authentication doesnt involve state at the top level we can write the authentication method at the Inventory component level which otherwise is deciding if the login component needs to be shown.

First, make sure to import Firebase else little will happen, Firebase has the methods we need to make this easy:

`import firebase from 'firebase'`;

We also need to refer our base compononent (SEE THE DATA PERSISTANCE POST)

`import {firebaseApp} from '../base'`

1. For the method we pass in the value from the button as `Provider` (i.e "Github"). This is a clever way of checking the signup provider
2. We specify our auth provider
3. We use firebase's methods to produce a popup that uses the auth provider specified to prompt for iign in

The code looks something like this:

```js
authenticate = provider => {
    const authProvider = new firebase.auth[`${provider}AuthProvider`]();
    firebaseApp.auth().signInWithPopup(authProvider).then(this.authHandler)
}
```

# Part 3 - Handling the authentication response

The last line of that code snippet calls `authHandler` which is all about what our app does once the authentication data is returned.

```js
authHandler = async authData => {
    console.log(authData);
  } 
```

If all went went so far. You now should be able to sign into github and see an object returned to the console.

On our use case, authhandler needs to do three things:

- Look up the current store in the firebase DB
- Claim it as current user if there is no owner
- Set the state of the inventory component to reflect the current user so it now knows who is logged in.

## Look up the current store in the firebase database

We need to look up the current store and see if there is an owner, to do that we need to look at our database so import base from our base component:

`import base, {firebaseApp} from '.../base'`

Then we need to fetch details about the current store. But **wait**, we first need the Inventory component to know the storeid which we can get from the parent App component (which itself is getting it from React Router):

`storeId ={this.props.match.query.storeId}`

So back in our authHandler method in the Inventory component:

`const store = await base.fetch( *STORE GOES HERE* )`

To get the store name we need to pass the prop from App:

`storeId={this.props.match.params.storeId}`

So the finished command in authhandler looks like this:

`const store = await base.fetch(this.props.storeId, {context: this})`

If we don't use await here, store will be the promise as opposed to the result of the promise which is what we want.

## 2. Claim ownership if no current owner

Next we need to check if there is an owner, if not we save the owner information to the firebase DB.

```js
if(!store.owner){
    await base.post(`${this.props.storeId}/owner`, {data: authData.user.uid})
}
```

At this point  we should be able to check in the Firebase DB if an owner is being set.

## 3. Set the state of the inventory component to reflect the current user

To work out what to do when a user logs in we need to know two things:

- What is the UID of the newly logged on user?

- Who is the owner of the resource? If any?

The setstate command looks like this:

```js
this.setState({
    uid: authData.user.uid,
    owner: store.owner || authData.user.uid
})
```

As we dont need this information elsewhere we can set State locally to the Inventory Component as opposed to the parent root app. This requires setting up state on the component:

```js
state = {
    uid: null,
    owner: null
}
```

The entire authHandler method looks like this:

```js
authHandler = async authData {
    if(!store.owner){
    await base.post(`${this.props.storeId}/owner`, data: authData.user.uid)
    }
    const store = await base.fetch(this.props.storeId, {context: this})
    this.setState({
        uid: authData.user.uid,
        owner: store.owner || authData.user.uid
    })
}
```

If everything has gone well you should be able to log on and see the new keys in Inventory's state and an owner value in the Firebase DB store.

# Part 4 - Displaying the right content

The inventory render method will need some logic to check the following scenarios:

- IF they are NOT logged in THEN Show login component
- IF Logged in and NOT the owner THEN Show "Do not have access message"
- IF Logged in AND the owner THEN Show the inventory Component

Aside from this, we also want to make a logout button to allow a different login if need be.

Lastly we don't want to logon each time we refresh the page so lets recheck the current user automatically.

## If NOT Logged In

The uid contained within State determines if they are logged on so we just need to return the login component if there isnt a uid availible:

`if (!state.uid) {return <Login authenticate={this.authenticate} />}`

## Logged in but NOT the owner
Easy enough, we need to compare the uid in state with the owner in state:

`if (this.state.uid !== this.state.owner){return <div>You are not the owner</div>}`

You will probably want to spruce that up with a better response than a plain div but it will do for now.

## Logged in as the owner
If they pass the first two tests we know they are the owner and can return the component as normal.

## The Logout button
Ideally this should be a component but for the sake of brevity we wil define a JSX variable inside the render method:

`const logout = <button onClick={this.logout}>Log Out</button>`

We can then place the button on the 'not owner' and 'owner' return paths

## The Logout Method

The button calls a method which doesnt exist so we should sort that out, there is two tasks to do during logout:

1. Sign out of the auth provider
2. Clear the state of the current user details

This can be done in a line each:

```js
logout = async () => {
    await firebase.auth().signOut();
    this.setState({uid:null})
}
```

## Rechecking we are logged in

When we refresh the page it would be good if it can check to see if we are logged in to avoid the login prompt. We just need to use the `componentDidMount` lifecycle method to:

1. Get Firebase to check if there is a user
2. Pass that user to our authHandler method

```js
componentDidMount(){
    firebase.auth().onAuthStateChanged(user => {
        if(user) {
            this.authHandler({user});
        }
    })
}
```

# Part 5 - Securing the Firebase Backend

All that we have done so far is secured the client side, a determined person can still access and change the information in Firebase as we have left it open for anyone to read anad write.

Luckily for us, this is fairly straightforward to do:

1. Go to Firebase
2. Go to the `Database` section and then `Rules`

This should get you to the rules section of the database where previously we allowed both read and write to be true:

```json
"rules" : {
    "read": "true",
    "Write": "true"
}
```

Instead we need to change this as follows:

```json
"rules": {
    ".write": "!data.exists()",
    ".read":true,
    "$room": {
        ".write": "auth != null && (!data.exists() || data.child('owner').val() === auth.uid) ",
        ".read": true
    }
}
```

Lets explain that:

1. Read access is allowed for everyone anywhere.
2. A user can only write at the top layer (i.e where a store goes) if there is no current store (ie No data exists)
3. Within a store ($room) write is only allowed if:

- auth isnt null (the user is logged on)
- Either, no data exists or the existing owner matches the current one

# Conclusion

I have written about authetiacation with Passport JS before. This, overall, seems a little more friendlier as firebase handles some of the heavy lifting. Plus using async and await avoids some of the callback hell I experienced before.

Hopefully the above is enough to get the authentication ball rolling when it is needed. However I think some time with the Firebase docs when trying to use it would be a good idea.

Breaking it down into small steps is definately the way to avoid losing your mind when it comes to authentication.




Chapter ....28??? - Building and Deploying a Create-React-App App

In the React for Beginners series we have been using `create-react-app` to get ourselves up and running with React. However there comes a time where every fledgling app must leave the nest. This post covers how to productionise your app.

The main steps are as follows:

1. Run the Build Script to build our production ready app
2. Configure and Deploy to a Hosting Provider

And not quite needed but useful... how to eject from create-react-app so it is just a plain old react app which is more configurable for more advanced users.

# Building our App for Production

This process strips away any development specific features, compresses and optimises our application to a format that is ready to deploy into production.

## Stop the App
The first step is to stop the application from running if it currently is. Easy enough I hope.

## Build Our App
In our package.json file we have a script caled build we can run to magically make our build we run it with:

`npm run build`

This will take a few moments to run but you should end up with a new `build` folder in the root folder of your application.

## The Build Folder

We can explore the build folder and see what has happened. The main things are:

- The folder structure of before, and node modules have been replaced by a more standardised one.
- All the React code has been squished into one super efficient JS file
- A source map file which helps devs navigate through it to the source files should errors occur
- Some service workers have been set up, which can aid offline use but thats probably for a blog post next year!

The build folder is almost a static site, what we want to put onto a server somehow. There is one catch: *the server needs to be made aware that any routing should redirect to the root so that the client, with React Router handles in on the page*

# Deploying to Hosting Services

Now that we have our app built for production, we need somewhere to put it. This section goes through the basic steps of deploying to some of the different hosting providers out there, bearing in mind the little catch we just mentioned...

## Deploying to Now

Now from Zeit software. This is a service you can use to easily bring sites up from your own server. We do need to tweak our app to use a package that will allow it to be served correctly on the Now service.

1. Install Now via you command line - `npm i -g now` This will install the now command globally.
2. Install serve into the app - `npm i serve` This is a package to let us serve it with the right options.
3. In package.json rename the `Start` script to `Dev` - This is because we are making a new start command that uses serve.
4. Make the new start script - `"start" : "serve --single ./build` This uses serve to run it as a single page application in the build folder.
5. Run Now in the command line - `now` (you might need to register) to start deploying the site.

This should now have your application up and running a temporary url. You can configure this somewhat, but I will leave that to the Now Documentation to explain. 

## Deploying to Netlify

Netlify is a relatively new kid on the block which I think is very easy to use and very highly recommended.

1. Install the Netlify Command Line Tool globally - `npm i netlify-cli -g`
2. Deploy using Netlify from the Root App folder - `netlify deploy`. Specify `build` as the current path to deploy.

All done? Nope!

If we refresh the page it will break as it cannot handle the routing. To fix this we need to create a redirects file in the build folder that will configure the routing to act as a single page application. This info can be found in the Netlify docs.

1. In the build folder create a file called `_redirects`
2. Open it up and add the following: `/*   /index.html 200` which instructs netlify to always point to index.html with a 200 status code.
3. Netlify deploy again from the Root App folder

Netlify is now happily running the app. Probably

## Deploying to Apache

An apache server, such as GoDaddy is a possible destination for your react app. One main gotcha is that its highly recommended to deploy a React app as a subdomain rather than a folder else the routing gets screwed up.

1. Upload the build files to the server via FTP, its a good idea to use the same folder name on both.

And it will work right? Nope... you guessed it, the redirects will not work. To fix this on an Apache server  do the following:

1. In the server's root app folder, make a file called `.htaccess`
2. Open it up and add the following:

    RewriteBase /
    RewriteRule ^index\.html$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.html [L] 

That basically forces itself to redirect back to index.html. A bit like the Netlify redirect but longer.

It's not like you are going to remember the exact steps for every hosting method, but its important to appreciate the common things that can go wrong when its a single page application. If you have certain server type then you can just google your server/hosting type plus `single page app` and you should find a configuration that works.

## Final Step - Sorting out Firebase

To make authentication work fully regardless of which host you use, there is one thing left to do with Firebase

Firebase needs to know what domains it is going to used from. So whatever domain is chosen we must tell Firebase that is the case.

1. Go to [console.firebase.google.com]
2. Go to the `Authentication` Section
3. Under `availiable domains` enter your new domain

Once you have done that, your React app should be up and running and ready to take on the world!

# Ejecting from Create-React-App

Finally, lets imagine a scenario where we need a little bit more control than Create-React-App allows. It allows us to strip away all the training wheels and show thing as they really are. I am definately not at the stage where this is helpful to me but for completeness this is what you do...

The command is simple: `npm run eject`

It will now eject your app out of create-react-app!

If you look in package.json now, you have a huge list of packages! You also have access to the Webpack to do all sorts of tweaks to your App.

# Final Conclusion

Thats the end of the series. There is more fancy things to learn but this is enough info to help get a react up and running. Whenever I focus on a new framework/library/tool/tech I feel like my core JS skills atrophy, so I expect my next posts will be a back-to basics look at JS stuff. Good luck, have fun!