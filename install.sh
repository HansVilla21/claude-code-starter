#!/usr/bin/env bash
# =====================================================================
# Claude Code Starter Kit v2 — instalador para Mac, Linux y Git Bash
# Copia las instrucciones globales y las skills a ~/.claude
# Respalda lo que reemplaza en ~/.claude/backups/starter-kit-<fecha>
# Uso: bash install.sh
# =====================================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$REPO_DIR/global"
CLAUDE_DIR="$HOME/.claude"
STAMP="$(date +%Y-%m-%d_%H%M%S)"
BACKUP_DIR="$CLAUDE_DIR/backups/starter-kit-$STAMP-$$"

if [ ! -f "$GLOBAL_DIR/CLAUDE.md" ]; then
  echo "Error: no encontré la carpeta global junto al instalador ($REPO_DIR)."
  exit 1
fi

echo
echo "Claude Code Starter Kit v2 — instalación"
echo

mkdir -p "$CLAUDE_DIR/skills"
installed=()
backed=()

# Respalda $1 en el respaldo como $2. Devuelve 0 si había algo que respaldar.
backup() {
  if [ -e "$1" ]; then
    mkdir -p "$(dirname "$BACKUP_DIR/$2")"
    cp -R "$1" "$BACKUP_DIR/$2"
    backed+=("$2")
    return 0
  fi
  return 1
}

# 1. Instrucciones globales
backup "$CLAUDE_DIR/CLAUDE.md" "CLAUDE.md" || true
cp "$GLOBAL_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
installed+=("CLAUDE.md")

# 2. Skills
for skill in "$GLOBAL_DIR"/skills/*/; do
  skill="${skill%/}"
  name="$(basename "$skill")"
  dst="$CLAUDE_DIR/skills/$name"
  if backup "$dst" "skills/$name"; then rm -rf "$dst"; fi
  cp -R "$skill" "$dst"
  installed+=("skills/$name")
done

# 3. Los comandos de la v1 que ahora son skills se mueven al respaldo, para que no queden repetidos
for name in init-proyecto commit review progress security-check; do
  old="$CLAUDE_DIR/commands/$name.md"
  if backup "$old" "commands/$name.md"; then rm -f "$old"; fi
done

echo "Instalado en $CLAUDE_DIR:"
for i in "${installed[@]}"; do echo "  + $i"; done
if [ ${#backed[@]} -gt 0 ]; then
  echo
  echo "Lo que había antes quedó respaldado en $BACKUP_DIR:"
  for b in "${backed[@]}"; do echo "  - $b"; done
fi
echo
echo "Listo. Abrí Claude Code en una carpeta y decile: «Creemos un proyecto para …»"
echo
