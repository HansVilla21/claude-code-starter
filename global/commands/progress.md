---
description: Reporta el estado actual del proyecto — qué está hecho, qué falta, qué está bloqueado
---

Genera un reporte de progreso claro del proyecto actual.

## Proceso

### 1. Recopilar contexto
- Lee `CLAUDE.md` del proyecto para entender el objetivo
- Lee `memory/learnings.md` si existe
- Usa `git log --oneline -10` si hay git para ver cambios recientes
- Revisa la estructura de carpetas para ver qué existe y qué no

### 2. Si hay una tarea específica en curso
Pregunta: "¿Hay una tarea específica de la que quieres ver el progreso, o quieres un resumen general del proyecto?"

### 3. Formato del reporte

---
## 📊 Estado del Proyecto — [Nombre del Proyecto]

### ✅ Completado
- [Lo que está hecho y funcionando]

### 🔄 En Progreso
- [Lo que está parcialmente hecho]

### ⏳ Pendiente
- [Lo que falta hacer]

### 🔴 Bloqueado
- [Qué está bloqueado y por qué]

### 📈 Próximo Paso Recomendado
[El siguiente paso más importante y concreto]

### 💡 Notas
[Contexto relevante, decisiones pendientes, dependencias]
---

Sé específico y accionable. No hagas el reporte genérico — muestra el estado real basado en los archivos que existen.
