# ============================================================
# Claude Code Starter Kit — Instalador (Windows PowerShell)
# Copia los archivos globales a ~/.claude/
# ============================================================

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = Join-Path $RepoDir "global"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host ""
Write-Host "============================================" -ForegroundColor Blue
Write-Host "  Claude Code Starter Kit — Instalación" -ForegroundColor Blue
Write-Host "============================================" -ForegroundColor Blue
Write-Host ""

# Verificar que existe la carpeta global/
if (-not (Test-Path $GlobalDir)) {
    Write-Host "Error: No se encontró la carpeta global/ en $RepoDir" -ForegroundColor Red
    exit 1
}

# Crear ~/.claude/ y subcarpetas si no existen
$null = New-Item -ItemType Directory -Path $ClaudeDir -Force
$null = New-Item -ItemType Directory -Path (Join-Path $ClaudeDir "commands") -Force
$null = New-Item -ItemType Directory -Path (Join-Path $ClaudeDir "hooks") -Force

Write-Host "Instalando archivos..." -ForegroundColor Yellow
Write-Host ""

$installed = @()

function Install-File {
    param($Src, $Dst, $Label)

    if (Test-Path $Dst) {
        Copy-Item $Dst "${Dst}.backup" -Force
        Copy-Item $Src $Dst -Force
        $script:installed += "$Label (backup guardado)"
    } else {
        Copy-Item $Src $Dst -Force
        $script:installed += $Label
    }
}

# CLAUDE.md global
$src = Join-Path $GlobalDir "CLAUDE.md"
if (Test-Path $src) {
    Install-File $src (Join-Path $ClaudeDir "CLAUDE.md") "CLAUDE.md"
}

# settings.json
$src = Join-Path $GlobalDir "settings.json"
if (Test-Path $src) {
    $dst = Join-Path $ClaudeDir "settings.json"
    if (Test-Path $dst) {
        Copy-Item $dst "${dst}.backup" -Force
        Write-Host "  ⚠ settings.json ya existe. Backup guardado en settings.json.backup" -ForegroundColor Yellow
        Write-Host "    Revisa y fusiona manualmente si tienes configuración personalizada." -ForegroundColor Yellow
    }
    Copy-Item $src $dst -Force
    $installed += "settings.json"
}

# Comandos
$cmdFiles = Get-ChildItem -Path (Join-Path $GlobalDir "commands") -Filter "*.md" -ErrorAction SilentlyContinue
foreach ($file in $cmdFiles) {
    $dst = Join-Path $ClaudeDir "commands" $file.Name
    Install-File $file.FullName $dst "commands/$($file.Name)"
}

# Hooks
$hookFiles = Get-ChildItem -Path (Join-Path $GlobalDir "hooks") -ErrorAction SilentlyContinue
foreach ($file in $hookFiles) {
    $dst = Join-Path $ClaudeDir "hooks" $file.Name
    Install-File $file.FullName $dst "hooks/$($file.Name)"
}

# Resultado
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Instalación completada" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Archivos instalados en ~/.claude/:" -ForegroundColor Green
foreach ($item in $installed) {
    Write-Host "  ✓ $item" -ForegroundColor Green
}

Write-Host ""
Write-Host "Próximos pasos:" -ForegroundColor Blue
Write-Host "  1. Abre Claude Code en cualquier carpeta de proyecto"
Write-Host "  2. Escribe: /init-proyecto"
Write-Host "  3. Sigue las instrucciones para generar la estructura completa"
Write-Host ""
Write-Host "Comandos disponibles globalmente:" -ForegroundColor Blue
Write-Host "  /init-proyecto   -> Inicializa un proyecto nuevo"
Write-Host "  /commit          -> Commit inteligente"
Write-Host "  /review          -> Revisión de código"
Write-Host "  /progress        -> Estado del proyecto"
Write-Host "  /security-check  -> Auditoría de seguridad"
Write-Host "  /help            -> Mapa completo del proyecto"
Write-Host ""
