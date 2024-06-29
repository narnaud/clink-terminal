@echo off

@REM Aliases
doskey ls      = dir /w $*
doskey ll      = dir $*
doskey clear   = cls
doskey cp      = copy $*
doskey mv      = move $*
doskey rm      = del $*
doskey e       = start %windir%\explorer.exe .

if exist %~dp0user_aliases.bat (
    call %~dp0user_aliases.bat
)

@REM Start clink
set CLINK_INPUTRC=%~dp0
set CLINK_PATH=%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos
clink inject --quiet
