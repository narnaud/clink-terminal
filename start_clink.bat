@echo off

@REM Aliases
doskey dir     = dirx
doskey ls      = dirx --icons -2 -v -h $*
doskey ll      = dirx --icons -a $*
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
set CLINK_PATH=%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos
clink inject --quiet
