Test-Driven Development (TDD) is a term that gets a subset of people really excited and a larger chunk with dread. As I have been playing around with it more an more I wanted to reflect on my own understanding and the theory behind it as well as provide a small, non-scary example to help get things started. In this post we will cover:

- My own introduction
- What TDD is, and common concepts.
- A simple unit test using Jest
- A quick overview of Integration Testing and Mocks.


## My Introductions to TDD as a former business analyst.

> "Well if I don't have the code, what am I supposed to test?" - Me, several years ago.

As a business analyst at the time, it turns out I actually was very test-orientated but just hadn't realised it: 

In a traditional project, the business analyst is the person who talks to the business and understands their needs and turns that into a set of requirements for the development team to implement. These requirements should be clear, measurable and actionable so that the development team builds what the business has asked for (which is debateable to say the least).

The point is that we are already thinking about the outcomes we'd like before we begin to make it happen. In coding, we get so wrapped up in the challenge of making it happen, TDD makes us consider what success actually looks like before we get started.

## What is TDD as others see it??

Researching online it seems it is quite confusing, people have different views on how tests should be used with development.

- Test Oriented Development, AKA lots of test are written for the code

- "Test First Development", AKA We write the tests first, then write code.

- "Test Driven Dev and Design", AKA the tests we write inform us of how we expect the code to function and be designed.


The point here is that the Internet holds many opinions on what TDD should be, so do different organisations. This is going to be my take on it, because its my blog. But as you learn more, try keep an open mind and be flexible about how different people approach it. 

One term you might hear often is *production code*. In the context of TDD, that is code that is not a test. Maybe it will be in the Production environment, maybe it wont but thats what we see it as.


The origins of TDD comes from eXtreme Programming, a framework about how development should be. Slowly many elements of it has been getting adopted so its no longer viewed as quite so extreme. From there the idea developed with Kent Beck writing his 2003 book "Understanding Test Driven Development". That's a good place to start if you want to get into the theory and have a reliable source of truth. But let's look at the common drawback of TDD you may hit early on..


### It takes so long to write tests AND the code!

Well yes, in a new team using TDD, it does take longer to implement, but the bug fixing and testing steps are much more reduced. Overall it goes take longer but it comes with some benefits:

- Better design
- Les bugs in production
- Easier Integration Testing

In order words, TDD feels like a lot of faff because, yes it takes take much longer to produce the code when you have to write tests. As a new coder, writing code is the only part of the process you see, so TDD just doubles your time.

In the world of real shippable code we have to consider: 

- Ensure it works as intended a a whole
- Ensure it works with the rest of a bigger application or system (Integration Testing)
- Ensure old features didn't break when we added the new feature (Regression testing)

This is a significant chunk of time overall, and this is where TDD really trims things don't. Its annoyingly sensible, more work now to save work later. As we will see soon, it is also like having a team member who can point out when things go wrong so you don't have to. When it is done well, it makes a coder a happier coder, which is also a Good Thing. 


## Skills of TDD

TDD isn't like, say using camelCase, you either do or don't do. Its a discipline, like any physical exercise, that will feel uncomfortable and pointless to begin with, but with practice you will start developing the skills that make it worthwhile.

1. Writing Good tests, regardless of if you do it before or after.

If you test doesn't test your code in a meaningful way, if there is special cases we don't consider for example then the test wont do its job properly. Learning how to write a good test, or set of tests is an important skill. 

2. Write the Test First

Trying to think in terms in test without code makes it easier. You get to think about requirements without getting hung up on  in the implementation. However, this is a shift in mindset compared to building a function in a linear (e.g. Input, Do Something, Output) fashion.

3. Design Thinking with Tests

This is hard and something that comes with time but taking a step back to consider the requirements for the software itself in your testing is the key to writing the code you need to write and no more. 


## Red, Green, Refactor.

If there is one thing to remember from this post, here it is.


1. RED: Start with simplest test that proves something is missing.

Think of a missing feature as a bug in your code. The test should fail because it doesn't exist yet. This is where design comes in, thinking smart about what you want to exist before you make it allows us to consider design rather than jump straight into the code. We want it to fail before we make it pass, this lets us prove the test is good, in other word we test the test so we be confident in the test.

2. Green: Write the simplest way to make the test pass.

The next step is to pass the test. At this point you can be confident that the code works *for that specific test* because you have a test that works.

3. Refactor, improve the code till you are happy with it.

This might happen several times, repeating till the code is where you would like it. This is important to ensure the code is something you enjoy working with over the long run. Additionally when you have the tests in place you can quickly see if your refactoring is breaking things which makes it a more relaxing proposition

However make sure the refactor is within the constraints of the test. the golden rule here is, **we cannot write new functionality without writing a test**. It is so easy once our initial functionality works to instantly hop to the next bit of functionality but its an art to stop yourself and return to the test spec and plan the next move forward.

## Why 1 test first instead of writing 10?

One by one forces us to work on one piece of functionality at a time, which leads to simpler maintainable code. When we have a douzen tests to make pass, we often end up writing something that attempts to pass all of them efficient but opening up gaps of additional functionality. Its not something I have seen commonly done but consider going test by test when starting out, and see if,over time, that habit can form.


# Ok, cool but how do we do it?

To get started with it? Read on. 

To actually get good at it? Practice. Sorry, I wish there was a easier answer.

The way I learnt was to look at a problem that is really straightforward so my brain doesn't need to worry about that side but instead focus on the test side of things. And example of which we are about to get into. Using something called Jest.


## Jest, making life easy for testing in React but also Javascript.

Jest is built into Create React App. Jest is a  test runner that is easy and quick to run, as a React guy its what I turned to. It also can be installed via npm/yarn for JS.

To learn more go to (https://jestjs.io/). The docs are really easy to get going with some examples and some of the different things to do.

We can launch Jest with `npm test` automatically in a React app created with Create React App. Or in Node [follow these steps](https://jestjs.io/docs/en/getting-started.html) 

There is a number of ways to have test files that Jest can use. I typically create a `FILENAME.test.js` in the same place as the code.

## Our First Unit Test

Let's create a function we are going to test in App.js of a new React App. We are going to try and build a function that adds two numbers.  Though we should write the test first, I personally like having the stub of the future code to exist before writing the test like so: 

```js
export const add = () => return {
    null
}
```

In your `App.test.js` file, lets import the function and then write our first test: 

```js
import {add} from './App';

test('add', () => {
  const value = add(1,2);
  expect(value).toBe(3)
})
```

So lets go through the key elements of this:

1. We open a test function and we call it whatever name we like, something that explains what we are testing
2. We declare a constant `value` which has an example of how we'd use the function.
3. We **expect** value *to be* 3

The `expect` line is the key one, there are a [number of methods](https://jestjs.io/docs/en/expect) we can use to say what we expect to happen.

Now we have written it, lets look at what the terminal where we ran `npm test` is saying:

```
 FAIL  src/App.test.js
  ✕ add (3 ms)

  ● add

    expect(received).toBe(expected) // Object.is equality

    Expected: 3
    Received: null

       5 | test('add', () => {
       6 |   const value = add(1,2);
    >  7 |   expect(value).toBe(3)
         |                 ^
       8 | })
       9 |
      10 |

      at Object.<anonymous> (src/App.test.js:7:17)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 1 total
Snapshots:   0 total
Time:        3.241 s
Ran all test suites related to changed files.
```

Ok, the test failed. This is **good**, we have ticked off the first step of TDD: Write a test that fails!

Next step, lets make it work however we can:

```js
export const add = ( a,b ) => {
  let total = 0
  total = total + a
  total = total + b
  return total
};
```

And if we check our test terminal (as I like to call it):

```
 PASS  src/App.test.js
  ✓ add (2 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        3.342 s
```

Woohoo, we have done it! Time to go party right? Ah no, making the test pass was just step 2. There is probably a refactor or two we can do to this code, so lets see what we can do.

```js
export const add = ( a,b ) => a * b
```

Look how efficient that is now, we are such great coders! But wait... what is happening in the test terminal?:

```
FAIL  src/App.test.js
  ✕ add (4 ms)

  ● add

    expect(received).toBe(expected) // Object.is equality

    Expected: 3
    Received: 2

       5 | test('add', () => {
       6 |   const value = add(1,2);
    >  7 |   expect(value).toBe(3)
         |                 ^
       8 | })
       9 |
      10 |

      at Object.<anonymous> (src/App.test.js:7:17)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 1 total
Snapshots:   0 total
Time:        0.962 s
Ran all test suites related to changed files.
```

Ah nuts, it has failed! Just as well we had a test in place to tell us we made a mistake when refactoring! This is my favourite aspect, having something to watch our back while we get creative in making the code neater. Because it gives us information such as what it expected and what it got, it helps us narrow down the issue (which I am sure you can figure out yourself!). 

Since the above function would pass the test if we just returned 3 or even (-1, -3) we might want to consider adding another *assertion*:

`expect(add(-1,-3)).toBe(-4)`

Now both assertions have to be true for the test to pass, adding additional assertions increases the bulletproof nature of the function.

Now this example wasn't the most complex example in the world but its a start. If we want to add extra functionality, TDD makes us write the test first to make sure we develop decent test coverage.

Testing an individual function that stands alone is called **a Unit Test** as opposed to testing,say a React Component that in turn renders or *integrates* other components. That requires a different type of test...what would be a good name for them...

## Integration Tests


So some functions rely on other functions so to see how one function works with another. Let's run through an example.

Lets say we wanted to return a string that said how many people were at a school using the add function, we would write a test like this: 

```js
test("schoolPopulation", () => {
    expect(schoolPopulation(10,100)).toBe("There are 110 people at the school"))
})
```

As per step 1, we write something that fails the test:

```js
const schoolPopulation = (teachers, students) => {
    return add(teachers, students)}
}
```

As the next step we write the thing that hopefully passes the test:

```js
const schoolPopulation = (teachers, students) => {
    return `There are ${add(teachers, students)} people at the school`
}
```

Just because we can refactor now because mean we have to. It looks good to me. 

Now the thing to bear in mind here is that while the test is similar to the one we wrote for the Unit Test. It isn't a Unit Test because it depends on the add function working too. If we broke the add function this would break this test too even if, on its own, it works fine. What we need is a unit test for the `schoolPopulation` function as this would help highlight which part of the chain is broken. This needs something we call Mocks.


## Mocks, or Mock Functions.

This will be a quick dip into the subject as I think its beyond the scope of my little introduction to TDD. 
In a nutshell, a mock is basically a fake function for our tests. While it can be useful to provide unit tests to a function that relies on other functions. It also is handy for testing functions that call an API or database, in other things you get want to actually run for the sake of testing.

So if we look at our school population and add functions what Jest allows us to do is essentially intercept the function call to the add function and provide a fake result to use in the school population function.

This is better shown first:

```js
//In the schoolPopulation.test.js file

import {schoolPopulation } from './schoolPopulation'
import {add} from './add';

jest.mock('./add', () => ({ //Instead of the add function we imported...
    add: jest.fn() => 50) //... use this fake function which returns 50 always.
}))

test('school population', () => {
    expect(schoolPopulation(10, 50)).toBe('There are 50 people at the school') //
    add.mockImplementation(() => 30) //if we wanted, for some reason,  we can change what the fake add function gives us.

     expect(schoolPopulation(5, 25)).toBe('There are 30 people at the school')
    
})
```


This starts getting more important as you dive deeper into the world of testing. But its important to understand that creating a mock dependance so the test can run without being effected by outside factors.

## Conclusion

Phew, this was supposed to be a very quick primer on what TDD is and how to actually get started without getting bogged down in the details. There is a whole world under the little bit I have shown but hopefully this is useful to understand how I leant and how you might be able to get your feet wet into quite a growing movement towards TDD.







# part 2 - Testing React with React Testing Library

Last time I explained a little about concepts and basic testing. As a React developer primarily, I tend to test things that are in React, madness I know. In this post we will look at:

- React Testing Library
- Unit Tests with Data Test Ids
- Interactive Test with FireEvent
- Clean up
- Integration Testing with Forms


## Introduction to React Testing Library


To be able to test React code life is much easier with React Testing Library to allow us to properly query whats going on with React to build our tests.  The other popular dog in this world is Enzyme. Which is better is a debate for an internet search. But React Testing Library has more of a focus on the DOM and what the user actually sees whereas Enzyme focuses more at the component itself. If you are using create-react-app then the good news is that React Testing Library is built in, otherwise we can add it with:

`npm install --save-dev @testing-library/react`



Quick note: For the sake of clarity and brevity, i'll be breezing over the step by step TDD approach, namely:

1. RED: Start with simplest test that proves something is missing.
2. GREEN: Write the simplest way to make the test pass.
3. Refactor, improve the code till you are happy with it

But hopefully you can see where those steps would exist in the process.

## Unit Tests with Data Test IDs

Lets pretend we want to have a component called Greeter who's job it is to show a div that says 'Howdy'. In the test file we can provide assertions using a bunch of queries made available to us via React Testing Library (and DOM testing Library which is merged into it). 

```js
import React from 'react'
import { render } from 'react-testing-library';
import Greeter from './Greeter';

test('<Greeter/>', () => {
  const {debug, getByTestId}= render(< Greeter/>);
  debug(); //outputs the dom to see what it is, useful for building tests so handy for building the test.
  expect(getByTestId('greeter-heading').tagName).toBe('div');
  expect(getByTestId('example-heading').textContent).toBe('Howdy');
})
```

So what's this getByTestId business? Data Test IDs let us identify elements so we can see whats going on there. We can assign a test id by simply adding the id in our JSX we write to pass the test:

```js
import React, { Component } from 'react'
export default class Greeter extends Component {
    state = {
      greeting: "Howdy" //Let's assume it is in state because it might change
    }
    render() {
      const { greeting } = this.state
      return (
        <div data-testid='greeter-heading'> 
                { greeting }
        </div>
        )
    }
}
```


Of course we don't have to use data test ids. To get a fuller taste of what you can query look at the cheatsheets for [React Testing Library](https://testing-library.com/docs/react-testing-library/cheatsheet) and [DOM Testing Library](https://testing-library.com/docs/dom-testing-library/cheatsheet). It should cover everything you might want to query so I don't have to!



## Building More Interactive Tests

React is all about interactions so we need to test that the interface actually works by testing the interactivity of React.

For this lets dream up a component that is a counter that ticks up every time we click the button. Lets jump to the point where we have a test and js file that is not yet interactive, in other words a dumb button that says 0:

```js
//Test File
import React from 'react'
import { render} from 'react-testing-library';
import Counter from './Counter';

test('<Counter />', () => {
  const { debug, getByTestId } = render(<Counter />);
  const counterButton = getByTestId('counter-button')
  debug();

  expect(counterButton.tagName).toBe('BUTTON');
  expect(counterButton.textContent).toBe('0');
});

//JS
import React, { Component } from 'react'

export default class Counter extends Component {
    state = {
      count: 0
    }
    render() {
      const {count } = this.state
      return (
        <div>
            <button type="button" data-testid='counter-button'>
                {count}
            </button>
        </div>
        )
    }
}
```

Ok, so we need a test to define what happens when there is an event on that button. So first we need a way of watching events that are fired...


```js
//Test File
import React from 'react'
import { render, fireEvent} from 'react-testing-library'; //Added FireEvent from React Testing Library
import Counter from './Counter';

test('<Counter />', () => {
  const { debug, getByTestId } = render(<Counter />);
  const counterButton = getByTestId('counter-button')
  debug();
  expect(counterButton.tagName).toBe('BUTTON');
  expect(counterButton.textContent).toBe('0');
  fireEvent.click(counterButton) //sends a click to the counter button
  expect(counterButton.textContent).toBe('1'); //expect it to be one after the first click.
  fireEvent.click(counterButton) //sends another click to the counter button
  expect(counterButton.textContent).toBe('2'); //expect it to be two after the second click
  debug() //This will output the DOM in the terminal after the additional clicks so its a good place to check whats happening.
});
```

At this point our test suite should be telling us we are failing the test. Well, thats what happens if you have a button that does nothing so lets fix that...

```js
import React, { Component } from 'react'

export default class Counter extends Component {
    state = {
      count: 0
    }

    count = () => {
        this.setState( (prevState) => ({
            count: prevState.count +1
        }))
    }

    render() {
      const {count } = this.state
      return (
        <div>
            <button type="button" 
            onClick={this.count}
            data-testid='counter-button'>
                {count}
            </button>
        </div>
        )
    }
}
```

### Cleanup, because testing isn't just always fun.

One little housekeeping touch. We want to ensure that after each test we clean things back up so its all fresh for the next step. Handily React Testing Library gives us a cleanup method just for that purpose if we add that, that will make sure each test has a clean slate.

```js
import { render, fireEvent, cleanup} from 'react-testing-library'; //Added from React Testing Library
afterEach(cleanup)

test('<Counter />', () => { //etc
```

Without that, you will get duplicate values in the DOM which is not ideal. Its easy to forget about but please don't!

## Integration Testing with Forms

Ok so we have the basics down lets try and apply what we have learnt to a slightly more challenging but realistic example (but not that realistic, as you'll see)

Let's imagine we have a React App that is all about books and one of the features we want is the ability to add a new book. For that we might want a component for a new book with a book form component that is used inside :

- NewBook
- BookForm

I like to scaffold empty components before we get into the tests, but of course thats up to you.

So I would like the NewBook component to:

1. Show a H1 that says "Enter a New Book"
2. Show the book form found in BookForm


If we hold onto our test-id pattern from before it will be straightforward right? Here is our test...

```js
import React from 'react'
import { render, cleanup } from 'react-testing-library'; 
import NewBook from './NewBook';

afterEach(cleanup)

test('<NewBook>', () => {
 const {debug, getByTestId} = render(<NewBook/>) //Grab the tools we need for this next.

//Check Page Title is present and correct
 const heading = getByTestId('page-title') //This id might be a good pattern between multiple components
 expert(heading.tagName).toBe("H1") //Note the caps in 'h1'
 expert(heading.textContent).toBe("Enter a New Book")
 
//Check Book Form is present
 expert(queryByTestId('book-form')).toBeTruthy(); //Lets talk about this line.
 debug()
});
```

We use `queryByTestID` where we are a bit more causal about if it exists or not. It doesn't really matter when we are expecting it to be truthy

And the New Book component:

```js
import React, { Component } from 'react'
import BookForm from './BookForm'

export default class NewBook extends Component {
    render() {
        return (
            <div>
                 <h1 data-testid='page-title'>Enter a New Book</h1>
                 <BookForm data-testid='book-form'/>
            </div>
        )
    }
}
```

And we get a Failure message like this:

`expect(received).toBeTruthy() Expected value to be truthy, instead received null`

What gives?!

Remember at the start of the post, I said now React Testing Library looks at the resultant DOM whereas Enzyme looks at the Component. This is where they differ in philosophy.  In this case, the Component **BookForm** doesn't exist in the DOM, just its contents so we need the data-testid to be on the form within the BookForm component. It is possible to mock the BookForm component (thats for another post) so that it can be picked up in the test, but the default 'thinking' of React Testing Library wants us to consider the result in the DOM. So I guess you can say it is integration-first. Is that better, thats for the Internet to fight over, I am not taking sides in that one!

Soon as we create the BookForm component with something that has the testId we can pass the test (though not very robustly):

```js
import React, { Component } from 'react'

export default class BookForm extends Component {
    render() {
        return (
            <div>
               <form data-testid='book-form'></form>
            </div>
        )
    }
}
```

The resultant HTML from the debug output might help show what is going on if you are a bit lost:

```html
    <body>
        <div>
          <div>
            <h1
              data-testid="page-title"
            >
              Enter a New Book
            </h1>
            <div>
              <form
                data-testid="book-form"
              />
            </div>
          </div>
        </div>
      </body>
```


## Phew, let's wrap this up

We covered the basics of React Testing using React Testing Library. In order to do this, we are going lightly over a few concepts and quality of the tests. Hopefully that is something I'll find time to do a deeper dive of later, my main goal is to get people up and running with the infrastructure of React testing, the quality of the tests is really important to look at! However next time I think I will talk about the cool kid of Testing, Snapshot testing as that is cool... in the world of testing anyhow.

































# Don't Be Afraid of ... Snapshot Testing and Mocking Forms and Props

From our last post, we got introduced to React Testing via React Testing Library. For the sake of keeping things short and sweet we left out a few extra things to talk about. For that reason this post will be quite a mixture of things. In this post we will look at:

- Snapshot Testing
- Mocking a Form submission
- Testing Specific Input Values


## Snapshot Testing.

Snapshot testing sounds a bit like what it sounds like. If you took a photo of the result, did something then happen that makes it look different to that photo? Because we take the snapshot at a high-level on the component, typically the enclosing Div Snapshot testing lets us watch for changes across everything under that element. However, since Snapshot testing compares to a moment frozen in time, it works great for components that are static in nature, but ones with dynamic changeable elements, they may not be the best fit. Anyhow. let's look at implementing it


### Implementing Snapshot Testing

Jest makes this a doddle. First we need to grab `container` from our render:

`const {container} = render(<NewMovie/>)`

Container being the contents of the rendered component **including any child components**. Then we want to say what we expect to match the Snapshot:

`expect(container.firstChild).toMatchSnapshot();`

The firstChild in this regard is the enclosing div. 

Soon as you have done that for the first time, Jest will do something cool, it will create the snapshot for us in the `__snapshots__` folder. If you check it out you will see it is basically the output of the enclosing div. That's cool but here what I said about it being best for things that done change very often, what if you decide you wanted to add or tweak something? For example, an extra <p> tag? Soon as you have done that the test suite will be pointing out it no longer matches the snapshot:

> expect(value).toMatchSnapshot() Received value does not match stored snapshot 1. - Snapshot


>Snapshot Summary
>1 snapshot test failed in 1 test suite. Inspect your code changes or press `u` to update them.`

If it was a tweak that was intended, then as it says, its straightforward to update the snapshot with a tap of the u key. This also makes it easy to accept something that has not been intended so be careful that Snapshot does not make things too easy for you to the point you snapshot intended stuff.

Still, snapshot testing is a very useful way of quickly flagging when something changes and definitely should be considered for less dynamic components. This not intended as a replacement for unit testing , and its not really practical to write a snapshot so they are not really compatible with TDD principles but provide a good quick additional layer of testing. You can learn more from the [JEST Documentation about Snapshots](https://jestjs.io/docs/en/snapshot-testing)


## Mocking and Spying a Form Submission

Ok, so let's take another look at Mocking which I touched on in my first testing post. But this time we can apply it to a more real world example. Namely lets look at a testing a form component. This is a common use case for mocking a function as we don't want to actually submit something to the database when we test things. I am sure we all have databases that are full of entries like "test" and "aaaa" from our manual testing days, let's see about reducing that a little!

So let's go with a New Book Form that takes a book title and submits it, not too complex but will do as an example. First of all let's build out the test to:

1. The button to exist, 
2. And also tell the test suite to click it.

```js
import React from 'react'
import { render, cleanup, fireEvent} from 'react-testing-library'; //Added FireEvent from React Testing Library
import BookForm from './BookForm';

afterEach(cleanup)

test('<BookForm>', () => {
  const {debug, getByText} = render(<BookForm/>)
  expect(getByText('Submit').tagName).toBe('BUTTON') //Looks for an element with the text Submit, just for the sake of being different.
  fireEvent.click(getByText('Submit'))
  debug()
});
```

So lets build the component with the button and also a little cheeky function when the form is submitted:

```js
import React, { Component } from 'react'

export default class BookForm extends Component {
    render() {
        return (
            <div>
               <form data-testid='book-form' onSubmit={ ()=> console.log("click")}>
                   <button type="submit">Submit</button>
               </form>
            </div>
        )
    }
}
```

The reason I added that click function is to show that when we run the test, we can see that `click` appear in the log:

```
PASS  src/BookForm.test.js
  ● Console
    console.log src/BookForm.js:10
      click
```

That might be useful in testing things work in a quick and dirty way. But if that form submission actually did something, then our tests would start getting dangerous so we need a safe way to submit the form when testing. To do this we need to consider the pattern we use for the component so we can safely mock it. This involves providing the function that is ran on submit via props. The component we will end up will looking like this:

```js
export default class BookForm extends Component {

    state = {
        text: ''
    }
    render() {
        const {submitForm} = this.props
        const {text} = this.state
        return (
            <div>
               <form data-testid='book-form' onSubmit={ ()=> submitForm({text})}>
                 
                   <button type="submit">Submit</button>
               </form>
            </div>
        )
    }
}
```

Ok so the big question here is, *why have we bumped the submitForm function to props?* Because we need to change what that function does if it is ran by our test compared to its normal job in the application. This will make sense when we look at the test we have written:


```js
import React from 'react'
import { render, cleanup, fireEvent} from 'react-testing-library'; 
import BookForm from './BookForm';

afterEach(cleanup)
const onSubmit = jest.fn(); //Our new Spy function

test('<BookForm>', () => {
  const {debug, getByText, queryByTestId} = render(<BookForm submitForm={onSubmit} />) // The spy function is used to for the submit form

  //Unit Tests to check elements exist
  expect(queryByTestId('book-form')).toBeTruthy()
  expect(queryByTestId('book-form').tagName).toBe("FORM")
  expect(getByText('Submit').tagName).toBe('BUTTON')

  //Check Form Submits
  fireEvent.click(getByText('Submit'))
  expect(onSubmit).toHaveBeenCalledTimes(1); //This tests makes sure we van submit the spy function
  debug()
});
```

So to repeat what the comments say we:

1. Create a spy function that does nothing
2. This function is passed via props when we render the component.
3. We test to see if it runs with a `expect(onSubmit).toHaveBeenCalledTimes(1)`. Which hopefully it does.

This is all very clever but we have not done much but tested the form submits ok. Which is important but lets take things a step further looking at the inputs that are submitted.


### Bonus: Spying on Console Errors

We can spy on pretty much anything we like. Even errors when a component is not called properly. Lets say,for example, we had a component that needs a bunch of props with specific proptypes defined. If we built a test for that, we would see the console.errors appear even though those errors were expected since we didn't provide props. So we can use the mocking function to handle the console errors like so:

```js
console.error = jest.fn()
test('<ExampleComponent'>, () => {
  render(<ExampleComponent />)
    expect(console.error).toBeCalled()
});
```

Of course, while this gets rid of the console error, this will still show any errors that may occur due to the lack of props passed in.

## Specifying Input Values for testing

To make our testing more aligned to real life we may want to write a test that checks that a form can be submitted with certain specified inputs. In our example, we want our Book Form to have a text input for a title. Nothing too crazy but we want to make sure when we submit the form it can pass the title we want. The way you might approach this is as follows:

1. Find a way to target the relevent part to be tested (i.e. the input field)
2. Change the value of the input.
3. Check that the form was submitted with the value we wanted.

That is pretty good but there is a gotcha you need to be aware of. Changing the value of the input does not cause React's state to update in our test, we need to use a **change* event to update the value but the change to occur. ?Here are the additional parts we need to add to do this:


```js
test('<BookForm>', () => {
  const {getByLabelText} = render(<BookForm submitForm={onSubmit} />) //Adding the getByLabelText

  //1. Unit Test to check our input element exists
  expect(getByLabelText('Title').tagName).toBe('INPUT') //test to make sure the input is there
  
  //2. change the Input Value using the change event.
  fireEvent.change(getByLabelText('Title'), {target: {value: "Girl, Woman, Other"}}) //This event sets the value of the input and lets the change affect the state. 

  //3. Check Form Submits as expected
  fireEvent.click(getByText('Submit'))
  expect(onSubmit).toHaveBeenCalledWith({title: 'Girl, Woman, Other'}) //This checks that the submission has the title we asked it to have earlier.

  ```

  Note that I am using a new query, *getByLabelText* which, unsuprisingly looks at the text of the label to find the element we are after. Step 2, is where we use our fireEvent. since our target is the input element, we need to drill down to find our value and change it. Finally we can check what our Spy function used with the *toHaveNeenCalledWith* method which is hopefully an easy one to understand. 

  So we better see what the React code looks like that passes these tests:

  ```js
import React, { Component } from 'react'
export default class BookForm extends Component {

    state = {
        title: '' //what gets sent on submit
    }

    render() {
        const {submitForm} = this.props
        const {title} = this.state
        return (
            <div>
               <form data-testid='book-form' onSubmit={ ()=> submitForm({title})}>
                   <label htmlFor="title">Title</label> //Remember that it is the text of the element our test is looking for not the HTMLFor
                   <input id="title" type="text" onChange={(e) => this.setState({title: e.target.value})}></input> //Quick and Dirty input controlling
                   <button type="submit">Submit</button>
               </form>
            </div>
        )
    }
}
```

Cool, now it isn't the most complex form in the world but hopefully you can see how the techniques can be scaled up accordingly and also are getting a grasp of how simply we test dynamic content. If you set up the snapshot test earlier you will now see they can be a little annoying when you are writing out the code!



### Bonus: Negative Assertions

In our test we had the following line: 

> expect(onSubmit).toHaveBeenCalledWith({title: 'Girl, Woman, Other'})  

Which is checking if that assertion is true, if it **did** happen. There might be occasions where passing means checking if something **did not** happen. In Jest thats as easy as adding a `not` as part of the method like so:

> expect(onSubmit).not.toHaveBeenCalledWith({title: 'Girl, Woman, Other'}) 

This can be useful when, for example, you are testing what happens when data is not provided by props to a component that needs them. Which is handy as our next topic is...


## Mocking Props

So we are able to emulate form data, but another thing we common deal with is props. If our component needs props, we need a way of providing some. On a basic level this is quite straightforward if all the above made sense. In our test we need to: 

1. Mock out what the props should be 
2. Include those props when we render:

```js
console.error = jest.fn()

const book = {
  title: "The Stand"
}

test('<Book> without Book props', () => { //No props so 
  render(<Book />)
  expect(console.error).toHaveBeenCalled();
})

test('<Book> with Book Props', () => {
  render(<Book book={book}/>)
  expect(console.error).not.toHaveBeenCalled();
})
```

Pretty cool right? Well yes but now we are into multiple tests, we have a little gotcha to be aware of. In the example above we have two places where we check if the console.error has been called. Once without props and a second time without props where we expect that it will not run. However if you run this it will fail as it will say that console.error was run the second time.... what gives?!

Put simply, console.error was called when it ran the first test so it thinks it was called when doing the second. The fix for this is fairly simple and requires a tweak to our clean up function.

```js
afterEach( () => {
  cleanup
  console.error.mockClear()
})
```

Now the memory of the console error is cleared between tests and things are more normal.

There are unfortunately lots of little gotchas you will hit as you start testing real-world components. A common one is around React Router expecting things that are not found in the test, its beyond the scope of this blog post to cover you own use cases but its the kind of thing that is going to [need some research](https://stackoverflow.com/questions/43771517/using-jest-to-test-a-link-from-react-router-v4) when you encounter them. Tsking a step by step approach when writing tests and code does help narrow down and help search for solutions to such issues.



















# Don't be afraid of ... Testing Fetch requests in React

In previous posts, I have been going over how to test common things we would do in React such as:

- Component Elements
- Forms
- Props

That is quite a few things in our testing toolbox. Now another common thing you might do in react is fetch data from a backend or external API. This can get a little hairy so I wanted to break it down and go slowly through it. In this post we will cover.

- Mocking APIs
- Asynchronous Testing
- Additional Information

## Mocking APIs

Now lets assume we have a Book component which fetches data from an external API when it provides an ID. 

From previous posts we know how to provide props and variables to a test, so we could easily give the test an ID to then fetch from the external API. This is doable but perhaps not a good idea. Still we need to setup that initial step of the fetch request as that is a param we pass in when using the book component:

```js
const match = {
    params: {
        id: 'abc1234567'
    }
}
```


We don't want to actually hit the API as that takes a little time to do and introduces a dependency to the API which makes it harder to reliably test.

Instead,  we want to make up a result we can use for the test. To make generating fetch requests a snap I reach for a library called `jest-fetch-mock` which can be installed by:

`npm install --save-dev jest-fetch-mock`

Now, if this is something you are expecting to do a lot of, I recommend following the [setup steps provided](https://www.npmjs.com/package/jest-fetch-mock). For the sake of a punchy blog post we will do things quicker and dirtier.

Once we have it installed we can override global fetch with our new package:

`global-fetch = require('jest-fetch-mock')` allows us to override the normal fetch for our test suite and instead allow us to provide our own JSON.


Now we have global fetch configured we need to perform the fetch in our test, here is an example, obviously we need to tailor it according to the fetch we would want to perform. Its a really common error for me to fail to replicate what is coming back from the fetch so its worth triple checking your mocked response is in the right format!: 

```js
fetch.mockResponseOnce(JSON.stringify({
    title: "1984",
    author: "George Orwell"
}))
```

So let's see how out test now looks with all that information:

```js
import React from 'react'
import { render, cleanup } from 'react-testing-library'; 
import Book from './Book';

global.fetch = require('jest-fetch-mock'); // Makes the test use 'jest-fetch-mock

afterEach( () => {
    cleanup
    console.error.mockClear()
})

console.error = jest.fn()

const match = { //our params to grab the book info from the ID provided.
    params: {
        id: 'abc1234567'
    }
}

test('<Book />' , () => {
    fetch.mockResponseOnce(JSON.stringify({
      title: "1984",
      author: "George Orwell"
    }))
  const {debug}  = render(<Book match={match}/>)
  debug()
});

```

We are not actually testing anything yet but that will come... first we have a little problem.

If you check the debug (making sure to use the fetched data in some way in the book component) you'll notice that the data we fetched isn't being used. This starts to make sense when you consider it is a fetch request and they are asynchronous. We need a way to wait for the result to come back before proceeding. Handily enough, my next section is called...

## Asynchronous Tests

How do we get this data to show?

`waitForElement` is some magic in React Testing Library that waits for the element to show up before proceeding. We grab it from React Testing Library like so:

`import {render, cleanup, waitForElement} from 'react-testing-library`

As with previous tests we need to define a target using a query such as *getByText*. But of course the problem is that we need to wait for that to exist on the page, to do that we need to make the test asynchronous. That is not as scary as it may sound as we can use the **async and await** syntax, like so..

```js 
test(<Book/>, async () => {

  //other stuff

  const book = getByText('1984') //This will NOT work as the element doesn't exist.
  await waitForElement(() => getByText('1984')) //This waits for the element to exist so that...
  expect(getByTestId('book-title').textContent).toBe('1984') //...this WILL work.
})
```

And.... you should have the book data coming through in the debug view. A common issue is getting the mock fetch in the correct format your component is expecting. Let's have a look at the test in full:


```js
import React from 'react'
import { render, cleanup, waitForElement, getAllByTestId} from 'react-testing-library'; 
import Book from './Book';

global.fetch = require('jest-fetch-mock');

afterEach( () => {
    cleanup
    console.error.mockClear()
})

console.error = jest.fn()

const match = {
    params: {
        id: 'abc1234567'
    }
}

const book = {  //makes life easier as we can reference this in multiple places in the test.
    title: "1984",
    author: "George Orwell"
}
test('<Book />' , async () => {
  fetch.mockResponseOnce(JSON.stringify(book))
  const {getByTestId}  = render(<Book match={match}/>)
  await waitForElement(() => getByTestId('book-title'))

  expect(getByTestId('book-title').textContent).toBe(book.title)
});
```

As for the JS, this is a snippet of how it might look like:

```js
class Book extends Component {
  state = {
    book: {},
  }

  async componentDidMount() { //Example API call
    try {
      const res = await fetch(`https://somebookapi.com`);
      const book = await re,hs.json();
      this.setState({
        book,
      });
    } catch (e) {
      console.log(e);
    }
  }

  render() {
    const { book } = this.state;
    if(!book.title) return <h1 data-testid='loading'>Loading</h1>; //This check is important as it stops the element existing before it has the content from the API. You could add a test to check for this prior to the waitForElement.
    return ( 
      <h1 data-testid='book-title'>{book.title}</h1> //The element we are looking for
      <h3>{book.author}</h3>
    )
  }
}
```

Phew, there is a number of steps to getting it up and running but as long as you take it step by step and know the right react testing library magic you should get through it.

As always this was just a look at one way of getting async tests to work, depending on what exactly you are doing there may be a better approach. The Jest docs has [good info](https://jestjs.io/docs/en/asynchronous) about several async methods. So I would give that a good read when you start thinking about it. 

## Neater Testing with the __tests__ folder

There is plenty you can test, and I have only covered a few testing angles for the sake of simplicity. Before you know it you will have test files everywhere and I haven't really mentioned a convention of how to organise them.

For react apps I try and group components that related to a particular model, say Books. We don't have to have our tests sitting in the same folder as the component, there in a special folder `__tests__` where it is expected to place our tests. Remember that you need to update the component imports in the tests as well as any other components that rely on the moved files.


## Code Coverage

You may hear people that are really into testing say things like, "our app has 95% test coverage" which sounds pretty impressive but what do they mean? Lets see if we can work it out by checking our own coverage:

`npm test --coverage`

Will spit you out a table breaking down, on a component by component basis how much of your code is covered by a test, splitting it up by Statements, Branches, Functions and Lines.


```html
--------------------------|----------|----------|----------|----------|-------------------|
File                      |  % Stmts | % Branch |  % Funcs |  % Lines | Uncovered Line #s |
--------------------------|----------|----------|----------|----------|-------------------|
All files                 |    46.07 |    19.35 |    46.67 |    60.66 |                   |
 App.js                   |       50 |      100 |        0 |       50 |                13 |
 Book.js                  |      100 |      100 |      100 |      100 |                   |
 Book Form.js             |      100 |      100 |      100 |      100 |                   |
 BooksList.js             |    90.91 |      100 |      100 |       90 |                22 |
 NewBook.js               |      100 |      100 |      100 |      100 |                   |
 index.js                 |        0 |        0 |        0 |        0 |     1,2,3,4,5,7,8 |
 registerServiceWorker.js |        0 |        0 |        0 |        0 |... 25,126,127,128 |
--------------------------|----------|----------|----------|----------|-------------------|
```

I wouldn't lose too much sleep over 'All Files' value as there is a bunch of files that you typically don't care for testing. 

Code Coverage can point out testing gaps in the code but it does not say if the tests are actually good ones. Use it as a pointer where improvements might be needed but not as a score for how good your testing is.


## That's a wrap

Ok I have written a few amount of words with regards to testing and I feel like I have only scratched the surface! But hopefully how I picked it up is a good starting point in general.  There is much more the tools used can do with regards to testing so all I can say is to have the [Jest](https://jestjs.io/docs/en/getting-started) and [React Testing Library]((https://testing-library.com/docs/) docs handy when starting to build out your own tests and see what works best for you.












