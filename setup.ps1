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
winget install -e --accept-source-agreements --accept-package-agreements --ignore-warnings --silent --id Starship.Starship

# Create Starship config directory, file and environment variable.
# Updates the config if the file already exists.
Write-Host "Checking Starship configuration..."

$starshipPath = "$HOME\.starship\"
$starshipConfigFile = $path + "starship.toml"

if (!(Test-Path -Path $starshipPath -PathType Leaf)) {
    try {
        if (!(Test-Path -Path $starshipPath)) {
            Write-Host "Creating directory for starship configuration: [$($starshipPath)]"
            New-Item -Path $starshipPath -ItemType "directory"
        }

        Write-Host "Installing Starship profile: [$($starshipConfigFile)]."
        Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $starshipConfigFile
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Write-Host "Updating Starship profile: [$($PROFILE.CurrentUserAllHosts)]."
    Invoke-RestMethod https://raw.githubusercontent.com/huskylabs-ca/powershell-profile/main/.starship/starship.toml -OutFile $starshipConfigFile
}

# Updates terminal icons to the latest version
Write-Host "Installing Terminal Icons..."
Install-Module -Name Terminal-Icons -Repository PSGallery -Force | Out-Null
