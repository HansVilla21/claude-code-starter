---
name: security-check
description: Busca secretos, claves y datos sensibles expuestos en el proyecto y revisa que .gitignore los proteja. Usar cuando el usuario diga «¿hay algo inseguro?», «revisá la seguridad», antes de subir el proyecto a GitHub o antes de compartirlo.
---

# Revisión de seguridad

## 1. `.gitignore`

Tiene que incluir: `.env` y `.env.*` (con la excepción `!.env.example`), `CLAUDE.local.md`, las
carpetas de dependencias (`node_modules/`, `.venv/`) y las carpetas con datos sensibles del
proyecto (por ejemplo `datos/`).

## 2. Secretos escritos en archivos

Buscá en todo el proyecto, sin `node_modules/` ni `.env.example`:

- `api_key`, `apikey`, `password`, `secret` o `token` seguidos de `=` o `:` y un valor entre comillas
- `sk-` seguido de 20 caracteres o más (claves de OpenAI o Anthropic)
- `AKIA` + 16 caracteres (AWS), `ghp_` o `github_pat_` (GitHub), `xoxb-` (Slack), `sk_live_` (Stripe)
- `-----BEGIN … PRIVATE KEY-----`

Al reportar, nombrá el archivo y la línea, **nunca copies el secreto**.

## 3. `.env`

- Si existe, no puede estar en git: `git ls-files .env` tiene que salir vacío.
- Si el proyecto usa claves y no hay `.env.example`, recomendalo, con valores de ejemplo.

## 4. Datos sensibles

Datos de salud, documentos de identidad o finanzas de clientes: confirmá que están en carpetas
ignoradas por git y que no aparecen en lo que se va a publicar o compartir.

## 5. Lo que está por subirse

Si hay git: `git diff --cached`, buscando lo mismo del punto 2.

## 6. Reportar

```
🔴 Crítico (acción ya): …
🟡 Advertencia: …
✅ Bien: …
Resultado: seguro | requiere atención | crítico
```

Si un secreto ya llegó a git o a internet: se considera comprometido. Se cambia la clave en el
servicio que la emitió, no alcanza con borrarla del archivo.
