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


## Back to the commit

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

## Pull Requests


Thisi s a bit confusing as its easy to think we are pulling FROM someone. This aint the case, its a pull **request**. We are requesting the owner of another repo to take your changes and *pull* it into thiers.

This is part of a long chain where we:

1. Fork thier repo into our organisation

2. Clone the Repo locally so we can work on it

3. Push the changes to our online repo.

4. Submit a pull request.

There is a nice button for it on Github. 

You can still work on your code that forms part of the pull request.

## Branches 

Its really important to make sure that the default 'master' stays functional, if we keep making changes there is a good chance we will break it at some point in the process of making it better. For example ofr a website, we might want to redesign a given page, while it is being redesigned it wont look right, the web site vistors will cry. Branches are a way of dealing with that kind of thing.

Branches are alternate realites for our code. We make a copy of 'master' work on that branch and then wwhen we are good and ready to merge it back.

We start a new branch by typing `git branch <branch name>` we then can see the branch by typing `git branch`

So for our example we can have a `page-redesign` branch which is a copy of the master branch. At this point, there are no changes.

To work on this branch we need to **check out** the file. - `git checkout page-redesign` like checking out a book at the library. Except don't make changes to library books, thats not cool.

Before you check out other branches, make sure you commit your changes! git stash might help here but we wont go into it.

Using `git log`, we will eventually see that eventually the new branch has changes the master doesnt have. So lets **merge those branches** 

To do this you:

1. Checkout master as thats what we want to make changes to.

2. Use the `git merge` command: `git merge -m "merge in feature add page-redesign"

3. Use git log to confirm the commits from the new branch are now in master.

4. At this point you can dleete the branch by doing `git branch -d <branch name>

Lastly, to view a list of branches we just do `git fetch <remote-name>`

Its a good idea to get i nthe habit of using branches for things we are working on. Working on just the master is risky and also harder to understand what changes are going on without a branch that relates to a specific area.

## Conclusion


Thats the basics of using git, at this point it starts getting a little more philosophical so thats topic to come back to another time.
