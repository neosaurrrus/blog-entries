# Start

Short snippet today but it’s a pretty useful tip. When writing things in node its pretty annoying to restart the server over and over. Would it not be great if the app restarted automatically when it changes?...

This is why we need : http://nodemon.io/

# Installing NodeMon

nodemon can be installed to the node environment to automatically restart the service when it detects changes.

It can be installed from npm via the following:

`npm install -g nodemon`

(The g is for global)

You might need to do deal with admin access depending on your setup (1sudo npm install -g nodemon`)

Once you are installed instead of doing: node app.js

You can use: `nodemon app.js` This launched your app, making it automagically restart as you make changes. By default it will watch for changes that would need a restart (changing a model file for example)

# Additional options

What if you don’t want to watch a certain file? Or need to watch another one. Or you have special flags when launching your application?

I could tell you but really the docs explain it a whole lot better:

https://github.com/remy/nodemon#nodemon

# Other tools

There is other tools out there that handle restarting of servers, refreshing of pages when we make changes. I am suspect I will mention those at some point.