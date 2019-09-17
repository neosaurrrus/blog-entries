# Object Relational Mapping

In previous blog posts we have looked at Object Oriented Programming and SQL. Let's bring that together with Object Relational Mapping

# What is ORM?

ORM isn't a particular language or gem, it is a design pattern we can use when our programs connect to a database. The idea is thus:

> When mapping our program to a database, we equate classes with database tables and instances of those classes with table rows

That probably makes sense, a table contains a set of columns or properies that all rows will consist of. Thats similar to how Classes and instances are.

This is good as it avoids repetition and is organised in a way that makes sense. If this is what other devs expect then thats a pretty good reason in itself.

So there is a number of areas we will look as part of understanding the design pattern:

1. Creating the database


## Creating the Database

Creating the database for our program is not really a job for a particular class and is often set up in its own config file. After all, in real life, we might have different DBs for different environments. The code may look a little like this:

```rb
require 'sqlite3'
require_relative '../lib/dish.rb'
 
DB = {:conn => SQLite3::Database.new("db/food.db")}
```

That way we can reference the connection to the DB with `DB[:conn]`


## Creating the Table

Since a table relates to a class we need the class to produce the table. Lets look at an example:

```rb
class Food
 
  attr_accessor :meal, :cuisine, :id
 
  def initialize(meal, cuisine, id=nil)
    @id = id
    @meal = meal
    @cuisine = cusine
  end
 
  def self.create_table
    sql = 
      "CREATE TABLE IF NOT EXISTS food (
        id INTEGER PRIMARY KEY, 
        meal TEXT, 
        cuisine TEXT
        )"
    DB[:conn].execute(sql) 
  end
 
end
```

Note that the ID is nil as the Database will do that.

So we might do `Food.new("Fish and Chips", "British")`

But to get it into the database we need to do something in SQL akin to: `INSERT INTO food (meal, cuisine) VALUES ("fish and chips", "British")` For that we can use a save method that does that but in a clever way..

```rb
def save
    sql = <<-SQL
      INSERT INTO food (meal, cuisine) 
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.meal, self.cusine)
  end
end
```

The ID attribute exists in the table we made and in the row of the database as it automatically assigns it. However the Class instance does not have it so thats something we can add to our Save method to get the database ID and set the @id variable to it.

 `@id = DB[:conn].execute("SELECT last_insert_rowid() FROM foods")[0][0]`


 Its a good idea to keep the save function and initialise methods seperate as you may not always want to save straight to the DB upon creation. However it can be annoying to do *new* and then *save*. So we could have a create method that combines the two. Just remember to return the created instance at the end of the method as that saves alot of faffing around later.


# Reading from the database

So far we have been putting things int othe databasebut what if we want to actually get stuff out of it? Thats a pretty useful thing to want to do. If and when we add to the database we write a new row to our SQL database, logically we read that row...

There is a few ways to do that:

1. new_from_db - Turn a DB row into a Ruby Object

2. all - Select all rows from a db, interate over the results using new_from_db

3. find by name - We pass in a name and slect based upon that

## new_from_db

This is the method that turns a DB line into an object. 

The thing to note here is that we get an array when grabbing from the DB so its a case of slotting in the array items into the object we create

```rb
def self.new_from_db(row)
    new_food = self.new
    new_food.id = row[0]
    new_food.name = row[1]
    new_food.cuisine= row[2]
    new_food
end
```

## all

Here we build the select query to grab everything from the database, execute it and then for each thign that gets returned we use new_from_db to get an object created.

```rb
class Food
    def self.all
        sql = <<-SQL
            SELECT * FROM foods
        SQL

        DB[:conn].execute(sql).map do |row|
            self.new_from_db(row)
        end
    end
end

```

## find_by_name

This is just a different query to selecting all, and thus requires a name to look for. Once we have done, it is fairly similar:

```rb
class Food
    def self.find_by_name(name)
        sql = <<-SQL
        select * FROM foods WHERE 
        name = ?
        LIMIT 1
    SQL

    DB[:conn].execute(sql).map do |row| self.new_from_db(row)
    end.first
    end
end
```


# Updating Records

Using ORM, So we have Created things, Read things from the database. Now lets look at Updating things 

Updating can be broken into three steps:

1. Find the record we want
2. Update it in some manner
3. Save the changed version to the DB

We have defined some methods we will use again earlier in this post so lets drill down on the methods that matter for updating.

## Update Statement

So let's assume we have Foods again and that currently `pasta.cuisine is 'french'`

That wont do so we can change it in ruby by just doing `pasta.cuisine = 'italian'`. Now its a case of using that in an update statement:

```sql
UPDATE foods
SET cuisine = "Italian"
WHERE name = "pasta";
```

Using the SQLite3-Ruby gem we can do it a little easier:

```rb
sql = "UPDATE foods SET cuisine = ? WHERE name = ?"
DB[:conn].execute(sql,pasta.cuisine, pasta.name)
```

However if we wanted to change the name of the food then we would have to do a very similar query to the above, it would be better to come up with a more flexable UPDATE method... so we can just update all the attributes to catch whochever one has a change:

```rb
def update
    sql = "UPDATE foods SET name = ?, cuisine = ? WHERE name = ?"
    DB[:conn].execute(sql, self.name, self.cuisine, self.name)
end
```

So lets create and update a food

```rb
pizza = Food.create(name: "Pizza", cuisine:"Spanish")
pizza.cuisine = "Italian"
pizza.update
```

This is fine for cuisine but here is the rub, if we did this using name it wouldnt work as in changing the name it would not be able to find the old name in DB and thus the corresponding record. This is why having the `ID` field helps, no matter what we do, the ID will always be true. Like a dog.


