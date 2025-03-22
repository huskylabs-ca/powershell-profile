
# Create Powershell profile config file
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
} else {
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts
    Write-Host "Updating PowerShell profile  @ [$($PROFILE.CurrentUserAllHosts)]."
}

# Create Starship config file
if (-not $env:STARSHIP_CONFIG -or !(Test-Path -Path $ENV:STARSHIP_CONFIG -PathType Leaf)) {
    try {
        if (!(Test-Path -Path "$HOME\.starship\")) {
            New-Item -Path "$HOME\.starship\" -ItemType "directory"
        }

        $ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
        Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $ENV:STARSHIP_CONFIG
        Write-Host "Installing Starship profile @ [$($ENV:STARSHIP_CONFIG)]."
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $ENV:STARSHIP_CONFIG
    Write-Host "Updating Starship profile  @ [$($PROFILE.CurrentUserAllHosts)]."
}

Write-Host "Installing Starship Terminal..."
winget install -e --accept-source-agreements --accept-package-agreements --id Starship.Starship

Write-Host "Installing Terminal Icons..."
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

if (-not $ENV:GOTO_PROJECTS_PATH) {
    Write-Warning "Goto function path environment variable for projects is missing. Please define `$ENV:GOTO_PROJECTS_PATH in an elevated powershell prompt using the following expression `n -> [System.Environment]::SetEnvironmentVariable('GOTO_PROJECTS_PATH','$HOME\Projects', 'User') `n Replace the path if necessary."
}
