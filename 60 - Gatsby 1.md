This is a seris of Blog posts that follow me as I learnt about usingGatsby and Sanity through Wes Bos' Master-Gatsby course. There will be a focus on all the landmines I step on along the way to make sure they can be learnt from!


# Episode 1 - Setting up for the Course

We are using Gatsy for the front End and Sanity for the backend. To get started there are a bunch of things that require setting up for the course.

## The Terminal Stuff 

They both need an up to date version of Node, so make sure you do that. Else it will fail. Please don't mistake npm for node when doing so. One day I will learn! But not too up to date as I learn in the next paragraph.


The Gatsby CLI and Sanity CLI tools are very useful and can be installed with: `npm install gatsby-cli @sanity/cli -g`. However this led me to some issues:

On the gatsy-cli I got the following error:

`cannot read property 'matches' of undefined`

Searching on Slack, this turned out to require a combination of upgrading HomeBrew, MacOS and XCode as well as *not* using node version 14. Fun!

The sanity CLI also errored out till I installed a new version of XCode (which I did to fix the gatsby cli)

## Other Issues

The course comes with a configured ESLint which ame up with the following error: `eslint: createrequire is not a function referenced from:`

This turned out to be due to an old version of VS Code which was inexplicably running from the Downloads folder on Mac. When I moved to Applications I was able to update and the error went away.

Phew! Nothing a few heavy googles can't fix