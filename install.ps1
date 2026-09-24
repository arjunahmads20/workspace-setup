# Requires: Run as Administrator

$ErrorActionPreference = "Continue"

Write-Host "================================="
Write-Host " Workstation Setup"
Write-Host "================================="
Write-Host ""

# Check Winget
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed."
    Write-Host "Please update App Installer from Microsoft Store."
    exit 1
}

$apps = @(

    # Browser
    "Google.Chrome"

    # Development
    "Git.Git"
    "Python.Python.3.13"
    "Microsoft.OpenJDK.21"
    "Microsoft.VisualStudioCode"
    "Docker.DockerDesktop" 

    # Utilities
    "7zip.7zip"

)

foreach ($app in $apps) {

    Write-Host ""
    Write-Host "Installing $app ..."

    winget install `
        --id $app `
        --exact `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements

}

Write-Host ""
Write-Host "================================="
Write-Host " Installation Finished"
Write-Host "================================="
