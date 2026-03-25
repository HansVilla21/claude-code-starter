# Claude Code Starter Kit

Setup global de Claude Code con agentes, skills, comandos y seguridad preconfigurados.
Instálalo una vez y todos tus proyectos arrancan con estructura robusta desde el primer mensaje.

---

## ¿Qué incluye?

| Componente | Descripción |
|-----------|-------------|
| `~/.claude/CLAUDE.md` | Reglas globales que aplican a **todos** tus proyectos |
| `~/.claude/settings.json` | Hooks de seguridad automáticos |
| `~/.claude/commands/init-proyecto.md` | `/init-proyecto` — genera estructura completa en cualquier proyecto nuevo |
| `~/.claude/commands/commit.md` | `/commit` — commit inteligente con verificación de secretos |
| `~/.claude/commands/review.md` | `/review` — revisión de código con severidad |
| `~/.claude/commands/progress.md` | `/progress` — estado del proyecto |
| `~/.claude/commands/security-check.md` | `/security-check` — auditoría de seguridad |
| `~/.claude/commands/help.md` | `/help` — mapa completo del proyecto |
| `~/.claude/hooks/verify-no-secrets.py` | Hook que escanea secretos antes de cada commit |

---

## Instalación (una sola vez)

### Opción A — Prompt directo en Claude Code (recomendado para clase)

Abre Claude Code en **cualquier carpeta** y pega este prompt:

```
Clona el repositorio https://github.com/hansvilla/claude-code-starter en una carpeta temporal, ejecuta el script install.sh para configurar mi entorno global de Claude Code, y confirma qué archivos quedaron instalados en ~/.claude/
```

> Reemplaza `hansvilla` con el usuario de GitHub correcto si es necesario.

### Opción B — Terminal manual

```bash
# 1. Clonar el repo
git clone https://github.com/hansvilla/claude-code-starter ~/claude-code-starter-tmp

# 2. Correr el instalador
cd ~/claude-code-starter-tmp
bash install.sh

# 3. Limpiar
cd ~
rm -rf ~/claude-code-starter-tmp
```

### Opción C — Windows (PowerShell)

```powershell
git clone https://github.com/hansvilla/claude-code-starter $env:TEMP\claude-starter
Set-Location $env:TEMP\claude-starter
.\install.ps1
```

---

## Primer uso después de instalar

Abre Claude Code en cualquier proyecto nuevo y escribe:

```
/init-proyecto
```

Claude te preguntará el nombre, propósito y tipo de proyecto, y generará toda la estructura automáticamente.

---

## Tipos de proyecto soportados por `/init-proyecto`

| Tipo | Qué genera |
|------|-----------|
| `agentes` | Sistema multi-agente con orquestador, memoria, skills, templates |
| `software` | App/API/script con agente code-reviewer, tests, docs |
| `contenido` | Marketing/RRSS con memoria de marca, audiencia, contenido ganador |
| `generico` | Estructura mínima funcional para cualquier proyecto |

---

## Comandos disponibles (globales, funcionan en cualquier proyecto)

```
/init-proyecto   → Inicializa cualquier proyecto nuevo con estructura completa
/commit          → Commit inteligente con verificación de secretos
/review          → Revisión del trabajo actual con severidad (🔴🟡🔵)
/progress        → Estado del proyecto: hecho, en progreso, pendiente
/security-check  → Auditoría completa de seguridad
/help            → Mapa completo del proyecto actual
```

---

## Requisitos

- [Claude Code](https://claude.ai/claude-code) instalado
- Git instalado
- Python 3 (para el hook de seguridad)

---

## Estructura del repo

```
claude-code-starter/
├── README.md
├── install.sh          ← Instalador para Mac/Linux/Git Bash (Windows)
├── install.ps1         ← Instalador para Windows PowerShell
└── global/             ← Archivos que van a ~/.claude/
    ├── CLAUDE.md
    ├── settings.json
    ├── commands/
    │   ├── init-proyecto.md
    │   ├── commit.md
    │   ├── review.md
    │   ├── progress.md
    │   ├── security-check.md
    │   └── help.md
    └── hooks/
        └── verify-no-secrets.py
```

---

## Créditos

Desarrollado por [Hans Villalobos](https://instagram.com/hansvilla.ai) para Momentum AI Academy.
