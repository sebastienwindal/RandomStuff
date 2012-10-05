#.bash_profile

export PATH=~/bin/:$PATH

alias st='open -a "Sublime Text 2"'
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias ls="command ls -G"
alias ll="command ls -l -G"
