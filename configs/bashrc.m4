CONFIG_FILE(bash, ~/.bashrc)

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
set -o vi

export HISTSIZE=10000
export HISTCONTROL=ignorespace
export PYTHONSTARTUP=~/.pythonrc
export EDITOR=vim
export BROWSER=firefox
export AWT_TOOLKIT=webscarab
export MPD_HOST="/home/tom/.mpd/socket"

alias pbin="curl -F 'sprunge=<-' http://sprunge.us"
alias ls='ls --color=auto'
alias no="yes n"
alias xterm=uxterm
alias g=git
alias supervisorctl_cfg="supervisorctl -c ~/.supervisor"

export PATH=$HOME/.rvm/bin/:$PATH
export PATH=$HOME/.cabal/bin/:$PATH
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/bin/:$PATH

sinclude(bash_secrets.inc.m4)

ON_COMPUTER(LAPTOP)
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
ELSE_COMPUTER()
PS1='\[\e[0;32m\]tom\[\e[0;33m\]@\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
END_COMPUTER()


# virtualenv activation must happen in the shell for it to be able to set up
# the prompt and deactivate. The desk script just sets up the VIRTUAL_ENV
# variable, and the actual activation is done by the shell.
function activate_current_venv() {
	if [[ -n "${VIRTUAL_ENV+x}" ]]; then
		source "$VIRTUAL_ENV/bin/activate"
	fi
}
activate_current_venv

function get_desk() {
	i3-msg -t GET_WORKSPACES | \
		jshon -a -e focused -u -p -e name -u | \
		grep -A 1 true | tail -n 1
}

function here() {
	desk=$(get_desk)
	
	mkdir -p $HOME/.i3/desks/
	echo "cd $(pwd)" > $HOME/.i3/desks/$desk
	if [[ -n "${VIRTUAL_ENV+x}" ]]; then
		echo "export VIRTUAL_ENV='$VIRTUAL_ENV'" >> $HOME/.i3/desks/$desk
	fi
}

function there() {
	desk=$(get_desk)
	
	[[ -n "${VIRTUAL_ENV+x}" ]] && deactivate
	[ -f "$HOME/.i3/desks/$desk" ] && source "$HOME/.i3/desks/$desk"
	activate_current_venv
}

function update_wheels() {
    pip2 wheel -r ~/.pip/wheels.txt
}
