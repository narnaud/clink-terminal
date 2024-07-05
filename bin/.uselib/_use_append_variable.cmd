:::============================================================================
::: Append a variable to another variable
::: Need to be an external script as we need delay extension
:::============================================================================
::: %1 variable name
::: %2 variable that we append

@echo off
setlocal enableDelayedExpansion 

echo !%1!,%2