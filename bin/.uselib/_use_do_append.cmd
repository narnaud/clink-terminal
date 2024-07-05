:::============================================================================
::: Parse the append lines
::: Need to be an external script as we need delay extension
:::============================================================================
::: %1 tool name
::: %2 tool json file

@echo off
setlocal enableDelayedExpansion

for /f "tokens=1,2 delims==" %%a in ('jq -r ".[""%1""].append | try to_entries[] | join(""="")" %2') do (
    if "%%a%" NEQ "" (
        ::: Only append a var if it has not been set before
        if "!%%a!"=="" (
            echo %%a=%%b
        ) else if "!%%a:%%b=!" == "!%%a" (
            echo %%a=!%%a!;%%b
        )
    )
)
