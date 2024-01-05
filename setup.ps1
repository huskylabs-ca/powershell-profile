#If the file does not exist, create it.
if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts -PathType Leaf)) {
    try {
        # Detect Version of Powershell & Create Profile directories if they do not exist.
        if ($PSVersionTable.PSEdition -eq "Core" ) { 
            if (!(Test-Path -Path ($env:userprofile + "\Documents\Powershell"))) {
                New-Item -Path ($env:userprofile + "\Documents\Powershell") -ItemType "directory"
            }
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            if (!(Test-Path -Path ($env:userprofile + "\Documents\WindowsPowerShell"))) {
                New-Item -Path ($env:userprofile + "\Documents\WindowsPowerShell") -ItemType "directory"
            }
        }

        Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts
        Write-Host "Installing PowerShell profile @ [$($PROFILE.CurrentUserAllHosts)]."
    }
    catch {
        throw $_.Exception.Message
    }
}
else {
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts
    Write-Host "Updating PowerShell profile  @ [$($PROFILE.CurrentUserAllHosts)] has been updated."
}

Write-Host "Installing Starship Terminal..."
winget install -e --accept-source-agreements --accept-package-agreements --id Starship.Starship

Write-Host "Installing Terminal Icons..."
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
