---
name: tarjeta-de-hoy
description: Reduce un proyecto trabado a una sola tarea para hoy, escrita para hacerse sin decidir nada ni abrir otro archivo, con una cola de las que siguen. Usar cuando hay estrategia y herramientas de sobra pero el resultado no sale, o cuando el usuario diga «no sé por dónde empezar», «tengo todo pero no avanzo», «llevo semanas sin tocar esto», «estoy trabado», «necesito que sea más simple».
---

# Tarjeta de hoy: una sola cosa

Cuando un proyecto tiene estrategia, documentos y herramientas de sobra y el resultado sigue en
cero, no falta otro plan: sobran decisiones. Esta skill deja **un archivo con una sola tarjeta**,
lo único que hay que hacer hoy, lista para empezar sin pensar.

## Cuándo usarla

- Hay un sistema armado y documentado, y lo que tiene que entregar sigue en cero.
- Cada sesión empieza releyendo para reconstruir dónde se iba. Eso ya es la señal.
- Sirve para cualquier trabajo repetido que cuesta arrancar: publicar contenido, prospectar,
  cerrar pendientes, mandar reportes.

**Cuándo no:** si el bloqueo es técnico —falta un acceso, un permiso, una decisión de cómo
construir algo—. Eso se destraba, no se simplifica.

## Por qué existe

En un proyecto real de contenido pasaron unas tres semanas sin publicar una sola pieza, con 17
skills, 6 agentes y toda la estrategia escrita. No faltaba estrategia: faltaba claridad para el
día. Abrir el proyecto obligaba a decidir —qué tema, qué formato, qué skill usar— y en cada
decisión el usuario se caía. Más maquinaria lo empeoraba. Lo que funcionó fue **borrar
decisiones**: el sistema bajó a 11 skills y 4 agentes, y todo lo demás quedó detrás de un archivo
con una tarjeta.

**La trampa número uno:** que trabajar *en el sistema* reemplace a producir. Planear, documentar y
pulir la estrategia se siente productivo y no mueve el entregable. Si una sesión mejora el sistema
y otra vez no salió nada, el problema es el sistema.

## Pasos

1. **Confirmar que es esto.** ¿Cuántas unidades de resultado real salieron en las últimas dos
   semanas? Si son cero con el sistema ya armado, es esto. ¿Cuántas decisiones hay entre abrir el
   proyecto y empezar a producir? Si es más de una, también.
2. **Crear dos archivos en la raíz del proyecto**, no en `docs/`: si hay que buscarlos, no
   funcionan. `HOY.md`: una tarjeta, lo único de hoy. `COLA.md`: las próximas tres a cinco, las
   ideas sin pulir y la lista de hechas, con fecha.
3. **Escribir la tarjeta para alguien sin contexto.** Se tiene que poder hacer sin abrir otro
   archivo y sin decidir nada:
   - **Cero decisiones adentro.** Si dice «elegí uno de estos tres ángulos», está mal: elegí vos y
     dejá los otros como nota al pie.
   - **Lo que se copia, ya escrito:** el texto final para pegar, no instrucciones para escribirlo.
   - **Lo que hace falta de afuera, en lista:** «necesitás dos capturas: X e Y».
   - **El paso 1, físico y chico:** «abrí la cámara», no «definí el enfoque».
   - El documento largo (el guion completo, el detalle) va enlazado como opcional, **nunca** como
     requisito para arrancar.
4. **Rotar hablando.** En el `CLAUDE.md` del proyecto: cuando el usuario diga «listo», «hecho» o
   «dame la siguiente», la hecha pasa a «Hechas» en `COLA.md` con la fecha, y la próxima de la cola
   pasa a `HOY.md`.
5. **Reponer antes de que se vacíe.** En el `CLAUDE.md`: si en la cola quedan menos de dos
   tarjetas, se escriben nuevas desde las ideas sin pulir, pasando por el filtro de calidad del
   proyecto si lo tiene. Una cola vacía devuelve al usuario al problema del principio.
6. **Recordarla al empezar.** En el `CLAUDE.md`: si el usuario abre una sesión sin pedir nada
   concreto, se le recuerda **en una línea** qué dice `HOY.md`. Un resumen largo vuelve a cargar lo
   que esta skill vino a sacar.
7. **Poner una meta de salida, con número.** El sistema no crece hasta que produzca. Por ejemplo:
   «6 piezas publicadas, al ritmo que sea; hasta llegar, nada de funciones nuevas, integraciones
   ni automatizaciones». Sin la meta, la fase de «mejorar el sistema» se vuelve a abrir sola.

## Qué entrega

```
proyecto/
├── HOY.md      una tarjeta, se hace sin decidir nada
├── COLA.md     próximas (3 a 5), ideas sin pulir y hechas con fecha
└── CLAUDE.md   frases para rotar, regla para reponer y meta de salida
```

`HOY.md` tiene esta forma:

```markdown
# Hoy — Tarjeta N

> Esto es lo único que tenés que hacer hoy.

## <Verbo + entregable concreto>

**Paso 1 (físico, chico):** …

**Lo que necesitás de afuera:**
- …

**<El contenido, listo para copiar y pegar>**

---
Detalle completo (opcional): `ruta/al/documento.md`
```

## Ejemplo

**Entrada:** el proyecto de contenido de arriba, tres semanas sin publicar.

**Salida:** `HOY.md` con una tarjeta: el guion escrito, el texto de la publicación listo para
pegar, las dos capturas nombradas y quién sale en cámara, ya decidido. Los otros cuatro guiones,
en `COLA.md`. La maquinaria que sobraba, archivada, no borrada (skill `archivar-en-vez-de-borrar`). Meta: 6 piezas publicadas antes de
tocar el sistema.

## Señales de que se está aplicando mal

- La tarjeta tiene opciones o preguntas, o para arrancar hace falta abrir otro archivo → paso 3.
- La sesión termina con el sistema mejorado y el entregable igual → falta la meta del paso 7, o no
  se respeta.
- La cola llegó a cero y nadie repuso → falta la regla del paso 5 en el `CLAUDE.md`.

Relacionada: `perfil-del-usuario`, cuando lo que traba no es arrancar sino cómo se le responde.
