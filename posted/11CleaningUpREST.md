# Cleaning up REST

You cant go round writing all your code in app.js when developing a REST application. It just isnt the polite thing to do. So there are a number of ways you can make a node app a lot more modular and easier to deal with. Here are some REST App tidying quick notes. I don’t think this will make much sense but hopefully jogs memory on things that can be done.


Previously we wrote a cattery app which I am going to tidy up a little.. 

Currently the app.js is 134 lines, lets see how we can shrink it down some via the following steps

# Split your models into the models directory. 

Here we take the schema generating to a different file that also exports the model.
    -Create models directory if it doesnt exist
    - Create a js file, a good naming convention is to keep the js file the same as the model we are using. We have a cat model so we can have a `models/cats.js`
    -add requires for anything it needs.
    -module.export the mongoose.model: `module.export = mongoose.model("cat", catSchema);`

• In app.js, add a require that references the model we just created: `const Cat = require("./models/cat.js")`

App.js is now 111 lines with a few minutes effort. 

# Split your routes into files in the routes directory. 

- Make a routes directory
- make JS files for each of your types of route. (eg. index.js, auth.js, comments, trails.)
- Move the relevent into the JS file.
- Remember to Require express.
- Require any relevent models/passport etc depending on type of JS files.
- add a line at the top: `const router = express.Router();`
- change instances of `app` to `router` for each route.
- add module.exports = router.


- In app.js require your new routes JS files. `e.g commentRoutes = require("/.routes/comments");`

Now we can do:

1app.use(indexRoutes);
app.use(commentsRoutes);`

which makes App.js far less confusing.

# Shorten paths

Where routes in a given JS file have a similar path we can shorten that path by adding the common part to the app.use:

`app.use("/cats", catRoutes)`

In catRoutes.js, remove the duplicated bit of path:

`router.post("/cats" ….` becomes `router.post("/"….`

`router.get("/cats/:id"`, becomes `"/:id"`

Comments is more difficult as it tries to pass through an ID:

`router.get("/cats/:id/comments")`

However the ID doesn’t get passed by default.

Thus we need to add a `router = express.Router({mergeParams: true})` to do this.

# Remember to Generally prettify and comment the files accordingly

That's a whole other topic but don't make things harder to understand in your quet for efficiency.