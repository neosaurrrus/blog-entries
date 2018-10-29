# Code Problem Solving Techiques

Some very clever people have come up with patterns that help us efficiently work with large datasets, efficiency in most cases being avoiding nsting of loops. The patterns we will cover are:

- Element Counter Object
- Multiple Pointers
- Sliding Window
- Divide and Conquer

These wont always apply but its useful to be aware of them as they may help you out more often than you might expect. Please note that I am using really simple and small examples to keep things clear. For these examples, it wont matter how you do it but just imagine the examples being a thousand times bigger to start appreciating the benefit.

# Pattern 1 - The Element Counter Object

This type of problem is used where we have multiple arrays of inputs which we need to compare with each other.

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

Note that this is an O(N) solution with a few loops but none listed. Counting the amount of elements in this example allows us to subtract from them to keep track the amount of each particular letter. This is my favourite pattern so I often look to this one first.

# Pattern 2 - Multiple Pointers

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

Here is my implementation, with added argument to make the target value dynamic:

```js
function findPair(arr, target){
    let left = 0;
    let right = arr.length-1;
    while(left < right){
        let sum = arr[left] + arr[right]
        if (sum === target){
            return [arr[left], arr[right]]
        }
        if (sum < target){
            left++
        } else {
            right--
        }
    }
}
findPair([1,2,3,4], 7) // [3 , 4]
```

## Another usage of multiple Pointers

Lets say we want to find the number of unique values in an array of numbers. i.e in the following:

`[1,1,1,2]`, the output should be 2.

How so we do it without a nested loop?

Loads of different ways... first lets go for a hipster solution using Sets:

```js
function findUniqueValues(arr){
    let arrSet = new Set([...arr])
    return arrSet.size
}
findUniqueValues([1,1,2,2]) // 2
```

*mic dropped*

**What about a solution using an element counter? Sure...**

```js
function findUniqueValues2(arr){
    let valueCounter = {}
    arr.forEach(num => {
        valueCounter[num] = (valueCounter[num] || 0) +1
    })
    return Object.keys(valueCounter).length
}
console.log(findUniqueValues2([1,1,2,2,3,4,5,6,7,7,7,7,7,]))
```

**Ok, lets use multiple pointers**

```js
function findUniqueValues3(arr){
    if (arr.length === 0) return 0;
    let i = 0
    for (let j=1; j < arr.length; j++){
        if (arr[j] !== arr[i]){
            i++
            arr[i] = arr[j]
        } 
    }
    return i+1
}

findUniqueValues3([1,1,1,2,3,4,4,4,5,6,7,8]) //8
```

The key here is that *i* only moves up and changes its current element when a mismatch is found.

## Multiple Pointer conclusion

Having two points working together can really cut down the time complexity. However, for me, how they can be used is not always obvious so I suspect its something you'll come to recognise in time as it needs a hefty dose of logic.

# Pattern 3 - Sliding Window

Here is a real world scenario, dumbed down:

You are hosting a house party, and you count up the number of guests as 10.
2 people arrive and 1 person leaves. Now you still want to know how many people are in your house. To do this you could:

1. Just count everyone up again.
2. Add 2 to your current count (10) and subtract 1.

Hopefully, you can see #2 will be easier. That's kinda what the sliding window pattern represents.

In a more codey way, the sliding window refers to a way of analysing a subset of data within a larger one. By moving that 'window of focus' by calculating what is now in the window and what has now left rather than calculating from scratch what is in the sub-array.

`[@1,2@,3,4,5,6]`

The @ sign represents the window and as as we loop through, the window *slides* along accordingly. It will add 3 and subtract 1 as opposed to looping through the sub array to calculate 2 and 3 from scratch. 

## Our basic problem and basic answer

So lets say we wanted to calculate the maximum sum of X elements of an array with unordered integers

`maxSubArray( [1,2,3,2,1] , 2) //returns 5 from the '3 and 2' values`
`maxSubArray( [1,2,3,2,1,4] , 3) //returns 7 from the '2,1,4' values`

So the naive approach would be to start with the first element in the sub array and then loop through the other elements to get a sum, and then comparing this sum to the previous highest sum. This is a nested loop with quadratic time complexity. We don't like that, when we could be smarter about it.

## Our 'Sliding Window` Answer

Ok, again, so what makes a sliding window exactly?

In our simple approach we use a nested loop to add up the sub array every time it moves through the parent array.

The sliding window technique simply keeps the sub array we created and instead of recalculating from scratch what it contains, it **calculates what has changed** . So, for our function, as it moves through the array it:

- Adds the next element that is now IN the window.
- Subtracts the element that is now OUT of the window.
- Checks if the modified window is greater than the old one.

Let's give it a go:

```js
function slidingSubArray(arr, size){
    //Check that the inputs are valid
    if (size > arr.length) return null

    //set up variables to track the index that is outside the window, highest total and current total
    let indexOutofWindow = (0-(size))
    let max = 0;
    let current = 0;
    
    //Loop through the array adding each element to current
    arr.forEach((num, index) =>{
        current += num
        //once the window slides to full size.  delete that value from Current.
        if (indexOutofWindow >= 0) {
            current-=arr[indexOutofWindow]
        }
        //compare current and max
        if (current > max) {
            max = current
        }
        //increment the trailing index
        indexOutofWindow++
    })

    return max
}
```

Maybe not the neatest solution but it works. Plenty of errors in the difference between the index and size.

I guess looking at it, sliding window is a bit like multiple pointers as you have two points you care about.

Interesting.

# Pattern 4 - Divide and Conquer

This one you definately have come across before, lets look at a real life example:

You need to find "fish" in the dictionary, you open the directionary around halfway, and you see the word "Leopard". Fish comes before Leopard so you turn to the page halfway between Leopard and the start. That gives you "Dentist" and so on...

Hopefully you are familar enough with that idea to warrent no more examplanation.

## The basic problem with a basic solution.

Let's say we have an array of sorted numbers. And we want to know the index of a certain number (and dont know what indexOf is)

`findIndex([1,2,5,14,20,24,25,29], 14) //should return 3`

Now the naive approach here would be to simply loop through and check each value in sequence. This would be a O(n) time complexity.

This probably isn't the end of the world but if you imagine looking for the word "fish" in the dictionary, you might want a smarter way of doing it. This is where Divide and Conquer comes in.

## Using Divide and Conquer

This is also similar to a binary search which is another blog post really. But here is a rough solution I concocted:

```js
function findElement(arr, num){
    //define min and max
    let min = 0
    let max = arr.length -1
    //loop while value is not found
    while(min <=max) {
        let mid = Math.floor((min+max)/2)
        //set min to be higher than the current Midpoint if the value we are looking for is higher.
        if (arr[mid]<num) {
            min = mid +1;
        //Vice Versa with max
        } else if (arr[mid] > num) {
            max = mid - 1;
        //if its not higher or lower it must be our goal.
        } else {
            return mid;
        }
    }
}
console.log(findElement([1,2,5,6,7,8,9,16,24,35,50], 9))
```

Hopefully that gets the gist across. I will be writing more about this in due course but for now I hope the general idea of divide and conquer makes sense. Note that it relies on the content to be sorted. By the way if you thought to use `indexOf`, know that it is of O(n) time complexity. If it is an unsorted array then it won't matter as thats the quickest you can do in that situation.

# Pattern Conclusion

That was alot to take in and I expect its a little hard to commit to memory. Hopefully the idea behind those patterns at least informs how algorithms can have reduced time complexity and gives us a little more confidence we dont always need to rely on nested loops for everything.

