:::============================================================================
::: Setup one tool
:::============================================================================
::: %1 tool name
::: %2 tool json file

@echo off


::: Check that the tool exist
:::============================================================================
for /f "delims=" %%a in ('jq "has(""%1"")" %2') do (
    if "%%a"=="false" (
        echo The tool '%1' does not exist, please check your configuration file:
        echo   %2
        goto end
    )
)

::: Setup sub-tools
:::============================================================================
for /f "delims=" %%a in ('jq -r "((.[""%1""].use // []) - [%__USE_TOOLS%])[]?" %2') do (
    for /f "delims=" %%v in ('%~dp0_use_append_variable.cmd __USE_TOOLS ""%%a""') do (
        set __USE_TOOLS=%%v
    )
    if "%%a" NEQ "" (
        call %~dp0\_use_setup_tool.cmd %%a %2
    )
)

::: Set the different environment variables
:::============================================================================
for /f "delims=" %%a in ('jq -r ".[""%1""].set | try to_entries[] | join(""="")" %2') do (
    if "%%a" NEQ "" (
        set "%%a"
    )
)

::: Append variables
:::============================================================================
for /f "delims=" %%a in ('%~dp0\_use_do_append.cmd %1 %2') do (
    if "%%a%" NEQ "" (
        set "%%a"
    )
)

::: Call all deferred scripts
:::============================================================================
for /f "delims=" %%a in ('jq -r ".[""%1""].defer[]?" %2') do (
    if "%%a" NEQ "" (
        call "%%a" >NUL
    )
)

::: Display configuration message
:::============================================================================
for /f "delims=" %%a in ('jq -r ".[""%1""].display" %2') do (
    if "%%a"=="null" (
        echo Configuring %1 environment.
        TITLE %1
    ) else (
        echo Configuring %%a environment.
        TITLE %%a
    )
)

:end