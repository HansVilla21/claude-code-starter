---
name: creador-de-skills
description: Convierte un proceso que ya funcionó en una skill del proyecto, para que la próxima vez se haga igual de bien sin explicarlo de nuevo. Usar cuando un proceso se hizo dos veces y se ve venir la tercera, cuando la primera vez dejó un aprendizaje que no es obvio, o cuando el usuario diga «convertí esto en una skill», «guardá cómo se hace esto».
---

# Crear una skill

## Cuándo

- Un proceso se resolvió **dos veces o más** y se ve venir la tercera.
- O fue la primera vez, pero dejó un aprendizaje **que no es obvio** y se va a olvidar.
- El usuario casi nunca la va a pedir: detectalo vos y proponelo en una línea, «esto ya da para
  una skill, ¿la armo?».

**Cuándo no:** un paso que no se va a repetir, algo que ya está escrito en `memory/decisions.md`,
o un procedimiento para un trabajo que todavía no se hizo nunca. Una skill que nadie usa es peso
muerto.

## Cómo

1. **Nombrá el patrón, no la tarea:** `armar-plan-de-entrenamiento` sirve; `lo-del-martes` no.
   Nombre en kebab-case, que se entienda sin abrir el archivo.
2. Creá `.claude/skills/<nombre>/SKILL.md` **dentro del proyecto**, con el formato de abajo.
3. La `description` dice **cuándo se activa**, con las frases que usa el usuario: Claude decide
   usarla leyendo esa línea.
4. Escribí el porqué, no solo el cómo: una skill sin su razón se vuelve a discutir.
5. Si cambia cómo se trabaja en el proyecto, mencionala en el `CLAUDE.md`.

## Formato

```markdown
---
name: <nombre>
description: Qué hace y cuándo usarla, con las frases que diría el usuario.
---

# <Nombre>

## Cuándo usarla
Lo que la activa. Y cuándo no.

## Por qué existe
Qué pasó que la hizo necesaria, con fecha.

## Pasos
Numerados y verificables.

## Qué entrega
Qué produce, en qué formato y dónde se guarda.

## Ejemplo
Uno real: entrada → salida.
```

## La prueba

Alguien que no estuvo en la conversación la puede seguir sin preguntar nada. Si para aplicarla hay
que acordarse de algo que no está escrito, está incompleta.

**Se mejora con el uso:** cada vez que se aplica y algo sale distinto, se corrige la skill en ese
momento.
