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

xxxxxxxxxxxxxxxxxxx


Now, looking at the diagram I can see that the challenging part, since I have never done it before, is the many-to-many relationship to the same model. Some initial research suggest ways to get this done. It's easy for me to lose my head and start worrying about how to implement it. For now, its written down and that's good enough.


## Wireframing and General Styling

 I did sketch out some wireframes to help coax out the user stories above.

 The initial sketches were just come on pen and paper and then I used Figma to try and get a more developed style to have something to aim for. There end result isn't exactly what I came up with but at least it was an inspiration. 

 While it does help to sketch out the way the app will work and look. It is a trap to focus too much on the visuals at this point, simply because you will develop that sense of what it needs to look like over time as the app builds up. An example of this is the inital dark theme I considered, I help clashed with the clean, lighter feel associated with food sites. However the final app has minimal styling simply because I wanted to complete hte project and move on but it was only when I had the app working I felt best placed to style it properly. With more time, it would be the ideal time to revise my figma style and make sure the app has its own unique but appealing styling.


## My Models and Migrations

For the app to work I needed to create several models:

- Category
- Ingredients
- Substitutions
- User

Each model may contain scopes, validations, associations and methods.

### Category

Category is the simplest model to define and explain. The category is used to simply group ingredients so that similar ingredients are kept together for navigation simplicity. Since categories are not expected to change, they are created automatically as part of the seeds file.

```rb
# Migration
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end

# Model
class Category < ApplicationRecord
    #scopes
    scope :ordered_by_name, -> { order(name: :asc) }
    #associations
    has_many :ingredients
    has_many :substitutions, :through => :ingredients
end
```

There is only two fields, has fairly simple relationship with the other models. There is no validations as there is simply no way to add more or make changes to the existing ones.

As I often need to show a list of categories to the user, there is a scope which orders them alphabetically making it easier for the user to browse for what they are after.

### Ingredient

Ingredients need to exist for a substitution to be created. Typically these are created when a user creates a substitution, however I still give the often for these to be created seperately as well.

```rb
# Migration

class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.boolean :vegan, :default => false
      t.boolean :vegetarian, :default => false
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end

# Model

class Ingredient < ApplicationRecord
     #scopes
     scope :ordered_by_name, -> { order(name: :asc) }
     #validations
    validates :name, length: { minimum: 3}
    validates :description, length: { minimum: 10}
    validates :category, presence: true
    validates :name, uniqueness: true
    #associations
    has_many(:substitutions, :foreign_key => :original_id, :dependent => :destroy)
    has_many(:reverse_substitutions,:class_name => :Substitution, :foreign_key => :sub_id, :dependent => :destroy)
    has_many :ingredients, :through => :substitutions, :source => :sub 
    belongs_to :category
    belongs_to :user
end

```

Ok, so this one is a tad more complicated. It has foreign keys to allow it to belong to a user and category. It has validations to try and persaude users to provide more info where required, as well as ensuring the same ingredient name can't be provided twice. For similar reasons to the Category, a scope is provided to list Ingredients in alphabetical order.

The associations are a bit crazy in order to get the double ingredient thing working with substitutions as well as ensuring that if the ingredient is deleted, any dependant substitutions go as well. It probably makes a bit more sense once we look at...

### Substitutions

Substitutions are the whole point of the app. They exist to map an original ingredient to a substitution (shorted to sub most of the time in my code and below) ingredient as well as providing a little more info about the substitution.

```rb
# Migration
class CreateSubstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :substitutions do |t|
      t.integer :original_id
      t.integer :sub_id
      t.string :description
      t.string :issues
      t.boolean :same_quantity, :default => false
      t.integer :user_id
      t.timestamps
    end
  end
end

# Model
class Substitution < ApplicationRecord
    #scopes
    scope :last_5, -> { order(created_at: :desc).limit(5) }
    #validations
    validates :original_id, :sub_id, presence: true
    #associations
    belongs_to :original, :class_name => :Ingredient
    belongs_to :sub, :class_name => :Ingredient
    belongs_to :user
    accepts_nested_attributes_for :original, :sub

    def original_ingredient
        Ingredient.find(self.original_id)
    end

    def sub_ingredient
        Ingredient.find(self.sub_id)
    end

end
```

The substitution migration has 3 foreign keys to join 2 ingredients and the user together. Since the app need to refer to the original and substitution ingredients often, there are a few methods to assist with that.

There is a feature to view the last 5 substitutions so a scope is provided to make that easy to do.

The associations is the other half of the puzzle in how to reference 2 ingredients as original and sub. 


### Users

I am going to assume you are familar with the concept of a user. In the context of my app, a user is able to create new ingredients and substitutions and edit and delete ones they have created. Nothing too suprising I expect.

```rb
# Migration
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.timestamps
    end
  end
end

# Model

class User < ApplicationRecord
    has_secure_password
    validates_confirmation_of :password
    validates :password, length: { in: 8..20 }
    validates :username, uniqueness: true
    validates :username, length: { in: 3..20}
    has_many :substitutions
    has_many :ingredients
end
```

I use BCrypt to hash the password so it is securely stored in the database. There is a number of validations to ensure a good quality password, it is confirmed by the user and there cant be a clash of users. 
















