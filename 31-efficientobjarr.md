Efficient Objects and Arrays/


You are familiar with Objects and Arrays right? When you need to use them, you make your functions and it all works. Life is good!


But then due to your amazing skills you are hired to work with really large data sets, a billion facebook profiles, or just the English dictionary. Now your thrown together functions might not be running so quick.  Life is now bad!

This post is all about thinking about considering the small things in Objects and Arrays that make a big difference in large data sets.

# Object Basics

Objects are collections of key value pairs without any order to them. Lets look at one:

```js
let cat = {
    name: 'Jim',
    age: 7,
    male: true
}
```

If we want to:

- Insert a new key/value pair
- Remove a key/value pair
- Access a key/value pair
  
**It has a constant time complexity.** An object with a million key/value pairs takes pretty much the same time as our cat above. This is great.

However when it comes to searching *values* objects have a linear or O(n) time complexity. It just runs through each key and checks the value as there is no relationship to other key/values for it to use.

## Object Methods

Most methods such as: `Object.values` , `Object.keys`, `Object.entries` are O(n)

A few such as `Object.hasOwnProperty` are constant time, O(1) which makes sense as it only needs to access a key in the object.

The takeaway is Objects are generally fast but lack any order which is a big different to ...

# Arrays

You know arrays, look here is one:

`let planets = ["Earth", "Mars", "Venus"]`

They are ordered, which has some pros and cons when it comes to performance.

Access is fast, if you ask for `planets[2]` it will give you 'Venus' with a constant time complexity. A planets array with a thousand items will take the same time fetching you `planets[999]`

Insertion and Deletion is where it gets interesting. 

If we insert the planet *Jupiter* by **pushing** (AKA at the end) it takes O(1) as it just needs to add another item to the end.

However if we insert *Jupiter* at the start (i.e shift), that means that *Earth* is no longer element 0 and has to be moved to 1, and... **everything else after has to be moved as well!** The reindexing can be pretty costly!

Deletion is a similar deal for the same reason.

So they are both O(n)

Searching an array, much like an object just runs through the array one by one. So that too has a linear time complexity, O(n)

An important note, this doesn't mean you should never do those things but just be aware of the cost so you can decide if its worth it.

## Array Methods

Arrays have lots of methods. Most of them are O(n) they just go through each element in turn. This includes *shift, concat, slice, splice, forEach, map* 

As discussed a moment ago, working at the end of an array is low cost so *push and pop* are O(n)

*Sort* however, that is O(n* log n). It takes longer thna just working with each element once. But sorting a topic ill get to at some point in more detail.

## So I guess that just the rules of JS huh? 

Not quite. In times of need we have some other data structures we can make and use:

- Single Linked Lists
- Double Linked Lists
- Heaps
- Stacks

Depending on what we need to do, they can save the day!