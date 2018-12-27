# Intro

I have a lot of ideas for applications. Some of them are web based, some of them make sense on a mobile device. However, since I have spent my time learning Javascript, I didn't really fancy picking up Kotlin, Objective C, Swift, Java if I could avoid it. So I was curious about something I heard of called React Native. A way of using React to build mobile applications.

Too good to be true? Well that is I intend to find out.

# What is React Native exactly?

`Learn Once, write everywhere`

React Native isn't intended for a set of code to work magically between for Android and iOS apps. But *the way you write it* is the same and thus the "Learn Once" part.

It isnt a web app that runs in a browser or a wrapper, it is Native Code. Sortof. ReactNative puts a wrapper around to interfact wit hthe device.

## How does it work?

We write React components like we would a React app. However, what we render is different.

Normally we would render things like Divs, Spans and Inputs. These is stuff that would go into a DOM to be rendered by a browser. A mobile device isnt a DOM and thus this is where we use different tags for a different 'DOM' Here are some examples of how it changes:

- Div > View
- Input > TextInput

We still need React as that handles to the structure but instead of JSX tags we use ReactNative tags.

# Installing our first React Native App Template  the Easy way:

You could install React-Native manually but let's assume you are familiar with using Create-React-App then you should find this a similar process.

Make sure you have nodeJS version 8 or more.

`npm install -g expo-cli`

This installs Create expo-cli which might be familiar since I have used create-react-app plenty and this is a continuation of that concept. It performs a similar role here in making a barebones app ready to be developed.

Expo-CLI is actually the successor to Create React Native App, you can learn more [here](https://opencollective.com/expo-cli)

...Well thats not entirely true as we will see..

Once we have that, navigate where you want to create the app folder and type:

`expo init APP_NAME`

If it will promp whether you want a `blank` or `basic tabbed` template. I'd advise making a version of each to appreciate the difference. It will take a few minutes before either app is ready.

Once its done you should be able to 'cd' to the new folder and type `npm start` to get the app server up an running.

If you open up your folder in your favourite IDE you should see it looked a little Reacty and hopefully familiar to you as a web developer:

This is how we will create our mobile apps in the warm familair world of React. With some differences....

# Those differences in more detail.

The App component we see above is just a fairly regular React component. 

React is still used to handle components the same way it normally does, it doesnt care what those components do, whether it is for the web or mobile devices.

The magic comes from the react native imports. This adds the functionality to get produce elements that run on the mobile device rather than on a browser.

Now, an iPhone and an Android phone will expect different things as they use different OSes. They certainly dont know what a div, h1 is. However the beauty of React Native is that a common JSX element can be used for both and it does the conversion for us.

A full list of React Native components are availible on the React Native documentation site.

This get you up and running with a React App in the most simplest way.

Much like create-react-app you can eject out of the friendly expo managed app development environment when we want a little bit more control.

# Setting up React-Native without Expo.


We don't need the training wheels if we dont want to. But it is a little more 

# So far so good, how do I view my mobile app?

There are a number of ways to view.

1. You can scan the QR code with your phone. This is pretty cool. I had trouble connecting my LAN but using the tunnel option worked for me. I suspect this was down to my wierld LAN setup.



