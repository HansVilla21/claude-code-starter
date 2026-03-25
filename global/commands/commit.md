---
description: Crea un commit inteligente con formato convencional, verifica secretos y protege main/master
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*)
---

Crea un commit con las mejores prácticas. Sigue estos pasos en orden:

## Paso 1: Verificar estado

Ejecuta en paralelo:
- `git status` — ver archivos modificados y staged
- `git diff --cached` — ver exactamente qué está staged
- `git branch --show-current` — ver rama actual

## Paso 2: Proteger main/master

Si la rama actual es `main` o `master`, DETENTE y pregunta:
> "Estás en la rama `main/master`. ¿Quieres crear una rama nueva antes de commitear? (recomendado: `feat/<nombre>`)"

Espera confirmación antes de continuar.

## Paso 3: Verificar secretos

Busca en los archivos staged patrones de secretos:
- Archivos `.env` staged
- Strings que parezcan API keys (sk-, AKIA, ghp_, etc.)
- Passwords o tokens hardcodeados

Si encuentras algo sospechoso, DETENTE y advierte al usuario antes de continuar.

## Paso 4: Stagear archivos si es necesario

Si el usuario no especificó qué archivos stagear y hay archivos sin stagear, pregunta:
> "¿Stageo todos los cambios con `git add .` o quieres especificar archivos?"

NUNCA stagees `.env` o archivos con credenciales.

## Paso 5: Generar mensaje de commit

Analiza los cambios staged y genera un mensaje en formato convencional:

```
tipo: descripción breve en imperativo

[cuerpo opcional si el cambio es complejo]
```

**Tipos:** `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`

**Ejemplos:**
- `feat: agregar agente investigador con búsqueda Perplexity`
- `fix: corregir generación de calendario semanal`
- `docs: actualizar README con instrucciones de setup`

Usa el idioma del proyecto (si el CLAUDE.md está en español, el commit en español).

## Paso 6: Confirmar y ejecutar

Muestra el comando antes de ejecutarlo:
> ¿Ejecuto este commit?
> `git commit -m "tipo: descripción"`

Espera confirmación del usuario antes de hacer el commit.

## Paso 7: Confirmar éxito

Después del commit, muestra:
- Hash del commit
- Rama actual
- Archivos commiteados
