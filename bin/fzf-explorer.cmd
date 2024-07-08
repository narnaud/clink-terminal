@echo off
setlocal enableDelayedExpansion

::: Generic fzf options
set __ZFZ_FRAME=--ansi --border=rounded --color="header:italic:underline"
set __ZFZ_LAYOUT=--layout=reverse --height=50%% --min-height=20
set __ZFZ_PREVIEW_WINDOW=--preview-window="right,50%%,border-left" --bind="ctrl-/:change-preview-window(down,50%%,border-top|hidden|)"

::: Explorer specific options
set __EXPLORER_CMD=dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8
set __EXPLORER_TITLE=--border-label="📁 Explorer"
set __EXPLORER_HELP=--header "ALT-E (Edit in VS Code)"
set __EXPLORER_SEPARATION_LINE=[38;2;95;95;95m────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
set __EXPLORER_PREVIEW_CMD="if exist {-1}\* (echo [94m Directory[0m: {-1} & echo %__EXPLORER_SEPARATION_LINE% & dirx.exe /b /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8 {-1}) else (echo [33m File:[0m {-1} & echo %__EXPLORER_SEPARATION_LINE% & bat --color=always --style=changes,numbers --line-range :500 {-1})"
set __EXPLORER_ALT_E="alt-e:execute-silent(code {+2..})"

%__EXPLORER_CMD% 2>nul | fzf %__ZFZ_FRAME% %__ZFZ_LAYOUT% %__ZFZ_PREVIEW_WINDOW% %__EXPLORER_TITLE% %__EXPLORER_HELP% --multi --preview=%__EXPLORER_PREVIEW_CMD% --bind=%__EXPLORER_ALT_E%

exit /b 0
