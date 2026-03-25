#!/usr/bin/env bash
# ============================================================
# Claude Code Starter Kit — Instalador
# Copia los archivos globales a ~/.claude/
# Compatible con: Mac, Linux, Windows (Git Bash)
# ============================================================

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$REPO_DIR/global"
CLAUDE_DIR="$HOME/.claude"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Claude Code Starter Kit — Instalación${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Verificar que existe la carpeta global/
if [ ! -d "$GLOBAL_DIR" ]; then
    echo -e "${RED}Error: No se encontró la carpeta global/ en $REPO_DIR${NC}"
    exit 1
fi

# Crear ~/.claude/ si no existe
if [ ! -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_DIR"
    echo -e "${GREEN}✓ Carpeta ~/.claude/ creada${NC}"
fi

# Crear subcarpetas necesarias
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/hooks"

echo -e "${YELLOW}Instalando archivos...${NC}"
echo ""

INSTALLED=()
SKIPPED=()

install_file() {
    local src="$1"
    local dst="$2"
    local label="$3"

    if [ -f "$dst" ]; then
        # Archivo existe — hacer backup y sobreescribir
        cp "$dst" "${dst}.backup" 2>/dev/null || true
        cp "$src" "$dst"
        INSTALLED+=("$label (backup guardado como ${label}.backup)")
    else
        cp "$src" "$dst"
        INSTALLED+=("$label")
    fi
}

# CLAUDE.md global
if [ -f "$GLOBAL_DIR/CLAUDE.md" ]; then
    install_file "$GLOBAL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md"
fi

# settings.json — merge inteligente si ya existe
if [ -f "$GLOBAL_DIR/settings.json" ]; then
    if [ -f "$CLAUDE_DIR/settings.json" ]; then
        cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup"
        echo -e "  ${YELLOW}⚠ settings.json ya existe. Se hizo backup en settings.json.backup${NC}"
        echo -e "  ${YELLOW}  Revisa y fusiona manualmente si tienes configuración personalizada.${NC}"
        cp "$GLOBAL_DIR/settings.json" "$CLAUDE_DIR/settings.json"
        INSTALLED+=("settings.json (backup guardado)")
    else
        cp "$GLOBAL_DIR/settings.json" "$CLAUDE_DIR/settings.json"
        INSTALLED+=("settings.json")
    fi
fi

# Comandos
for cmd_file in "$GLOBAL_DIR/commands/"*.md; do
    if [ -f "$cmd_file" ]; then
        filename=$(basename "$cmd_file")
        install_file "$cmd_file" "$CLAUDE_DIR/commands/$filename" "commands/$filename"
    fi
done

# Hooks
for hook_file in "$GLOBAL_DIR/hooks/"*; do
    if [ -f "$hook_file" ]; then
        filename=$(basename "$hook_file")
        install_file "$hook_file" "$CLAUDE_DIR/hooks/$filename" "hooks/$filename"
        # Dar permisos de ejecución en Mac/Linux
        chmod +x "$CLAUDE_DIR/hooks/$filename" 2>/dev/null || true
    fi
done

# Resultado
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Instalación completada${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo -e "${GREEN}Archivos instalados en ~/.claude/:${NC}"
for item in "${INSTALLED[@]}"; do
    echo -e "  ${GREEN}✓${NC} $item"
done

echo ""
echo -e "${BLUE}Próximos pasos:${NC}"
echo "  1. Abre Claude Code en cualquier carpeta de proyecto"
echo "  2. Escribe: /init-proyecto"
echo "  3. Sigue las instrucciones para generar la estructura completa"
echo ""
echo -e "${BLUE}Comandos disponibles globalmente:${NC}"
echo "  /init-proyecto   → Inicializa un proyecto nuevo"
echo "  /commit          → Commit inteligente"
echo "  /review          → Revisión de código"
echo "  /progress        → Estado del proyecto"
echo "  /security-check  → Auditoría de seguridad"
echo "  /help            → Mapa completo del proyecto"
echo ""
