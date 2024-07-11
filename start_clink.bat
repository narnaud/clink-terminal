@echo off

:::============================================================================
::: Aliases
:::============================================================================
doskey ls      = dirx --icons -2 -v -h -oga $*
doskey ll      = dirx --icons -a -oga $*
doskey clear   = cls
doskey cp      = copy $*
doskey mv      = move $*
doskey e       = start %windir%\explorer.exe .

::: User specific aliases
for /f "tokens=1,2 delims=@" %%a in ('jq -r ". | to_entries[] | join(""@"")" %USERPROFILE%\.alias.json') do (
    if "%%a%" NEQ "" (
        doskey %%a=%%b $*
    )
)

:: fzf aliases
doskey fe       = %~dp0bin\fzf-explorer.cmd
doskey fgf      = %~dp0bin\fzf-git-status.cmd
doskey fgb      = %~dp0bin\fzf-git-branches.cmd
doskey fgs      = %~dp0bin\fzf-git-stashes.cmd
doskey fgh      = %~dp0bin\fzf-git-hashes.cmd

:::============================================================================
::: Add custom command path
:::============================================================================
set PATH=%PATH%;%~dp0bin

:::============================================================================
::: Start ssh-agent
:::============================================================================
ssh-agent -s 2>nul

:::============================================================================
::: clink
:::============================================================================
::: Change the .inputrc file (the one in this directory)
set CLINK_INPUTRC=%~dp0
::: Add some script paths. Note that clink-flex-prompt must be before scripts
set CLINK_PATH=%~dp03rdparty\clink-flex-prompt;%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos;%~dp0scripts
::: Change dirx colors
set DIRX_COLORS=di=36:di hi=37:.*=37;2:ex=32:sc=33:bu=33:cm=34;4:*.md=35:do=35
::: Change the command used to list files and folders for fzf (use direx, for icons)
set FZF_DEFAULT_OPTS=--ansi
set FZF_CTRL_T_COMMAND=dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8 $dir
set FZF_ALT_C_COMMAND=dirx.exe /b /s /X:d /a:d-s-h --bare-relative --icons=always --escape-codes=always --utf8 $dir
set FZF_ICON_WIDTH=2

::: Finally, inject clink
clink inject --quiet
