---
description: Inicializa cualquier proyecto nuevo con estructura robusta de agentes, memoria, skills y configuración completa
argument-hint: tipo de proyecto — agentes | software | contenido | generico
---

Eres el inicializador de proyectos. Tu misión es crear una estructura completa, robusta y lista para trabajar.

## Paso 1: Leer el contexto actual

Usa Glob para ver qué archivos existen ya en el directorio. Luego determina si el usuario especificó un tipo de proyecto como argumento. Si no, pregunta:

---
**Para inicializar este proyecto necesito 3 datos:**

1. **Nombre del proyecto** (si el nombre de la carpeta no es claro)
2. **Propósito** — ¿Qué va a hacer este proyecto? (1-2 oraciones)
3. **Tipo:**
   - `agentes` — Sistema de agentes de IA con roles especializados (como un equipo virtual)
   - `software` — Aplicación web, API, script, herramienta
   - `contenido` — Marketing, redes sociales, creación de contenido
   - `generico` — Cualquier otro tipo de proyecto

---

Espera la respuesta antes de continuar.

## Paso 2: Crear archivos base (aplica a TODOS los tipos)

Una vez que tienes el nombre, propósito y tipo, crea estos archivos:

### `.gitignore`
```
# Secretos — NUNCA en git
.env
.env.*
!.env.example

# Claude Code
CLAUDE.local.md
.mdd/

# Sistema
.DS_Store
Thumbs.db

# Python
__pycache__/
*.pyc
*.pyo
.venv/
venv/

# Node
node_modules/
dist/
.next/
build/

# IDEs
.vscode/settings.json
.idea/
```

### `.env.example`
Genera este archivo con las variables relevantes para el tipo de proyecto. Para todos incluye como mínimo:
```
# ============================================
# [NOMBRE DEL PROYECTO] — Variables de Entorno
# ============================================
# Copia este archivo a .env y llena los valores reales
# NUNCA subas .env a git

# Anthropic
ANTHROPIC_API_KEY=sk-ant-...

# Agrega aquí las variables específicas de tu proyecto
```

Para proyectos tipo `agentes`, agrega también:
```
# Perplexity (para búsquedas en tiempo real)
PERPLEXITY_API_KEY=pplx-...

# Google Gemini (para imágenes y análisis visual)
GEMINI_API_KEY=AIza...
```

## Paso 3: Crear CLAUDE.md del proyecto

Genera un `CLAUDE.md` personalizado con estas secciones, adaptadas al tipo de proyecto:

```markdown
# [Nombre del Proyecto]

## Qué es este proyecto
[Descripción clara del propósito en 2-3 oraciones]

## El Negocio / Contexto
[Quién lo usa, para qué, cuál es el objetivo]

## [Si es tipo agentes: Los Agentes / Si es software: La Arquitectura]
[Estructura principal del proyecto]

## Cómo Trabajamos
- Qué ejecutar directamente sin preguntar
- Qué requiere confirmación del usuario

## Convenciones
- Idioma del proyecto
- Formato de outputs
- Estructura de carpetas

## Reglas Específicas del Proyecto
[Reglas que aplican solo a este proyecto]

## Estructura del Proyecto
[Árbol de carpetas con descripción de cada una]
```

## Paso 4: Crear estructura de carpetas y archivos por tipo

### Si tipo = `agentes`

Crea esta estructura completa:

**Carpetas:**
- `agents/` — Un subfolder por agente, cada uno con su `CLAUDE.md`
- `memory/` — Cerebro compartido de todos los agentes
- `.agent/skills/` — Skills reutilizables
- `inputs/` — Material de entrada (ideas, datos, referencias)
- `outputs/` — Resultados organizados por tipo
- `templates/` — Moldes para outputs recurrentes

**Archivos en `memory/`:**

`memory/proyecto.md` — Contexto del proyecto (nombre, propósito, estado)
`memory/brand-voice.md` — Tono, estilo, frases clave (si aplica)
`memory/learnings.md` — Aprendizajes acumulados (empieza vacío)
`memory/decisions.md` — Decisiones importantes tomadas y por qué

**Agentes base en `.claude/agents/`** (formato nativo de Claude Code):

Crea un archivo `.claude/agents/orquestador.md`:
```markdown
---
name: orquestador
description: Punto de entrada principal. Lee el contexto, delega a agentes especializados, consolida resultados. Úsalo para cualquier tarea de alto nivel.
---

Eres el agente orquestador de [nombre del proyecto].

## Tu Rol
Eres el único punto de contacto con el usuario. Lees primero los archivos en `memory/`, luego delega a los agentes especializados según la tarea.

## Cómo Delegar
- Analiza qué tipo de tarea es
- Identifica qué agente(s) especializado(s) la pueden resolver
- Delega con contexto completo
- Consolida los resultados antes de responder al usuario

## Reglas
- Siempre lee `memory/proyecto.md` y `memory/learnings.md` al inicio
- Guarda en `memory/` cualquier aprendizaje validado
- Reporta al usuario de forma clara y accionable
```

**Skill base en `.agent/skills/creador-de-skills/SKILL.md`:**
```markdown
# Skill: Creador de Skills

## Cuándo usar esta skill
Cuando detectas un patrón que se repite más de 2 veces, o cuando el usuario pide hacer algo que debería estandarizarse.

## Proceso
1. Identifica el patrón repetible
2. Define el nombre de la skill (kebab-case)
3. Crea la carpeta `.agent/skills/<nombre>/`
4. Escribe el `SKILL.md` con el formato de abajo
5. Actualiza el CLAUDE.md del proyecto para mencionar la nueva skill

## Formato de SKILL.md
```
# Skill: [Nombre]

## Cuándo usar esta skill
[Condiciones que activan esta skill]

## Proceso
[Pasos numerados, cada uno con nombre único]

## Output esperado
[Qué produce esta skill y en qué formato]

## Ejemplo
[Un ejemplo concreto de input → output]
```
```

### Si tipo = `software`

Crea esta estructura:

**Carpetas:**
- `src/` — Código fuente principal
- `tests/` — Tests
- `docs/` — Documentación técnica
- `.claude/agents/` — Agentes especializados (code-reviewer, debugger)
- `.claude/commands/` — Comandos específicos del proyecto

**Agente en `.claude/agents/code-reviewer.md`:**
```markdown
---
name: code-reviewer
description: Revisa código en busca de bugs, problemas de seguridad, y violaciones de las convenciones del proyecto. Solo lee, nunca modifica.
allowed-tools: Read, Grep, Glob
---

Eres un revisor de código exhaustivo. SOLO lees, nunca modificas archivos.

Cuando revisas código, evalúas:
1. **Seguridad** — Credenciales hardcodeadas, injecciones, OWASP Top 10
2. **Correctitud** — Lógica, edge cases, manejo de errores
3. **Convenciones** — Cumple las reglas del CLAUDE.md del proyecto
4. **Calidad** — Legibilidad, duplicación, complejidad innecesaria

Reporta findings con severidad: 🔴 Crítico | 🟡 Importante | 🔵 Sugerencia
```

### Si tipo = `contenido`

Crea esta estructura:

**Carpetas:**
- `research/` — Investigación y referencias
- `drafts/` — Borradores en proceso
- `published/` — Contenido publicado y aprobado
- `assets/` — Imágenes, videos, recursos visuales
- `templates/` — Formatos reutilizables
- `memory/` — Voz de marca, avatar, aprendizajes

**Archivos en `memory/`:**
- `memory/brand-voice.md` — Tono, frases, estilo
- `memory/audience.md` — Audiencia objetivo y pain points
- `memory/winning-content.md` — Qué funcionó y por qué

### Si tipo = `generico`

Crea estructura mínima pero funcional:
- `docs/` — Documentación
- `outputs/` — Resultados
- `memory/learnings.md` — Aprendizajes del proyecto

## Paso 5: Crear README.md

Genera un README.md claro con:
- Descripción del proyecto
- Requisitos y setup (incluye: copiar `.env.example` a `.env`)
- Cómo usar el proyecto
- Estructura de carpetas (árbol)

## Paso 6: Confirmación final

Cuando termines, muestra al usuario:

---
**✅ Proyecto inicializado correctamente**

**Archivos creados:**
[Lista de todos los archivos y carpetas creados]

**Próximos pasos:**
1. Copia `.env.example` a `.env` y llena tus API keys
2. [Próximo paso específico del tipo de proyecto]
3. Empieza a trabajar — el sistema ya sabe cómo eres

**Comandos disponibles:**
- `/review` — Revisar el trabajo actual
- `/progress` — Ver estado del proyecto
- `/security-check` — Auditar seguridad
---
