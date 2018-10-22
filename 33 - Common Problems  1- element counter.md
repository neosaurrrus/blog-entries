
# Technique 1 - The Element Counter

This type of problem is where we have multiple arrays of inputs which we need to compare with each other.

The normal approach is to use a nested loop with the basic logic of:

1. Take the first thing in an array
2. Compare it to all elements in another array

This is basically has a big O of N Squared which rapidly becomes unmanageable when we start looking at bigger datasets. 

## Our example function

Let's take the simple example of a function that takes in an array of numbers, and returns true or false if another array contains a number that is double the ones in the original Array.

`containsDouble([2,4], [6, 7]) //Should return false`
`containsDouble([2,4], [6, 8]) //Should return true`

You get the idea. Let's ignore considerations of edge cases and just focus on our initial approach to solving this:

```js
function containsDouble(sourceArray, checkArray) {
    for (let i = 0; i < sourceArray.length; i++) {
        let multipleFound = checkArray.indexOf(sourceArray[i] * 2)
        if (multipleFound !== -1) { return true}
    }
    return false;
}
```

So the key point here is that there is a nested loop going on:

1. A loop through the source array in which we take each source element and...
2. Loop through the check array to see if any of them are doubles of the element.

This is O(N^2) time complexity, this works fine for small values,  this doesnt scale very well when we have really large arrays and values.

## How can we solve this better? Whats the trick?

So, if nested loops are bad. two seperate loops are better. That is just O(n) or linear time complexity.

From a previous post, we discussed how if you want to look for a value in an array, you have to go through the array to find it, which takes up to N operations. However, if the values are in an object, it can be retrived with 1 operation. So..

**If we loop through an array and use it to record the values in an object, we can quickly find the value we need in the object without always looping through the array everytime**

So lets look at a new and improved function with this in mind:

```js
function containsDouble2(sourceArray, checkArray) {
    //set up objects
    let sourceCounter = {}
    let checkCounter = {}
    //populate objects with a count of each value
    sourceArray.forEach(num =>{
        sourceCounter[num] = (sourceCounter[num] || 0)+ 1
    });
    checkArray.forEach(num => {
         checkCounter[num] = (checkCounter[num] || 0) + 1
    });
    //loop through the sourceCounter and check there is a doubled key in the checkCounter
    for (let key in sourceCounter){
        if ((key*2 in checkCounter)){return true }
    }
    return false
}
```

If you look carefully you will see the above will always have three loops of N. As opposed to n*n loops. This is good.

This is a really simple example, there is alot of similar problems that can be solved like this. As you have a count of each instance you could loop through to subtract the values to see if there is the same frequency of items. The key thing is that accessing things in Objects is really quick so scales much better. Get familiar with doing this as it comes up plenty.

## An anagram example

Let's look at how we might use what we learnt to check if there is an anagram between two words:

`checkAnagram("sent", "went") // false`
`checkAnagram("sent", "sennt") // false`
`checkAnagram("sent", "nets") // true`

So here we can use the element counter but lets take a step back and understand the problem:

- The words must be the same length
- Each letter must exist in both words

If we can end the algorithm early if it fails either of those tests we can be super quick! Here is a hopefully clear solution:

```js
function checkAnagram(word1, word2){
    //check if the words are same length else stop there
    if (word1.length !== word2.length){return false}
    //make two arrays from each word
    let word1Arr = Array.from(word1)
    let word2Arr = Array.from(word2)
    //make an object of the first array
    let wordObj = {}
    word1Arr.forEach(letter => {
        wordObj[letter] = (wordObj[letter] || 0)+1 
    })
    //Create Loop through the 2nd Array
    for (let element in word2Arr) {
        let letter = word2Arr[element]
    //if it cant find the letter OR there are no more of that letter left call false.
        if(!(letter in wordObj) || wordObj[letter] === 0) return false
    //decrement the letter used by 1
        wordObj[letter]--
    }
    return true
}
```

Note that this is an O(N) solution with a few loops but none listed. Counting the amount of elements in this example allows us to subtract from them to keep track the amount of each particular letter.

# Technique 2 - Multiple Pointers

When moving through an array we normally have an element we are looking at, *i*, thats the single pointer. We often nest a loop to have a second pointer to compare other elements while remembering the location of *i*

Multiple pointers is a technique of using logic to move the pointers in some way in order to get the answer in a more efficient way

## Basic Example, basic solution

Let's say we have an array of *ordered* numbers and we want to return a pair that adds to 7:

`[1,2,3,4]`

You might write a nested loop where the outer loop points at 1, and then the inner loop looks at 2,3,4. Then the outer loop points to 2 and the inner loop repeats again. That will work, it will also be O(N^2) time complexity

I wont write it out, I trust you have done something like that before.

Now what if we had *i* and *j* in the same loop, could it be more efficient? Maybe...

1. *i* is pointing to the first element as per a normal loop - thats 1
2. A defined variable *j* is at `array.length-1` AKA 4
3. We add them up, in the example array above that equals 5. No good, we need 7.
   
**Now this is the clever bit... we don't just move a pointer along and hope...**

4. Since the numbers are in order, we know to get closer to 7, we need a bigger number. Since *j* is at the highest number already we increment *i* so now it points to 2. 

5. We add them up (i=2, j=4). That equals 6, getting closer!

6. Again, no point moving *j* so we move *i* up so it points at 3.

7. Yay, 3 + 4 equals 7!

Because we add some logic governing the result, we can move the pointers in a way that helps us get to the desired result quicker.

