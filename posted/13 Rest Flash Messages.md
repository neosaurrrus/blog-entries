# Flash Messages

Those little messages you see the first time you log on somewhere they are flash messages. You see them all the time but you didn’t know that’s what they were called:

For the backend REST app I am working on. The package we will use for this is connect-flash.


# Basic Setup

1. Install it from npm: `npm install connect-flash`
2. Require it 
3. `app.use(flash())` - add it to express.

*Note that if you forget the braces to invoke flash, your app will happily load infinitely while you wonder what went wrong. Don't ask me how I know…*

If you havent set up session manager this is a good time to do it, google the setup as you may or may not require other things depending on your express version.

# General Idea

`Connect-flash` operates as middleware, in the route definition it would be called as follows:

`app.get("/posts", flashMessage, (req, res) ...`

However as we are using flash messages as part of our authentication, we will be adding to the middleware already defined. In my fictional forum application I have two pieces of middleware:

1. Check if user is logged on
2. Check if the current user matches the post author
3. Same again but for comments.

Lets first assume we want to show a message when a user tries to access something they need to be logged in for. So here is my Login Check middleware currently. At the moment it redirects to the login form if the user cannot proceed to the destination:

```js
middlewareObject.isLoggedIn = (req, res, next) => { //Check if logged in
if (req.isAuthenticated()) {
return next();
}
res.redirect("/login")
};
```

To explain things better for our user, we can add something like this:

```js
middlewareObject.isLoggedIn = (req, res, next) => { //Check if logged in
if (req.isAuthenticated()) {
return next();
}
req.flash("error", "Please login first")
res.redirect("/login")
};
```

In the above:

`req.flash(<key>, <message>)` 

This doesn’t render anything straightaway, this is configured to give the capability of showing "error" on the next page.

# Displaying the Message

So on the login route which looks like this currently:

```js
router.get("/login", (req, res) => {
res.render("login");
})
```

We can pass things to the template by passing through req.flash with the key:

```js
router.get("/login", (req, res) => {
res.render("login" {message: req.flash("error")});
}
```

Now if you add it to the login template like `<h1 >  <%= message %> </h1>`. The H1 will say "Please login first"

# Styling on templates.

To have the flash functionality on all routes we could add the h1 message to the header.

However, this alone will cause an error on all routes (except logon) as 'message' isnt defined.

We can however can use some middleware to passthrough message to every route:

```js
app.use((req, res, next) => {
	res.locals.message = req.flash("error");
	next();
});
```

*Note: you might have already set this up for passing req.user if you have been working with passport for authentication*

It is worth styling based on the type of flash message:

Green = Success, relax everything is fine.
Blue = Informative, something nice to know
Yellow = Warning, something might not be right
Red = Danger, something has gone wrong

So instead of a ` <h1 >  <%= message %> </h1>`

we can style a div according to the type of message it is.

<div class="alert-danger">
	<%= error %>
</div>

*You can use css to make the div and text a suitably frightening red*

The 'error' message can be configured on a given route to say "Login successful"  for example

That isnt too logical and also if we replace the h1 with the div, it will always display even if there is no message so we need to be smart…

# Smarter things to do when using Flash Messages

Different types of message are agood idea.

In our logout route, where thins have gone OK we could introduce a success message like so:

`req.flash("success", "Sucessfully logged out")`

We can:

1. Make additional variables in res.locals to define the type of message

```js
app.use((req, res, next) => {
	res.locals.message = req.flash("error");
	res.locals.message = req.flash("success");
	next();
});
```

2. Add alternative  divs to the header:
		
```js
<div class="alert-danger">
	<%= error %>
</div>
<div class ="alert-success"> 
	<%= success %>
</div 
```

Obviously this will show multiple divs:

3. We can get rid of the spare one by adding an IF statement in the header:

```js
if (error && error.length > 0) {     
	//show div
	
if (success && success.length > 0) {
		//show div
	}
```

# Where to add messages

This really depends on the type of app you have, but assuming a RESTful CRUD app with Authenticaton, the error path can have a req.flash setup like below:

- CREATE ... "You need to be logged in"
- NEW ... "You need to be logged in"
- SHOW ... "Everyone can access"
- EDIT ... "You are not allowed to edit this / You need to be logged in"
- UPDATE ... "You are not allowed to edit this / You need to be logged in"
- DESTROY ... "Successfully Deleted"

Basically look for error and success routes and the feedback you want ot give back to the user.

# Extra Nice Stuff

You can pass a lot of things…

- Pass through the username to greet the user.
- We can even send through the 'err' parameter:

`req.flash("error", err);  // Will show the error to the user.`

However err will be an object… you want to use err.message or check err.name to make your own custom error.

# Flashing Logins

If you want to have flash messages for login and using passport, you might have set up passport to redirect after a login attempt. If that’s the case you'll have something like this:

```js
router.post("/login", passport.authenticate("local", {
successRedirect: "/trails",
failureRedirect: "/login",
}), (req, res) => {})
```

How can you manage the flash messages of this? You can use passports built in flash handling to do the job:

```js
failureFlash: true,
successFlash: "Welcome to my Site, " + req.body.username + "!"
``
If you do, you'll end up with something like this:

``js
router.post("/login", passport.authenticate("local", {
	successRedirect: "/trails",
	failureRedirect: "/login",
	failureFlash: true,
	successFlash: "Welcome back to my site"
}), (req, res) => {})
```

More on this can be found at : http://www.passportjs.org/docs/authenticate/
