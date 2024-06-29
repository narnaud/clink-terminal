@echo off

@REM Start clink
set CLINK_INPUTRC=%~dp0
set CLINK_PATH=%~dp03rdparty\clink-zoxide;%~dp03rdparty\clink-gizmos
clink inject --quiet
