# ES6 Stuff

ES6 has been around for a couple of years now, I don't think people can call it new. Some of it gets taken for granted by myself, or I forget its a thing.

# Enhanced Object Literals

Take the following example from ES5:

```js
function createBookShop(inventory) {
	return {
        inventory: inventory,
        inventoryValue: function(){
            return this.inventory.reduce((total, book) => total + book.price, 0);
        },
        titlePrice: function() {
            //etc
        }
}
const inventory = [
	{title: Lukie Cooks With the Stars", price: 10"},
	{title: Sci Fi Adventurues", price: 15"}
    ]
const bookShop = createBookShop(inventory);

bookShop.inventoryValue();   // 25
bookShop.priceForTitle("Lukie Cooks With the Stars"    // 10
```

There is a few things we can do to just make things easier to read.

**Same key value pairs**

In the example above, if we have the same key and value we can condense it as so:

`inventory: inventory` can reduce down to just `inventory`

p.s its conventional to put your shortest key value pairs first.

**Functions in Objects**
	
If you have a key value pair that is a function then you don’t need the  function keyword and colon

So `inventoryValue = function(){` becomes:

`inventoryValue() {
	//Your function
}`

This becomes more apparent when you start seeing `class notation`

# Default Function Arguments

When passing in a function, **we can set defaults for arguments if they are unspecified**

Lets take the following code as an example where the method is normally GET.

```js
function  makeAjaxRequest(url, method) {
	//logic to make the request
	if(!method){
		method= "GET";
	}
}
```

That’s quite a faff to do. Instead we can just do the following:

makeAjaxRequest ( url, method = "GET")

This will make the  default method to be "GET". However if we were to specify a method if will take that as the value for method: `makeAjaxRequest(url , "post");`

Here is another Example where we might want to look for a User's ID or create an ID if it doesnt exist:

```js
function User(id) {
	this.id = id;
}

function generateID() {
	return Math.random()  * 99999999;
}

function createAdminUser(user = new User(generateID()) ) ){
	user.admin = true;
	return user;
}

createAdminuser()  //  will create a new user if no user is specfied
```

# Rest, not REST

REST captures additional arguments in a single array

```js
addNumbers(1,2,3,4,5,6,7)

Function addNumbers(…numbers) {   //This makes the arguments into a single array
	return numbers.reduce((sum, number) => {
	return sum + number;
	}, 0);
}
```

# Spread

SPREAD is used to spread variables out, kinda opposite of Rest. We could use the concat method to join some arrays together:

    arr1 = [1,2,3]
    arr2  = [3,2,1]
    arr1.concat(arr2)

Or we can use spread:

`spreadArr = […arr1, … arr2]`

Its good because:

- We can spread multiple arrays
- Make a list with its own elements already

# Spread WITH Rest

You could have a shopping list function that takes in items which via Rest:

`shoppingList(…items)`

This can take a number of arguments and make an array out of them. However if we always wanted to add a particular item we can return using spread:

`return ['spinach' , …items]`

----
# Destructuring

Destructuring is the act of 'breaking open' an object or array to pluck out a property:

    Pulls off properties from Objects.
    Pulls off Elements from Arrays.

Lets say you have the following ES5 code:

```js
var expense = {
	type: 'Business',
	amount: 45
}
var type = expense.type;
var amount = expense.amount;
```

In ES6 we can express that like this:

	const { type } = expense;
	const { amount} = expense;

We can simplfy it further by:

    const { type, amount } = expense;

The variable must match the key in the object. This is a really useful to shrink the amount of code that must be written. There is a lot of ways to use it.

In ES5 if you have a file like:

```js
var savedFile = {
	name: "secrets"
	size: 1000;
}

function fileSummary(file) {
	return "The file is " + file.name + " and is a size of " + file.size;
	
fileSummary(savedFile);
```

Using ES6 we can change the arguments we pass to functions:

`function fileSummary( {name, size})`

This means that the name and size arguments are from the object.


## Destructuring in an Array.

This pulls of elements of an array as follows:

```js
const companies = [
	'Amazon',
	'Facebook',
	'Uber'
];

const [ first ] = companies;  //First is now 'Amazon'
```

## Destructuring BOTH arrays and objects

```js
const companies = [
	{name: 'Google', location: "mountain View"}
]

const [{location}] = companies   //mountain View
```

Or the other way around:

```js
const Google = {
	locations:['mountain view' , 'new york']
}

const    {locations: [location}  }  = Google   //mountain view
```

**Why is Destructuring useful?**

If you have a function with a lot of arguments its hard to recall the order in which those arguments needs to be provided


Instead of `example(1,2,3,4,5);`. You could pass an object through that is destructured:

```js
const thing = {
	a: 1,
	b: 2,
	c:3,
	d:4,
	e:5
}
example(thing)
function thingFunction({a,b,c,d,e})
```

That will look for the keys regardless of order. Using a destructured object or array in a function can be useful. It also is how alto of libraries work so its a syntax style you should expect to see often.

## Conclusion

This is only a partial look at ES6. Some things, such as array helpers and promises really deserve thier own sections. Other things like template strings I just forgot about.

If you want to know more, I can heartily recommend Stephen Grider's [ES6 Javascript: The Complete Developer's Guide](https://www.udemy.com/javascript-es6-tutorial/learn/v4/overview)

As that's been my main source of getting to grips with it.