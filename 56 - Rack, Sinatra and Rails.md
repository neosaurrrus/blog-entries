# Introduction

Lets look at how we can make websites and dynamic applications using Ruby.

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






