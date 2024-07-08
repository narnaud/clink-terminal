@echo off

git branch --sort=committerdate --sort=HEAD --format="%%(HEAD) %%(color:yellow)%%(refname:short) %%(color:green)(%%(committerdate:relative)) - %%(color:white)%%(subject)%%(color:reset)" --color=always %*
