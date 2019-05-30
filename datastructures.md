# Why do we care about data structures?

If you are somewhat familiar with Javascript you know about arrays and objects.

These are ways of containing information, sometimes you need arrays, sometimes you want objects as they serve different purposes.

However there are more data structures that can be used to serve different purposes some examples are:

- Binary Search Trees
- Hash Tables
- Linked Lists
- Stacks
- Tree
- Graph

In this post we are going to look at some of them. But there are loads

## What makes a data structure?

They are collections of values, the relationship between those values and operations that can be applied to the data.

Some of them are great for certain tasks, while others are more general. These are the types that tend to be included for free in languages, like arrays.

## Why do we care?

Sometimes in code one of these other data structures will do a job better than an array or whatever you currently know.

For example, if you need an ordered list with fast inserts/removals at the beginning and end. Arrays are kinda slow when manipulating the start, so a `linked list` might be better.

If you are working with a DOM, you might rather a `tree`. You get the idea.

