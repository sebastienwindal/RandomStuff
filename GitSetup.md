# Basic git stuff
## Make sublime text 2 the default git editor
* add a link to sublime text in your home bin folder. 
``ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl``

* Make sure  ~/bin is in your path. See [.bash_profile](.bash_profile ".bash_profile")  for that.
* run ``git config --global core.editor "subl -n -w"``


## quickly serve a local git repo

* go to the same folder as the .git folder is
* run:
``git daemon --reuseaddr --base-path=. --export-all --verbose``
* You can now pull it using ``git clone git://yourIP/ projectName`` a folder projectName will be created.

## Standard git workflow

* Creating a branch

```bash
git checkout -b myFeature
```

working, working, commiting, working, committing, pushing, working, commiting, pushing.

* bring changes made by others in the dev branch to myFeature branch

Unfortunately there are other people in the world, and they are pushing their crap to the dev branch too.
Not just me writing useless code.

```bash
git checkout dev
git pull
git checkout myFeature
git rebase dev
```

First we get the latest on dev and then switch back to the myFeature branch. The ```bash git rebase dev```
command "replays" the changes made to the dev branch on the myFeature branch.

This step is optional but it ensures I am not diverging too much from the main branch while
working on my own custom branch, it should make the final merge less painful (in theory).
Good to do that daily or so...

working, working, commiting, working, committing, pushing, working, commiting, pushing....

Repeat this whole step until you are done with myFeature...

* Pushing all changes to dev

I am done with myFeature, I have checked in and pushed all my changes to the myFeature branch,
I passed code review because ~~code reviews are useless~~ I am abviously a genius.
Merge and push the myFeature branch to dev:

```
git checkout dev
git pull
git merge myFeature
```

fix conflicts, commit and push to dev. Done.
