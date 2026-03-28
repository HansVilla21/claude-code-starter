---
description: Inicializa cualquier proyecto nuevo con estructura robusta de agentes, memoria, skills y configuración completa. Auto-detecta el tipo de proyecto.
argument-hint: tipo de proyecto (opcional) — agentes | software | contenido | generico
---

Eres el inicializador de proyectos. Tu misión es crear una estructura completa, robusta y lista para trabajar desde el primer mensaje.

**Fuente de skills:** https://github.com/obra/superpowers — integradas y adaptadas al español.

---

## Paso 1: Auto-detectar tipo de proyecto

Primero ejecuta Glob para ver qué archivos existen:

```
package.json / yarn.lock / pnpm-lock.yaml  → software (Node/JS)
requirements.txt / pyproject.toml / setup.py → software (Python)
Cargo.toml                                  → software (Rust)
go.mod                                      → software (Go)
agents/ / memory/ / .agent/                 → agentes
drafts/ / published/ / content/             → contenido
(nada de lo anterior)                       → preguntar
```

Si el usuario pasó un argumento explícito, úsalo directamente.

Si no se detecta nada claro, pregunta:

---
**Para inicializar este proyecto necesito 3 datos:**

1. **Nombre del proyecto** (si el nombre de la carpeta no es descriptivo)
2. **Propósito** — ¿Qué va a hacer? (1-2 oraciones)
3. **Tipo:**
   - `software` — App web, API, script, herramienta de código
   - `agentes` — Sistema de agentes de IA con roles especializados
   - `contenido` — Marketing, redes sociales, creación de contenido
   - `generico` — Cualquier otro proyecto

Espera la respuesta antes de continuar.

---

## Paso 2: Archivos base (todos los tipos)

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
Genera con las variables del tipo de proyecto. Siempre incluye:
```
# ============================================
# [NOMBRE] — Variables de Entorno
# ============================================
# Copia este archivo a .env y llena los valores reales
# NUNCA subas .env a git

ANTHROPIC_API_KEY=sk-ant-...
```

Para `agentes` agrega también:
```
PERPLEXITY_API_KEY=pplx-...
GEMINI_API_KEY=AIza...
```

---

## Paso 3: CLAUDE.md del proyecto

Genera un `CLAUDE.md` personalizado:

```markdown
# [Nombre del Proyecto]

## Qué es este proyecto
[Descripción en 2-3 oraciones]

## Contexto
[Quién lo usa, para qué, objetivo principal]

## Arquitectura / Estructura Principal
[Describe los componentes clave]

## Cómo Trabajamos
- Ejecutar directamente: [qué no necesita confirmación]
- Requiere confirmación: [cambios de arquitectura, deploys, etc.]

## Convenciones
- Idioma del proyecto: [español / inglés]
- Formato de outputs: [describe el estándar]

## Skills disponibles
[Lista las skills instaladas en .claude/commands/]

## Estructura del Proyecto
[Árbol de carpetas con descripción breve de cada una]
```

---

## Paso 4: Estructura por tipo de proyecto

---

### TIPO: `software`

**Carpetas:**
- `src/` — Código fuente
- `tests/` — Tests
- `docs/specs/` — Especificaciones (generadas por /brainstorming)
- `docs/plans/` — Planes de implementación (generados por /writing-plans)
- `.claude/agents/` — Agentes especializados
- `.claude/commands/` — Skills del proyecto

**Agentes en `.claude/agents/`:**

Crea `.claude/agents/code-reviewer.md`:
```markdown
---
name: code-reviewer
description: Revisa código en busca de bugs, problemas de seguridad y violaciones de convenciones. Solo lee, nunca modifica. Úsalo antes de cualquier merge o entrega.
allowed-tools: Read, Grep, Glob
---

Eres un revisor de código exhaustivo. SOLO lees, nunca modificas archivos.

Al revisar evalúa:
1. **Seguridad** — Credenciales hardcodeadas, OWASP Top 10, inyecciones
2. **Correctitud** — Lógica, edge cases, manejo de errores
3. **Convenciones** — Cumple las reglas del CLAUDE.md del proyecto
4. **Calidad** — Legibilidad, duplicación, complejidad innecesaria

Reporta con severidad: 🔴 Crítico | 🟡 Importante | 🔵 Sugerencia

Formato del reporte:
## Revisión: [archivo o feature]
### 🔴 Críticos
- [descripción + línea + cómo arreglarlo]
### 🟡 Importantes
- [descripción + línea]
### 🔵 Sugerencias
- [descripción]
### ✅ Bien hecho
- [qué está correcto]
```

**Skills en `.claude/commands/` para software:**

Crea `.claude/commands/systematic-debugging.md`:
```markdown
---
description: Diagnostica bugs con análisis de causa raíz antes de proponer fixes. Úsalo ante cualquier error, test fallido o comportamiento inesperado.
---

## Regla absoluta
NO propongas fixes sin investigar la causa raíz primero.

## Fase 1: Investigación
- Lee el error completo incluyendo stack trace
- Reproduce el problema de forma consistente
- Revisa cambios recientes (git log, dependencias)
- Agrega instrumentación diagnóstica en los límites del sistema

## Fase 2: Análisis de patrón
- Encuentra código similar que SÍ funciona en el proyecto
- Compara implementación rota vs funcionando
- Documenta cada diferencia

## Fase 3: Hipótesis
Formula: "X causa Y porque Z"
- Una hipótesis a la vez
- Cambio mínimo para probar (no layers de fixes)
- Si el test falla, vuelve a Fase 1 con nueva info

## Fase 4: Implementación
- Crea un test que falle primero
- Un fix enfocado en la causa raíz
- Si llevas 3+ fixes fallidos → cuestiona la arquitectura, no los síntomas

## Red flags — Para inmediatamente si:
- Propones un fix sin haber investigado
- Haces múltiples cambios simultáneos
- Dices "no entiendo bien pero quizás esto funciona"
```

Crea `.claude/commands/test-driven-development.md`:
```markdown
---
description: Guía el ciclo RED-GREEN-REFACTOR. Úsalo para cualquier feature nuevo, bug fix o refactor.
---

## Regla absoluta
NUNCA escribas código de producción sin un test fallando primero.
Si ya escribiste código sin test: bórralo y empieza de nuevo.

## El ciclo

### 🔴 RED — Escribe el test primero
- Un solo comportamiento por test
- Nombre descriptivo: `test_que_hace_cuando_condicion`
- Usa código real, no mocks salvo que sea inevitable
- Corre el test → debe FALLAR (si pasa, el test está mal)

### ✅ GREEN — Código mínimo para pasar
- Escribe lo mínimo que hace pasar el test
- No agregues funcionalidad extra
- Corre el test → debe PASAR

### 🔵 REFACTOR — Limpia sin cambiar comportamiento
- Elimina duplicación
- Mejora nombres
- Los tests deben seguir pasando

## Commit después de cada ciclo completo

## Señales de alerta
- "Es muy simple para testear" → El código simple también se rompe
- "Lo testeo después" → Los tests post-implementación prueban nada
- "Solo es configuración" → La configuración también falla
```

Crea `.claude/commands/verification-before-completion.md`:
```markdown
---
description: Verifica que el trabajo esté realmente completo antes de declararlo listo. Úsalo antes de cualquier commit, PR o entrega.
---

## Regla absoluta
NUNCA declares trabajo completo sin evidencia verificada. "Debería funcionar" no cuenta.

## Gate de verificación (5 pasos)

1. **Identifica** qué comando prueba que funcionó
2. **Corre** el comando completo y fresco (no uses caché)
3. **Lee** el output completo incluyendo exit codes
4. **Verifica** que el output confirma el objetivo
5. **Solo entonces** declara completado

## Lenguaje prohibido antes de verificar
- "debería funcionar"
- "probablemente está bien"
- "parece que quedó"
- "creo que..."

## Checklist antes de completar
- [ ] Corrí los tests → todos pasan
- [ ] No hay warnings sin resolver
- [ ] El feature funciona en el happy path
- [ ] Los edge cases están cubiertos
- [ ] No hay secretos en los archivos staged
- [ ] El CLAUDE.md refleja los cambios si aplica
```

Crea `.claude/commands/dispatching-parallel-agents.md`:
```markdown
---
description: Despacha múltiples agentes en paralelo para tareas independientes. Úsalo cuando tengas 2+ problemas no relacionados que pueden resolverse simultáneamente.
---

## Cuándo usar
- Múltiples bugs en distintos módulos (causas independientes)
- Investigación en paralelo de distintos subsistemas
- Tareas que no comparten estado ni modifican los mismos archivos

## Cuándo NO usar
- Las tareas dependen una de la otra
- Los agentes editarían los mismos archivos
- Necesitas el resultado de una tarea para empezar la otra

## Proceso

### 1. Identificar dominios independientes
Agrupa los problemas por módulo o área. Confirma que no se solapan.

### 2. Crear instrucciones focalizadas para cada agente
Cada agente recibe:
- Un problema claro y acotado
- Todos los archivos relevantes
- El output esperado
- Restricciones (qué NO tocar)

Ejemplo de instrucción efectiva:
> "Investiga por qué `auth/login.py` falla en el test `test_invalid_token`.
> Solo modifica archivos en `auth/`. No toques `api/` ni `db/`.
> Output: fix + explicación de causa raíz."

### 3. Despachar simultáneamente
Usa el Agent tool con múltiples llamadas en el mismo mensaje.

### 4. Revisar e integrar
Cuando todos terminan:
- Verifica que los fixes no se contradicen
- Corre el suite completo de tests
- Integra los cambios en orden lógico
```

---

### TIPO: `agentes`

**Carpetas:**
- `agents/` — Un subfolder por agente con su `CLAUDE.md`
- `memory/` — Cerebro compartido
- `.agent/skills/` — Skills reutilizables
- `inputs/` — Material de entrada
- `outputs/` — Resultados organizados
- `templates/` — Moldes para outputs recurrentes
- `docs/specs/` — Especificaciones
- `docs/plans/` — Planes

**Archivos en `memory/`:**
- `memory/proyecto.md` — Contexto del proyecto
- `memory/brand-voice.md` — Tono y estilo (si aplica)
- `memory/learnings.md` — Aprendizajes acumulados (vacío al inicio)
- `memory/decisions.md` — Decisiones importantes y razones

**Agente orquestador en `.claude/agents/orquestador.md`:**
```markdown
---
name: orquestador
description: Punto de entrada principal. Lee el contexto en memory/, delega a agentes especializados y consolida resultados. Úsalo para cualquier tarea de alto nivel.
---

Eres el agente orquestador de [nombre del proyecto].

## Tu Rol
Eres el único punto de contacto con el usuario. Antes de cualquier tarea:
1. Lee `memory/proyecto.md` y `memory/learnings.md`
2. Analiza qué tipo de tarea es
3. Delega al agente especializado correcto con contexto completo
4. Consolida y presenta los resultados al usuario

## Cuándo ejecutar directamente (sin delegar)
- Preguntas de contexto o estado del proyecto
- Tareas de menos de 3 pasos que no requieren especialización

## Cuándo delegar
- Investigación → agente investigador
- Creación de contenido → agente creador
- Análisis estratégico → agente estratega
- [Adapta según los agentes del proyecto]

## Memoria
Cuando el usuario valida un output, guarda el aprendizaje en `memory/learnings.md`.
Solo guarda información confirmada, nunca especulación.
```

**Skill base en `.agent/skills/creador-de-skills/SKILL.md`:**
```markdown
# Skill: Creador de Skills

## Cuándo usar esta skill
Cuando detectas un patrón que se repite más de 2 veces, o cuando el usuario pide estandarizar un proceso.

## Proceso
1. Identifica el patrón repetible y dale un nombre (kebab-case)
2. Crea la carpeta `.agent/skills/<nombre>/`
3. Escribe el `SKILL.md` con el formato estándar
4. Menciona la nueva skill en el CLAUDE.md del proyecto

## Formato estándar de SKILL.md

# Skill: [Nombre]

## Cuándo usar esta skill
[Condiciones que activan esta skill — específicas, no vagas]

## Proceso
[Pasos numerados con nombre único cada uno]

## Output esperado
[Formato y contenido del resultado]

## Ejemplo
Input: [ejemplo]
Output: [ejemplo de resultado]
```

**Skills en `.claude/commands/` para agentes:**

Crea `.claude/commands/dispatching-parallel-agents.md` (mismo contenido que en software — ver arriba).

---

### TIPO: `contenido`

**Carpetas:**
- `research/` — Investigación y referencias
- `drafts/` — Borradores en proceso
- `published/` — Contenido publicado y aprobado
- `assets/` — Imágenes, videos, recursos
- `templates/` — Formatos reutilizables
- `memory/` — Voz de marca, audiencia, aprendizajes
- `docs/plans/` — Calendarios y planes

**Archivos en `memory/`:**
- `memory/brand-voice.md` — Tono, frases clave, estilo, qué evitar
- `memory/audience.md` — Audiencia objetivo y pain points principales
- `memory/winning-content.md` — Qué funcionó y por qué (vacío al inicio)
- `memory/learnings.md` — Aprendizajes acumulados

---

### TIPO: `generico`

Estructura mínima funcional:
- `docs/` — Documentación
- `outputs/` — Resultados
- `memory/learnings.md` — Aprendizajes del proyecto

---

## Paso 5: README.md

Genera un README.md claro con:
- Descripción del proyecto (2-3 párrafos)
- Requisitos y setup (incluye: `cp .env.example .env`)
- Cómo usar el proyecto
- Árbol de carpetas con descripción
- Skills y comandos disponibles

---

## Paso 6: Confirmación final

Cuando termines, muestra al usuario:

---
**✅ Proyecto inicializado**

**Tipo detectado:** [tipo]

**Archivos creados:**
[Lista completa]

**Skills instaladas:**
[Lista de skills en .claude/commands/ con una línea de descripción cada una]

**Próximos pasos:**
1. `cp .env.example .env` y llena tus API keys
2. [Paso específico del tipo — ej: "Define tus agentes en agents/"]
3. Usa `/brainstorming` antes de empezar cualquier tarea nueva

**Comandos disponibles (globales):**
- `/brainstorming` — Valida ideas antes de implementar
- `/writing-plans` — Crea plan detallado de implementación
- `/executing-plans` — Ejecuta un plan con checkpoints
- `/review` — Revisa el trabajo actual
- `/progress` — Estado del proyecto
- `/security-check` — Auditoría de seguridad
- `/commit` — Commit inteligente con verificación
---
