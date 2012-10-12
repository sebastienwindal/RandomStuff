# Basic git setup
## Make sublime text 2 the default git editor
* add a link to sublime text in your home bin folder. 
``ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl``

* Make sure  ~/bin is in your path. See [.bash_profile](.bash_profile ".bash_profile")  for that.
* run ``git config --global core.editor "subl -n -w"``
<<<<<<< HEAD

* quickly serve a local git repo, go to the same folder as the .git folder is and run:
``git daemon --reuseaddr --base-path=. --export-all --verbose``
You can now pull it using ``git clone git://yourIP/ projectName`` a folder projectName will be created.
=======
>>>>>>> sdf
