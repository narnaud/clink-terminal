@echo off
setlocal EnableDelayedExpansion

@REM Extract parameters

:parse

if /i "%1"=="-f" (
	set "Force=/Q"
	shift /1
	goto parse
)
if /i "%1"=="-r" (
	set "Recursive=/S"
	shift /1
	goto parse
)
if /i "%1"=="-rf" (
	set "Force=/Q"
	set "Recursive=/S"
	shift /1
	goto parse
)

@REM Emulate rm on linux

if exist %1\* (
    @REM Trying to delete a directory
    rmdir %Force% %Recursive% %1 %2 %3 %4 %5 %6 %7 %8 %9
) else (
    @REM Trying to delete one or multiple files
    del %Force% %* %1 %2 %3 %4 %5 %6 %7 %8 %9
)
