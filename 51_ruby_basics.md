# What is this about

I know Javascript fairly well. But now I am learning Ruby. This means a whole new set of syntax for doing similar things. I am going to write these basics here as I go, comparing how I know things in Ruby to how I know things in JS.

This isn't meant to be a comprehensive view on everything but rather a sampling on the general differences in the most common things. As with JS, there are plenty of resources out there for cataloging methods and helpers. General rule of thumb is to google what there is much like you would regardless.

## Commands

`puts` - Outputs to console. Similar to `console.log` 

`gets` - Gets. A bit like `prompt` but sits in the terminal rather than creating a popup box

## Methods...or Functions

A `method` in Ruby is a function in Javascript. That is a little confusing. There is some differences in how we call them. This is Ruby:

```ruby
def say_hello(name)
    puts "Hello #{name}"
end
```

This is JS:

```js
function sayHello(name){
    console.log(`Hello ${name})
}
```

A few things you might notice:

- Rubyists prefer snake_case, whereas as Javascripters(?) prefer camelCase
- Ruby relies on an `end` command, whereas JS prefers brackets.
- Ruby has a different way of interpolating variables into string, double quotes and then `#{RUBY_VARIABLE}` like so:

`"Hello #{name}`

There are a few things to watch out for: scoping for example, you can define a variable before a method is called but unless the method is taking it in as an argument it will no???

## Defining Arrays

Array syntax is much like JS:

`fruits = ["Apple", "Banana", "Clementine"]`

We can refer to a fruit in a similar way:

`fruits[1]` is a banana in the above example.

`fruits.push("pear")` - Adds Pear to the end.

You also can do `fruits << "peach"` for a similar effect

## Loops

Loops are fairly straightforward. You have while and until loops which are not too far removed from JS.

The most basic look is just `loop` which is good for causing infinite loops:

```ruby

loop do
    puts "This will never end!"
end

# while loops are a little more structured to end at some point at least...

while i < 10 do
    puts "looping #{count} times"
    i += 1
```

You also have `until` which is like a backwards while.


`times` is a another way of looping, saying `7.times do` will, unsuprisingly perhaps, do somethign 7 times.


## Interators

In JS we have .forEach, in Ruby we have .each like so:

```ruby
horses.each do | horse |
    pet(horse)
end  
```

EACH EITH INDEX

MAP/COLLECT

INJECT

FIND down there

## Enumberables and Array methods

In JS we have some array helpers such as `.some`, `.every`

In Ruby we have similar but cooler ones such as:

**`#none?`**  - Returns true if it doesnt find what is asked for.

`1,3].none?{|i| i.even?} #=> true`

**`#any?`** - Returns true if there is at least one element matching the condition.

`[1,2,100].any?{|i| i > 99} #=> true`

**`#include?`** - Refurns true if it can find a specified value.

`numbers = [4,8,15,16,23,42]
the_numbers.include?(42)`

These are boolean enumerables as they return either true or false.

We also have search enumerables.

`#select` - this is similar to `map` in that it searches through 

`#first` and `#last` are hopefully self examplanitory and `#reverse` will... yeah, it will reverse it, you clever reader.

If you miss the `.length` property in JS, rest assured it also exists in Ruby.

We can sort an array by using `#sort`. This by default with sort it into ascending order as you might expect. Much like JS, it uses the concept of comparing `a` and `b` to determine what should be where in a sort. For example, the following will sort by length of each array:

```rb
def sort_array_char_count(arr) # sort by length of each element
  arr.sort do | a, b |
    a.length <=> b.length
  end
end
```



## Conditionals

Work in a similar way to JS, some gotchas:

`elsif` instead of `elseif`

And a general lack of brackets all around. This is optional however, and could be used and is considered off form when it is just a one-liner

We also have support for Ternany Operations for example

`car == "red" ? "ferrari" : "not a ferrari"`

You can see the difference in readability with the following:

```rb
def unsafe?(speed)
	if speed < 40 || speed > 60
		true
	else
		false
	end
end

def not_safe?(speed)
	(speed < 40 || speed > 60) ? true : false
end
```

## Statement Modifiers

This is cool. In ruby we can put a conditional at the end of a statement.

`puts "Hello Dave" if your_name == "Dave`

We can also use *unless* which is kinda the negative version of *if*


## Case Statements

Case statements are useful when we have one value but loads of conditionals that come off of it. Having douzens of if/elseif is fine but not the most readable. A case statement might be a good idea:

```rb
job = "chef"

if job == "chef"
    puts "Make me tasty food"
elsif job == "builder"
    puts "Make me a house"

# And so on...

end
```
A case statement version will look like

```rb
case job
    when "chef"
        puts "Make me tasty food"
    when "builder"
        puts "Make me a house"

# You get the idea...

end
```

## Using REPLs

Ruby comes with a command, `irb` that essentially gives you a ruby sandbox on the terminal. That is a pretty cool way of testing ideas and methos before introcducing them into your code.

`Pry` is another REPL. This one however can be embedded into your code, allowing us to *pry* into the code at a certain point in time. So, for example, we need to stop and check a value in the middle of a method, we can type:

`binding.pry` to pause the running and instead have access to the pry repl to test things out.

You need to make sure you `require 'pry'` in the script and make sure you have the gem installed: `gem install pry`

## Yielding Results

Yield is an important concept in Ruby. To yield in a method is to stop the method, execute some code that was passed to the method and then continue on. Effectively you can give a method some code to run at a certain point (or over and over using loops)

Here is a super basic example

```rb
def my_method
    puts "This is before the yield"
    yield
    puts "This is after the yield"
end

my_method {puts "this is DURING the yield!"}

```

So basically we are passing some code (AKA a BLOCK) for my_method to run.

However, there is more we can do:

1. We can pass a value to the block by passing it like you would a method:

`yield(text)`

2. You can also pass in arguments AND a block by simply using the right brackets:

`my_method("Tom") { |name| puts "#{name} has arrived!"}`

3. The block looks alot like the blocks found in interators and is written in a similar way with either `do / end` or `{}` we hold the value passed in via the `| |` pipes.

```rb
def my_all?(collection)
  block_return_values = []
  i = 0
  while i < collection.length
    block_return_values << yield(collection[i])
    i += 1
  end
```

## Hash! Ahhh, SavingAllTheElements!

I really wanted to make that pun.

Anyhow Hashes are what JSers know and love as Objects. A collection of items with a key value pair relationship. Let's define one:

`hash = {"key" => "value", "another_key" => "another value"}`

It's slightly different to how you'd do it in JS:

`hash = {key: "value", another_key: "another value"}`

The two things you'll notice is the quotes required and the use of `=>` (the hash rocket) instead of a boring old colon `:`. Though in modern ruby you can still use a colon, but thats only when using a symbol.... I'll get there.

We can grab info from hashes by simply doing:

`food["fish"]`

And change it as you would a variable:

`food["meat"] = "beef"`

Hopefully the concept is not too disimilar to JS, just a few differences in syntax. I quite like the specific quotes as its easier to tell when you are using a variable instead of a symbol...

A what? I am glad you asked....

## The Ruby Concept now known as Symbol

Symbols are immutable which means they are more efficient to use.

We can use a symbol intead of a string by using a colon like so: `:name` however if we can use the colon like so if we are using a symbol as a key: `name: "Davina"`

When we are changing parts of a hash, if we are using symbols the syntax looks a little different:

`life_hash[:animals][:birds] << "Parrot"`

In Javascript, I guess it is just symbols by default but since keys are never anything else, it really is not a consideration.

## Iterating over a Hash

This is fairly straightforward to do, you can use each, but as a hash consists of a key and a value, they both can be brought along for the ride:

```rb
hash.each do |key, value|
  puts "#{key}: #{value}"
end
```

We can loop through multiple layers by iterating again accordingly:

```rb
hash.each do |key, value|
  # do something at the first level
  key.each do |subkey,subvalue|
    # do something at the second level
  end
end
```

## Hash Helpers

There a much of helper methods we can call on hashes:

`#values` - returns all the values of the hash
`#keys` - returns all the keys of the hash
`#min` - returns the minimum value of the hash

There are a bunch more which might save you some time with logic.

Hashes are a very fundemental data structure as Objects are in Javascript. So its important to be confident in your ability to traverse and manipulate them. Getting to use each for hashes is pretty cool since I don't think we have Object.foreach in JS. I NEED TO CHECK THIS!!!!!

## Object-Orientated Programming in Ruby

