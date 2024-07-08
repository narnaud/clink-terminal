@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse --height=50%% --min-height=20
set __ZFZ_PREVIEW_WINDOW=--preview-window="right,50%%,border-left" --bind="ctrl-/:change-preview-window(down,50%%,border-top|hidden|)"

::: Git specific options
set __GIT_CMD=git l --color=always
set __GIT_TITLE=--border-label="🍡 Git hashes"
set __GIT_PREVIEW_CMD="git show --color=always {2}"

%__GIT_CMD% 2>nul | fzf  %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW% %__GIT_TITLE% --preview=%__GIT_PREVIEW_CMD%

exit /b 0
