This is a series of Blog posts that follow me as I learnt about using Gatsby . There will be a focus on all the landmines I step on along the way to make sure they can be learnt from!

The main font of knowledge comes from Wes Bos' Master-Gatsby course. Is it any good? I don't know but lets see if I figure it out as I progress through!

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

This is part 3 of my Gatsby series start XXXXX for it to make more sense!

First of all, if you just want to create a CSS file in your layouts.js and link to it, you sure can. There is nothing stopping you in Gatsby. But like with alot of Gatsby, there is a better way that allows Gatsby to do things smarter. For Gatsby to do that, it needs to be made aware of the CSS by importing it.

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






Part 4 