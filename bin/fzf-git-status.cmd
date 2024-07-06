@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse --height=50%% --min-height=20
set __ZFZ_PREVIEW_WINDOW=--preview-window="right,50%%,border-left" --bind="ctrl-/:change-preview-window(down,50%%,border-top|hidden|)"

::: Git specific options
set __GIT_CMD=git -c color.status=always status --short
set __GIT_TITLE=--border-label="☘️ Git status"
set __GIT_HELP=--header "CTRL-A (Select all) / ALT-E (Edit) / ALT-S (Git add) / ALT-R (Git reset)"
set __GIT_PREVIEW_CMD="git diff --no-ext-diff --color=always {-1}"
set __GIT_CTRL_A="ctrl-a:select-all"
set __GIT_ALT_E="alt-e:execute-silent(code {+2..})"
set __GIT_ALT_S="alt-s:execute-silent(git add {+2..})+down+reload(%__GIT_CMD%)"
set __GIT_ALT_R="alt-r:execute-silent(git reset {+2..})+down+reload(%__GIT_CMD%)"

%__GIT_CMD% 2>nul | fzf  %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW% %__GIT_TITLE% %__GIT_HELP% --multi --preview=%__GIT_PREVIEW_CMD% --bind=%__GIT_ALT_E% --bind=%__GIT_ALT_S% --bind=%__GIT_CTRL_A% --bind=%__GIT_ALT_R%
