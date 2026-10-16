# =====================================================================
# Claude Code Starter Kit v2 - instalador para Windows (PowerShell)
# Copia las instrucciones globales y las skills a %USERPROFILE%\.claude
# Respalda lo que reemplaza en .claude\backups\starter-kit-<fecha>
# Uso: powershell -ExecutionPolicy Bypass -File .\install.ps1
# =====================================================================

$ErrorActionPreference = "Stop"

$RepoDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = Join-Path $RepoDir "global"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$Stamp     = Get-Date -Format "yyyy-MM-dd_HHmmss"
$BackupDir = Join-Path (Join-Path $ClaudeDir "backups") ("starter-kit-" + $Stamp + "-" + $PID)

if (-not (Test-Path (Join-Path $GlobalDir "CLAUDE.md"))) {
    Write-Host "Error: no encontre la carpeta global junto al instalador ($RepoDir)." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Claude Code Starter Kit v2 - instalacion" -ForegroundColor Cyan
Write-Host ""

$null = New-Item -ItemType Directory -Force -Path $ClaudeDir
$null = New-Item -ItemType Directory -Force -Path (Join-Path $ClaudeDir "skills")

$installed = New-Object System.Collections.Generic.List[string]
$backedUp  = New-Object System.Collections.Generic.List[string]

function Save-Backup([string]$Path, [string]$Relative) {
    if (Test-Path $Path) {
        $dest = Join-Path $BackupDir $Relative
        $null = New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest)
        Copy-Item -Path $Path -Destination $dest -Recurse -Force
        $backedUp.Add($Relative)
        return $true
    }
    return $false
}

# 1. Instrucciones globales
$dst = Join-Path $ClaudeDir "CLAUDE.md"
$null = Save-Backup $dst "CLAUDE.md"
Copy-Item -Path (Join-Path $GlobalDir "CLAUDE.md") -Destination $dst -Force
$installed.Add("CLAUDE.md")

# 2. Skills
foreach ($skill in Get-ChildItem -Path (Join-Path $GlobalDir "skills") -Directory) {
    $dst = Join-Path (Join-Path $ClaudeDir "skills") $skill.Name
    if (Save-Backup $dst ("skills\" + $skill.Name)) { Remove-Item -Path $dst -Recurse -Force }
    Copy-Item -Path $skill.FullName -Destination $dst -Recurse -Force
    $installed.Add("skills\" + $skill.Name)
}

# 3. Los comandos de la v1 que ahora son skills se mueven al respaldo, para que no queden repetidos
$commandsDir = Join-Path $ClaudeDir "commands"
foreach ($name in @("init-proyecto", "commit", "review", "progress", "security-check")) {
    $old = Join-Path $commandsDir ($name + ".md")
    if (Save-Backup $old ("commands\" + $name + ".md")) { Remove-Item -Path $old -Force }
}

Write-Host ("Instalado en " + $ClaudeDir + ":") -ForegroundColor Green
foreach ($i in $installed) { Write-Host ("  + " + $i) -ForegroundColor Green }
if ($backedUp.Count -gt 0) {
    Write-Host ""
    Write-Host ("Lo que habia antes quedo respaldado en " + $BackupDir + ":") -ForegroundColor Yellow
    foreach ($b in $backedUp) { Write-Host ("  - " + $b) -ForegroundColor Yellow }
}
Write-Host ""
Write-Host "Listo. Abri Claude Code en una carpeta y decile: 'Creemos un proyecto para ...'" -ForegroundColor Cyan
Write-Host ""
