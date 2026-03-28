---
description: Ejecuta un plan existente tarea por tarea con checkpoints de revisión. Úsalo cuando tengas un plan aprobado listo para implementar.
---

Ejecuta el plan de implementación de forma ordenada, con verificación en cada paso.

## Antes de empezar

1. Lee el archivo del plan completo
2. Identifica dependencias entre tareas
3. Si hay algo ambiguo o bloqueante, plantéalo ANTES de empezar (no durante)
4. Confirma con el usuario que está listo para proceder

## Ejecución

Para cada tarea del plan:

```
▶ Tarea [N]: [Nombre]
  Estado: En progreso...

  [ejecuta los pasos exactos del plan]

  Verificación: [resultado del comando/acción de verificación]

✅ Tarea [N] completada
   Commit: [mensaje del commit si aplica]
```

### Cuándo parar inmediatamente

- Aparece un error no contemplado en el plan
- Una dependencia está faltando
- El resultado de la verificación no coincide con lo esperado
- Las instrucciones son contradictorias

Cuando pares: reporta exactamente dónde estás, qué falló y qué información necesitas. No intentes improvisar un fix silencioso.

## Checkpoints

Después de cada 3 tareas (o después de una tarea crítica), muestra un resumen:

```
📊 Checkpoint — Progreso del plan
✅ Completadas: Tarea 1, 2, 3
⏳ Siguiente: Tarea 4
🔴 Bloqueadores: ninguno

¿Continúo con la Tarea 4?
```

Espera confirmación del usuario antes de continuar.

## Al terminar

Cuando todas las tareas estén completas:

1. Ejecuta la verificación final del plan (si existe)
2. Muestra resumen completo de lo que se hizo
3. Lista los archivos creados/modificados
4. Indica los próximos pasos sugeridos

## Nota sobre calidad

No marques una tarea como completa si la verificación no pasó. "Debería funcionar" no es una verificación. Corre el comando, lee el output, confirma el resultado.
