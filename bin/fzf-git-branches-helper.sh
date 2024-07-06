#!/bin/bash

# This script has been taken from PsFzf:
# https://github.com/kelleyma49/PSFzf/blob/master/helpers/PsFzfGitBranches-Preview.sh

 branches() {
    # TODO: the branch name is intentionally not colored as we can't figure out how to remove VT codes from the output
    git branch "$@" --sort=committerdate --sort=HEAD --format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' --color=always | column -ts$'\t'
}
case "$1" in
branches)
    branches
    ;;
all-branches)
    branches -a
    ;;
*) exit 1 ;;
esac
