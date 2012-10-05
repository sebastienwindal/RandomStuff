# Basic git setup
## Make sublime text 2 the default git editor
* add a link to sublime text in your home bin folder. 
``ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl``

* Make sure  ~/bin is in your path. See .bash_profile for that.
* git config --global core.editor "subl -n -w"

