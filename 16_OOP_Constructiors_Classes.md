#Constructors, Classes and Closures

These concepts relate to Object Orientated Programming. I tend to forget or muddle them up so I am hoping writing this will help me get my terminolgy straight!

## Constructors

Constructors are functions that create new objects. They should be distinguished by the use of a CAPITAL letter at the start of their name. We can define proerties it will have by saying:

this.<property> = <value>

To make a new instance using the constructor we use the NEW operator: `let pet = new Dog();`

We can specify what we want the properties to be by passing through some arguments to the function: `let pet = new Dog(name, color)`

Objects created with constructor functions are considered instances of the constructor: `pet instanceof Dog //true`

Properties that are defined on the instance Object, ie they have their own separate properites are called *own properties*.


You can use the following method to check if there is a certain own property: dog.hasOwnProperty(numLegs);

## Prototypes

Prototypes are the recipe for creating objects.

If we have a collection of dogs we can be sure that every one has 4 legs (in this world, there are no accidents) so instead of defining the number of legs on each instance of dog we can instead assign it to the prototype: `Dogs.prototype.numLegs = 4;`

**So objects have thier own properties and prototype properties.**

We can populate the prototype like any object:

```js
Dog.prototype = {
	numLegs :4,
	eat(){},
	describe(){}
}
```
Watch out though, the constructor property will be lost so manually define it by including the property: `constructor:  Dog`


Prototypes get inherited from the constructor function that created it. You can test if the prototype comes form a certain source by using `isPrototypeOf`:


`Dogprototype.isPrototypeOf(terrier); //Probably true`


## The Prototype chain

All objects, with a few expections have a prototype and the protype itself has a prototype.

Object.prototype.isPrototypeOf(Dog.prototype)

The core of object oriented programming is using inheritance so you don’t repeat yourself.


    Objects up the Chain are supertypes
    Objects down the chain are subtypes

    terrier ------ > dog -----> Animal

To set something for inheritance it’s a good idea to use Object Create: `let Dog = Object.create(Animal.prototype);`

Note that the Dog's constructor property will be set to animal.

You can set this manually by doing:

`Dog.prototype.constructor = Dog;`

You can have methods on subTypes that are unique to them.

```js
Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog;
Dog.prototype.bark = function(){
console.log("Woof!")
}
```


So overall it’s a 3 step process:

1. Set the Dog.prototype to the Animal.prototype
2. Set the Dog.prototype.constructor = Dog;
3. Add the method to the prototype via `Dog.prototype.<method>`

You can override parent methods by making another with the same name that overrides the parent method.


## Mixins

If you have two objects that should share SOME properties but not others you can use a mixin function to give a payload of properties to the relevent objects:

```js
let peelMixin = function(obj){
	obj.peel = function(){
		console.log("You can peel this!")
	};
}

peelMixin(apple)
peelMixin(orange)
```


## Closures

The infamous Closure, not as scary as it first appears. Let me simplify it. First if you have an object you will have properties:

    function Person() {
        passportNumber = 344432444;
    }

Currently passportNumber is public, so any part of the code can just do <person>.passportNumber and change it. This can be a problem in big codebases. So we can make it only availible within the object's scope by setting the variable inside the function: `let passportNumber = 344433442;`

However, now we can only access it within the object's scope right?

**That’s where we need a closure!**

A closure is a method to the object which has the job of fetching ,an otherwise, private property. The method will have access to the Object scope and can return it when asked from outside the Object scope.

This is not quite right but should give you the gist of it:

```js
function Bird() {
    let weight = 15;
    this.getWeight = function(){return weight}
}
bird.getWeight() //15
```

I always imagine a closure as a Personal Assistant who can give you the information you asked for from the Boss, but not letting you otherwise access the Boss.... well it works for me.

## Immediately Invoked Function Expression

Lets just make it clear that you can run an anonymous function as soon as it is declared. The following function is pretty immediate:

```js
function sayHello(){
	console.log("A hello to you")
}
sayHello();
```

But you can turn it into a IFFE by using a quirk of the language:


    (function (){
        console.log("A hello to you")
    })();

*Basically you wrap the function in ()  and then add another pair at the end to invoke.*


##Combinine IIFEs and Mixins to Make Modules

IIFEs can be used to create a package called a `module` which can contain a number of mixins.

```js
let dancemodule = (function(){
	return {
	tangoMixin: function(obj) {
	obj.tango = function() {
		//do tango stuff
	},
	foxtrotMixin: function(obj) {
	obj.foxtrot = function(){
		//do foxtrot stuff
	};
    })}();     //don’t forget the IIFE invocation.
```	

The IIFE helps make the mixins private as they are unreachable outside of the module.

# CLASSES

New in ES6 (sortof). This helps organise our objects using prototypal inheritance but using special class objects. Lets take an ES6 example:

```js
function Car(options) {
	this.title = options.title;
}
const myCar  = new Car({ title: 'Ford' });
```

We can add a method to the prototype by doing:

```js
Car.prototype.drive = function() {
	return "Driving the car"
}
myCar.drive() // "Driving the Car"
```

Classes mean we don’t have to worry about the prototype.

So the example refactored using classes is like this:

```js
function Car(options) {
	this.title = options.title;
}


function Toyota(options) {
	this.color = options.color;
}

const toyota = new Toyota({ color: 'red', title: 'My wifes car"});
```

Hooking up two constructor functions is a pain in ES5. So we have two constructor functions, but as Toyota is a Car we want to create that link between them. To do this we can do the following.

```js
class Car {
	constructor(options){
		this.title = options.title;
	}
	drive() {
		return "brummm"
	}
}
```

Note that the constructor method is where we do any initialisation and you don’t need to split methods by commas as in objects.


How do we have a subclass Toyota from Car?

`class Toyota extends Car`

However we need to get the Car's constructor method so we need to use:

super(options) //arguments to pass up 

This tells Toyota constructor function to go and grab the parent Constructor function. So the finished article looks like this

```js
class Toyota extends Car {
constructor ({ options } ) {  
	super(options)
	"color: red"
	}
	honk() {
		return: "beep";
}
toyota.honk() // "beep"
toyota.drive() // 
```

# Conclusion

Constructors, Classes adn Object Orirented programming comes into its own once you start building more complex applications. It allows us to seperate concerns without repeating code needlessly.

The drawback, which really isn't a valid one, is that it forces you to think of the design of the overall application and how things can related to each other and share methods. That's a good thing but when I was a complete beginner you just tend to create things here and there as and when you need them. I don't think you need to plan every little thing, thats what refactoring is for.

Classes get a bit of a bad rap as just being syntaxical sugar of prototypal inheriance but I think thats a bit mean. It makes inheritence much more easier to spot and the usage is cleaner to look at. Apparently its not as good as other language's implementations at least we can agree its going in the right direction.
