Why should you care about Recursion?

Recursion, in javascript is a function that calls itself. This is used everywhere. For example:

-`JSON.parse`
- `document.getElementBYId`

It is a nice clean way to write complex data structures.

## Functions in Javascript

To be able to work with recursion in JS we need to know how functions work in Javascript. In particular the concept of the *call stack*. When a function is invoked, it put on top of the call stack. When the function ends, it is removed from the top. Last in First Out.

## A Basic Recursive Function

A recursive function needs:

- A base case, where the recursion stops.
- The recursive call with a different input.

