# All about the SQL

What is SQL? In my previous life SQL is magic only know to certain areas of an IT department. Generally the people who tend to kno alot about it were a little bit ... strange. Well it looks like I am about to get  strange (er)

# What is SQL?

It is a language for manageing data in a database. There is different favours but they all aim to query and mutate data in a database in some way. As a web developer we need databases to keep data we want to exist between sessions.

So we need to learn how to:

1. Create a database
2. Create, update, select and delete data from database tables.
3. Relate data within a given database
4. Write Code that interacts with the  database
5. Write prorams that can talk to and save data data to your database.

For the learn.co course, we will be using SQLite

## Our first commands

`CREATE TABLE` - Create a new table
`.help` - get help on SQL commands
`.tables` - list all tables in a DB
`.schema` - Lets us look up the structure of a DB
`ALTER TABLE` - Add columns
`DROP TABLE` - Deletes the table


To create a database inthe first place we can type something like: `sqlite example_database.db`
This is an example of creating a table:

```
sqlite> CREATE TABLE cats (
        id INTEGER PRIMARY KEY,
                name TEXT, 
                age INTEGER
            );
```


We can put these commands and run then against a DB like so: 

`sqlite3 pets_database.db < 01_create_cats_table.sql`

## SQL Datatypes

Like Ruby, there are datatypes in SQL (and SQLite) that determine what values we can provide. This is important for much the same reason as Ruby #in that it makes sure things are predictable and usable in specific ways.

SQLite uses the following:

TEXT - Like a string
INTEGER - A whole number
REAL - A number like 1.3 which is a bit wierder
BLOB - Which we dont normally need so will gloss over...

However it will accept variations of these such as "INT" for "Integer" as these are used in other versions of sql.

## SQL Inserting

Insert is the act of adding an entry into our database. To do this we have to :

1. Define the table we want to insert into
2. The columsn we wnat to insert into
3. The values we want in those columns.

So the command looks like this:

```sql
INSERT INTO food (name, calories, cuisine) VALUES ('Popadom' '400', 'Indian');
```

You can see from the above its fairly self-explanitory.


## SQL Select

Selecting data is all about reading data. Once we have some data in our database it can be retrieved through select. To do this we have to:

1. Select the columns we want
2. Specify the table we want to get it from.

```sql
SELECT id, name, calories, cuisine FROM food;
```

We can also just grab every column  with a `*` so `SELECT * FROM food;` will do the same as above.

`SELECT DISTINCT name FROM food` only returns unique values.

What if we only want to return all Italian food? This is where the `WHERE` keyword comes into play.

`SELECT * FROM food WHERE cuisine = 'Italian';`

This also works with comparison operatoris like `< >` so we can return all foods with less than 400 characters with `SELECT * FROM food WHERE calories < 400;`

## SQL Update

Update is all about the changing of data that already exists. This is half select and half insert in a wierld way but it makes fairly logical sense if you see it written down:

```sql
UPDATE food SET name = 'Chicken Korma' WHERE name = 'Korma';
``` 

Hope that makes sense when you see it.

## Lastly we have delete

Delete is fairly self-explanitory so lets take an example:

```sql
DELETE FROM food WHERE name = 'Chicken Korma';
```

Thats your basic options in SQL. Lets look at some more advanced onces.


## Little output tips

.headers on - Shows the name of each column
.mode column - Column mode allows us to run `.width auto` and `.width 1,2` to play with width optiosn

# Queries

Queries are, much like in real life, a action to ask for data from the database. While we can do `select * from <table>` we could be smarter about it.

## Order By

Puts the data return by a query into a specific example...

`SELECT name from food ORDER BY calories DESC;`

In the example above it will order the results in decending calorie order. The DESC is descenting. If this is not added it will ASC by default.

## Limit 

As you might guess, this limits what is returned:

`SELECT * FROM FOOD ORDER BY calories DESC LIMIT 1`

In the example above, this will return the food with the highest calories.


## Between

This slects between a rage, again this is fairly logical:

`SELECT * from food WHERE calories BETWEEN 100 AND 300;`

Hopefully you get the idea, this hows all items that are between 100 and 300 calorie wise.

## NULL values

Null is a useful value when we don't have one.

`INSERT INTO food (name, calories, cuisine) VALUES ("Fish and Chips", NULL, "British");`

In the above example, we dont know hte calories so we can use a null instead.

## Count

Count is an agregate function that returns a count of items that are in a specific criteria. For example:

`SELECT COUNT name FROM food WHERE calories > 400;` 

This will show the number of foods with calories over 400.

## Group By

This is another aggregate function that lets you see results based of of a particular column:

`SELECT cuisine, COUNT(cusine) FROM food GROUP BY cuisine;`

You dont need to just group by one field, you can do several as you need to.

## More aggregate functions

SQL has a number of aggregate functions some of which are covered below

*AVG* - Returns the average value ( `SELECT AVG(calories) FROM food;`)
*AS* - Allows an alias to be used as AVG by itself can return a non-pretty column name (`SELECT AVG(calories) AS average_calories FROM food;`)
*SUM* - Sum of all values in a column (`SELECT SUM(calories) FROM food;`)
*MIN/MAX* - These return the minimum and maximum values accordingly. (`SELECT MIN(calories) FROM food`)

## Final note on selecting

We can do `SELECT food.name` instead of  `SELECT name` this is useful if you are trying to get data from various tables that might otherwise have the same column name.






