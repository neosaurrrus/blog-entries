# Big O Notation

Its big because its a really important concept. And also is a capital letter. Let's talk about it.

# Why do we need it?

In the modern age, we assume our computers can do anything we ask instantly and can remember as much as you tell it to. To be fair, in most cases that is effectively true, however when we start working with really large data sets, you can hit the limits of your super fancypants processor suprisingly fast.

We can figure out a number of solutions to solve a problem in code. However some are better than others when dealing with a lot of data, big O is a system that allows us to evaluate the performance of the solution.

It allows us to discuss performance in more specific ways other than 'better'. It's the language of code performance if you will.

# How do we measure 'better'?

Generally we mean better in the following ways:

1. It is quick
2. It uses less memory
3. It is clear and understandable for a human

Ideally we would have all 3, but in reality we sometimes have to trade a little of #3 for #1 and #2

For now lets focus on the time it takes, this is the **time complexity**

## How do we measure time taken/time complexity?

Javascript does have a method called `performance.now()` which returns the time elapsed as the point it is ran, so you could use that before and after a function and compare the difference. However, this might be useful in a pinch, it has a few drawbacks:

- Different computers will record different times when running the function
- The same computer might record different times when running the function!
- For something really quick, the above will make it near impossible to measure accurately
- If something takes 20 minutes to run its a pain to sit there waiting for a measurement.

To measure things in a more abstract level, we need something smarter than time to measure performance. 

## Introducing Operations

So instead we look at **Operations**. Basically, the amount of times that thhe computer needs to *do something* in the code. Lets take the following example where we have a function that adds all digits up to the given number:

```js
function addUpTo(n){
    let total = 0
    for (let i = 0; i<= n; i++){
        total += i;
    }
    return total;
}
addUpTo(5);
```

Each addition and assignation is an operation, there is probably 10 or so in the above.  However it would be silly to count the number of operations across a function to figure out the time complexity so we take a more general approach. Take my hand, we are about to discuss maths...

The number fed into the function is defined by *n* and for *n* there are a roughly *n* runs through the function. In other words if we give the function the number 10, it will loop 10 times.

Roughly speaking it will take longer in a steady fashion the higher n is, this is a linear relationship so this has a **linear time complexity**

If you are lost bear with me for 3 minutes...

## Constant Time Complexity

Let's look at another, quite pointless, function:

```js
function halfNumber(n){
    return n/2
}
halfNumber(5)
```

In the example above, hopefully it is clear to see that no matter what *n* is, there is a certain number of operations that must take place, that never changes.

This is a constant relationship so this has a **constant time complexity**

## Why do we care?

Now you might say, they are different functions, of course they would take different times! I hear you, but what if I told you there is a way to do the first function with a constant time complexity...

```js
function addUpTo(n){
    return n * (n + 1) /2
}
addUpTo(5);
```

Mind Blown. I wish I could say I thought that out myself....but I didn't.

## Quadratic complexity

What if you have a function with two loops:

```js
function printAllPairs(n) {
    for (let i = 0; i < n; i++){
        for (let j = 0; j < n); j++){
            console.log(i,j);
        }
    }
}
printAllPairs(10)
```

In this function, the first loop runs *n* times, but... during the first loop, another loop happens *n* times. So, roughly speaking the function runs *n times n* or *n squared* times.

Hopefully you can see how this number increases faster with higher values of *n*.

This is known as **quadratic time complexity**. If you remember nothing else, remember that functions with quadratic time complexity are likely to blow up bad when given large *n*

# Big O Notation

Still with me? That was tough but the net result is that we have a few different time complexities which grow at different rates with higher values of *n*. They make a pretty graph:

BigO notation is just a simple way of showing that complexity:

O(n) - Linear
O(1) - Constant
O(n^2) - Quadratic

There are some other common time complexities but we will get to that.

There are some simple rules for the notation:

- Get rid of your constants, O(950n+4) is just O(n)
- Only the big term matters, O(n^2 + 100n) is just O(n^2)
- Arithmetic and variable assignments are constant
- Accessing an array or object is constant
- The complexity of a loop is the length of the loop multiplied by whatever is in the loop.
- Pick whatever is the worst case.

# Space Complexity

So far we have been looking at how quickly our code will run. Another aspect is how much memory does it take to run the code in our algorithms.

For our needs, we are concerning ourselves with hte space the alogirthm takes up. Not what is passed to it as an input, even though this is technically not correct. Some basic rules to work this out are:

- Primitives (AKA numbers, booleans) are constant space.
- Strings requires O(n) space (where n is the string length)
- Reference types (Arrays and Objects) are generally O(n). Where n is the length or number of keys for arrays and objects respectively.

So a function that takes in an array and just adds the contents has a space complexity of O(1) space. It always just requires the input plus some assignations.

If we have a function that adds to an array for each element, that effectively increases with *n* so it has O(n) complexity.

# Logarithms

Remember I said there were other complexities, these involve logarithms:

A logarithm is the opposite to an exponent, in really simple words as exponents get bigger and bigger with , logarithms get smaller and smaller.

A space or time complexity of O(log n) will start similar to O(n) but will taper off to a O(1). This is really good thing to do.

Almost impossible right? Nah, its just finding ways to discount what is not required to process. We do it all the time. If I asked you to find **'fish'** in the dictionary, you probably won't start at `Aardvark` and proceed one word at a time which is O(n). Think about how you would instead...and note that it is only possible because the dictionary is sorted. That's important to consider.

You can also have a O(nlog n) which is better than a quadratic time complexity at least. Lets see all those on a graph.

Logarithmic time complexity comes into its own when performing searches or sorting algorithms, and is a common feature as part of rescursion. These are all things I want to write about at some point so I will expand upon it in another post.