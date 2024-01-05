# Installation steps to personnalize a Windows Powershell Terminal
This customization improves the usability of the windows powershell Terminal with these different features :
- Uses the Starship Terminal.
- Uses Terminal Icons for folder and file types.
- Customizes the Windows Terminal theme and profiles.
- Adds the goto command to navigate to different directories defined in environment variables.

## Install Nerd Fonts
Current terminal profile uses FireCode Nerd Font. You can modify the terminal profile to use a different font. Download the fonts here: https://www.nerdfonts.com/font-downloads.

## Run setup.ps1 in a PowerShell terminal.
```pwsh
```Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/setup.ps1 | Invoke-Expression
```
