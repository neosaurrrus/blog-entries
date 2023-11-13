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
- Some way of changing the input.
- Call the function again with the modified input

If it goes horribly wrong, its likely on one of those is wrong.

## Factorial example

The classic example working out a factorial. A factorial is the value of a given value by all lesser integers..I am not a maths guy. Basically 3 facorial is 3 x 2 1 = 6. Get it?

So calling a function factorial(3) should equal 6... what does that look like?

```js
function factorial(num){
    if (num<=1) return 1
    return num * factorial(num-1)
}
```

Not that frightening really. It often helps to write it out.

## Helper Method Recursion

So if we wanted to recursively add data to an object or array we will need to have two functions, an outer one that:

- Defines empty array
- Returns the array
- Inbetween these points, a inner recursive function that does something recursively to the array (i.e the array is modified in some way)
- After that, call the inner, or helper function.

Without this, it is a bit harder as the array keeps getting reset. ITs still possible, just a bit more difficult.
