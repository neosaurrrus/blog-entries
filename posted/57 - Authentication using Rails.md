# Authentication using Rails

Authentication is a scary topic for developers, at least it is for me. Hackers are everywhere constntly coming up with new tricks so it feels so easy to do something wrong and boom, all your data is gone. That wont do at all so lets learn about what Authentication is all about and then look at common ways of implementing it in Rails

## Getting some basic terminology straight

Authentication is more than authentication. Confused? let me break it down...

**Authentication** is the part where we validate the person is who they say they are but before that we need.. e. g. *This person is Sam*

**Identification** to understand who you are claiming to be. *Who are you? Oh you say you are Sam...*

Once you have done that, an **access policy** can be used to define what roles (e.g. Admin) can do. As opposed to saying *Sam can delete content*, its better to say *Sam is an Admin who can delete content*, for several reasons.

Lastly, **Authorisation**. We need to check against the access policy when doing certain actions. Everyone might be able to access a landing page but for the admin page we need to check that the person doing it is an admin.


Despite the big and easily misspelt words, you see this all the time on the web.

- Identification is your username to a given site
- Password is a typical way to autheticate
- Access Policies exist behind the scenes on social media sites to allow only to create/delete your posts but porbobably not allow you to delete other users'
- And again behind the scenes, your favourite social media site is checking when you create a post or dleete something it is really you, and that you have a role that can do what you have asked it to.


## Cookies, a little bite.

You probably noticed you don't normally enter your username and password each time you do something that needs it on the web. That is thanks to cookies and sessions...most of the time. A cookie is just bit of data the site passes to the browser so it can refer to it later. This doesn't just get used for usernames, if you ever go back to a shopping site you might often find it remembers you and always what you were tryting to buy. Cookies are very useful and and as such can often be used for purposes you may not be so keen on. But thats for another topic...

Cookies hold and then make avaialible data in the HTTP header. However as cookie is stored as plain text in the browser, this means the user is able to read and modify the cookie data and thus could manipulate it with unintended consequences. Rails has a solution to this in the form of *sessions*


## Sessions in Rails

So Rails' solution is the session method. This behaves liek a hash and we can use it to store whatever we like. Rails uses a *config/secrets.yml* file that contains a secret key that is used to convert session data to an unreadable format and back without the user being able to understand it. This done through the magic of crytography which is... yeah... its magic. Let's leave it as that.

## A basic use of the Session hash

Let's use it in a shopping cart example:

In the Application controller we might define the cart as follows:

```rb
helper_method :cart
def cart
    session[:cart] ||= []
end
```

And then on the cart page we can simply treat it like a hash we have access to:

```rb
<% cart.each do |item| %>
    <li> <%= item %> </li>
<% end %>
```


## A more common use of the session hash, logins.

You know what a login is. Lets look at how we implement it in Rails using the session hash.

Our basic login system will have:

1. A /login GET route where the user enters a username
2. A /login POST route where the username is submitted.
3. A create action that writes the username onto the session hash which can be checked anywhere it is needed.
4. A destroy action which can delete the username out of the session hash... which is pretty much what logging out is.


We can configure the hypothetical application controller/view as follows:

```rb 
# Application Controller
def index
    if !session[:username] 
        redirect_to controller: 'application', action: 'new'
    end
end

def new
end

 def create
    if !params[:username] || params[:username].empty?
      redirect_to controller: 'index', action: 'new'
    else
    session[:username] = params[:username]
    redirect_to controller: 'application', action: 'index'
    end
  end

  def destroy
    if session[:username] 
        session.delete :username
    end
  end


# The new view:

<%= form_tag ({controller: 'application', action: 'create', method: 'post'}) do %>
  <input name=username>
  <input type=submit value='login'>
<% end %>
```

## Authorisation, AKA Login Required

So you have your basic login sorted... now lets look at actually using that to control access accordingly.

Being logged in is effectively having a username active in the session so before checking that, we could have a *return guard* like so:

`return head(:forbidden) unless session.include? :user_id`

That does the job but you will find out that if alot of routes require it, you end up saying the same thing over and over. So instead, we can use the `before_action` method Rails gives us and use it to have a seperate method that checks login:

```rb
  before_action :require_login

  # later in the code...

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end
```

This will run the login check for every action. But what if we have a method we want to NOT check, in that case we can put in an exception using `skip_before_action :require_login, only: [:index]` to skip the check for the index.



## Passwords, you forgot about those?

I did. But these are particularly tricky as if they fall into the wrong hands you are in trouble. If only there was a way to store passwords without actually storing them.... Well there is by hashing the password and storing that. That is known as the password digist

A hash is something that is created as an output from a string into a hash function. Basically the hash functions transforms it based on some clever calculations. Saltign the hash stops people from reverse engineering the password by checking what outputs from common passwords Now I wouldnt recommend doing the calculations yourself, for a number of reasons. Instead rely on someothing that can take the heavy lifting out of things. For Ruby we can use a gem called *BCrypt* 

BCrypt has a bunch of functions we can use. `BCrypt::Engine::generate_salt` for example but rails abstracts its usage away to instead handle it by a simple `has_secure_password` in the relevent model.

This adds two fields 'password' and 'password_confirmation' but the method expects a corresponding 'password_digest' column in the migration for the model. Below is an example of how it can be used:

```rb

# form example
<%= form_for :user, url: '/users' do |f| %>
  Username: <%= f.text_field :username %>
  Password: <%= f.password_field :password %>
  Password Confirmation: <%= f.password_field :password_confirmation %>
  <%= f.submit "Submit" %>
<% end %>

# User Controller Example

class UsersController < ApplicationController
  def create
    User.create(user_params)
  end
 
  private
 
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

# Sessions controller Example

class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    return head(:forbidden) unless @user.authenticate(params[:password])
    session[:user_id] = @user.id
  end
end

# User Model Example

class User < ActiveRecord::Base
  has_secure_password
end

```


## Phew that seems complex is there an easier way?

Well yes, managing credentials can be taxing. However laot of websites allow you to simply use your credentials from another service. Be it Facebook, Google or others using OAuth. Using OAuth is quite com;plex but handily there is gems that do the heavy lifting. One of which is OmniAuth the usage of which we will run through here.

1. Install the omniauth gem as well as the strategy (ie for google thats omniauth-google... you can see more strategies on the OmniAuth site)
2. OmniAuth needs to know the OAuth credentials of your app. We can do this this with the following code:

```rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
```

This is created here: config/initializers/omniauth.rb. To get the app working with Facebook we need:

- App ID 
- Secret.

And specify the Valid Oauth Redirect URIs whih is by default `https://<app>/auth/facebook/callback` in OmniAuth

I will glosss over how to do it on the Facebook end as it will likely change but hopefully it is striahgtforward.

Now we have the key and secret we just whack it into the code we wrote over and we are done? Well you could do that but its a bad idea.

## Security ENVy

The App ID and Secret are really important. Its a bad idea to just have them flouncing around in your code. Thats why we use Environment files that keep information about the specific environment the app is running on and does not get added to git for the whole world to see on github.

As always there is a gem that makes it alot easier to manage this. It is `dotenv-rails` we use it by:

1. Installing the gem
2. Create a file called `.env` in the application root.
3. Add your secret keys accordingly to the file.

Once you got that sorted we can start using the authetication in our sessions create method:

```rb

 def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
 
    session[:user_id] = @user.id
 
    render 'welcome/home'
  end
 
  private
 
  def auth
    request.env['omniauth.auth']
  end
  ```

  The auth hash contains a whote bunch of data that comes back from Facebook or whatever. IT might be interesting to take a look at it.


