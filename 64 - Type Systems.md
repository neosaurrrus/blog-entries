
# Type systems

I recently attended a webinar by Roy Derks and it inspired me to get my thoughts down with regards to type systems since they are an awfully dry subject to try and get the concept and usefulness across.

Type systems are one of those things that is getting more popular in the Javascript world. 

## What is Typescript, how is it different to use  Javascript?

Typescript can be considered a superset of Javascript. In other words it adds extra functionality on top of Javascript. Javascript with Types is a good 3 word explanation.

The nice thing about Typescript is that it has a compile step which turns it back into Javascript. So that means it is quite easy to dip your toe into Typescript without having to do anything radically different to writing Javascript.

Having a compile step does mean that it has to be ran before your browser can make sense of it. If you have been using frameworks like React however, this shouldn't be an alien concept.

Typescript files have a `.ts` extension as opposed to `js` in case you stumble across them.



## Ok, sooo... whats a type?

Programming languages come in two flavours. Statically typed or dynamically typed. Dynamically typed languages like Javascript don't make it something we need to consider, at least when writing the code...

In statically typed languages we say what datatype it is before running it (i.e Age is an integer, Name is a string). In Javascript we never do that so we can do things like this:

```js
const age = 12
const another_age = "12 years old"
```

Static typing allows us to catch errors much easily. If there is an error it gets thrown up at the compile step.

With Javascript we don't see these errors till the code is running, and is so much harder to debug.


## "OK, this might be handy, how do I do it?"




