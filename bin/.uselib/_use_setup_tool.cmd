:::============================================================================
::: Setup one tool
:::============================================================================
::: %1 tool name
::: %2 tool json file

@echo off

::: Follow the go directory, but only for the first tool set
:::============================================================================
if "%__USE_TOOLS:~2,-2%"=="%1" (
    for /f "delims=" %%a in ('jq -r ".[""%1""].go" %2') do (
        if "%%a" NEQ "null" (
            cd %%a
        )
    )
)

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
    call %~dp0_use_append_variable.cmd __USE_TOOLS ""%%a""
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
    if "%%a" NEQ "" (
        set "%%a"
    )
)

::: Prepend variables
:::============================================================================
for /f "delims=" %%a in ('%~dp0\_use_do_prepend.cmd %1 %2') do (
    if "%%a" NEQ "" (
        set "%%a"
    )
)

::: Prepend to the PATH variable
:::============================================================================
for /f "delims=" %%a in ('%~dp0\_use_set_path.cmd %1 %2') do (
    set "PATH=%%a"
)

::: Call all deferred scripts
:::============================================================================
for /f "delims=" %%a in ('jq -r ".[""%1""].defer[]?" %2') do (
    if "%%a" NEQ "" (
        ::: Only call a script if it has not been called before
        echo.%__USE_DEFER_SCRIPTS% | findstr /C:"%%a" >NUL
        if errorlevel 1 (
            call %~dp0_use_append_variable.cmd __USE_DEFER_SCRIPTS "%%a"
            call "%%a" >NUL
        )
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
