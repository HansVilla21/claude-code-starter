---
description: Revisa el trabajo actual contra las reglas del proyecto y reporta findings con severidad
---

Haz una revisión completa del trabajo actual en este proyecto.

## Proceso de Revisión

### 1. Leer el contexto
- Lee el `CLAUDE.md` del proyecto para entender las reglas y convenciones
- Identifica qué archivos fueron modificados recientemente (usa `git diff` si hay git)
- Si no hay contexto claro de qué revisar, pregunta al usuario: "¿Qué quieres que revise?"

### 2. Criterios de revisión

Evalúa cada archivo o cambio contra estas dimensiones:

**Seguridad** 🔴
- ¿Hay credenciales, tokens o secretos hardcodeados?
- ¿Está el .env en .gitignore?
- ¿Hay inputs sin validar en código?

**Correctitud** 🟡
- ¿La lógica hace lo que debe hacer?
- ¿Se manejan los edge cases y errores?
- ¿El código/contenido cumple el objetivo declarado?

**Convenciones del Proyecto** 🔵
- ¿Sigue la estructura definida en CLAUDE.md?
- ¿El idioma/tono es correcto?
- ¿Los archivos están en las carpetas correctas?

**Calidad** 🔵
- ¿El código/contenido es claro y legible?
- ¿Hay duplicación innecesaria?
- ¿Se podría simplificar?

### 3. Formato del reporte

Presenta los findings así:

---
## 📋 Revisión — [fecha/contexto]

### 🔴 Crítico (debe resolverse antes de continuar)
- [finding] en [archivo:línea]

### 🟡 Importante (resolver pronto)
- [finding] en [archivo]

### 🔵 Sugerencias (mejoras opcionales)
- [sugerencia]

### ✅ Lo que está bien
- [qué funciona correctamente]

**Veredicto:** [Listo para avanzar | Requiere ajustes | Bloqueado por críticos]
---

Si no hay nada que revisar, di: "No encontré cambios recientes. ¿Qué quieres que revise?"
