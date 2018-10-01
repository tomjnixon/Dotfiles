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

alias pbin="curl -F 'clbin=<-' https://clbin.com"
alias ls='ls --color=auto'
alias no="yes n"
alias xterm=uxterm
alias supervisorctl_cfg="supervisorctl -c ~/.supervisor"

alias g=git

alias gs="git status"

alias gsh="git show"

alias gc="git commit"
alias gca="git commit --amend"

function gcm(){ git commit -m "$*"; }
function gcam(){ git commit --amend -m "$*"; }

alias gco="git checkout"
alias gcop="git checkout --patch"
alias gcob="git checkout -b"

alias gd="git diff"
alias gdc="git diff --cached"
alias gds="git diff --stat"

alias gl="git log"

alias ga="git add"
alias gap="git add -p"

alias gr="git reset"
alias grp="git reset --patch"
alias grh="git reset --hard"

alias gre="git rebase"

alias gf="git fetch"

alias gp="git push"
alias gpf="git push --force-with-lease"

alias gss="git stash save"
alias gsa="git stash apply"
alias gsl="git stash list"

function f() {
    local file;
    file="$(fzf)"
    [ $? -eq 0 ] && "$@" "$file"
}

# rerun the last command with the last argument moved to the second, and update
# the history; used to correct a common mistake with 'find' command lines.
function fff(){ args=$(history -p '!:0 !$ !:1-'); history -s $args; $args; }

# Run ssh with the given args after removing the fingerprint from known_hosts.
# The determination of the host argument is not exact.
function fssh(){
    local OPTIND
    while getopts p:o:i: arg; do true; done
    ssh-keygen -R ${!OPTIND#*@} && ssh "$@"
}

function mcd() {
    mkdir -p $1 && cd $1;
}

function maudacity() {
    local tmpfile
    tmpfile="$(mktemp audacity_XXXXXXXX.lof)"
    for fname in "$@"; do
        printf 'file "%s"\n' "$(readlink -f "$fname")"
    done > "$tmpfile"
    audacity "$tmpfile"
    rm "$tmpfile"
}

function qr() {
    qrencode -t ANSI256 "$@"
}

alias t="xterm &"

export PATH=node_modules/.bin/:$PATH
export PATH=$HOME/.rvm/bin/:$PATH
export PATH=$HOME/.cabal/bin/:$PATH
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/bin/:$PATH

export GOPATH=$HOME/dev/build/go/
export PATH=$HOME/dev/build/go/bin/:$PATH

sinclude(../configs_priv/bash.m4)

ON_COMPUTER(LAPTOP)
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
ELSE_COMPUTER()
PS1='\[\e[0;32m\]tom\[\e[0;33m\]@\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[0;32m\]£\[\e[m\] '
END_COMPUTER()


# virtualenv activation must happen in the shell for it to be able to set up
# the prompt and deactivate. The desk script just sets up the VIRTUAL_ENV
# variable, and the actual activation is done by the shell.
function _activate_current_venv() {
	if [[ -n "${VIRTUAL_ENV+x}" ]]; then
		source "$VIRTUAL_ENV/bin/activate"
	fi
}
_activate_current_venv

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
	_activate_current_venv
}

function update_wheels() {
    pip3 wheel -r ~/.pip/wheels.txt
}

function update_python() {
    pip3 install --upgrade --user -r ~/.pip/wheels.txt
}

function clean_wheels() {
    rm -rf ~/.pip/wheelhouse/
    rm -rf ~/.cache/pip/wheels/
}

function update_vim() {
    vim -i NONE +PluginUpdate +PluginClean +qall
}

function activate_venv() {
    source $1/bin/activate
}

function venv2() { virtualenv --python=python2 "$@" && activate_venv "${@: -1}"; }
function venv3() { virtualenv --python=python3.6 "$@" && activate_venv "${@: -1}"; }
function venv() { venv3 "$@"; }

function pass() {
    # tell vim not to write files that might leak the password
    VIM_NO_WRITE_TMP=1 /usr/bin/pass "$@"
}
[ -f /usr/share/bash-completion/completions/pass ] && source /usr/share/bash-completion/completions/pass
