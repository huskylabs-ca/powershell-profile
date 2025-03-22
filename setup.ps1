# Create Powershell profile config file
Write-Host "Checking PowerShell configuration..."
if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts -PathType Leaf)) {
    try {

        # Detect Version of Powershell & Create Profile directories if they do not exist.
        if ($PSVersionTable.PSEdition -eq "Core" ) { 

            $path = $env:userprofile + "\Documents\Powershell"

            if (!(Test-Path -Path $path)) {
                Write-Host "Creating directory for PowerShell Core profile: [$($path)]"
                New-Item -Path $path -ItemType "directory"
            }
        }
        elseif ($PSVersionTable.PSEdition -eq "Desktop") {
            
            $path = $env:userprofile + "\Documents\WindowsPowerShell"

            if (!(Test-Path -Path $path)) {
                Write-Host "Creating directory for WindowsPowerShell profile: [$($path)]"
                New-Item -Path $path -ItemType "directory"
            }
        }

        Write-Host "Installing PowerShell profile: [$($PROFILE.CurrentUserAllHosts)]."
        Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Write-Host "Updating PowerShell profile: [$($PROFILE.CurrentUserAllHosts)]."
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/profile.ps1 -OutFile $PROFILE.CurrentUserAllHosts    
}

# Updates starship to the latest version
Write-Host "Installing Starship Terminal..."
winget install -e --accept-source-agreements --accept-package-agreements --id Starship.Starship

# Create Starship config directory, file and environment variable.
# Updates the config if the file already exists.
Write-Host "Checking Starship configuration..."
if (-not $ENV:STARSHIP_CONFIG -or !(Test-Path -Path $ENV:STARSHIP_CONFIG -PathType Leaf)) {
    try {
        $path = "$HOME\.starship\"
        $configFile = $path + "starship.toml"

        if (!(Test-Path -Path $path)) {
            Write-Host "Creating directory for starship configuration: [$($path)]"
            New-Item -Path $path -ItemType "directory"
        }

        Write-Host "Exporting STARSHIP_CONFIG environment variable with value [$($ENV:STARSHIP_CONFIG)]"
        [Environment]::SetEnvironmentVariable('STARSHIP_CONFIG', $configFile, 'User')

        Write-Host "Installing Starship profile: [$($ENV:STARSHIP_CONFIG)]."
        Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $ENV:STARSHIP_CONFIG
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Write-Host "Updating Starship profile: [$($PROFILE.CurrentUserAllHosts)]."
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $ENV:STARSHIP_CONFIG
}

# Updates terminal icons to the latest version
Write-Host "Installing Terminal Icons..."
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

if (-not $ENV:GOTO_PROJECTS_PATH) {
    Write-Host "Exporting GOTO_PROJECTS_PATH environment variable with value [$($ENV:GOTO_PROJECTS_PATH)]"
    [Environment]::SetEnvironmentVariable('GOTO_PROJECTS_PATH', '"$HOME\Projects\"', 'User')
    Write-Host "Override the GOTO_PROJECTS_PATH environment variable value if the path is different than the default value [$(ENV:GOTO_PROJECTS_PATH)]."
}
