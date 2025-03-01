@echo off

if "%2" == "" (
    :: single parameter, check if the file is deleted
    if not exist %1 (
        echo [41m%1 deleted[0m
        goto :eof
    )

    :: single parameter, check if the file is new
    git ls-files --error-unmatch %1 >nul 2>&1
    if errorlevel 1 (
        echo [42m%1 added[0m
        echo.
        bat --style=plain --color=always %1
        goto :eof
    )
)


:: do a git diff in all other cases
git diff --no-ext-diff --color=always %*

:eof
