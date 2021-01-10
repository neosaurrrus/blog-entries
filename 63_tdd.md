Test-Driven Development (TDD) is a term that gets a subset of people really excited and a larger chunk with dread. As I have been playing around with it more an more I wanted to reflect on my own understanding and the theory behind it as well as provide a small, non-scary example. In this post we will cover:

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

