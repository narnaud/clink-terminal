# Clink Setup

## Installation

To install clink, the easiest way is to use [scoop](https://scoop.sh/). Open a powershell terminal, and type:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Then you can install clink and some of the extensions:
```
scoop install clink clink-completions
```

## Intergration in Terminal

To integrate clink in the Terminal application:
- open the Terminal
- go to the settings
- pick the `Command Prompt` settings
- change the command line to `%SystemRoot%\System32\cmd.exe /K PATH_TO_CLINK\start_clink.bat`

![](assets/terminal.png)

