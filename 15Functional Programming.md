#Functional Programming 

Functional programming is a technique that can be used to write better code:

- Avoids bugs arising from mutation
- Makes it clearer what is being worked on to ensure more predictable results

First of all some terminology:


`First class functions` -Since functions can be assigned to a variable, passed into another function or returned from another function, they act like any other value.


`Callbacks` -Are the functions that are passed into another function to decide how that function is invoked

`Higher Order functions` -These are functions that take a function as an argument, or return a function as a return value.

`Lamba` - The fuctions that are passed in or returned can be called a lamba.


Here is an example of a higher order function:

```js
const redColor = () => "This car is red"

const makeCar = (sprayPaint, numberOfCars) => {
	//Loop NumberOfCars
		//run sprayPaint (which is really redColor)
}

const makeRedCars = makeCar(redColor, 30);
```

A core principle of functional programming is that it should not change things, this is called mutation. `Avoid mutation`. When this happens it is a side effect, we should aim for pure functions, ones that do not cause any side effects. In simple terms, when fed inputs, do not return those inputs changed but return an output based off of it.

Another core principle is to `declare your dependancies explicily`, you can do this by passing the variables/objects into the fucntion as an argument. As long as you only use those inputs, the outputs can be more more prediactable regardless of the code inbetween.

So basically, you use variables passed into the function. `if you need to change it, work on a copy of an array`, *be careful you do not copy by reference. Spread or slice is useful here.*

Concatentation can allow you to attach an existing array to a new one and thus avoid mutating the existing data. Or just use Spread.

Some helpful methods to help in this are MAP which can be run on an array in order to return the values to a new array. ES6 Array helpper methods generally help us to avoid mutations and keep thigns functional


## Currying

**Arity** is the measure of the number of arguments a fucntion has. Currying is the act of turning a function with X arity into a X functions of just 1 arity

You can do this to save part of a function while you wait for other arguments to exist.

```js
function add(x) {
	return function(y){
		return function(z){
			return x+y+z
		}
	}
}
add(10)(20)(30);
```

`Partial Application` is like currying but involves SOME arguments as opposed to just 1.

```js
//Impartial function
function impartial(x, y, z) {
  return x + y + z;
}
var partialFn = impartial.bind(this, 1, 2);
partialFn(10); // Returns 13
```

## Conclusion

Currying and Partial application give me headaches but generally functional programming makes sense. If you are making sausages, you should be confident that what comes out can only change by what you put in.

I suspect as the apps I develop become more complex, such things will be a lifesafer for my sanity.
