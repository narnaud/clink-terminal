@echo off

:::============================================================================
::: Aliases
:::============================================================================
doskey ls      = dirx --icons -2 -v -h $*
doskey ll      = dirx --icons -a -og --string-sort $*
doskey clear   = cls
doskey cp      = copy $*
doskey mv      = move $*
doskey more    = bat -p $*
doskey e       = start %windir%\explorer.exe .

::: Git aliases
doskey gl      = git log --graph --pretty=format:"%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset" --abbrev-commit --date=relative
doskey gs      = git status $*
doskey gd      = git diff $*

::: Run some software from command line
doskey np      = "C:\Program Files\Notepad++\notepad++.exe" $*
doskey qtc     = C:\Qt\Tools\QtCreator\bin\qtcreator.exe -client $*

:: Misc aliases
doskey xhost   = sudo code C:\Windows\System32\Drivers\etc\hosts
doskey mariadb = mysql

:::============================================================================
::: Add custom command path
:::============================================================================
set PATH=%PATH%;%~dp0bin

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
set FZF_CTRL_T_COMMAND=dirx.exe /b /s /X:d /a:-s-h --bare-relative --icons=always --utf8 $dir
set FZF_ALT_C_COMMAND=dirx.exe /b /s /X:d /a:d-s-h --bare-relative --icons=always --utf8 $dir
set FZF_ICON_WIDTH=2

::: Finally, inject clink
clink inject --quiet
