@echo off

::: Note: we can't use setlocal as we want to change the env variables

set "__USE_ENV_FILE=%USERPROFILE%\.useconfig.json"

:::============================================================================
::: Parse command line arguments
:::============================================================================

if /i "%1"=="--list" (
	goto list
)
if /i "%1"=="-l" (
	goto list
)
if /i "%1"=="-h" (
    goto help
)
if /i "%1"=="--help" (
    goto help
)

set USE_PROMPT=%*

:parse
if "%~1"=="" (
    goto end
)

:::============================================================================
::: Setup one tool
::: Keep the defer scripts ran to avoid re-running them
:::============================================================================
set __USE_ENV=""%1""
set __USE_DEFER_SCRIPT=
call %~dp0.uselib\_use_setup_tool.cmd %1 %__USE_ENV_FILE%
shift /1
goto parse

:::============================================================================
:list
::: Show the list of envs
:::============================================================================
jq -r keys[] %__USE_ENV_FILE%
goto end


:::============================================================================
:help
::: Display an help for the command
:::============================================================================
echo use - commandline utility to setup environment
echo.
echo Usage:  use env [env2...]
echo.
echo   -h --help      Display this help text.
echo   -l --list      Display the list of known environments.
goto end

:end
set __USE_ENV=
