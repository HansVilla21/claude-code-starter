# Instrucciones Globales — Claude Code

## Comportamiento General

- Responde siempre en el mismo idioma que el usuario
- Planifica primero, ejecuta después — para tareas no triviales, acuerda el plan antes de actuar
- Si no estás seguro, pregunta antes de ejecutar
- Calidad sobre velocidad — menos pero bien hecho
- Un task, un chat — usa /clear entre tareas no relacionadas

## Proyectos Nuevos

Cuando abres una carpeta sin `CLAUDE.md`, pregunta al usuario si quiere inicializar el proyecto:
> "No veo un CLAUDE.md en este proyecto. ¿Quieres que lo inicialice con `/init-proyecto`?"

## Reglas de Seguridad (Absolutas — Sin Excepciones)

- NUNCA escribas passwords, API keys, tokens o secretos en ningún archivo
- NUNCA hagas commit de `.env` — verifica SIEMPRE que esté en `.gitignore`
- NUNCA hagas commit directo en `main` o `master`
- NUNCA hagas deploy a producción sin confirmación explícita
- SIEMPRE usa variables de entorno para credenciales
- SIEMPRE incluye `.env.example` con placeholders en proyectos nuevos

## Reglas de Git

- Ramas: `feat/<nombre>`, `fix/<nombre>`, `docs/<nombre>`, `refactor/<nombre>`
- Verifica la rama ANTES de escribir cualquier archivo
- Mensajes de commit en el idioma del proyecto, formato: `tipo: descripción breve`
- Antes de cualquier commit: verifica que no haya secretos en los archivos staged

## Reglas de Calidad

- Archivos > 300 líneas: dividir en módulos más pequeños
- Sin warnings de linter sin resolver
- Sin credenciales hardcodeadas bajo ninguna circunstancia
- CLAUDE.md es la memoria del equipo — después de cada error repetible, agrega una regla

## Archivos Requeridos en Todo Proyecto

| Archivo | Propósito | En Git |
|---------|-----------|--------|
| `.env` | Variables reales | ❌ NUNCA |
| `.env.example` | Template con placeholders | ✅ Siempre |
| `.gitignore` | Incluye: `.env`, `CLAUDE.local.md` | ✅ Siempre |
| `CLAUDE.md` | Instrucciones del proyecto | ✅ Siempre |
| `CLAUDE.local.md` | Overrides personales | ❌ Gitignoreado |

## Comandos Disponibles (Globales)

| Comando | Qué hace |
|---------|----------|
| `/init-proyecto` | Inicializa un proyecto nuevo con estructura completa |
| `/review` | Revisa el trabajo actual contra las reglas del proyecto |
| `/commit` | Crea un commit inteligente con formato convencional |
| `/progress` | Reporta el estado actual: qué está hecho, qué falta |
| `/security-check` | Escanea secretos, revisa .gitignore, audita archivos sensibles |
| `/help` | Lista todos los comandos y agentes disponibles |

## Filosofía de Trabajo

**Defensa en profundidad:**
1. Reglas en CLAUDE.md → guía el comportamiento
2. Hooks → enforcement determinístico
3. .gitignore → última línea de defensa

**El loop de mejora:**
Después de cada mistake → nueva regla en CLAUDE.md → el error no se repite.
