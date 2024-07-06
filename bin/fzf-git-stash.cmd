@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse --height=50%% --min-height=20
set __ZFZ_PREVIEW_WINDOW=--preview-window="right,50%%,border-left" --bind="ctrl-/:change-preview-window(down,50%%,border-top|hidden|)"

::: Git specific options
set __GIT_CMD= git stash list --color=always
set __GIT_TITLE=--border-label="🥡 Git stashes"
set __GIT_HELP=--header "CTRL-X (Drop stash)"
set __GIT_PREVIEW_CMD="git show --color=always {1}"
set __GIT_CTRL_X="ctrl-x:execute-silent(git stash drop {1})+reload(%__GIT_CMD%)"

%__GIT_CMD% 2>nul | fzf  %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW%  %__GIT_TITLE% %__GIT_HELP% -d: --preview=%__GIT_PREVIEW_CMD% --bind=%__GIT_CTRL_X%
