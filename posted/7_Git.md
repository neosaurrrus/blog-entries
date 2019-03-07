# Learning GIT stuff 


`Git` is at its most basic a Version Control System


`Commits` are the 'saves' that occur.n GitHub we can see the commits

`Respository`, a collection of files in git.

Some really important commands:

`git --version` - This gives us the current version of Git installed. This is a simple way of seeing that it is installed.

`git init` - Tell git to that you intend to use it to watch a folder and all subfolders. It wont track changes outside. This will create a .git folder that’s hidden contains the changes and history. If you delete this, you will lose the tracked changes. This doesn’t automatically begin tracking your changes though, that comes later.



`git status`

Gives an overview of the git status of the repo. Will tell you:

• The current branch
• The current comment
• What files are tracked.

Though normally you want your files to be tracked, its worth considering that some files should not be tracked if they are confidential in some way.

`git add` - Tell git what files to track. You can add files one at a time: For example: `git add app.js` would tell git to add the app.js file

However, this does not actually commit that action, for that you need to use…

`git commit -m "<Explain your change>"`

Its convention to provide the message in present tense....**However, the first time you go this it wont work.**

An important part of version control is knowing who has done what. So we first need to provide that information. The message you will get is fairly clear on what you need to do.


## Back to the commit…

Now the app.js is no longer in the untracked list. Ok so if I make a change to app.js and run git status again, it will tell us that *the changed app.js file isnt staged for commit.*

Everytime we commit we must tell git what files to commit first by using `git add`.


So to track that change we will need to **git add our app.js and then run the commit.**

## What about multiple files?

It would suck to have to type git add for all the files that might be changing on a regular basis. We can add all changes not staged for commit by doing:

`git add .`     (note the dot)

## Previous Versions

To actually go back in time you need other commands:

`Git Log` 
`Git Checkout`

If you mess up a file and want to get back in time you need to see whats in the past first. If you type Git log you will be presented with your changes:

**You can type Q to get out of this.**

The long string is the ID of the commit and that’s what we need to find it.

### Git Checkout

You can check the commit id using git checkout:

`git checkout <commit id>`

We have gone back in time. the files are now as if they were prior to the change. You might see a Head Detached message. This is because the Head is still at the Master (latest point)

Check out this lame diagram:

    Commit 1 ---> Commit 2(Reverted to here) ----> Commit 3  ---> Master(Head is here)

If we go back the master is still there, hence the head detached warning.

Normally we are at this point to check on old code before returning to the Master.


To go back to master use `git checkout master`


## Reverting
To revert back to that point there is a lot of ways to do this. Its quite rare to do that however. But you never know.

One way is:

`git revert --no-commit <commit ID>..HEAD`
`git commit`


This will go back in time and make that commit the new head.


# Using GitHub with the command line

Github has far better tutorials on this. I am just keeping this for my own sanity. Here are the basic steps:

1. Make a new repository on github
2. Grab the url
3. In the command line, first need to specify the url for the origin `git remote add origin <url>`
4. Check the location by typing `git remote -v`vIf you have made a mistake you can use `git remote remove origin`
5. `git push origin master` - makes your files go up to the master branch.

If you get an error like this :

Do what it says i.e git pull origin master.

## What about push, pulls and branches?

Thats going to be for a Part 2. Stayed Tuned for when I get aorund to writing it.