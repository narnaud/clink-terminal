@echo off
setlocal

rem   Copy a file to the clipboard (both as file drop and as text path).
rem   Paste in Explorer = paste the file. Paste in terminal = paste the path.
rem   Usage: cpclip <file> [<file2> ...]

if "%~1"=="" goto :usage

rem -- Build file list, validate all files exist
set "FILES="
set "PSFILES="
:argloop
if "%~1"=="" goto :docopy
if not exist "%~f1" (
    echo Error: File not found: %~f1
    goto :end
)
if defined FILES (
    set "FILES=%FILES%, %~f1"
    set "PSFILES=%PSFILES%; [void]$f.Add('%~f1')"
) else (
    set "FILES=%~f1"
    set "PSFILES=[void]$f.Add('%~f1')"
)
shift
goto :argloop

:docopy
powershell -NoProfile -Command ^
    "Add-Type -AssemblyName System.Windows.Forms;" ^
    "$d = New-Object System.Windows.Forms.DataObject;" ^
    "$f = New-Object System.Collections.Specialized.StringCollection;" ^
    "%PSFILES%;" ^
    "$d.SetFileDropList($f);" ^
    "$d.SetText(($f -join [Environment]::NewLine));" ^
    "[System.Windows.Forms.Clipboard]::SetDataObject($d, $true)"
goto :end

:usage
echo Usage: cpclip ^<file^> [^<file2^> ...]
echo   Paste in Explorer to paste the file(s).
echo   Paste in terminal to paste the path(s).

:end
endlocal
