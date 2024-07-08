@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse --height=50%% --min-height=20
set __ZFZ_PREVIEW_WINDOW=--preview-window="down,50%%,border-top" --bind="ctrl-/:change-preview-window(right,50%%,border-left|hidden|)"

::: Git specific options
set __GIT_CMD=_git-branches-helper.cmd
set __GIT_CMD_ALL=_git-branches-helper.cmd -a
set __GIT_TITLE=--border-label="🌳 Git branches"
set __GIT_HELP=--header "CTRL-A (Show all branches) / ALT-X (Drop branch)"
set __GIT_PREVIEW_CMD="_git-log-helper.cmd {1}"
set __GIT_CTRL_A="ctrl-a:change-border-label(🌳 Git all branches)+reload(%__GIT_CMD_ALL%)"
set __GIT_ALT_X="alt-x:execute-silent(git branch -D {1})+reload(%__GIT_CMD%)+reload(%__GIT_CMD%)"

%__GIT_CMD% 2>nul | fzf  %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW% %__GIT_TITLE% %__GIT_HELP% --preview=%__GIT_PREVIEW_CMD% --bind=%__GIT_CTRL_A% --bind=%__GIT_ALT_X%

exit /b 0
