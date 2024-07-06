@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse
set __ZFZ_PREVIEW_WINDOW=--preview-window="down,border-top,50%%" --bind="ctrl-/:change-preview-window(down,70%%|hidden|)"

::: Git specific options
set __GIT_CMD=bash fzf-git-branches-helper.sh branches
set __GIT_CMD_ALL=bash fzf-git-branches-helper.sh all-branches
set __GIT_TITLE=--border-label="🌳 Git branches"
set __GIT_HELP=--header "CTRL-A (Show all branches)"
set __GIT_PREVIEW_CMD="git l --color=always {1}"
set __GIT_CTRL_A="ctrl-a:change-border-label(🌳 Git all branches)+reload(%__GIT_CMD_ALL%)"

%__GIT_CMD% 2>nul | fzf  %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW% %__GIT_TITLE% %__GIT_HELP% --preview=%__GIT_PREVIEW_CMD% --bind=%__GIT_CTRL_A%
