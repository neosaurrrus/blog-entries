# All about the SQL

What is SQL? In my previous life SQL is magic only know to certain areas of an IT department. Generally the people who tend to kno alot about it were a little bit ... strange. Well it looks like I am about to get  strange (er)

# What is SQL?

It is a language for manageing data in a database. There is different favours but they all aim to query and mutate data in a database in some way. As a web developer we need databases to keep data we want to exist between sessions.

So we need to learn how to:

1. Create a database
2. Create, update, select and delete data from database tables.
3. Relate data within a given database
4. Write Code that interacts with the database
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
