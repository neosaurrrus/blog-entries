# Introduction

Lets look at how we can make websites and dynamic applications using Ruby which requires learning about some of the more popular backend tooking

# Rack

Rack creates a web server which allows our apps to sit on the web. Rails is based upon it but its worth understanding Rack to know what Rails will rely on.

## Rack Setup

We first need a class called 'call'. This returns the status code, headers and body using the Rack::Response object. Something like this:

```rb
class Application
 
  def call(env)
    resp = Rack::Response.new
    resp.write "Hello, World"
    resp.finish
  end
 
end
```

BUT before that will work we need to start our HTTP web server that can handle the request and then use call. There is two elements to that:

1. config.ru file
2. rackup command

The config can look like this:

```rb
require_relative "./application.rb"
 
run Application.new
```

Which can then be run with `rackup config.ru`

If it all goes to plan you'll see a message referencing a port number. IF it call goes to plan, the HTTP server cn be accessed by going to `http://localhost:9292/`

## The very basics of dynamic web apps

So we can see in the example above that resp.write can write to our page. So anything we normally do in ruby can be written to the web page.

```rb
sum = 1 + 2
resp.write sum
```


### Path

So path is the bit of a HTTP request after the domain. For example `/items`

The path lives in the env part of the call function:

 The Rack::Request contains a whole bunch of methods to be able to play with HTTP requests and path by looking at the env variable:

```rb
class Application

@@cars = ["Ford", "Tesla", "Ferrari"]

def call(env)
 res = Rack::Response.new
 req = Rack::Request.new(env)

 if req.path.match(/cars/)
  @@cars.each do |car|
  res.write "#{car}\n"
  end
  else
    res.write "Path Not found"
  end

  res.finish
 end
end
```

Note that we need the IF statement in place else the code will run regardless of which path we are on.

### User Input via path.

When you query a website you will often see something like this:

`www.google.com/search?s=hello`

This is passing the `s=hello` key value pair via the path. This is known as the GET Params. we can use that in our code using the following code:

```rb
req = Rack::Request.new(env)
if.req.path.match(/search/)
search_term = req.params["q"]

if @@cars.include?(search_term)
# ...etc
```
This is starting to smell a little bit like a web application!

### Dynamic Routes

So far we have look at static routes search as the search example. However, how do we go about sorting out paths that can go and find data themselves

Lets say we wanted to see the each of the cars in our previous example. We could hard code the paths:

```rb
if req.path=="/cars/Ford"
      resp.write @@cars[0].name
    elsif req.path == "/cars/Tesla"
      resp.write @@crs[0].name
    end
```

But if our cars array changes it would be awesome if we could have a `/ford`, `/tesla`, and `/ferrari` path that looks against the array. Just as well we can...

```rb

  if req.path.match(/cars/)
    car_name= req.path.split("/cars/").last 
    car = @@cars.find{|c| c.name = car_name}
    res.write car.colour
  end
```

## Status Code

Status Codes give us an update on whats going on with the request:

1xx - Informational ("I'm working on it")
2xx - Success ("I did it!")
3xx - Redirection ("I need to check something else")
4xx - Client Error ( "I think you did something wrong")
5xx - Server Error ("I think I did something wrong")

In Rack we can set the status accordingly:

```rb
resp.write "Page not found!"
resp.status = 404`
```

# Sinatra

Sinatra is what Rails is based upon. Whereas Rails set up lots of things and is 'magic', Sinatra is lightwieght in a way that lets us see the moving pieces of a MVC (model viewer controller) app,


## Setting up Sinatra

Getting Sintra installed is as easy as typing `gem install sinatra` and from there we can create a file and start making our routes:

```rb
require 'sinatra'
 
class App < Sinatra::Base
  get '/' do
    "Hello, World!"
  end
end
```


The app.rb file is the application controller, which handles requests to our app.


Then we can run this by doing `rackup app.rb` (or whatever file it is called). This will set the application running and we can use a browser to view the route. However to do it propertly we'd configure Sinatra properly using a common pattern

## Config.ru

The first element of the pattern is config.ru which details the environment requirements of the application.

```rb
require 'sinatra'
 
require_relative './app.rb'
 
run Application
```

The last line refers to a ruby class application which we define on the app.js side:

```rb
class Application < Sinatra::Base
 
  get '/' do
    "Hello, World! "
  end
 
end
```

For a single controller application thats pretty much it, the app.rb file will define every single URL and response.

However just returning just text all the time is a bit boring. So we can get the ERB line to call up a HTML page. You can also run commands like you would in ruby prior to that.

```rb
get '/dogs' do
  @dogs = dogs.all
  erb :'dogs/index.html.erb'
end
```

### Shotgun

Running an application with Rackup means that if we make changes to the code, it will not be read till we restart the server. Shotgun lets us reload as we make changes to the code and can be ran by typing 'shotgun' instead of rackup.

Note that the gem needs to be installed `gem install shotgun`. If you still have issues run `bundler install` and `bundle exec shotgun`

The `-p` flag will specify the port you want to run it on.


## ERB Files

So we could provide HTML as the data returned when hitting a route:

```rb 
get '/' do
  <h1>Meow</h1>
end
```

This isnt very practical however so we can use a templating engine, such as ERB or Embedded Ruby.

If we create a file with the extension .erb we can just refer to the ERB file which contains HTML. The secret weapon of ERB files is that they allow us to use Ruby as well.

We can call ERB files with the simple command : `erb :dogs`


So we can embed ruby code into these tags but how? For that we need substitution and scripting tags.

Substition tags are called with `<%=` and they will display whatever is evaluated. They are closed with `%>`

Scripting tags just evaluate the code but do not display. They are caled and closed like so:

```rb
<% if user_exists %>
  <p> User is found </p>
<% else %>
  <p>User Not Found!</p>
<% end %>
```

Mixing and matching the two types of tags is essential to effeciently using ERB tags.


## Sinatra and ActiveRecord

So lets mix the two together...

We know that we can Create, Read and Update and Delete in Activerecord with the following

- Model.create
- Model.all or Model.find(id_number)
- Model.update
- Model.destroy

Lets look at how these Activerecord commands can be hooked up to the Controller and Views of Sinatra.

### Create

A new page might look like this:

```rb
  get '/dogs/new' do
  erb :new
  end
```

The form on there can have a POST request like so:

```rb
 post '/dogs' do
  Dogs.create(name: params[:dog_name])
```

### Read

We can read everything or just a specific item.

For all instances of a class it should do something like this:

```rb
get '/dogs' do
  @dogs = Dogs.all
  erb :index
end
```

The index page can then show all the dogs.

For a specific dog we can build the route as follows:

```rb
get 'dogs/:id' do
  @dog = Dog.find(params[:id])
  erb :show
end
```

### Update

Before we do this we need to confure config.ru to handle patch requests by modifying the patch.ru file to allow patch requests:

```rb
use Rack::MethodOverride
run ApplicationController
```

Now we have done that, updates falls in two parts. GETing an update form and then POSTing the results.

```rb
get "/dogs/:id/edit" do
  erb :edit
end
```

The form will use a patch request to patch "/dogs/:id" :

```html
<form action="/dogs/<%= @dogs.id %>" method="post">
<input id="hidden" type="hidden" name="_method" value="patch">
<input type "text" ... >
</form>
```

The method override, does just that. It makes sure that the post request is changed into a patch. There is a long reason why HTML ended up like that but I cant recall it now!

### Delete

This doesnt need its own page but is more of an action that takes place when requested. We need a form to perform the action which will look a little like this:

```html
<form method="post" action="/dogs/<%=@dogs.id %>
  <input id="hidden" type="hidden" name="_method" value="DELETE">
  <input type="submit" value="delete">
</form>
```

The hidden input makes it a delete as far as Sintra is concern.


