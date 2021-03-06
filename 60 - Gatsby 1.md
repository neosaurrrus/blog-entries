This is a series of Blog posts that follow me as I learnt about using Gatsby . There will be a focus on all the landmines I step on along the way to make sure they can be learnt from!

The main font of knowledge comes from [Wes Bos' Master-Gatsby course](http://mastergatsby.com). Is it any good? I don't know yet but lets see if I figure it out as I progress through.

In this post we will:

- Learn why we care about Gatsby
- Touch on its drawbacks
- Install prerequisites
- Install CLIs
- Create a new Gatsby App
- Make our first page

# Prologue - What is so great about Gatsby?

It's the latest hotness (as of 2020 anyhow) but what makes it good?

It's a framework that lets us make use of many of the latest developments in Web Dev without having to, well, know much about them. Gatsby uses React but builds upon it.

Mostly Its fast. Loading pages is real quick with little effort. It does this:

1. By being a static site generator building what is needed before someone asks for it. Kinda how websites used to be back in the day. This means Gatsby has a build step where all the HTML is ready to go. 

2. By calculating CSS required at build time.

3. Rehydration - It can use the static page to then leverage that, rehydrating to be a React app. So things can be changed.

4. Lazy Loading - Don't need to load things till they are ready to be seen Gatsby makes this easy to activate as well as other smart ways of handling images efficiently.

5. Routing built in - Allows loading to be handles within Gatsby, caching content as needed.

It also has a whole bunch of plug-ins to expand the functionality. This makes it easy to use other's contributions for doing things rather than having to roll your own. This, along with templates and built in stuff just makes it quick to get sites up and running!

## Drawbacks

What doesn't it do? It doesn't have anything for the backend so we need a CMS of some sort. For that we will be using **Sanity** which is worth its own post later

And since it is static and sometimes dynamic.. it does have a little wierdness we need to look at at a later point.



# Episode 1 - Setting up for Gatsby

We are using Gatsy for the Front End and Sanity for the backend. To get started there are a bunch of things that require setting up.

## The Terminal Stuff 

They both need an up to date version of Node, so make sure you do that. Else it will fail. 


The Gatsby CLI and Sanity CLI tools are very useful and can be installed with: `npm install gatsby-cli @sanity/cli -g`. However this led me to some issues:

On the gatsy-cli I got the following error:

`cannot read property 'matches' of undefined`

Searching on Slack, this turned out to require a combination of upgrading HomeBrew, MacOS and XCode as well as *not* using node version 14. Fun!

The sanity CLI also errored out till I installed a new version of XCode (which I did to fix the gatsby cli)

## Other Issues

The course comes with a configured ESLint which came up with the following error: `eslint: createrequire is not a function referenced from:`

This turned out to be due to an old version of VS Code which was inexplicably running from the Downloads folder on Mac. When I moved to Applications I was able to update and the error went away.

Phew! Nothing a few heavy googles can't fix. 

When setting up for a new project, its really important to pay attention to the output to stop these errors as that can give you headaches down the line!


# Our first Gatsby Environment

With the gatsby cli installed we can build a new starter site with the following command: 

`gatsby new SITE_NAME https://github.com/gatsbyjs/gatsby-starter-hello-world`

Where, in case it wasnt obvious, it will create a folder called SITE_NAME. So probably you can think of a better name for that. If you leave off the URL it will grab a default template

So a new Gatsy site consists of:

- Node Modules - If you don't know what it is, for now assume it is behind the scenes stuff.

- Static, simple static stuff like favicons and logos. You don't want to use this for other static stuff as there is a better place for it for Gatsby to work on it properly.

- Src, where Gatsby will live.By default you get Components, Images and Pages folders. Pages is fixed by Gatsby otherwise we can add other folders as needed. The basic structure will do for the time being.

When you build you will also get a `public` folder which contains the built version of the site. 

## Pages

Most of what we care about lives in Src and pages is a good place to start. 

We can have dynamically created pages or created by file system routing. We can have a 'index.js' file to start with, though this is actually provided by default. The basic idea is as follows:

```js

import React from 'react';
function HomePage() {
  return (
    <div>
      <p>This is the homepage woohoo!</p>
    </div>
  );
}

export default HomePage
```

If you know React, that should not be too shocking. Now that you got a shiney page lets see how it looks! But how...?

Handily Gatsby has a `develop` script in npm which we can start with `npm run develop`. This runs the server that llows us to see our work and also reloads when we make changes. So far so good. You should get a localhost address referenced in the terminal to connect to.

Note it also talks about GraphiQL as something to view. I'll talk about that in another post!

Anyhow you have your first Gatsby page up and running! 

## Bonus: 404 Pages

So if you type in any page that doesnt exist. Yuo will currently get a clever Gatsby Development 404 page which has some helpful info to debug things. You can make you own 404 page to replace this for production in a similar way to the Index.js but calling it.... 404.js. 


## Wrap Up.

So hopefully that gives a good sense of how to hit the ground running, next time we can see how we can do more than just a homepage annd a 404 page.












# Part 2 - Putting Pages Together

Last time we set stuff up and made our first page(s). Now lets look at the common things you will do when building out an actual site.

For this series of blog posts, I am working on a hypothetical restaurant site which will have the following pages:

- Home
- Food
- Drinks
- Team

Since we have the Index page set up, we can build basic versions of these pages by copying and pasting it and replacing a few words: 

```js
//Food.js

import React from 'react';

function FoodPage() {
  return (
    <div>
      <p>This is the Food page</p>
    </div>
  );
}

export default FoodPage;
```

Hopefully you can figure out how the rest will look. 

## Navigation - Our First Component

I imagine you have been using the web long enough to see that a navbar allowing us to jump between pages is a good idea in our app. You may also see that abstracting this out into a single component we use on all of our pages will be smart, so lets do that.

The *components* folder is where we create little pieces that are reuseable across pages. Here we can create a Nav Component like so:

```js
//Nav.js
import React from 'react';

function Nav() {
  return (
    <nav>
      <ul>
        <li> Food</li> //Not a link yet... 
        <li> Drinks</li>
        <li> Team</li>
      </ul>
    </nav>
  );
}

export default Nav;
```

We have to remember to add it to our Pages like so: 

```js
import React from 'react';
import Nav 
function FoodPage() {
  return (
    <div>
      <p>This is the Food page</p>
    </div>
  );
}

export default FoodPage;
```


That will get the Nav component onto our pages, but it doens't actually have any links just yet.

## The Link Tag 
 Now you could use `<a>` tags but that will result in a page refresh which isn't very Gatsby so lets use Gatsby link tags instead:

```js
import React from 'react';
import { Link } from 'gatsby';

export default function Nav() {
  return (
    <nav>
      <ul>
        <li>
          <Link to="/food">Food</Link>
        </li>
        <li>
          <Link to="/drink">Drink</Link>
        </li>
        <li>
          <Link to="/team">Team</Link>
        </li>
      </ul>
    </nav>
  );
}
```

If you test that out, it is fast.

## Navigate function

However, you can also change the page programatically. In other words, without replying on the user click? For a form for example. We need the navigate function from Gatsby:

```js
import { navigate } from gatsby
//at some point in the code... 
navigate('/newpage', {replace: true})
```

The `{replace:true}` option lets you add the new page to the hidtory, which allows the back button to work for it.
## Layouts

Most web page have a header, footer, navigation and a whole bunch of stuff that appears on each page. We have the Nav component added to each page, that will get annoying especially with a whole bunch of other components we want everywhere, this is where layouts come in.

It isnt as easy as just putting everything into a Layout component and calling it a day as we normally want our header to come before the content and the footer afterwards.

Handily, each componnet contains a props that references its children, allowing the components it contains to be rendered. So once we have created the Layouts component we can add `props.children` to allow child components to render between other elements of the layout. 

```js
export default function Layout(props){
  return (
    <div>
      <Header />
      {props.children}
      </Footer>
  )
}
```

Obviously you can change what is in the Layout and all you'd need to do is add the Layout component to each page. However Gatsby does does give us a smarter way of doing it...

We need to create a file in the root location called `gatsby-browser.js`. This file allows us, for the browser use several APIs. These APIs can be found [here](https://www.gatsbyjs.com/docs/browser-apis/). The one we want here is call `wrapPageElement\ which according to the Gatsby site:

>Allow a plugin to wrap the page element.
>This is useful for setting wrapper components around pages that won’t get unmounted >on page changes. For setting Provider components, use wrapRootElement.


So following the instructions given we will end up with something like this:

```js
import React from 'react';
export function wrapPageElement({ element, props }) {
  return <Layout {...props}>{element}</Layout>;
}
```
As you can see it is fairly similar to the Layout, where props are what props the page contains and element is the page itself in Gatsby. 

**Important** At time of writing, you need to restart the server when you modify these files If, like me you tend to lose the terminal you are running the server, then there is a [useful trick here(https://dev.to/eclecticcoding/kill-blocked-ports-25ca)


Once you have it working, the Layout component will be loaded on every page without doing anything! You might need to clear out old references to your Nav/Layout else you will see twice the Layout!

Finally, while this works for the browser, for server-side stuff, we want to do the same in a file called `gatsby-ssr.js` in the same location. Literally you can copy and rename the `gatsy-browser.js` file. More on all that SSR stuff later!

Hopefully if you followed all the above you have a smart set of pages with layouts that smart!

It looks a bit dull though, so lets dicuss CSS with Gatsby in the next post!




# Learning Gatsby - CSS in Gatsby with Styled Components

This is part 3 of my Gatsby series start XXXXX for it to make more sense! This is all about getting our plain Gatsby pages looking a little nicer using modern approaches as we go. 

First of all, if you just want to create a CSS file in your layouts.js and link to it, you sure can. There is nothing stopping you in Gatsby. But like with alot of Gatsby, there is a better way that allows Gatsby to do things smarter. For Gatsby to do that, it needs to be made aware of the CSS by importing it in specially.

There is lots of ways to do this:

- From your gatsby-browser.js file import a CSS file in /src/styles/
- CSS Modules, which is found on the Gatby site
- Styled Components, which we will focus on.


So lets think about the type of CSS we want to have in a typical app

1. Global Styles
2. Fonts/Typography
3. Layout Styling


Lets look at Global Styles first 
## Global Styles


Global Styles bascially means Stuff that is used everywhere so this is where you might add things like:

- CSS Custom Properties for the colour palette
- Background settings
- Styling of commonly used elements like buttons, scrollbars

Obviously this varies depending on what you want to do so i'll focus in on what is different in Gatsby

### Normalize.css

Before we do anything, a cool package to remove some annoying browser defaults is [normalize.css](https://necolas.github.io/normalize.css/) This helps get rid of things like the html margin for example, that means that a full page app still leaves a little gap on the edges. To use it:

1. Install in npm: `npm i normalize.css`
2. Import it to layout.js: `import 'normalize.css';`

While we are installing things from npm don't forget to install `styled-components` too
### GlobalStyles.js

For our actual GlobalStyles css we create a `GlobalStyles.js` file in /src/styles. There are some changes because we are using styled-components to a regular css file.

```js
import { createGlobalStyle } from 'styled-components';
import background from '../assets/images/background.svg';

const GlobalStyles = createGlobalStyle`

//examples of what you might add to your styles

  :root {
    --text: 
  }

  html{ 
    font-size: 10px;
     background-image: url(${background});
  }
  .gatsby-image-wrapper img[src*=base64\\,] {
    image-rendering: -moz-crisp-edges;
    image-rendering: pixelated;
  }
`
export default GlobalStyles
```

Ok a few interesting things to discuss.

- `import { createGlobalStyle } from 'styled-components'` - Its how Global Styles are made in Styled components.

- `import background from '../assets/images/background.svg'` To allow gatsby to do its image magic we import our images in this way. More on that later, for now just assume it makes it better.

- `const GlobalStyles = createGlobalStyle` This lets us provide a CSS string to export out. In other works, this begins the CSS that can be written normally from this point`

- `.gatsby-image-wrapper img ...stuff` - This is Wes Bos's clever way of showing an image before its loaded. In this case it is a 64x64px version of the image so it 'unpixelates' when it loads.

Once you have sorted this out, you can import it into Layouts as a component, something like:

```js
import React from 'react';
import Nav from './Nav';
import 'normalize.css';
import GlobalStyles from '../styles/GlobalStyles';

export default function Layout({ children }) {
  return (
    <>
      <GlobalStyles />
      <Nav />
      {children}
    </>
  );
}
```

## Typography

Everyone loves working with text, since we are in a component mindset, we might as well have a seperate Typography file. Lets look at the basics focusing on the Gatsy/Styled Components specific things:

```js
import { createGlobalStyle } from 'styled-components'; //import Global Style
import font from '../assets/fonts/ExampleFont.woff'; //Example Woff file.

const Typography = createGlobalStyle`
  @font-face {         
    font-family: ExampleFont;
    src: url(${font});
  }
  html {
  font-family: ExampleFont;
  color: var(--black);
}
`
export default Typography

```

So the above picks up a font in assets and then uses it accross the app. Again, letting Gatsby 'know' abotu the font will give us benefits down the line. Other things you may want to consider in this file include:

- Font Sizing
- Letter spacing
- Backup Fonts
- Anchor tag styling
- Header Styling

If `woff and font-face` is a bit new to you, [here](https://css-tricks.com/snippets/css/using-font-face/) is a good article
Once you are happy. Import the Typography component to Layouts and we got some nice text... or bad text, if your design skills need work! Hopefully this gets you into the flow of building up the CSS in this way.


# Nav Styling, Scope it out.

So now we want to look at scoped styling, and the Nav we discussed in the previous chapter is a good place to look at.

Why scoped? Because the CSS we will write will only apply to that component. That means we can change whatever we like and we know it will only effect our Nav.

First we want to import the styled function from styled components:

`import styled from 'styled-components'`

Then, we create the styled tag:

```js
const NavStyled = styled.nav` 
  background: purple;
`
```

Finally then rename our <Nav> tag to <NavStyled>

```js
<NavStyled>
  //stuff
</NavStyled>
```

If thats all gone to plan, you will have a purple nav component. Which is great.

Now if you have elements inside of the component you want to style you can either:

1. Create Styled tags as above and rename
2. Or just select them in NavStyled as you would in regular CSS.

Number 1 is a good idea if you intend to reuse the Styled component in multiple areas but Number 2 is quick and easy, you can always covert it if need be.

## Wrap Up

This is a fairly short one but hopefully enough to get you started with CSS in a scoped way, since its all very subjective I am assuming you can figure out what you want to do wit the snippet of knowledge contained above!







# Figuring out Gatsby #4 - A detour to the world of Sanity.

In my previous posts I have discussed:

1. Setting up Gatsby
2. Making Pages
3. Styling those pages

That is enough for a basic site, but if we need to make something a little more dynamic we need a:

 - Database to keep data that can be changed
 - Way of changing whats in the database
 - Way to show what we have in the database on our pages.


 The cool kids call this a Backend, and this is something that one can decidicate a whole career to building out. We will not do this, we will use something called Sanity.

 If you like using something else for data, thats cool, Gatsby doesn't really care too hard about what you use but for the app I am building, thats what I will be using. The concepts in later posts are pretty transferable.

 ## What the hell is Sanity? 

 Sanity is a headless CMS. Headless just means that it doesn't have a frontend for users to see whats there, thats what we have Gatsby for. CMS stands for Content Management System which is a system that manages content 😸... fine, its a tool that handles all ways we can change data, primarily... Create, Read, Update, Delete. AKA CRUD.

 There is a whole bunch of headless CMSes on the market, some cater for simplicity, some for more control. Sanity is a good mix of the two, and the general priniciples here should work more or less whatever you use.

 In a hypothetical restaurant app, we will have a bunch of meals in the menu, menus change often. We don't want this to be a hassle, we might even want something that a semi-skilled client could manage without you. This is why have a CMS to make this smooth is a good idea. However it doesn't mean that setting it up is all that easy. So lets walk through it.



## How do I get some of this Sanity?

You can probably figure most of it out by following the guidence on the [Sanity Website](https://create.sanity.io/). 

I am going to focus on getting it up and running via the command line.

### Step 1 - Install Sanity CLI and Initialise

This is as simple as typing `npm install -g @sanity/cli && sanity init`

This is will get it installed globally and the second command will initialise an blank Sanity instance in the location you are in.

You can check it is all version as intended with a `sanity --version`.


Once you have the starter files up and running, you wierdly should init again..

### Step 2 - Reconfigure

Its time to introduce yourself to Sanity.

First, type `sanity init --reconfigure` and it will prompt you to create an account with Sanity (unless you have done this before). Its a fairly straighforward process that can use GitHub or Google as authentication providers to make it easier.

Second, give your project a name.


Thirdly it will ask if you want a private or public dataset, and allows you to set up different datasets for testing etc. For your first time stick to the default which sets up a public production dataset but this is important to know for real life.


### Step 3 - Intro to Sanity Studio

We have everything set up, so we can type `npm start` or `sanity start` and if all has gone well it will tell you Sanity is running on localhost:3333. If you open that in your browser, you will be prompted to logon and.... 


It will tell you that you have an empty schema. How dull.

We better go make something to look at here then.

### Step 4 - Our first schema


The empty schema message will link to a [guide](https://www.sanity.io/docs/content-modelling). This a good step by step guide that provides more detail than I will type here. But I will go over what I did below.

Since I have a hypothetical restaurant site, I want to store content regarding the dishes that are served. 

In the `schemas` folder, I create a new schema called `dish.js`. This file exports an object defining what a *dish* actually is. hopefully it makes sense with my comments: 

```js
export default {
  name: 'dish', // what sanity will know it as
  title: 'Dishes', // what we see it called in Sanity Studio
  type: 'document', // We will get to this later, document will do for now
  fields: [
    // what fields does a dish have?
    {
      name: 'name', // What Sanity will know it as
      title: 'Dish Name', // What we see it called in Sanity Studio
      type: 'string', // The datatype, this could be lots of things.
      description: 'Name of the Dish', // Just explains what the field is.
    },
  ],
};
```


Once we have the dish schema set up, we need to add it to the overall schema.js file with a `import dish from './dish` and modifying the *createSchema* object as follows:

`types: schemaTypes.concat([dish]),`

Hopefully you begin to see how multiple schemas can be built up in this fashion.


### Step 5 - Bask in our incredible Back End skills

Let's hop back to Sanity Studio. If all has gone well we can see we have Dishes on the left hand side. But no content. We can fix that by clicking the new icon in the right hnd size and add our first Dish! 

![Fish and Chips](https://github.com/neosaurrrus/blog-entries/blob/master/pics/60/1.png?raw=true)
Of course it isn't all that interesting just storing the names of dishes, so once you are happy it works as intended you can delete it via the menu in the bottom right hand side. 


## Let's make it better, 

Well the possibilities are limitless at this point. The Sanity docs are really good for figuring out how to build upon it but here is what I did:

```js
import { check } from 'prettier';

export default {
  name: 'dish',
  title: 'Dishes',
  icon: () => '🥣', // Lets give it a cool icon!
  type: 'document', //
  fields: [
    {
      name: 'name',
      title: 'Dish Name',
      type: 'string',
      description: 'Name of the Dish',
    },
    {
      name: 'vegetarian',
      title: 'Vegetarian',
      type: 'boolean',
      description: 'Is it Vegetarian?',
      options: {
        layout: 'checkbox',
      },
    },
    {
      name: 'vegan',
      title: 'Vegan',
      type: 'boolean',
      description: 'Is it Vegan?',
      options: {
        layout: 'checkbox',
      },
    },
    {
      name: 'price',
      title: 'Price',
      type: 'number',
      description: 'Price of dish in pence',
      validation: (Rule) => Rule.min(99).max(10000), // Limits what can be entered for price
    },
    {
      name: 'image',
      title: 'Dish Image',
      type: 'image',
      options: {
        hotspot: true, // clever thing that lets us edit where to focus the picture when resizing
      },
    },
    {
      // Add a slug to deal with pesky spaces in names
      name: 'slug',
      title: 'slug',
      type: 'slug',
      options: {
        source: 'name',
        maxLength: 50,
      },
    },
  ],
  preview: {
    select: {
      name: 'name',
      vegetarian: 'vegetarian',
      vegan: 'vegan',
    },
    prepare: (fields) => ({
      title: `${fields.name} ${
        fields.vegan ? '- 🌱  Ve' : fields.vegetarian ? '-🍆 Veg' : '' //Nesting Ternaries is a naughty thing to do btw.
      }`,
    }),
  },
};

```

Which results in:


![Fish and Chips](https://github.com/neosaurrrus/blog-entries/blob/master/pics/60/2.png?raw=true)


Starting to look tasty! Note that we:

- Added Vegan and Vegetarian Options (and somehow I decided Fish and Chips was vegetarian)
- Added a preview property that lets us get some of the info without having to go into it. 

But lets start getting even more clever and look at some related data.


## Relational Data with a Second Content Type

Ok cool, we have some dishes in our restaurant but we don't want our customers with special dietary requirements to be worried about what we are serving up so we want capture data around use of dairy, nuts, gluten. That sort of thing.

 Multiple dishes might have dairy products in and maybe later we could filter out dairy products from the menu. To do this and save effort in the long run. it needs to exist as a seperate content type rather than just be a piece of info buried within each dish.

A dish can fit many intolerances, i.e it could have Gluten and Shellfish. So we call this a one to many relationship as ONE dish may have MANY ingredients that we care about.

Ok so first we need a new schema, called `intolerance.js` and we want to keep it fairly simple at first: 

```js
export default {
  name: 'intolerance',
  title: 'Dietary Intolerances',
  icon: () => '⚠️',
  type: 'document',
  fields: [
    {
      name: 'name',
      title: 'Name',
      type: 'string',
      description: 'Name of the Dietary Tolerance',
    },
  ],
};

```

Don't forget to add to the schema.js file as before:

`types: schemaTypes.concat([dish, intolerence]),`


### Linking it up

Now that we have done that we need to link dishes to thier intolerences. This requires us to make an addition to the pizza shema:

```js
  {
      name: 'Intolerences',
      title: 'Contains',
      type: 'array',
      of: [{ type: 'reference', to: [{ type: 'intolerance' }] }],
    },
```

So what are we doing here? We are adding an array to our dish schema, and then we are saying that array will contain *references* to our intolerences. This results in the following:

![Fish and Chips](https://github.com/neosaurrrus/blog-entries/blob/master/pics/60/3.png?raw=true)


Its  bit fiddly in the UI but allows us to link our previously created intolerences to our item. This isn't the most complex data ever for the sake of a short blog post but its easy to see how this can be developed.

My final (At least for now) dish schema looks like this:

```js
export default {
  name: 'dish',
  title: 'Dishes',
  icon: () => '🥣', // Lets give it a cool icon!
  type: 'document', //
  fields: [
    {
      name: 'name',
      title: 'Dish Name',
      type: 'string',
      description: 'Name of the Dish',
    },
    {
      name: 'vegetarian',
      title: 'Vegetarian',
      type: 'boolean',
      description: 'Is it Vegetarian?',
      options: {
        layout: 'checkbox',
      },
    },
    {
      name: 'vegan',
      title: 'Vegan',
      type: 'boolean',
      description: 'Is it Vegan?',
      options: {
        layout: 'checkbox',
      },
    },
    {
      name: 'price',
      title: 'Price',
      type: 'number',
      description: 'Price of dish in pence',
      validation: (Rule) => Rule.min(99).max(10000), // Limits what can be entered for price
    },
    {
      name: 'image',
      title: 'Dish Image',
      type: 'image',
      options: {
        hotspot: true, // clever thing that lets us edit where to focus the picture when resizing
      },
    },
    {
      // Add a slug to deal with pesky spaces in names
      name: 'slug',
      title: 'slug',
      type: 'slug',
      options: {
        source: 'name',
        maxLength: 50,
      },
    },

    {
      name: 'Intolerences',
      title: 'Contains',
      type: 'array',
      of: [{ type: 'reference', to: [{ type: 'intolerance' }] }],
    },
  ],
  preview: {
    select: {
      name: 'name',
      vegetarian: 'vegetarian',
      vegan: 'vegan',
    },
    prepare: (fields) => ({
      title: `${fields.name} ${
        // eslint-disable-next-line no-nested-ternary, naughty naughty
        fields.vegan ? '- 🌱  Ve' : fields.vegetarian ? '-🍆  Veg' : ''
      }`,
    }),
  },
};

```

## Customising our Inputs

One last thing, mostly optional. We are not limited to how Sanity renders the inputs by defailt. We can make our own version of the inputs using React components, we just need to tell Sanity to do that.

### The basics

First we want to create a components folder and inside of that the component we want to use.


We create a simple React component and import it into the schema as we would in React. In the relevent field object add the following property to tell it to use the component for the input: 

`inputComponent: nameOfComponent`

Its a good idea to get a basic component rendering something basic to check it works before moving on.


### Actually customising the input

There are a few things that are special because we are using Sanity in order for our input to talk to it properly.

#### 1. Get Props from Sanity

This is Because we told Sanity that we want to use this component for the input, it gives us a whole bunch of Props we have access to that relate to the data in Sanity. Some key ones are:

- Type, the filed object, contains title and descript and other things
- Value, what is in the input
- onChange, what to do when it changes
- inputComponent, reference to input itself so Sanity knows what to look at.

#### 2. Setting up Patching function

Sanity has its own method of updating its data, and it requires some Santity magic as follows:

1. We import the following:

`import PatchEvent, {set, unset} from 'part:@sanity/form-builder/patch-event'`

2. Build the following function:

```js
function createPatchFrom(value){
  PatchEvent.from(value === '' ? unset() : set(value))
}
```

Basically Sanity will set the value if the input value exists and unset it if it does not.

### 3. Build our input and complete our component

So I am building an input for an employee's age here, which is a bad idea for real life but for the sake of showing you the whole component:

```js
import React from 'react'
import PatchEvent, {set, unset} from 'part:@sanity/form-builder/patch-event'

function createPatchFrom(value){
  PatchEvent.from(value === '' ? unset() : set(value))
}

export default function AgeInput({ type, value, onChange, inputComponent }){
  return (
    <div>
      <h2>{type.title} {value ? value : ''</h2> 
      <p>{type.description}</p>
      <input
        type={type.title}
        value={value}
        onChange={event => onChange(createPatchFrom(event.target.value)})
        ref={inputComponent}
      />
    </div>
  )
}

```

### Conclusion

Phew, if you don't care about Sanity this would be a dull one but since Gatsby doesnt involve itself in backend stuff we need something to handle our data. Sanity is a good pick for something fairly easy to work with and obviously that is what I am working with in my posts going forward where we get to look at hooking up our Gatsby to our Sanity.





# Figuring out Gatsby #5 - GraphQL how Gatsby eats data

In my last post I actually didn't talk much about Gatsby and instead set up a Sanity backend for Gatsby to injest somehow.

The gist of the Sanity backend is that we have the following data for our restuarant app to use:

- dishes, our meals
- intolerences, things like gluten that can be in dishes
- employees, who works at the restaurant
- jobs, the jobs at the restuarant which an employee has

Regardless of how that data exists we need a way to show it for visitors to our Gatsby site so thats what we will talk about in this post.


## Set up Gatsby Config

`gatsbyconfig.js` which may need creating on your root folder, and sets up thignmd that apply accross your site mostly:

1. Site Metadata - Basic properties of your site
2.


```js 
module.exports = {
  siteMetadata: {
    title: `The Cat and Bear Restaurant`
    siteUrl: `whatever.com`
    description: 'Purrfect Food. Roarsome ambiance'
  }
}
```
Now we actually have some data we can head to `localhost:8000/___graphql` to build our first query:

```js
query MyQuery {
  site {
    siteMetadata {
      title
    }
  }
}
```

Should return:

```js
{
  "data": {
    "site": {
      "siteMetadata": {
        "title": "The Cat and Bear Restaurant"
      }
    }
  },
  "extensions": {}
}
```


### Hol' Up, whats this GraphQL stuff?

If you haven't seen graphql before then it. Put simply graphQL can let make queries (reading data) and mutations (changing data) using syntax that is a little bit like working with JSON (...not really true but best I can do in a sentance.) Its morefun than writing an SQL query at least. 

It will be quite the detour to explain it fully but I can recommend the [ video series by The Net Ninja](https://www.youtube.com/watch?v=Y0lDGjwRYKw) to get the general gist of it. Watch the first few videos at least, I find the visualisations help alot in making sense of how it works.

 GraphQL is the backbone of how Gatsby handles data so its important to get it understood.


 ## Pluggin' In to Gatsby Plugins
Plugins are a superpower of Gatsby, taking what already exists and hooking it up in your own app. At time of writing there is 2516 plugs availble. You can view the Gatsby Plugin [Library](https://www.gatsbyjs.com/plugins) to get a flavour of what things are availiable.


Adding a plugin is as easy as specifying the name of the plugin:

```js
module.exports = {
  siteMetadata: {
    title: `The Cat and Bear Restaurant`
    siteUrl: `whatever.com`
    description: 'Purrfect Food. Roarsome ambiance'
  },
  plugins: [
    'PLUGIN_NAME'
  ]
}
```

This gets it working in the most default manner possible but the documents usually have options we can configure. For the site map plug in we can do something like this:

```js
plugins: [
  //assume other plugs exist in this array
  {
    resolve: `gatsby-plugin-sitemap`,
    options: {
      sitemapSize: 5000
    }
  }
]
```

**Important Note:** It won't do much till you also `npm install` the relavent plug in by its name. 

Getting plugins in Gatsby is a doddle, any complexity will come from the Plugin itself so it will require studying the docs for each one. In my case, we have to get Gatsby talking to Sanity so lets take a deeper look at that:


1. Deploy graphQL for Sanity. In your Sanity folder type `sanity graphql deploy <dataset_name>`

2. Back in the Gatsby folder, get it installed with `npm install gatsby-source-sanity`

3. Get some details of your Sanity Project. Assuming you have set up a project at (https://manage.sanity.io/projects/) we will need:

- Project ID
- The name of the dataset 
- Token. This is a bit more involved. We can create a token by going to 'settings', 'api' and 'add new token'. Give it a label for your own info and copy the long string that appears somewhere. While you are in the API settings, take a mental note that we should specify CORS origins for the URL that will allow us talk to Sanity when it is in production.


```js
plugins: [
    {
      resolve: `gatsby-source-sanity`,
      options: {
        projectId: `<YOUR SANITY PROJECT ID`,
        dataset: `<PRODUCTION IN MY CASE>`,
        watchMode: true, //Allows changes to be reflected in Realtime for development
        token: process.env.SANITY_TOKEN, //DO NOT put you token in here. We need to keep our token secret. So we stick it into a .env file. See below...

      },
    },
  }
]
```

### ENV files, to stop ENVious hackers.

Quick aside, API tokens are sensitive, if people have access to them, they can do bad things. Our gatsby-config will be included in version control such as github so we can put the token there. Instead we just place a reference to an env file which contains secrets and doesn't go into version control. As an aside to our aside, having environment variables is also handly for things that do change between environments, such as connecting to a test database as opposed to a production one, without changing the 

1. npm install `dotenv` which allows us to use environment files easily
2. Create a `.env` in the root of our gatsby site.
3. Specify what SANITY_TOKEN is:

`SANITY_TOKEN=reg4ergGW...etc`

4. Lastly we need to configure dotenv in our gatsby config file: 

```js 
import dotenv from 'dotenv'
dotenv.config({path: '.env'})
```

This will get the config file using our API Key securely.

Lastly we should test it all works, a quick way is to console log the variable (if local) in gatsby-config to see if it is working properly. But if it is all hooked up as intended, when we go to our GraphiQL we should start seeing the contents of our Sanity popping in. Sanity data should start with `allSanity` so that: 

```js
query MyQuery { 
  allSanityMeals {
    nodes {
      name
    }
  }
  }
```

Should return all the names of our meals in our hypothetical restaurant site. Phew, the above looks fairly tricky if you have never done something like this before but compared to hooking up a seperate backend, I promise, its a relative breeze!


## Getting it visible via Gatsby Queries

So far we have gotten Gatsby to talk to our Sanity via GraphQL. The last step is getting the data from GraphQL onto our pages. Pretty much the whole reason for two wholly unrelavent blog posts. As before all my examples revolve around a hypothetical restaurant site that cares about showing off what it has on its menu.

In Gatsby, at present, there can are two types of queries we can write to get data into our components and onto the page

1. Page Queries. These allow variables but only can be run on a top-level page
2. Static Query - Do not allow for variables, but can exist everywhere

Images are a special bit of data we can look at in more detail.
## Page Queries

Page queries are pretty straightforward. Here is how we might get the dishes from the database adding the following GraphQL query to the Food page where we might see all the dishes:


```js
import React from 'react';

function FoodPage() {
  return (
    <div>
      <p>This is the Food page, where the dishes we serve are listed</p>
    </div>
  );
}

export const DishQuery = graphql`
  query DishQuery {
    dishes: allSanityDish {        //rename the output something nicer
      edges {
        node {
          id
          name
          price
          intolerences { 
            name
          }
          image {                // We will talk images in a bit
            asset {
              fluid(maxWidth: 400) {
                src
              }
            }
          }
        }
      }
    }
  }
`;

export default FoodPage;
```

If that works, you can use React Dev tools to see that the dish data has appeared in props. A good step but lets see if we can manipulate it some more by accessing the props in our code.

In our FoodPage component we can access the data by passing in the props, or more exactly the data field within props. At this point we can use that data however we like in the component:

```js
function FoodPage({ data }) {
  const dishes = data.dishes.edges;
  return (
    <div>
      <h1>We currently serve {dishes.length} dishes.</h1>
    </div>
  );
}
```
From there you can build extra components for mapping over the array if you so wish as pass dishes down as props. I wont get into that but if you have worked with React that should be fairly straightforward, here is the component file I ended up with:


```js
import React from 'react';

function DishItem({ dish }) {
  return (
    <div>
      <h2>
        {dish.name} - {dish.price}{' '}
      </h2>
      <h3>Intolerence information:</h3>
      <p>
        {dish.intolerences.map((intolerence) => intolerence.name).join(', ')}{' '}
      </p>
    </div>
  );
}

export default function DishList({ dishes }) {
  return (
    <div>
      {dishes.map((dish) => (
        <DishItem key={dish.id} dish={dish.node} />
      ))}
    </div>
  );
}

```




## Gatsby Images 

Making images work efficiently is a pain. File sizes can be all over the shop and cause performance issues, you might get wierd dimension issues. Certainly getting lazy loading, where it only loads when it about to be viewed is a hassle too. Gatsy has an image plugin to make getting this stuff right a breeze... once you have it set up!

Manipulating images takes alot of computing effort, so you either need to configure a computer to do the heavy lifting or you can use a service like Cloudinary or Imgix. Sanity has one that I will use. 

First off in whatever component you wish to wish to use to display images:

`import Img from 'gatsby-image'`

And then use the image tag as follows:

`<Img fluid={dish.image.asset.fluid} alt={dish.name}>`




