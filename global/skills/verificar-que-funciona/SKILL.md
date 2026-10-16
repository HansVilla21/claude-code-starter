---
name: verificar-que-funciona
description: Comprueba que algo funciona de verdad antes de decir que está listo — que el efecto quedó en su fuente de verdad (la base después de recargar, la ejecución real, la versión publicada), no solo que compiló, respondió 200 o se ve bien. Usar antes de reportar cualquier cosa como «hecha» o «funcionando», al revisar trabajo propio o de un agente antes de entregarlo, y cuando el usuario diga «¿seguro que funciona?», «¿lo probaste?», «se ve bien pero al recargar vuelve atrás», «respondió bien pero no pasó nada».
---

# Verificar que funciona

**«Compila», «corrió sin error», «respondió 200» o «se ve bien» no es «funciona».** Algo está
hecho cuando comprobaste su efecto real en la fuente de verdad de su capa —la base, la ejecución
real, la versión publicada—, no en la apariencia ni en la suposición.

## Cuándo usarla

- Estás por decir «listo» o «funciona»: una pantalla, un cambio en la base, una automatización, un
  webhook, una integración, un prompt publicado.
- Algo *parece* funcionar, pero no viste el efecto donde tiene que quedar.
- Vas a entregar o mergear trabajo, tuyo o de un agente.

## Por qué existe

En un proyecto real fallaron en una misma sesión cosas de capas distintas, y en todas se había
dicho «listo». No faltaba conocimiento: faltaba la disciplina de verificar. Se declaraba hecho lo
que *parecía* bien, no lo que estaba *probado*.

| Capa | Lo que se dijo | Lo que faltó |
|---|---|---|
| Publicación | «ya está publicado» | mirar la versión viva: seguía la vieja |
| Lógica | se predijo el resultado y se dio por bueno | correrlo de verdad una vez |
| Base de datos | se guardaba sin esperar la respuesta: no guardó nada, sin error | recargar y ver que quedó |
| Alcance | «ese botón no existe»; se arreglaron 2 de 8 y se dijo «resuelto» | buscar el texto real; terminar el barrido |

Mismo error, distinta capa. Y cada cosa a medias encima de otra a medias se vuelve imposible de
arreglar cuando llega lo grande.

## La fuente de verdad de cada capa

| Capa | Se comprueba en… | No alcanza con… |
|---|---|---|
| Pantalla que guarda datos | lo que muestra después de recargar | lo que se ve antes de recargar |
| Base de datos | el registro, consultado directo después de la acción | que no haya dado error |
| Automatización o bot | la ejecución real, paso por paso | verlo bien en el editor (puede mostrar una copia vieja) |
| API, webhook, función | el efecto que deja (el registro creado, el aviso enviado), con un evento real o simulado | «respondió 200», o leer el código |
| Publicación | la versión viva, comparada con la local | «el deploy terminó» |

- **Una pantalla que muestra el cambio antes de guardarlo miente** hasta que el guardado se
  confirma: esperá la respuesta y, si falla, volvé atrás y avisá.
- **«Corrió» no es «escribió».** En un proyecto real, un paso que guardaba registros marcaba
  «éxito» y no guardaba nada: tenía un nombre mal escrito, y la opción de seguir ante errores
  —correcta en producción, para que una falla no corte todo— lo volvía silencioso. El manejo de
  errores que necesitás en producción es el que esconde el bug en la prueba: contá los registros
  (y los duplicados), no mires el estado de la ejecución.

## Antes de decir «listo»: tres preguntas

1. ¿El camino completo se ejecutó de verdad, al menos una vez? No «compila», no «debería».
2. ¿El resultado quedó en la fuente de verdad de su capa?
3. ¿Qué pasa si falla? ¿Vuelve atrás, deja registro, avisa… o queda mostrando algo que no es?

Si no respondiste las tres con evidencia, no está hecho y no se reporta como hecho. Al reportar,
decí qué probaste y dónde viste el efecto.

**Señales de que no se verificó:** «se ve bien, pero al recargar vuelve atrás» (el guardado no
salió, o falló y la pantalla no volvió atrás); «en el editor está bien, pero responde lo viejo» (el
editor muestra una copia); «respondió 200 pero no pasó nada» (el 200 no prueba el efecto);
«debería funcionar», «creo que ya está».

## Cuando el que miente es el chequeo

En un proyecto real, en un mismo día, el código estaba bien y el chequeo mal, tres veces:

- **Decía que no existía algo que existía.** Una consulta mal armada devolvía cero resultados y se
  reportó que un registro no se había creado. Delator: cero resultados para algo que sabés que se
  cumple.
- **El reloj no avanzaba.** Una prueba de «pasó A y después B» falló porque A y B quedaron con la
  misma hora (corrían en la misma transacción). Si la prueba depende del orden en el tiempo, fijá
  las horas a mano.
- **Se midió una página muerta** (el peligroso, porque dio todo bien). Se revisaron 8 secciones en
  tamaño celular sin ningún problema, pero la página nunca había activado su parte interactiva: los
  clics no hacían nada y solo se medía la sección que ya venía abierta. Delator: las 8 daban
  resultados idénticos. Control: otra pantalla conocida tampoco reaccionaba; si un control conocido
  falla, el problema es el entorno, no tu código. Arreglo: medir contra la versión de producción y,
  antes de medir, comprobar que un clic cambia algo.

**La regla:** antes de creerle a un chequeo, preguntate qué tendría que pasar para que FALLE. Si no
hay respuesta, no mide nada; y la pregunta vale igual cuando el resultado es el que esperabas. Lo
más barato: **meté el error a propósito una vez** —un elemento de 500 px para ver si el control de
desbordes lo ve, un valor inválido para ver si la base lo rechaza—. Si no se pone rojo con el error
puesto a mano, tampoco se va a poner rojo con el de verdad.

## Si usás…

- **Supabase desde JavaScript:** una consulta sin `await` (o `.then()`) no se envía nunca:
  `void supabase.from(...).update(...)` no hace nada y no da error. Si una escritura «no toma» sin
  error, sospechá de RLS: probala con el rol de ese usuario dentro de una transacción con
  `rollback`. Si devuelve el registro, el problema está en la app; si no, en la política. Ahí
  adentro `now()` no avanza: para probar orden en el tiempo, usá `clock_timestamp()`.
- **n8n:** la verdad es la ejecución con sus datos (`includeData=true` en la API), nodo por nodo, y
  el workflow vivo comparado con tu JSON local (por hash). No el editor ni «el PUT dio 200».

## Ejemplo

Pedido: «Listo el aviso que se crea cuando entra un mensaje.»

- **Mal:** «Creé la función y los permisos. Quedó listo.» Nunca se mandó un mensaje de prueba.
- **Bien:** «Lo probé: mandé un mensaje de prueba y en la base apareció el aviso, para la persona
  asignada y con la conversación correcta. Probado, no supuesto.»
