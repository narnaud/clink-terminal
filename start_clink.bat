@echo off

@REM Start clink
set CLINK_INPUTRC=%~dp0
clink inject --quiet
