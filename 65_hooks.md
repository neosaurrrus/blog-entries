# Intro

React Hooks are no longer a clever new thing in React but actually how React is nowadays.

I actually avoided learning hooks for a long time as, since they were new, there was a lot of noise and differing opinion on how to use them. Now, a couple of years later, the dust has settled so I wanted to talk about some of the common hooks that you will encounter in React and more importantly have a reference so I remember how to use all these hooks whenever I forget!

We will cover: 

- UseState
- useEffect / useLayoutEffect
- Custom Hooks
- Fetching data via useEffect / Common Issues
- A quick tour of other common hooks (useRef, useMemo useReducer)


A great source of all things hooks is the ReactJS docs themselves. Especially the [Hooks Reference](https://reactjs.org/docs/hooks-reference.html)

## UseState

So state used to be only for class based components. Now with the Use State Hook we can use them in Functional Components.

Lets take an example input where we import UseState but otherwise it does nothing:

```js
import React, { useState} from 'react'
const Component = () => {

    return (
        <div>
            <input type="text" value={''} onChange={()=> null} />
        </div>
    )
}

```

So since value is set to nothing, nothing happens when we try and type into it. We need state to handle the value so lets look at the setState hook using some placeholder values:

```js
const [value, setValue] = useState(startingState);
```

*Value* - Value held in state
*SetValue* - Function used to set the value 
*startingState* - What the state starts with, typically an empty string for text fields

So if our input was capturing a name the hook might look like this:

```js
const[name, setName] = useState('')
```

With the corresponding input looking like:

```js
   <input type="text" value={name} onChange={(e)=> setName(e.target.value)} />
```

Boom! now we can use that name variable from state wherever we like in the component. So that's how we can use state in a functional component via hooks. Lets look at how useState can be used in a form:

```js
import React, {useState} from 'react'

export const UseStateForm = () => {
  const [name, setName] = useState('')

  const formSubmit = (name,setName) => {
    console.log(name)
    setName('')
  }
  return (
    <div>
      <h1>Use state Form</h1>

      <form onSubmit={ e => {
        e.preventDefault()
        formSubmit(name, setName)
      }}>
        
        <label htmlFor="name">Name</label>
        <input type="text" onChange={ e => setName(e.target.value)} name="name" value={name}/>
        <button type="submit">{name}</button>
      </form>
    </div>
  )
}

```


Compared to 'setState' in class-based components its nice and easy.



# useEffect

The useEffect hook is analogous to the lifecycle methods such as component did update, component did mount and so on. It isn't exactly the same but we will get to that. In a nutshell useEffect is a function that runs after every completed render. In its most basic form we can use it like so:


```js
import React, {useEffect} from 'react'

// Inside component...

useEffect(() => {
    //do something
}
 ```


## useLayoutEffect

Most of the time useEffect is what you need to use. It runs AFTER react render the component and thus if there is any callback (we will get to this) it doesn't get in the way of the browser painting.  But  when changing the DOM appearance this could potentially cause a flicker when the browser paints before the change and then has to paint the change again.

Use Layout Effect runs synchronously straight after React has changed the DOM but BEFORE the browser paints the resultant DOM. This makes sure the user only sees one change and if your code relies on the final state of the DOM (say, checking a style) it makes sure it happens behind the scenes. 

General rule, use `useEffect` unless the hook is relying on or making *visible* changes to the DOM in which case use `useLayoutEffect`


So far so easy? Well lets suppose the code we run in useEffect we use in a lot of places then we need to consider how to build...


# Custom Hooks

Ok, so lets imagine we have a pressing need to console log certain input fields when they change, this means:

1. Setting up useState to record the change
2. Setting useEffect to console log the values found in state
3. Returning the values so they are available to the component.

If we have a bunch of input fields this is alot of repeating code, so this can be wrapped up into our own hook that we can use wherever it is needed. This could be a seperate function in the component file or its own file entirely, whatever makes sense but fundamentally it is a function somewhere, and that somewhere doesn't have to have any relationship to any particular component.:

```js
function useLogInput(initialValue){
    const [value, SetValue] = useState(initialValue)
    useEffect(() => {
        console.log(value)
    })
    return [value,setValue] //since we still need to use the state values elsewhere
}
```

Once we have the hook we can use that instead of useState and useEffect:

`const [value, setValue] = useLogInput('')`

So our reworked form from before now looks like this:

```js
import React, {useState, useEffect} from 'react'

export const UseCustomHookForm = () => {
 
  const [name, setName] = useLogInput('')
  
  return (
    <div>
      <h1>Use Custom Hook Form</h1>

      <form onSubmit={ e => {
        e.preventDefault()
      }}>
        
        <label htmlFor="name">Name</label>
        <input type="text" onChange={ e => setName(e.target.value)} name="name" value={name}/>
        <button type="submit">{name}</button>
      </form>
    </div>
  )
}


const useLogInput = (initialValue) => {
  const [value, setValue] = useState(initialValue)
  useEffect(() => {
      console.log(value)
  })
  return [value,setValue] //since we still need to use the state values elsewhere
}
```

This is one of those things that can be extremely powerful but in a simple example like the above seems like I just rejigged my previous code. That is pretty much what I did but now that code is modular. Hell, maybe someone can create a package of hooks we can use in our code....how cool. 

If you get into writing custom hooks, `useDebugValue` is a hook to help debug in dev tools, any hooks you create. I'll just point that out as something to look into to provide debug info.



## Using useEffect to fetch data

If we are working with an API then thats a great example of code we might use in variety of places in our application and a great candidate for our own hook. However this is also where we start to see some issues you might come across with useEffect. I will assume you are confident working with fetch to grab a variety of APIs and gloss over that. For the sake of this example, let's assume we are using an API have lists animals.

Lets assume you have something like this to start with:

```js
export default AnimalList = () =>{

const [animals, setAnimals] = useState([])

useEffect( async () => {
  const res = await fetch('animalAPILocation');
  const data = await res.json()
  setAnimals = (data)
})

//returning method
{animals.map(animal => (
  <h2>{animal.name}</h2>
  <p>{animal.description}</p>
  //etc
))}

}
```

This is first of several gotchas... React will error out saying that *An Effect Function must not return anything besides a function, which is used for clean-up*. It basically wants us to have the async function seperate and call it from useEffect:

```js
const fetchAnimals = async () => {
  const res = await fetch('animalAPILocation');
  const data = await res.json()
  setAnimals = (data)
})

useEffect(() = {
  fetchAnimals()
}
```

Problem, number 2! This will recur infinitely as it calls each time it renders causing it to re-render. We need to tell useEffect to be a componentDidMount type of function and run only once. That is done by using the second argument of useEffect.

The first parameter is the function, the second is an array that contains inputs we want to check that have changed before proceeding running. With an empty array it only runs on mount and not every time.

```js
useEffect(() = {
  fetchAnimals()
,[]}
```

Thats all it take But that extra parameter can be used to control when it re-renders to be efficient when it it runs:

```js
useEffect(() = {
  fetchAnimals(id)
,[id]}
```

Where the id could be help in state to indicate where to grab that particular id.



### Clean up


`componentWillUnmount` is a lifecycle in class based components that concerns itself with what happens when the component unmounts. This is important when we have something to close down when its no longer required, not doing so will introduce a memory leak.  The [react docs](https://reactjs.org/docs/hooks-effect.html) provide a clear example of this so I will lift it here for you:

```js
function FriendStatus(props) {
  const [isOnline, setIsOnline] = useState(null);

  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }
    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    // Specify how to clean up after this effect:
    return function cleanup() {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  }, []);

```

Handily ESLint rules for hooks will normally point out when this might be an issue so its something you'll typically be told about should you need to clean something up. 

More deliberately if useEffect applies a value to an element, you might want to reset it back to a default value when the component unmounts. Such as hiding an element when a modal appears, you want the element to return when the modal is done... Its a hard concept to explain but hopefully it will make more sense when you encounter a situation that calls for it.


## Other Common Hooks You'll come across

For the rest of this post, I want to touch on a bunch of other hooks that are available and might be useful to know about. More to make you curious than a particularly deep explanation.

### useMemo

This hook relates to what I was I just talking about with useEffect's second parameter so thought it a little shout-out here:

If you have an element on your page which is the result of a complex function that takes time and effort to complete then you don't want it running every time the component re-renders unless it is changing. useMemo helps with that:

```js
//Within a functional component after importing the useMemo hook./.

const complexFunction  = input => {//some complicated function}
const complexOutput = useMemo(( ) => complexFunction(input), [input]) //assume input is in your state and is needed to generate a new output to render only when it changes.

return (
  {complexOutput}
)
```


### UseRef

Refs are a way to reference a dom node. We can use this like so:

`const ref = useRef()` 

Once we import it from React. Then we can mark certain JSX elements with the ref:

`<h1 ref={ref}>Cool Heading </h1>` 

When we have done that, we will have a link to that dom element. Try putting a `console.log(ref)` after the `const ref = useRef()` and you'll get...

`{current: undefined}` ... as the H1 has not rendered at that point. Soon as we rerender (by typing into an input field) we will see we get the DOM node

`{current: h1)}` 

Under current we get all the properties we could want of the DOM element. Now this is where we can use refs for interactions such as an `onClick` so that we can change the H1's values when we click a button:

`<button onClick={() => ref.current.innerHTML="Clicked"}>Move H1</button>`

I am not sure why you'd do exactly that but it becomes a neat way of setting up interactions in your component.

### useContext

Context allows state to be shared across components. Its a neater way than old school prop drilling but I'd advise looking it up seperately if you are not familiar with it. It isn't new with hooks but hooks just give us an easy way to work with it. There are two sides to it, first setting up the provider where our data will live and then accessing the data in a component.


1. First we need a provider which holds the data that gets shared through the app. To do that we first need to import CreateContext

`import {createContext} from 'react'`

2. Set up a context we can import elsewhere we will use: `export const UserContext = createContext() `


3. Create the provider by wrapping the parent component. So everything we have done so far will look like: 

```js
import React, {createContext} from 'react';
import { UseCustomHook} from './UseCustomHook'

const UserContext = createContext()

const App = () => {
  return (
    
    <UserContext.Provider value={{user:"admin"}}>
      <div className="main-wrapper">
          <h1>I am the app component</h1>
          <UserDetails/>
      </div>
    </UserContext.Provider>
  );
};

export default App;
```

Now we have done that, we need to access the provider in the UserDetails component.

1. In the `UserDetails` component, we can import the useContext hook : `import {useContext} from 'react'` and the actual context from our parent component: `import {UserContext} from './App'`

3. Get the data from the context via `const userInfo = useContext(UserContext)` and 

4. From there we can reference `userInfo` wherever we need, here is the full user details component.: 

```js
import React, {useContext} from 'react'
import {UserContext} from './App'


export const UserDetails = () => {
  const userInfo = useContext(UserContext)
    return (
        <div>
            <h1>User Details</h1>
            {userInfo.user === 'admin' && <h2>You are an admin</h2>}
        </div>
    )
}
```

Now that isn't the most compelling use of useContext but we have covered the steps in setting up the provider and then using the hook to access the provider elsewhere.


### useReducer

This is like diet Redux, allowing us to do more with our state management in a dispatch/action/reducer pattern you find in Redux. If Redux lingo is not that familiar then this might be a rough ride!

It requires a reducer function that is passed the current state and an action, each action has a path that defines that it does to state.

```js
  import React, {useReducer} from 'react'

  const reducer = (state, action) => {  //takes current state and action
    switch (action.type){
      case 'add':
        return {
          count: state.count + 1
        }
      case 'minus':
        return {
          count: 0
        }
      case 'reset':
        return {
          count: 0
        }
      default: 
        throw new Error();
    }
  }
   
  const Counter = () => {
    const [state, dispatch] = useReducer (reducer, initialState)
    return(
      <div>
        <button onClick={() => dispatch({type: 'add'})}>+</button>
        <button onClick={() => dispatch({type: 'minus'})}>-</button>
        <button onClick={() => dispatch({type: 'reset'})}>Reset</button>
       </div>
    )
  
  }
```

If you combine it with our Context API then we start getting really powerful state management across our application. Its important to note that useReducer (with contextAPI) [does not replace Redux](https://medium.com/javascript-scene/do-react-hooks-replace-redux-210bab340672), or [maybe it does](https://blog.logrocket.com/use-hooks-and-context-not-react-and-redux/). Its beyond the scope of my quick tour of Hooks to get into that particular fight but we at least have:

- useState
- useReducer/useContext
- Redux

as tools to consider for different levels of state management requirements for your project. 

## Wrap up

Phew, thats a lot of hooks to cover but, as with all my posts, on a subject I just wanted to cover the basics to jog my own memory when I need it and help start others off into the world of hooks. Hope it was handy, not hasty and helps you have a happy and healthy home for hooks in your own hobby... projects.