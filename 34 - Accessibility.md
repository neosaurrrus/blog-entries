# Why do we care?

I don't think we need to think too hard to figure out why this matters. If you have your own accessibility needs you know. If you don't, over 1 billion people on the planet have accessibilty needs. Thats alot of people, we should make sure they can access your stuff, like everyone else.

Plus, more and more organisations, public and private are making accessibility cosiderations part of thier policies. So, if nothing else, it's good for you to appreciate these things 

## The goal of accessbility

How do we know when our webapp is accessible? Well that's a tricky thing to define which we will get to but a good motto (not mine) is:

*Make changes today to make things more accessible than they were yesterday*

Aim to make improvements, to make sites 100% accessible is daunting to most so focus on what you can do, something is better than nothing.

# The Basics

`a11y` - Accessbility, or prounounced "Ally" is somethign you'll see alot of you look around this topic.


SEARCH: INCLUSIVE DESIGN

<Someone> defines 3 types of disability:

- Permanent, what you probably think about, blindness, deafness, hand-eye coordination issues.
- Temporary, say you break your hand and it is in a cast.
- Situational, holding a baby or driving.

In that regard, all of us will have accessbility needs at some point in your life.

# Simple Stuff you can do

Nearly all of this is free, and quick to do it just takes consideration. It is even less work when you bear it in mind as you build in the first place.

## Use the right HTML tags

You can pretty much use divs for everything

# Keyboard Usage



## Skip to Content button

If you imagine most sites have a set of nav items at the top, if you are tabbing through them all to actually get to the content that will be tiresome.

A common solution to this is to have a button at the top of the page, hidden by default, that links to an ID where the content begins. You can use CSS to show it when focused which then lets people get to the good stuff easily.



# Tools 

Lighthouse - In Chrome Dev Tools, under Audits. You have lighthouse that allows you check various things about your website. Here you can run an accessibilty audit. If you don't know where to begin this is a good idea.

AXE - Lighthouse is using an application AXE - By DQ? . This has a few extra features so its a browser extension worth grabbing. 

Attest - For enterprise, the same company also has a product called Attest for more in-depth paid analysis. 

ESLint Rules - Consider use of extensions in your text editor such as ESLint rules to flag up things that might be an issue accessibility-wise
