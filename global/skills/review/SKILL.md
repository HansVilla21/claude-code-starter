---
name: review
description: Revisa el trabajo hecho contra las reglas del proyecto y reporta los problemas por gravedad. Usar cuando el usuario diga «revisá esto», «¿está bien lo que hicimos?», antes de entregar algo importante o antes de un commit.
---

# Revisión

## 1. Qué se revisa

- Leé el `CLAUDE.md` del proyecto: lo que tiene que entregar y sus reglas.
- Si hay git, `git diff` muestra lo que cambió. Si no, lo último que se produjo en `outputs/`.
- Si no está claro qué revisar, preguntá: «¿Qué querés que revise?»

## 2. Contra qué

- **Seguridad:** secretos o claves escritos en archivos; `.env` fuera de `.gitignore`; datos
  sensibles donde no deben estar.
- **Que esté bien:** hace lo que tiene que hacer; los datos son reales y no inventados; los casos
  raros y los errores están cubiertos.
- **Lo que pide el proyecto:** el formato, la estructura y el tono del `CLAUDE.md`; cada archivo en
  su carpeta.
- **Claridad:** se entiende, no hay cosas repetidas, se podría simplificar.

## 3. Reportar

```
🔴 Crítico (se arregla antes de seguir): … en <archivo>
🟡 Importante: …
🔵 Sugerencia: …
✅ Bien: …

Veredicto: listo | requiere ajustes | bloqueado
```

Si no hay nada que revisar: «No encontré cambios recientes. ¿Qué querés que revise?»
