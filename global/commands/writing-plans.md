---
description: Crea un plan de implementación detallado paso a paso antes de escribir código o ejecutar tareas complejas. Úsalo después de aprobar una spec en brainstorming o cuando tengas una tarea de más de 3 pasos.
---

Crea un plan completo y sin ambigüedad antes de cualquier implementación. El plan debe ser tan claro que cualquier persona (o agente) pueda ejecutarlo sin contexto adicional.

## Regla absoluta

Cada paso debe tomar 2-5 minutos. Si un paso toma más, divídelo. Sin placeholders, sin "TBD", sin instrucciones vagas.

## Estructura del plan

Guarda el plan en `docs/plans/YYYY-MM-DD-<nombre-feature>.md`

```markdown
# Plan: [Nombre del Feature/Tarea]
**Fecha:** YYYY-MM-DD
**Objetivo:** [Una oración clara]
**Tipo de proyecto:** [software | agentes | contenido | generico]

## Arquitectura / Estructura
[Qué archivos se crean, cuáles se modifican, cómo se relacionan]

## Mapa de archivos
| Archivo | Acción | Responsabilidad |
|---------|--------|-----------------|
| src/... | crear  | [qué hace]      |

## Tareas

### Tarea 1: [Nombre descriptivo]
**Archivos:** [lista exacta]
**Pasos:**
1. [instrucción exacta con código si aplica]
2. [instrucción exacta]
**Verificación:** [comando o acción que confirma que funcionó]
**Commit:** `tipo: descripción breve`

### Tarea 2: ...
```

## Principios del plan

**Para proyectos de software:**
- Primero el test, luego la implementación (TDD)
- Cada tarea termina con un commit
- Los comandos son exactos (no "instala la dependencia", sino `npm install express`)

**Para proyectos de agentes:**
- Define qué agente ejecuta cada tarea
- Especifica qué archivos de memoria se leen/escriben
- Cada agente tiene inputs y outputs claros

**Para proyectos de contenido:**
- Define el formato del output (guion, calendario, brief)
- Especifica la fuente de información (research primero)
- Incluye criterios de aprobación

## Auto-revisión antes de presentar

- [ ] ¿Cubre todo el scope de la spec aprobada?
- [ ] ¿Hay algún placeholder o sección incompleta?
- [ ] ¿Los pasos son ejecutables sin preguntas adicionales?
- [ ] ¿Cada tarea tiene verificación?

## Opciones de ejecución

Cuando termines el plan, ofrece al usuario dos caminos:

**A) Ejecución directa** — Ejecutas tú mismo tarea por tarea con checkpoints
**B) Subagentes paralelos** — Despachas agentes independientes para tareas no relacionadas (usa `/dispatching-parallel-agents`)
