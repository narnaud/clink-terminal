@echo off
setlocal

rem    This script comes from clink-gizmos, which is a collection of useful
rem    scripts for clink.  It is available at:
rem    - https://github.com/chrisant996/clink-gizmos

rem     Depends on:
rem     - https://hpjansson.org/chafa
rem     - https://github.com/sharkdp/bat
rem     - https://github.com/chrisant996/dirx

rem -- Ignore empty filenames.
rem    For example if {2..} is used with only one field, such as when
rem    configured to use icons but a match has no icon.
if "%~1" == "" goto :end

rem -- Make sure the filename is quoted.
set __ARG=%~1
if %__ARG% == "" goto :end

rem -- Display a directory.
rem --------------------------------------------------------------------------
if exist %__ARG%\* (
    dirx.exe /b /X:d /a:-s-h --bare-relative --level=3 --tree --icons=always --escape-codes=always --utf8 --ignore-glob=.git/** %__ARG%
    goto :end
)

rem -- Display a file.
rem --------------------------------------------------------------------------
rem -- Try to preview as an image.
rem    NOTE: Unfortunately chafa does not support the usual -- syntax to end flags.
if x%__ARG:~1,1% == x- goto :try_file
2>nul chafa -f sixels %__ARG%
if not errorlevel 1 goto :end

rem -- Try to preview as a text file.
:try_file
bat -f -p -- %__ARG%

:end
