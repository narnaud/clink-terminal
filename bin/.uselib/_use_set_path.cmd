:::============================================================================
::: Parse the path lines
::: Need to be an external script as we need delay extension
:::============================================================================
::: %1 tool name
::: %2 tool json file

@echo off
setlocal enableDelayedExpansion

for /f "delims==" %%a in ('jq -r ".[""%1""].path[]?" %2') do (
    if "%%a%" NEQ "" (
            set "PATH=%%a;%PATH%"
        )
    )
)
echo %PATH%
