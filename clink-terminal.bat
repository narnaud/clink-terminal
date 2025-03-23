@echo off

:::============================================================================
::: Aliases
:::============================================================================
doskey ls      = dirx --icons -2 -v -h -oga -Qvsh $*
doskey ll      = dirx --icons -a -oga -Qvsh $*
doskey clear   = cls
doskey cp      = %USERPROFILE%\scoop\apps\git\current\usr\bin\cp.exe $*
doskey mv      = %USERPROFILE%\scoop\apps\git\current\usr\bin\mv.exe $*
doskey rm      = %USERPROFILE%\scoop\apps\git\current\usr\bin\rm.exe $*
doskey pwd     = cd
doskey e       = start %windir%\explorer.exe .

::: User specific aliases
if exist %USERPROFILE%\.alias.yaml (
    for /f "tokens=1,2 delims=@" %%a in ('yq -o props "... comments = """"" --properties-separator="=" %USERPROFILE%\.alias.yaml') do (
        if "%%a%" NEQ "" (
            doskey %%a $*
        )
    )
)

:::============================================================================
::: Add custom command path
:::============================================================================
set PATH=%PATH%;%~dp0bin

:::============================================================================
::: Yazi setup
:::============================================================================
set YAZI_FILE_ONE=%USERPROFILE%\scoop\apps\git\current\usr\bin\file.exe

:::============================================================================
::: Dirx setup
:::============================================================================
::: Change dirx colors
set DIRX_COLORS=di=36:di hi=37:.*=37;2:ex=32:sc=33:bu=33:cm=34;4:*.md=35:do=35

:::============================================================================
::: Fzf setup
:::============================================================================
::: Change the command used to list files and folders for fzf (use dirx, for icons)
set FZF_DEFAULT_OPTS=--ansi
set FZF_CTRL_T_COMMAND=dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --escape-codes=always --utf8 --ignore-glob=.git/** $dir
set FZF_ALT_C_COMMAND=dirx.exe /b /s /X:d /a:d-s-h --bare-relative --icons=always --escape-codes=always --utf8 --ignore-glob=.git/** $dir
set FZF_ICON_WIDTH=2

::: Does not work for now on Windows Terminal
::: set CLINK_FZF_PREVIEW_SIXELS=1

:::============================================================================
::: Start ssh-agent
:::============================================================================
ssh-agent -s 2>nul

:::============================================================================
::: clink
:::============================================================================
::: Change the .inputrc file (the one in this directory)
set CLINK_INPUTRC=%~dp0
::: Add some script paths.
set CLINK_PATH=%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos;%~dp0scripts

::: Finally, inject clink
clink inject --quiet
