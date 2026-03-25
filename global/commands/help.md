---
description: Muestra todos los comandos disponibles, agentes activos y skills del proyecto actual
---

Muestra un mapa completo de todo lo disponible en este proyecto.

## Proceso

### 1. Comandos globales (siempre disponibles)

Lista estos comandos que están instalados globalmente:

| Comando | Descripción |
|---------|-------------|
| `/init-proyecto` | Inicializa un proyecto nuevo con estructura completa |
| `/review` | Revisa el trabajo actual con severidad (🔴🟡🔵) |
| `/commit` | Commit inteligente con verificación de secretos |
| `/progress` | Estado del proyecto: hecho, en progreso, pendiente |
| `/security-check` | Auditoría de seguridad completa |
| `/help` | Este menú |

### 2. Comandos del proyecto (si existen)

Busca archivos `.md` en `.claude/commands/` del directorio actual y lista los comandos específicos del proyecto.

### 3. Agentes disponibles (si existen)

Busca archivos `.md` en `.claude/agents/` y lista los agentes con su descripción.
Si también existe `agents/*/CLAUDE.md`, lista esos agentes también.

### 4. Skills disponibles (si existen)

Busca carpetas en `.agent/skills/` o `.claude/skills/` y lista las skills con su propósito.

### 5. Memoria del proyecto (si existe)

Si hay carpeta `memory/`, lista los archivos que contiene.

## Formato del Output

---
## 🗺️ Mapa del Proyecto — [Nombre]

### ⌨️ Comandos Disponibles

**Globales:**
[tabla de comandos globales]

**De este proyecto:**
[comandos específicos del proyecto, o "ninguno configurado"]

### 🤖 Agentes

[lista de agentes con descripción, o "ninguno configurado — usa /init-proyecto para crear uno"]

### 🛠️ Skills

[lista de skills, o "ninguna configurada"]

### 🧠 Memoria

[archivos en memory/, o "sin memoria configurada"]

---
**Tip:** Para empezar un proyecto desde cero, usa `/init-proyecto`
---
