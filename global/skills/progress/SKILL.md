---
name: progress
description: Cuenta en qué está el proyecto — qué está hecho, qué está en curso, qué falta y qué está trabado — leyendo su memoria. Usar cuando el usuario pregunte «¿en qué vamos?», «¿qué falta?», «¿dónde quedamos?», «resumime el proyecto».
---

# Estado del proyecto

## 1. Leer

- `memory/tareas-activas.md` y el `memory/session-handoff-*.md` más reciente.
- Las últimas entradas de `memory/decisions.md`.
- Lo que hay en `outputs/`.
- Si hay git: `git log --oneline -10`.

Si el proyecto no tiene `memory/`, decilo y ofrecé crearla con `init-proyecto`.

## 2. Contestar

Corto, con lo que dicen los archivos, no genérico:

```
Hecho: …
En curso: …
Falta: …
Trabado: … (y por qué)
Lo siguiente: una sola cosa, concreta.
```

Si la memoria está vieja o se contradice, decilo: «la última actualización es del AAAA-MM-DD».
