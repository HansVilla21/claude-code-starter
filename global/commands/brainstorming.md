---
description: Explora y valida cualquier idea antes de implementarla — hace preguntas, propone enfoques y crea una especificación aprobada. Úsalo antes de cualquier trabajo creativo o de implementación.
---

Antes de escribir código, crear contenido, diseñar agentes o cualquier trabajo de implementación, sigue este proceso de validación.

## Regla absoluta

NO escribas código, no crees archivos de implementación, no scaffoldees estructuras hasta tener una especificación aprobada por el usuario. Sin excepción.

## Proceso (9 pasos)

### Paso 1 — Explorar contexto
Lee los archivos existentes del proyecto (CLAUDE.md, memory/, estructura de carpetas). Entiende qué ya existe antes de preguntar.

### Paso 2 — Preguntas aclaratorias
Haz preguntas de una en una para entender:
- **Propósito:** ¿Qué problema resuelve esto?
- **Alcance:** ¿Qué está dentro y fuera del scope?
- **Criterios de éxito:** ¿Cómo sabremos que funcionó?
- **Restricciones:** Tiempo, tecnología, estilo, presupuesto

Usa preguntas de opción múltiple siempre que sea posible. Máximo 4 preguntas antes de proponer enfoques.

### Paso 3 — Proponer 2-3 enfoques
Para cada enfoque muestra:
- Descripción breve (1-2 oraciones)
- Ventajas principales
- Desventajas o riesgos
- Cuándo elegirlo

### Paso 4 — Diseño detallado
Cuando el usuario elige un enfoque, presenta el diseño en secciones. Una sección a la vez si es complejo.

Principios del diseño:
- YAGNI — no agregues lo que no se pidió
- Unidades pequeñas con responsabilidad única
- Límites claros entre componentes

### Paso 5 — Escribir especificación
Guarda en `docs/specs/YYYY-MM-DD-<tema>.md`:

```markdown
# Spec: [Nombre]
**Fecha:** YYYY-MM-DD
**Estado:** En revisión

## Objetivo
[Qué se quiere lograr]

## Alcance
**Incluye:** [lista]
**Excluye:** [lista]

## Diseño
[Descripción detallada del enfoque elegido]

## Criterios de aceptación
- [ ] [criterio 1]
- [ ] [criterio 2]
```

### Paso 6 — Auto-revisión
Antes de mostrar la spec al usuario, verifica:
- ¿Hay placeholders o secciones incompletas?
- ¿Hay contradicciones internas?
- ¿Cubre todos los criterios de éxito mencionados?

### Paso 7 — Usuario aprueba la spec
Muestra la spec completa y espera aprobación explícita. Si el usuario pide cambios, actualiza y vuelve a mostrar.

### Paso 8 — Transición a implementación
Solo cuando el usuario aprueba, invoca `/writing-plans` para crear el plan de implementación.

## Señales de que esta skill aplica

- Usuario dice "quiero hacer...", "me gustaría...", "necesito..."
- Se va a crear algo nuevo (feature, agente, contenido, campaña)
- Hay ambigüedad en el pedido
- La tarea tiene más de 3 pasos

## Lo que NO hacer

- No hacer preguntas y proponer enfoques en el mismo mensaje
- No proponer más de 3 enfoques (paraliza la decisión)
- No comenzar a implementar mientras se espera aprobación
- No crear una spec tan larga que nadie la lee
