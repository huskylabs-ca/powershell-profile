# Installation steps to personnalize a Windows Powershell Terminal
This customization improves the usability of the windows powershell Terminal with these different features :
- Uses the Starship Terminal.
- Uses Terminal Icons for folder and file types.
- Customizes the Windows Terminal theme and profiles.
- Adds the goto command to navigate to different directories defined in environment variables.

## Install Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

## Install Starship Terminal
winget install --id starship.starship  -e --accept-source-agreements --accept-package-agreements

## Install Nerd Fonts
Current terminal profile uses FireCode Nerd Font. You can modify the terminal profile to use a different font. Download the fonts here: https://www.nerdfonts.com/font-downloads.
