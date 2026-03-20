@echo off
if "%~1"=="" (
    start .
) else (
    start "" "%~1"
)
