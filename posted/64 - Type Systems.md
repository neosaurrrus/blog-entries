

I recently attended a webinar by Roy Derks and it inspired me to get into type systems since they are an awfully dry subject to try and get the concept and usefulness across.

Type systems is getting more popular in the Javascript world with Typescript by far the most popular as we begin 2021. With React being pretty popular with me, I wanted to get into Typescript via the world I am familiar with. And write about the landmines I step on along the way! By the way, I am assuming you know a little bit about React but nothing about Typescript.

In this post I will look at:

- What is Typescript
- What Types are
- Starting a  React App with Typescript support built in
- Our first TSX Component, and Typescript error.
- Common Types in Typescript
- Examples in Functions, Events and Children

The post ends fairly abruptly. As I often do, this is just a post to whet the appetite and get the ball rolling to get into things enough to research when using it for other things. Sound fair? Ok let's go...

## What is Typescript, how is it different to use  Javascript?

Typescript is known as a superset of Javascript. In other words it adds extra functionality on top of Javascript. Javascript with Types is a good 3 word explanation. 

The nice thing about Typescript is that it has a compile step which turns it back into Javascript. So that means it is quite easy to dip your toe into Typescript without having to do anything radically different to writing Javascript.

Having a compile step does mean that it has to be ran before your browser can make sense of it. If you have been using frameworks like React however, this shouldn't be an alien concept.

Typescript files have a `.ts` extension as opposed to `js` in case you stumble across them. In React, components will use the `tsx` extension.

## Ok, sooo... whats the Type in Typescript all about?

Programming languages come in two flavours. Statically typed or dynamically typed. Dynamically typed languages like Javascript don't make it something we need to consider, at least when writing the code initially 

In statically typed languages we say what datatype it is before running it (i.e Age is an integer, Name is a string). In Javascript we never do that so we can do things like this without a thought:

```js
const age = 12;
const another_age = "12yo";
const book = '1984';
const year_of_birth = 1984;
```

JS doesn't ask you what datatype you intended, which is nice except then it takes that decision itself which leads to some interesting results. In the example above, adding two of those variables can result in a variation of results. With Javascript we don't see these errors till the code is running, and is so much harder to debug


Static typing allows us to catch errors much easily. If something is not defined with a type, or against its type definition. It gets thrown up at the compile step allowing us to address it before it gives us a headache later on.

There is more to TS than just that but lets keep it simple for now.

## "OK, lets get started with it"

Lets get started with installing create-react-app with typescript installed.

`npx create-react-app my-app --template typescript`

If you already have a an existing create-react-app app you want to convert to use typescript you can see see the relavent [create react app guide](https://create-react-app.dev/docs/adding-typescript/)

If you rolled your React app without Create-React-App, then there are too many possibilities to advise.

Anyhow after a fresh new Create-React-App, you will notice that the typical starter JS files `Index` and `App` now have the tsx extension. You will also see some other new TS files. Its slightly disturbing seeing something familiar become slightly weird but we will get there../

It's important to note, it will still allow us to use regular JS components if we wanted to (say, if you have old components you want to migrate to TS later). If you check the `tsconfig.json` in the root of the application, there is an option to change this called 'allowJs'. As I said earlier, once you have Typescript setup it doesn't mean you have to always use it... but yeah, this would be a pointless blog post if I didn't! If you are converting JS files to JSX files you may need to restart the server to get react to realise it.


Speaking of which, you can start the server as you would any create-react-app with a `npm start` or `yarn start` depending on which one you like using.

## Our first TS component, lets do proper props.

We can create a component as we would otherwise but this time rocking the new `jsx` extension:

```js
import React from 'react'

export const OurFirstTSXComponent = () => {
    return (
        <div>
            <h1>Hey this is in Typescript!</h1>
        </div>
    )
}
```

That shouldn't be too shocking. If you are running the React server you should see the component works as you'd hope. Regular JS is fine till we start using some of things Typescript cares about. Like say, props....

```js
import React from 'react'

export const OurFirstTSXComponent = ({username, isMorning}) => {
    return (
        <div>
            <h1>Hey this is in Typescript!</h1>
            <h3>Hello {username}</h3>
            {isMorning && <h3>Good Morning</h3>}
        </div>
    )
}
```

If you have the server running, this is the point typescript starts to get interesting.

Basicially we have a two props, a string and a boolean...and our first Typescript error! 

> Type '{}' is missing the following properties from type '{ username: any; isMorning: any; }': username, isMorning

Which is it polite way of saying you haven't said what those props are! Nte that the linting rules will do its best to highlight where issues exist. Anyhow lets sort that out in three steps:


Step 1: Define our props. In the component lets say what props we are going to have.

```js
type Props = { //'Props' is an arbitrary choice 
    username: string,
    isMorning: boolean
}
```

Step 2: Assign the props given to that Props object.

```js
export const OurFirstTSXComponent = ({username, isMorning}: Props ) => {
```

Step 3: Actually give the component props in the parent component. Since we said it was going to have `username` and `isMorning` props, we better provide them:

```js
 <OurFirstTSXComponent username="tom" isMorning={true}/> //really regret that component name now!
 ```

To those of you who are used to Proptypes, that should not be too shocking. But as we have just seen, typescript tells you if there is an issue on compile which ensures it gets dealt with.

## That's cool but what if a prop is Optional?

Short answer, using ? makes the prop optional:

```js
type Props = {
    username?: string,
    isMorning?: boolean
}
```

In regular React, props are optional which, if you are like me, means I often include things that later on I don't need. Typescript, as you have just seen, makes us very explicit about the props we want and optional props are now the exception which is probably for the best.


## And what about default Props?

Thats a fair point. As a quick reminder, default props in react allows us to ...well, set a default value for our props:

```js
OurFirstTSXComponent.defaultProps = {
    username: "Alice"
    isMorning: false
}
```

In Typescript we can use classic JS way of setting default values inside of Parameters:

```export const OurFirstTSXComponent = ({username = "Alice", isMorning = false }) => {```

Easy! If you don't do anything else with Typescript you already are getting some benefits. But sorting our props was just paddling in the lake of Typescript so lets get swimming into some deeper waters and look more closely at types and how they relate to functions.


# So what are some types in Typescript?

This probably won't shock you but types are the foundation of Typescript, we touched on a few when looking at props. It's good to get more familiar with at least the ones you use in regular JS. 

## Common Garden Types

First of all lets cover off the ones that should not need explaining:

- String
- Number (also bigints)
- Boolean

But wait? How do you say a variable is a string exactly? Well this is the syntax you will see a lot when it comes to Typescript:

`let isHappy: boolean = false;` 

As opposed to a two-step process with `let isHappy = false` there is three steps which I call `assignment-type-value`. The typescripty bit is the `: boolean` in the middle that says what type we want the variable to be.





## New Types on the Block

Here are a few more basic types you might come across that are found in Typescript:

**Arrays** can be declared stating what you expect them to contain: `let scores: number[] = [1,2,3,4]` is an array of numbers.
**Tuples** are Arrays' more formal sibling and allows you express an array of fixed length where the types are known:

```ts
let product: [string, number]
product = ["Shoes", 34] //will work
product = ["Shoes", "34"] //will NOT work
```


Enums are common in other languages like C#, which basically allows you to map a word to a number. In other words making it easier for a human to assign:

```ts
emum Size {
    Small,
    Medium,
    Large
}

let s: Size = Size.medium
```

So we can call the text value by calling it like an array so `let sizeName: string = Size[1]` would map to Medium.

As quick aside,  **unions** which are something I will go into at a later point but one quick takeaway is we something like this to specify the valid parameters for that variable.

`meal: "breakfast"|"lunch"|"dinner"`

Which is cool.
### Weird metaphysical types

**Unknown** is what it says, when we don't know what it is. If its something provided by the user for example. We should probably know what the vast majority of our inputs are if we are coding them ourselves!

**Any** is any type, and effectively is doing what JS has been doing. Why use it? Sometimes it might genuinely be needed, or as part of a hybrid TS/JS/3rd party library situation. Just try not to lean on it too much!

**Void** is like the opposite of any. It wont have any type. This is typically used in functions more to state where it wont be returning anything explicitly.

**Never** is a weird one. Basically saying it will never exist. Typically in functions that do not complete and so wont be able to return anything (undefined or otherwise)


## Function Types

Assigning types to variables is fairly simple based on the above but what about using them with functions? Let's take a better look at that!

Lets take a basic button component which is fed a function via props:

```js
import React from 'react'

export const Button = ({onClick}) => {
    return (
        <button onClick={onClick}>Hello!</button>
    )
}

//In the parent component we can have something like:

<Button 
    onClick={() => {
        console.log("How is it going?")
    }}
/>
```

Linting rules for typescript will b pointing out that because we have not specified the output of the function, it is considered an *Any* type. This is not good typescripting so lets fix it up.

As we are not returning something we can use that mysterious `void` type, in a similar format to before.

```js
type Props = {
    onClick: () => void  // or...
    onClick:(text:string) => void
    // if, for example, we were passing in a string value to the function
}
export const Button = ({onClick}: Props) => {
    //etc
```

There is a bunch of ways we can define functions in TS but this is the most typical approach.


## Handling React Events in Typescript 

Events, in this case reacted to interacting with the component in some way. 

In JS world we just specify `e` and off we go:

```js
const handleClick = (e) => {
    //stuff
}
```

In typescript it will complain that the event hasnt been specified so we can do something like this:

```js
type Props = {
    onClick: (e: React.MouseEvent),
    onChange: (e: React.ChangeEvent)
    => void; //Mouse Event  
} 
```

But this is just saying we have a mouseevent, Its good to be specific with typescript for it to offer the best advice as you code. So we can say especially it is, for example, a form element, or button element:


```js
type Props = {
    onClick: (e: React.MouseEvent<HTMLButtonElement>),
    onChange: (e: React.ChangeEvent<HTMLFormElement>)
    => void; //Mouse Event  
} 
```

There are a whole bunch of Events and Elements you can specify. VSCode's intellisense is a good way fo figuring out what you should reach for for a given event.


## Dealing with Child Props

Simple props are easy enough to plan for as we did earlier. But what about children of the component. For example, what if we had a button with an image tag:

```js
   <Button 
    onClick={(e) => {
        e.preventDefault()
        console.log("How is it going?")
    }}>
      <img alt="something" src="somewhere.png"/>
    </Button>

```

If its just a string, from a <H1> instead of an <IMG> we could just explicitly say the component has a child that returns a string:


```js
type Props = {
    children: string,
    onClick: (e: React.MouseEvent<HTMLButtonElement>) => void; //Mouse Event  
} 

```

However if we were using more complex or unknown children, this can start getting hard to manage in the props. This is where we have a little help in the form of refactoring our component to use`React.fc`:

```js
export const Button:React.FC<Props> = ({onClick}) => {
    return (
        <button onClick={onClick}>Hello!</button>
    )
}
```

This ensures the children of a component are correctly typed. Note how props is using the angled bracket syntax we used for events earlier. You will get an error if you use two sets of `:`.  It is fair to say however, that this pattern is [debated](https://fettblog.eu/typescript-react-why-i-dont-use-react-fc/) but this is how I tend to operate.


## Wrap Up

This post was supposed to be a quick look at how to get started with Typescript with React and what you might commonly find in your initial steps with it. Hope it has helped. 

As for Typescript itself. Definitely consider picking it up if you are using React. Having a build process is something you are already familiar with and, while it is a little extra typing (no pun intended) It helps avoid issues later down the line when they are much harder to spot. The main takeaway here is that even a little typescript seasoning can be an tasty benefit to your apps even if you don't know all the ins and outs of it. And hopefully it gives you a taste for learning more!





