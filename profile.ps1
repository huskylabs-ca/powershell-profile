### PowerShell template profile 
###
### This file should be stored in $PROFILE.CurrentUserAllHosts
### If $PROFILE.CurrentUserAllHosts doesn't exist, you can make one with the following:
###    PS> New-Item $PROFILE.CurrentUserAllHosts -ItemType File -Force
### This will create the file and the containing subdirectory if it doesn't already 
###
### As a reminder, to enable unsigned script execution of local scripts on client Windows, 
### you need to run this line (or similar) from an elevated PowerShell prompt:
###   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
### This is the default policy on Windows Server 2012 R2 and above for server Windows. For 
### more information about execution policies, run Get-Help about_Execution_Policies.

# Import Terminal Icons
Import-Module -Name Terminal-Icons

# Set Starship config file location
$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"

function edit-profile {
    notepad $profile.CurrentUserAllHosts
}

function goto {
    param (
        $location
    )

    Switch ($location) {
        "projects" {

            if ($env:GOTO_PROJECTS_PATH) {
                Set-Location -Path $ENV:GOTO_PROJECTS_PATH
            } else {
                echo "GOTO_PROJECTS_PATH environment variable is undefined."
            }
        }
        "documents" {
            Set-Location -Path "$HOME/documents"
        }
        "downloads" {
            Set-Location -Path "$HOME/downloads"
        }
        "desktop" {
            Set-Location -Path "$HOME/desktop"
        }
        "home" {
            Set-Location -Path "$HOME"
        }
        default {
            echo "Invalid location 2"
        }
    }
}

function ll { 
    Get-ChildItem -Path $pwd -File 
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function df {
    Get-Volume
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

if ()

# Initialize starship
Invoke-Expression (&starship init powershell)
