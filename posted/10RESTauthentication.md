
Authentication, the bit of a web app that is all about logins, registrations and showing things that other people cant see. You have used the web, you know what it is. This cronicles my attempts to get it working in the most basic way possible for my REST App.

	
Authentication is a tricky concept, so much so its best to rely on reputable packages to handle it for simple apps.


# To reach our destination we need Passport

Since I have been working with Express and Mongo, the middleware I will be using is Passport Js  - http://www.passportjs.org/

This allows authetication to be dropped into an Express app with minimal (but still significant) fuss.

There are various ways it can autheticate, such as using twitter, or facebook. These are known as "Strategies", or as I describe it, additional stuff to make it work.

The most simplest method (and the the one with the most security holes) is local authentication. We will store the username and password (sort of) in a mongoose database ourselves rather than going to facebook/google/etc.

So the passport Strategy we want is passport-local:

`https://github.com/jaredhanson/passport-local`
And to make it easier to work with mongoose we will use the mongoose plugin passport-local-mongoose:

`https://github.com/saintedlama/passport-local-mongoose`

# Setting up our REST App

We need the following packages to be installed:

• Express - Handles web servering
• Mongoose - Allows simpler talking to the Mongo DB (which we are assuming is up and running here)
• body-parser - Makes body text coming back from responses a little easier to work with
• EJS - for creating web templates with HTML and JS.
• Passport - the Authetication thing we just talked about
• passport-local - The local strategy for passport
• passport-local-mongoose - Plugin to get mongoose to talk easiily with passport.
• express-session - It would suck if we had to login each time so this manages the session to allow previously logged in people to remain logged in.

Phew! That’s modern web development.

# The basics.. again

Ok, before we can think about authetication type stuff we need to set up the basics of express and mongo like so:

```jsx
const express = require('express'),
      bodyParser = require('body-parser'),
      mongoose = require('mongoose'),
      passport = require('passport'),
      localStrategy = require('passport-local'),
      passportLocalMongoose= require('passport-local-mongoose'),
      app = express();
mongoose.connect("mongodb://127.0.0.1/authentication");
app.use(express.static('public'));
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({
extended: true
}));
//Routes
app.get('/', (req, res) => {
res.send("home");
})

//Listen
app.listen('3000', () => {
console.log("Authentication Demo is running")
})
```

As always I am keeping it simple rather than ideal. A quick res.send allows us to check the basis are up and running. Which they are.

# Setting up the Routes
	
Here we need a basic home page with three links:

-Members Page
-Login
-Register

We also reate the page that requires authentication  In this case we are going to call the route "members" as its…well for members only.
	
In app.js the routes (currently) looks like:

```js
app.get('/', (req, res) => {
res.render("home");
})
app.get('/members', (req, res) => {
res.render("members");
})
```

We also make the pages in the views directory. Nothing fancy yet.

# Creating the User Schema

We need to define a user in order to manage access by having username and password fields

We create a models directory and create users.js where we have two tasks:

-create the user schema
-module export the model

This ends up looking something like this:

```js
const mongoose = require("mongoose");
const userSchema = new mongoose.Schema({
username: String,
password: String
})
module.exports = mongoose.model("user", userSchema)
```

In your app.js file don’t forget to add User as another require like so:

`const User = require('./models/users')`


# Initialising Sessions and Passport

We set up the ability to manage sessions using express-session:

```js
app.use(require("express-session")({ 
secret: "I am a robot",
resave: false,
saveUninitialized: false
}));
```

We initialise passport with the following:

`app.use(passport.initialize())
app.use(passport.session())`


# The register routes

## NEW registration route

We need a page where we can register a new user. For simplicity the route and template will be called register. You know how to do that.

On the register template we want a form to get a username and password. There are many best practises for gathering information from forms. We are going to ignore all of them (but maybe that’s another blog post sometime):

```js
<form action="/register" method="POST">
<input type="text" name=user[username] placeholder="Username">
<input type="password" name=user[password] placeholder="Password">
<button>Submit Registration</button>
</form>
```

## The Register Post Route

This is where things get spicy. We want to take the username and password and create a new user in the database. However, saving the password directly into the database is a really bad idea. Helpfully, the packages we have installed make doing it properly somewhat easier:

```js
app.post('/register', (req, res) => {
	User.register(new User({username: req.body.user.username}), req.body.user.password, (err) => {
	if (err) {
	console.log(err);
	return res.redirect("/register");
	} 
	passport.authenticate("local")(req, res, () => {
	res.redirect("/");
	});
	});
});
```

That should work! You can check in Mongo. You will see the password with salt and hash. This is all done via Passport Local Mongoose.


#The login form route

So if registering takes a user input and places it into the database then login is similar except it retrieves it from the database, checks the password is valid and creates the logged in session. Or something like that.

First of all we need to create the login page route, template and make the form on that, which is going to be like the registration form but with one key difference: where it is going to go:

`<form action= "/login" method="POST">`

Well that was easy….

# The Login Post Route

Well this is where things just interesting again…

Instead of just allowing the login go through:

`app.post("/login", (req, res) => {})`

We authenticate using passport.authenticate and define what happens when you are successful or not:

```js
app.post("/login", passport.authenticate("local", {
successRedirect: "/",
failureRedirect: "/register"
}), (req, res) => {
})
```

# Logging out

Thanks to the magic of packages, this is quite easy:

```js
app.get("/logout", (req, res) => {
req.logout()
res.redirect("/") 
});
```

Just remember to put a redirect link in there somewhere!

# Actually making the member's page members-only

So far, the members page has been accessible no matter what you did, It needs there to be a check when you access the page.

Currently the route is like this:

```js
app.get('/members', (req, res) => {
res.render("members");
});
```

We need to introduce some *middleware* to get it working.

First make a function that checks if the current session is logged on:

```js
function isLoggedOn (req, res, next){
if (req.isAuthenticated()) {
     return next();
    }
res.redirect("/login");
};
```

Then introduce that function as middleware to the app.get call:

```js
app.get('/members', isLoggedOn, (req, res) => {
res.render("members");
});
```

Then bang! We have a simple login system!

But what if we wanted to use the information in the user in someway? i.e Greet based upon username? Well the login is fairly simple, the user is kept as req.user. So its just a case of passing it through and using the object.

But if you don’t fancy passing through req.user to every route then there is a middleware we can use:

```js
app.use((req,res, next) => { //Pushes Req.User to all routes as currentUser
res.locals.currentUser = req.user;
next();
});
```

Ok, so we can check for users being logged on. But what if we wanted to restrict access to a particular user. For example, if you have a Forum post, you might want the original author to edit and delete it but not anyone else. In that case, just being logged on isnt a good enough check, we need to check the user's rights as well.

**This is Authorization.**

For an edit route we might want to check:

1. Is user logged in? The code for that is like…

```js
if (req.isAuthenticated()) {
    //do all the things.
} else {
    //<You need to be logged in type message>
}
```

2. Does user own the post?

After checking if they are logged in. Compare the Id on the post is the same as the user to determine if they own the post.

Small gotcha here:

The id of the current user could be: req.user._id which is a string.

The id of foundPost (see below) could be: foundPost.author.id This is an object!

So req.user._id does NOT equal foundPost.author._id! How do we get past this? Handily Mongoose gives us this method:

`foundPost.author.id.equals(req.user._id)`

So the example code within the req.authenticated success path looks a bit like this:

```js
Post.findbyId(req.params.id, (err, foundPost) => {
	if (err) {
	//Error handle
	} else {
		if(foundPost.author.id.equals(req.user._id)){
		//Show Edit page.
		} else {
		//<''you are not the owner'' type message.>
};
```

# Conclusion

Hopefully this gives you a quick taste of authentication using Express, Mongo and Passport. It quite an indepth topic. I suspect I will be writing more on this in due course.