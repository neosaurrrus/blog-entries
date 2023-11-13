This post is all about how I tackle a coding algorithms, lets say for a coding challenge or interview. How I think might be brilliant for you, it might just make you angry. Who knows, but we know we can always rely on the Internet to offer constructive feedback and support!

# What is an algorithm

A set of steps to accomplish a certain task. A process map for code a business analyst would say. Most things in code involves algorithms so how do you figure out what to do?

Some people are better at solving problems than others but everyone can learn.

Step 1: Make a plan for solving a problem

Step 2: Master common problem solving patterns

# Problem Solving Steps

1. Understand the problem
2. Explore Concrete Examples
3. Break it down
4. Solve/Simplify
5. Look back and refactor

# 1. Figure out the problem

Before we can solve the problem, we must first need to understand what we need to do. Investigate the requirements and ask questions.

1. Can you restate the problem in your own words? 
2. What are the inputs that go into the problem?
3. what are the outputs that should come from the solution to the problem problem? What does it look like?
4. Can the outputs be figured out from the inputs? (if you can figure that out at this stage)
5. How can I label the important pieces of data that are a part of the problem? What matters here to solve the problem?

If you can't do the above before leaping into code. It is likely going to give you a bad day!

# 2. Come Up With Examples

Basically plug in some default values to see what you expect. These are effectivley user stories: given a particular input what is our output?

You shouldnt do this willy-nilly, but consider the following scenarios, in a designing a function that just adds two numbers:

- Simple examples (2,2)
- Complex Example ( 20000.54 + 200000000.32 )
- Empty inputs ( 2, )
- Invalid Inputs (2, "fish")

Also consider how the output should be presented. Should it just be the value? does it need rounding? does it need to come back in a string etc?

Playing around with examples, is an extension of understanding the problem and might help uncover some key things to pay attention to when building your solution.

In my experience, people are very good at telling you what they want, but even better at thinking they have given you all the details you need to deliver. *Don't be afraid to ask those dumb questions as it will save you time in the long run!*

Final point, when we are focused on learning we tend to ignore most edge cases to focus on the solving the core problem. This is true in most of my blog posts! Just remember real life production systems are not as forgiving so consider all angles.

# Break it Down

This is all about the How. You should have a decent idea on WHAT you are trying to do, WITH what values. Now lets look at the HOW.

*4 easy problems is better than 1 hard problem.*

So lets break the problem down into smaller pieces, outlining the basic steps you need to take. This will give you a framework to write your code without worrying about the code.

Using comments to outline your approach is a good way to do this.

You don't have to be wedded to what you put down. You might start with one comment, and break that down further. The smaller the pieces, the easier the code for that is to write.

```js
function addNumbers(a, b){
    //check if a and b are numbers
        //if not number, handle the error
    //add a and b together
    //return string that presents the result correctly with rounding.
}
```

 This is really handy for an observer (say, an interviewer) to know what you are thinking about when you are code.

# Lets solve it, or make it simpler!

So now that you have an idea of HOW you can do it, try and solve it! If you can, great! but if you can't... try to solve a simplified version of it.

Obviously you want to solve it. However the logic behind simplfying is that it lets you begin exploring the issue and may trigger some further understanding.

When you are simplfying you can use the following steps:

- Identify the tricky part of what you are trying to do.
- Ignore that tricky part
- Swap it with an easy part
- Then explore the differences between the two.


Some examples of simplifying

- If you have an array to interate through, just try and make a solution for just the first element.
- If you can't recall a method (for rounding a number, say) just refer to it in your comments and see if you can research it later (if you can't figure it out in a minute or two)

# Look back and Refactor, I heard you say...

Ok, so you have got your function working. Good job! But, unless you are under a really tight deadline, you aint quite done yet.

Your first successful attempt is rarely your best attempt so there are some things you can ask yourself in order to improve what you have done.

1. Can you check it works for all inputs? See Step 2 earlier.
2. Can you get to the answer to a different way, what other ways are out there?
3. Can you understand it when you look at it? Can you make it clearer and neater?
4. Does this solve or help with another problem?
5. Can you improve the performance of your solution?
6. Can you simplify it in other ways?

Those points may be more or less relevent depending on what you are doing.

# So lets take what we have learnt...

Lets apply our new found problem solving plan to a simple problem your imaginary boss gives you:

**Write a function that will remove specified numbers from an array of numbers**

1. Understand the problem

- We can restate the problem as *Check an array for certain numbers and remove them*

We can learn the following from our boss:

- The numbers we need to check for will be provided in an array.

- The output should be an array of numbers

- The key pieces of information are the source array, the array of numbers we need to check against and the output array. How these interact is key to solving this.

2. Come up with Examples

You can jot down some arrays to visualise what the function should do. First you come up with the simplest version to help you see the big picture:

`Input 1 - sourceArray = [1,2,3,4]`
`Input 2 - checkArray = [1,3]`

*Function does something*

`Output Array = [2,4]`

Secondly you should consider what would constitute a complex example, at this point you should ask your boss what values are expected. Especially floating points and huge numbers. Luckily, she tells you no to both but the arrays could have over a thousand elements.

So your complex example could have a thousand elements in both the sourceArray and the numbers you are checking on....dont write it out.

Lastly, figure out if there is any need to deal with blank or non-integer values. For the same of this blog post, we are assuming she says no, its all nice simple integers. 

3. Break it Down!

Now you should have a decent idea of what the solution should do and roughly what to expect in terms of inputs you should be able to sketch out an initial approach to the solution.

```js
const removeNumbers = function(sourceArray, checkArray){
    //1. Get the first number in the checkArray
    //2. check each element in source array for this number
    //3. where we find it, remove the element
    //4. Repeat for the next number in the checkArray
}
```

If its really easy code feel free to write it, otherwise just stating in plain english should suffice for now. 

4. Solve or Simplify

Ok, so you are happy with the initial approach, now you can take your skeleton and put some tasty flesh (or code) onto it.

Based on our approach above we decide to first build the algorithm as follows:

```js
const removeNumbers = function (sourceArray, checkArray) {
    //4. Loop for the next number in the checkArray
    for (let i=0; i<checkArray.length; i++) {
        //1. Get the first number in the checkArray
        let numberToCheck = checkArray[i];
        //2. check each element in source array for this number, starting with 0
        for (let j=0; j<=sourceArray.length; j++) {
            //3. where we find it, remove the element
            if (numberToCheck === sourceArray[j]) {
                sourceArray.splice(j,1);  
                j--
            }
        }
    }
    return sourceArray;
}

```

You plug in a few test values and it seems to give you the right answer!

Are we done? Lets do this Choose your own Adventure style!

**If you said Yes**
You show your boss the input and outputs working. She is happy enough, but too busy to look too closely. You go on to throw together a number of other functions on the system. At some point this will probably catch up to you... but for now you have survived.

**If you said No**

You furrow your brow and realise there might be a better way of doing this, you roll up your sleeves and look again at the code...

5. Reflect and Refactor

Well done, a little extra time spent trying to improve your code is well spent.

By playing around with it for a few minutes you decide:

- Those ForLoops are hard to read, as you are dealing with arrays you think to use `ForEach` and `Some` methods instead.
- Now its clearer you probably dont need those comments for every part.
- You recall that its not a good idea to mutate the original array so you use a new array for your results.

```js
const removeNumbers2 = function (sourceArray, checkArray) {
   let newArray = []
   sourceArray.forEach(sourceNum => {
        if (!checkArray.some(checkNum =>  sourceNum === checkNum)){ //check if the Source array element is NOT found in the checkArray
             newArray.push(sourceNum)
         }
    })
   return newArray
}
```

Now that still works but is a little more robust and clearer. If you were to think about it some more, you would probably kick yourself for not using the `filter` method in some way.

The point is that a little time reviewing your code can make a difference, but it might take a couple of interations to get to 'perfection'

Now you note I didnt talk about the performance of our example much. There are certain patterns you should look out for when trying to look for efficiencies. The next few posts are gonna be all about some of the common ones you might come accross which will hopefully help you think more in terms of performance going forward.

