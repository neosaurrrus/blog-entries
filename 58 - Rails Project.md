# What am I doing?

This blog post is around documenting how I build my app from scratch to finish. This is for a FlatIron school project but I chose to make something that I want to exist in the world regardless.

At time of writing we are all forced to stay home due to COVID, there is no restaurants open so I have been cooking alot more. However, getting ingredients is a pain due to long queues and limited stock in stores. This means that when I want to cook, I often lack the ingredients the recipie is asking for.

If the recipe is asking for *kosher salt*, is regular table salt ok? Can I use white wine if I done have white wine vingar? That is the type of questions I want my app to build up a set of answers for. 

## User stories

User stories are a way setting out what an app needs to do by associating it with what a user (or other people) will want to do.  This keeps the actual people that will interact with the app first and foremost in our minds

The fundemental thing we want to do is **create an application where users can view and contribute ingredient substitutions**. That is our *Epic* in agile terms (really I think its multiple but let's keep it simple). So lets set out some user stories, once you got the jist of it, i'll meet you on the other side.


```
Welcome Page -> '/home'
- As a guest
- I want to learn what IngredientSubstitutions.com is about
- So I can see what substitutions I can make for a particular ingredient.

User Signup -> '/users/new'
- As a guest
- I want to sign up
- So I can submit an ingredient substitution and also make changes to them.

Session -> '/sessions/new'
- As a user
- I want to login with my user credientials
- So I dont have to keep entering my credientials everytime they are required.

View All Categories -> '/categories/index'
- As a guest
- I want to be able to see food categories
- So I am able to browse to the relevent type of ingredient substitution

View Category Ingredients -> '/categories/<category>/ingredients/index'
- As a guest
- I want to be able to see all the ingredients with substitutions for a given food category
- So I am able to see the ingredients that have a substition in that category

View An Ingredient's Substitutions  -> '/categories/<category>/ingredients/<ingredient>/show'
- As a guest
- I want to be able to see all the substitutions for a particular ingredient
- So I can see all the other ingredients I can use instead.

View An Ingredient's Substitutions  -> '/categories/<category>/ingredients/<ingredient>/show'
- As a guest vegetarian
- I want to be able to see all the substitutions for a particular ingredient are vegetarian
- So I can clearly see what substitutions are vegetarian.

View An Ingredient's Substitutions  -> '/categories/<category>/ingredients/<ingredient>/show'
- As a guest vegan
- I want to be able to see all the substitutions for a particular ingredient are vegan
- So I can clearly see what substitutions are vegan.

Add Substitution -> 'users/<user>/substitions/new'
- As a user
- I want to add a new ingredient substitution
- So I can share my substition with others

View All Substitution -> 'users/<user>/substitutions/index
- As a user
- I want to see all the substitution I have created
- So I can view each one as required.

View A Substitution -> 'users/<user>/substitutions/<substition>/show
- As a user
- I want to see the substitution I have created
- So I can confirm it is correct and share with others

Edit A Substitution -> 'users/<user>/substitutions/<substition>/edit
- As a user
- I want to edit the substitution I have created
- So I can amend any details that are incorrect.

Delete A Substitution -> 'users/<user>/substitutions/<substition>/delete
- As a user
- I want to see the substitution I have created
- So I can confirm it is correct and share with others

```

Phew, it is a bit hard to parse as a big list but hopefully you get the idea. It gives a reason app features and starts producing the resultant routes. In reality we should be creating user stories for the next level down, the fields we will have as well.

This is for an MVP version of the application. There is more we could look at given more time and attention:

1. A comment/rating system
2. Servicing other dietary requirements
3. Admin features to manage the content

## Rough Entity Relationship Diagram

(Assumes you have a decent knowledge of MVC and Associations)

I will be building the app in Rails and I need to first consider what models and data will be involved.

I built a rough entity relationship diagram, which will likely go through many revisions, here:



Now, looking at the diagram I can see that the challenging part, since I have never done it before, is the many-to-many relationship to the same model. Some initial research suggest ways to get this done. It's easy for me to lose my head and start worrying about how to implement it. For now, its written down and that's good enough.


## Wireframing 