CONFIG_FILE(bash, IF_COMPUTER(UNI, ~/.my_bashrc.all, ~/.bashrc))

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
set -o vi

export HISTSIZE=10000
export PYTHONSTARTUP=~/.pythonrc
export EDITOR=vim
export BROWSER=google-chrome
export AWT_TOOLKIT=webscarab
alias pbin="curl -F 'sprunge=<-' http://sprunge.us"

alias ls='ls --color=auto'
alias no="yes n"
alias pbin="curl -F 'sprunge=<-' http://sprunge.us"
alias xterm=uxterm

export PATH=$HOME/.cabal/bin/:$HOME/bin/:$PATH

sinclude(bash_secrets.inc.m4)

ON_COMPUTER(UNI)
PATH=$PATH:/opt/matlab/bin/
alias xtroll="xlock -bitmap $HOME/Documents/trollface.xbm -mode image"
export PYTHONPATH="$HOME/python/:$HOME/lib/python2.6/site-packages/"
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib:/usr/lib/perl5/CORE/
END_COMPUTER()

ON_COMPUTER(LAPTOP)
PATH=$PATH:/home/tom/opt/arm-2010.09/bin/
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
function t() { /usr/bin/t $@; update_t; }
alias git=hub
export MPD_HOST="/home/tom/.mpd/socket"
source /home/tom/dev/Scripts/shelf
ELSE_COMPUTER()
PS1='\[\e[0;32m\]tom\[\e[0;33m\]@\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
END_COMPUTER()


ON_COMPUTER(MINE)
source shet_complete
export SHET_HOST="localhost"
END_COMPUTER()

function send_to_kindle()
{
        echo "$1" | ssh 18sg.net "cat > redirect"
}

function there() {
        desk=$(
                i3-msg -t GET_WORKSPACES |
                jshon -a -e focused -u -p -e name -u |
                grep -A 1 true | tail -n 1)
        directory=$(cat $HOME/.i3/desks/$desk || echo $HOME)
        cd $directory
}
