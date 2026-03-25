---
description: Audita el proyecto en busca de secretos, problemas de seguridad y configuración incorrecta
allowed-tools: Read, Grep, Glob, Bash(git diff:*), Bash(git status:*)
---

Realiza una auditoría de seguridad completa del proyecto.

## Checklist de Seguridad

### 1. Verificar .gitignore

Abre el archivo `.gitignore` y verifica que incluye:
- `.env` y `.env.*` (con excepción de `.env.example`)
- `CLAUDE.local.md`
- Carpetas de dependencias (`node_modules/`, `venv/`, etc.)
- Archivos de credenciales comunes (`*.pem`, `credentials.json`, etc.)

### 2. Buscar secretos en el código

Usa Grep para buscar estos patrones en todos los archivos del proyecto:
- `api_key\s*=\s*["'][^"']+["']` (API keys hardcodeadas)
- `password\s*=\s*["'][^"']+["']` (passwords)
- `AKIA[0-9A-Z]{16}` (AWS keys)
- `sk-[A-Za-z0-9]{20,}` (OpenAI/Anthropic keys)
- `ghp_` (GitHub tokens)

Excluye de la búsqueda: `.env.example`, `node_modules/`, archivos de tests con datos de ejemplo.

### 3. Verificar archivos .env

- ¿Existe `.env`? Si sí, verificar que NO está tracked en git (`git ls-files .env`)
- ¿Existe `.env.example`? Si no, advertir que debería crearse
- ¿Los campos de `.env.example` tienen solo placeholders (no valores reales)?

### 4. Revisar archivos staged (si hay git)

Ejecuta `git diff --cached` y busca cualquier credencial en los cambios pending.

### 5. Verificar permisos de archivos sensibles

En sistemas Unix/Mac, verifica que archivos como `.env` no tienen permisos de lectura global.

## Formato del Reporte

---
## 🔐 Auditoría de Seguridad — [Proyecto]

### 🔴 Crítico (acción inmediata requerida)
- [Problema crítico encontrado]

### 🟡 Advertencia (resolver pronto)
- [Problema importante]

### ✅ Correcto
- .gitignore configurado correctamente
- No se encontraron secretos hardcodeados
- [etc.]

### 📋 Recomendaciones
- [Mejoras opcionales de seguridad]

**Resultado:** [SEGURO | REQUIERE ATENCIÓN | CRÍTICO]
---

Si todo está bien, di claramente: "✅ No se encontraron problemas de seguridad."
