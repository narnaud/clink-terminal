:::============================================================================
::: Append a variable to another variable
::: Need to be an external script as we need delay extension
:::============================================================================
::: %1 variable name
::: %2 variable that we append

@echo off
setlocal enableDelayedExpansion

::: Set a variable, and use the endlocal & trick to get the value out of the local block
set __USE_TEMP_APPEND_VAR=!%1!,%2
endlocal & set "%1=%__USE_TEMP_APPEND_VAR%"

set __USE_TEMP_APPEND_VAR=
