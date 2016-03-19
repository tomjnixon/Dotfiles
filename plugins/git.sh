#!/bin/bash

# Make sure the git repo in $1 is up to date with $2
function update_git_repo() {
	path=$1
	remote=$2
	mkdir -p $path
	(
		cd $path
		git init -q
		
		(git remote | grep -q origin) && git remote remove origin
		git remote add origin "$remote"
		
		git fetch origin master
		git branch --set-upstream-to=origin/master master
		
		git merge origin/master
	)
}
