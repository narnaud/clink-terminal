@echo off

@REM Aliases
doskey dir     = dirx
doskey ls      = dirx --icons -2 -v -h $*
doskey ll      = dirx --icons -a -og --string-sort $*
doskey clear   = cls
doskey cp      = copy $*
doskey mv      = move $*
doskey e       = start %windir%\explorer.exe .

if exist %~dp0user_aliases.bat (
    call %~dp0user_aliases.bat
)

@REM Add custom command path
set PATH=%PATH%;%~dp0bin

@REM Start clink
set CLINK_INPUTRC=%~dp0
set CLINK_PATH=%~dp03rdparty\clink-flex-prompt;%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos;%~dp0scripts
set DIRX_COLORS=di=36:di hi=37:.*=37;2:ex=32:sc=33:bu=33:cm=34;4:*.md=35:do=35
clink inject --quiet
