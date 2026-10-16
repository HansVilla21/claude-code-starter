---
name: matar-el-olor-a-ia
description: Encuentra las señales de que un texto lo escribió una IA y las quita sin cambiar lo que dice. Usar antes de publicar o mandar un texto hecho o ayudado con IA (un post, un email, un mensaje, una página), o cuando el usuario diga «suena a IA», «que no parezca escrito por ChatGPT», «revisá cómo suena».
---

# Matar el olor a IA

## Cuándo usarla

- Antes de publicar o mandar un texto que se escribió o se ayudó con IA: una página, un email, un
  post, un mensaje, documentación pública.
- Cuando el usuario dice «suena a IA», «no suena a nosotros», «muy corporativo».
- Es el **último paso** antes de publicar. Si el texto también tiene problemas de estructura o de
  argumento, eso se arregla antes; esta skill solo caza las señales.

## Por qué existe

El texto que escribe una IA es correcto y **reconocible**. Sale del promedio de millones de
textos, y ese promedio deja huellas muy estables: las mismas frases para arrancar, el mismo ritmo
parejo, la misma lista de tres, los mismos adjetivos sin sustancia.

Se cuela porque se lee bien. Lo que lo delata es el **patrón**, y el patrón solo se ve si se lo
busca a propósito, con una lista. El lector ya reconoce el molde aunque no sepa nombrarlo, y un
texto con olor a IA le parece **desatendido**.

**Regla madre:** se cambia la textura y se deja el contenido. Si al reescribir se movió una
afirmación, apareció un dato nuevo o se suavizó una promesa, salió mal.

## Pasos

### 1. Conseguir una muestra de la voz real

Antes de reescribir, buscá uno o dos textos escritos por una persona del proyecto: emails,
mensajes a clientes, posts viejos. Sin esa referencia, la reescritura cae en otro promedio, más
informal pero igual de genérico. Si no hay muestra, decilo; no inventes una voz.

### 2. Detectar: pasar el texto por la lista y marcar cada hallazgo

- **Frases plantilla para arrancar o cerrar:** «en el mundo actual», «hoy en día», «en la era
  digital», «imaginá un mundo donde», «ya sea que…», «en resumen», «en conclusión», «espero que
  te sirva».
- **Relleno de modelo:** «potencia», «desbloquea», «revoluciona», «transforma», «aprovecha»,
  «robusto», «escalable», «innovador», «fluido», «llevá tu X al siguiente nivel».
- **Paralelismo negativo, tolerancia cero:** «no se trata de X, sino de Y», «esto no es solo X,
  es Y», «no es magia, es método». Es la señal número uno, aparece en casi todo texto generado y
  se sacan todas sus formas.
- **Ritmo parejo:** todas las oraciones de largo parecido (15 a 22 palabras) y ningún fragmento.
  Una persona escribe irregular: una oración larga y después tres palabras.
- **Simetría mecánica:** una intro para entrar en calor, exactamente tres puntos del mismo tamaño
  y un cierre que repite lo ya dicho. La lista de tres perfecta delata.
- **Adjetivos en fila** que no se pueden comprobar ni desmentir: «potente, escalable e innovador».
- **Puntuación de máquina,** sobre todo en chats: guiones largos (—) de más, punto final en cada
  línea, «¿» de apertura en un mensaje casual, dos puntos donde iría un salto de línea.
- **Cierres que piden interacción:** «¿Qué opinás?», «Etiquetá a alguien que…», emojis de adorno.

### 3. Romper el ritmo

- Partí en dos al menos una de cada tres oraciones largas, y que una mitad quede corta (menos de
  ocho palabras).
- Meté un fragmento sin verbo donde caiga natural. «Cada vez.» «Vale la pena.»
- Dejá asimétrica, a propósito, alguna estructura paralela perfecta.

### 4. Cambiar lo abstracto por lo concreto, sin inventar

Donde el texto sea genérico, poné un número real en lugar de «muchos» o «significativo»; una
herramienta, un lugar o un tipo de negocio con nombre; un detalle que solo sabe quien lo hizo.
**Si el dato no existe, no se fabrica:** se marca `[PENDIENTE: dato real]` y se le pide al
usuario. Un número inventado es peor que un texto genérico: el genérico aburre, el inventado se
cae cuando alguien pregunta.

### 5. Reescribir sin mover lo que se afirma

Conservá exactamente lo que el texto afirma y promete, y también las mañas del autor si las tiene:
arrancar en minúscula, sus muletillas. Si lo pulís de más, queda plano.

### 6. Verificar y dar un veredicto

Releé buscando dos cosas: si quedó alguna señal de la lista y si el significado quedó intacto.
Cerrá con un veredicto explícito: **humano**, **mixto** o **todavía huele a IA**, y qué falta.

## Qué entrega

```markdown
## Señales encontradas
- [paralelismo negativo] "no es solo una herramienta, es tu centro de operaciones" → línea 4
- [ritmo parejo] 6 oraciones seguidas de 18 a 21 palabras → párrafo 2

## Versión reescrita
[el texto, listo para usar]

## Veredicto
mixto: falta un número real donde se habla de los clientes. [PENDIENTE: cuántos clientes activos]
```

## Ejemplo

**Entrada:** «En el mundo actual, gestionar clientes no se trata solo de guardar datos, sino de
construir relaciones. Nuestra plataforma robusta y escalable te permite desbloquear todo el
potencial de tu equipo comercial y llevar tu negocio al siguiente nivel.»

**Señales:** frase plantilla de arranque, paralelismo negativo, relleno de modelo («robusta»,
«escalable», «desbloquear»), cierre plantilla y ningún dato que se pueda comprobar.

**Salida:** «Tus clientes están repartidos entre WhatsApp, una hoja de cálculo y la memoria de
alguien. Acá quedan en un solo lugar, con la conversación completa. [PENDIENTE: dato real,
cuántos negocios lo usan hoy]»

**Veredicto:** mixto, falta el dato. Se conservó lo que afirmaba el original (junta a los clientes
en un solo lugar) y se fue la promesa vaga del «siguiente nivel», que no afirmaba nada.
