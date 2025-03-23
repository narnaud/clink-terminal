@echo off
setlocal

rem    This script comes from clink-gizmos, which is a collection of useful
rem    scripts for clink.  It is available at:
rem    - https://github.com/chrisant996/clink-gizmos

rem     Depends on:
rem     - https://hpjansson.org/chafa
rem     - https://github.com/sharkdp/bat
rem     - https://github.com/chrisant996/dirx
rem
rem     If your terminal supports sixels, then you can set the environment
rem     variable CLINK_FZF_PREVIEW_SIXELS to make this fzf-preview.cmd script
rem     tell chafa to use sixels.  E.g.:
rem
rem         set CLINK_FZF_PREVIEW_SIXELS=1


rem -- Ignore empty filenames.
rem    For example if {2..} is used with only one field, such as when
rem    configured to use icons but a match has no icon.
if "%~1" == "" goto :end

rem -- Strip off description, and make sure the filename is quoted.  This works
rem    because fzf.lua inserts at least 4 spaces before each description.
set __ARG=%~1
set __DELIMITED=%__ARG:    =	%
rem                         ^embedded TAB character
for /f "tokens=1,2 delims=	" %%a in ("%__DELIMITED%") do set __ARG="%%a"
rem                       ^embedded TAB character

rem -- Make sure the filename is quoted.
if %__ARG% == "" goto :end

rem -- Display a directory.
rem --------------------------------------------------------------------------
if exist %__ARG%\* (
    echo [94mDirectory:[0m %__ARG%
    echo.
    dirx.exe /b /X:d /a:-s-h --bare-relative --level=3 --tree --icons=always --escape-codes=always --utf8 --ignore-glob=.git/** %__ARG%
    goto :end
)

rem -- Display a file.
rem --------------------------------------------------------------------------
echo [33mFile:[0m %__ARG%
echo.

rem -- Try to preview as an image.
rem    NOTE: Unfortunately chafa does not support the usual -- syntax to end flags.
if x%__ARG:~1,1% == x- goto :try_file
set __CHAFA_OPTS=
if not x%CLINK_FZF_PREVIEW_SIXELS% == x set __CHAFA_OPTS=-f sixels
2>nul chafa %__CHAFA_OPTS% %__ARG%
if not errorlevel 1 goto :end

rem -- Try to preview as a text file.
:try_file
bat --force-colorization --style=numbers,changes --line-range=:500 -- %__ARG%

:end
