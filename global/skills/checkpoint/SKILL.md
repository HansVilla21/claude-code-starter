---
name: checkpoint
description: Guarda el estado de la sesión en la memoria del proyecto antes de cerrar — decisiones, aprendizajes, tareas y un handoff con fecha — para que la próxima sesión arranque sabiendo todo. Usar cuando el usuario diga «guardá todo», «hacé checkpoint», «guardá la sesión», «antes de cerrar guardá esto», «vamos a hacer pausa», o al terminar una sesión larga.
---

# Checkpoint

## 1. Contexto

- Si el proyecto no tiene `memory/`, ofrecé crearlo con `init-proyecto` y no sigas.
- Usá la fecha real del sistema, no una supuesta.

## 2. Qué vale guardar

Filtrá fuerte. De la sesión, solo lo que una sesión futura necesita saber:

- **Decisiones:** qué se decidió, por qué y qué se descartó.
- **Trabajo:** qué se hizo, en qué estado quedó, qué quedó a medias.
- **Aprendizajes:** errores, correcciones del usuario, preferencias nuevas.
- **Pendientes:** qué sigue y qué se espera de quién.
- **Correcciones:** lo que estaba mal en la memoria y ya no.

Si la sesión no dejó nada nuevo, decilo y no escribas nada.

## 3. Escribir

- `memory/decisions.md`: una entrada por decisión.
- `memory/learnings.md`: una entrada por aprendizaje.
- `memory/tareas-activas.md`: al día, con la fecha de la última actualización.
- `memory/proyecto.md`: solo si cambió el estado.
- `outputs/`: verificá que lo que se produjo quedó guardado ahí.

No dupliques: si ya existe una entrada parecida, actualizala.

## 4. El handoff

`memory/session-handoff-AAAA-MM-DD.md`. Si ya hay uno de hoy, se actualiza.

```markdown
# Handoff — AAAA-MM-DD

**Reemplaza a:** session-handoff-<anterior>.md (o «ninguno»)

## En qué quedamos
## Lo que se hizo
## Lo que quedó a medias
## Lo que sigue, en orden
## Lo que espera del usuario
## Lo que hay que saber para retomar
```

Al handoff anterior se le agrega arriba: `> Histórico: lo reemplaza session-handoff-<nuevo>.md`.

## 5. Skills

¿Salió de la sesión un proceso que ya se hizo dos veces, o un aprendizaje que cambia cómo se
trabaja? Creá o mejorá la skill con `creador-de-skills`, y decilo en la confirmación.

## 6. Confirmar

Corto: qué archivos se actualizaron, el handoff, la skill nueva o cambiada, y el próximo paso.

## Reglas

- No inventes: si no estuvo en la conversación, no se escribe.
- No copies la conversación: se resume lo que sirve.
- Nunca se guardan contraseñas ni claves. Ante datos sensibles nuevos (de salud, números de
  cuenta), preguntá antes de escribirlos.
- En el idioma del proyecto.
