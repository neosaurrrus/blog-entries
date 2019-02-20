
# Introduction to Associations

There are different types of data exist in applications, ie. For a blog you might have:
	
-Users
-Posts
-Title
-Comments
-Tags
-Likes

They have a relationship with each other, for example:

- A Post has ONE Title -  A title has ONE post
- A Post has MANY Likes  - A like has ONE post it refers to.
- Many Users make MANY comments.

So in short they can have the following relationships:

    ONE to ONE
    ONE to MANY
    MANY to MANY

There are two ways of linking Data, Embedding and Linking.


# Embedding Data

A user can have many posts. So let's define two models and schemas, user and post:

- USER
    1. name
	1. email

- POST 
	1. title 
	2. content

How can they be related? Via Embedding data!

In User's schema add the following Object Property:

`posts: [postSchema]`

This requires post schema to exist befoehand.

Now you can make a user contain the post array of postSchemas and then you can push posts to the object.

```js
ExampleUser.posts.push({
	title: "Hello world";
	content: "This is an example comment which is pushes to the postSchema embedded inside the ExampleUser});
```

Remember to save the User back to the database.

So to recap, to add a post to a user do the following:

1. First retrieve the user.

```js
User.findOne({name: Alice Smith}, (err, user) => {
if (err){
console.log(err);
} else {
```

2. Push in the posts from the posts array:

```js
user.posts.push({
	title: "Example Post"
	content: "Blah blah blah"
	});
```

3. Save the user:

```js
user.save( (err, user) => {
    if (err) {
    console.log(err)
    } else {
    console.log(user)
});
```

The post is now embedded within the user.



# Association by Object References


This points to a certain object rather than containing the actual information. 

- Person Object
   - Posts Array with IDs
  
A schema which uses object references looks much like this:

```js
let userSchema = new mongoose.Schema({
	email: String,
	name, String,
	posts: [
			{
			type: mongoose.Schema.Types.ObjectId, //ID for the item
			ref: "Post" //where it lives
			}
		}
```

The steps to set this up are as follows:

1. Make a User
	
```js
User.create({
	email: "alice.thomas@gmail.com",
	name: "Alice Thomas"
});
```
2. Create the Post, including an identifier of the poster
   
```js
Post.create({
	title: "How to get to Wonderland",
	content: "Don't use drugs"
	}), (err, post) => {
	User.findOne({email:"alice.thomas@gmail.com"}, (err, foundUser){
		if (err){
		console.log(err);
		} else {
			foundUser.posts.push(post);
			foundUser.save( (err, data) => {
				console.log(err);
		} else {
			console.log(data);
	});
```


## How to find a user's posts

1. Find User.
2. Find all posts for the user

```js
User.findOne({email: "alice.thomas@gmail.com}).populate("posts").exec( (err, user) => {
	if (err) {
		console.log(err);
	} else {
	console.log(user);
});
```

## How to link Mongo data together via Associations

Let's be less theoretical. Lets build an app that tracks laptimes by a racing car. We want to have a Car object and we want a Laptimes Object. A car can do several laptimes. These will be embedded in the Car Object.

Car Object can have:
• type - String  //Lets use this as the unique field even though it isnt…
• driver - String
• laptimes - Array of Objects
    □ ltime
    □ date

Step by Step:

1. Install mongoose and have a DB running
2. Make a new node file, lets say index.js
3. Require mongoose
4. Connect mongoose with: `mongoose.connect('mongodb://localhost/embed_demo')`
5. Build a schema and model for Cars and Laps something like:

```js
const carSchema = new mongoose.Schema({
    type: String,
    driver: String,
    laptimes: [ { }]
});

let Car = mongoose.model('car', carSchema);
const lapSchema = new mongoose.Schema({
    time: Number,
    date: Date
});
let Lap = mongoose.model('lap', lapSchema);
```

6. For our example we are going to create a car like so:

```js
Car.create({
    type: "Ferrari",
    driver: "Vettel"
    }, (err, newCar) => {
    if (err){
         console.log(err)
    } else {
    console.log(newCar)
    }
})
```
	
7. Then we can EMBED a laptime by first finding the car then pushing a lap object to the laptimes array:
	
```js
Car.findOne({driver:"Vettel"}, (err, driver) => {
    if (err){
        console.log(err);
    }
    else {
        driver.laptimes.push({
        time:123,
        date: "2015-11-09"
        })
    } 
});
```

8. We have retrieved the object from the database, added now content, but this wont be relfected in the database till we save!

And there we go, a one to many relationship, all the laptimes belong to one Car.

However, the lap schema isnt used here. This is just adding a separate object within the driver's laptime array.

## Association by Reference:

Embedding data might be good for certain circumstances but what if the laptime, in the example above, was in its own collection? Then we would need to point to that via a reference.

For this I am going to create a new car and see how I can pass a laptime to it via reference.

1. First do the steps as before but lets make a tweak to the schema for the car like so:
	
```js
const carSchema = new mongoose.Schema({
    type: String,
    driver: String,
    laptimes: [ {
        type: mongoose.Schema.Types.ObjectId, //find the ID in the database
        ref: "Lap" //Which model are we referring to?
    }]
});
```

This points laptimes to the Mongo ID in the Lap model.

2. Lets make the following car as our example:

```js
Car.create({
    type: "Red Bull",
    driver: "Max"
    }, (err, newCar) => {
        if (err){
         console.log(err)
        } else {
         console.log(newCar)
        }
})
```

Notice that there is no laptimes defined.

3. So the key difference is what happens when we create a lap. There is 4 steps :

• Create the lap
• Find the car
• Push the lap ID into the car's laptimes array
• Save the car back to the DB.

It is quite callbacky but here goes:

```js
Lap.create({
	time: 152,
	date: "2015-04-05"
	}), (err, lap) => {
		Car.findOne({driver:"Max"}, (err, foundCar){
			if (err){
				consolelog(err);
			} else {
				foundCar.laptimes.push(lap)
				foundCar.save((err, savedData) => {
					if (err) {
						console.log(err)
					} else {
						console.log(data);
					}
				})
			}
		});
```
And now we can see the laptimes (I ran it twice by mistake..) shown by id!

## Displaying Our Reference

So having a random collection of letters and numbers is all well and good by how do we see what they refer to?

As opposed to just finding a user (which would show the above) Mongoose offers a method which 'reaches out' and grabs the reference. This is called Populate and it goes something like this:

<Mistake Moment!>

So it turned out that I was making the wrong reference in the carSchema: It should have been the model name rather than the variable I used:

Anyhow, after about 30 mins of figuring it out, you do end up with something like this:

I had to create plenty of new cars and laps while troubleshooting this. Still, when things do wrong you get to learn. So I learnt!

So that is Embedding Objects and Using Object References. Quite a simple concept. A lot of syntax especially with all the callbacks. I am sure there is an ES6 way of doing it smarter maybe.