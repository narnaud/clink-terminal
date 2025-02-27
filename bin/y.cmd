@echo off

set tmpfile=%TEMP%\yazi-cwd.%random%

yazi %* --cwd-file="%tmpfile%"

:: If the file exist, then read the content and change the directory
if exist "%tmpfile%" (
    set /p cwd=<"%tmpfile%"

    if not "%cwd%"=="" (
        cd /d "%cwd%"
    )

    del "%tmpfile%"
)
