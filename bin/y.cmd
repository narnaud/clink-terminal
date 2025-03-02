@echo off

set tmpfile=%TEMP%\yazi-cwd.%random%

yazi %* --cwd-file="%tmpfile%"

:: If the file does not exist, then exit
if not exist "%tmpfile%" exit /b 0

:: If the file exist, then read the content and change the directory
set /p cwd=<"%tmpfile%"

if not "%cwd%"=="" (
    cd /d "%cwd%"
)

del "%tmpfile%"
