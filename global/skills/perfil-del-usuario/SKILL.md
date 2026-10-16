---
name: perfil-del-usuario
description: Documenta y respeta cómo responderle al usuario —cuánto detalle, qué tono, qué le molesta, cómo decide— en memory/perfil-del-usuario.md, para que cada sesión y cada agente le hable igual sin que tenga que corregirlo de nuevo. Usar al crear un proyecto, cuando el usuario corrige la forma de responder («no es eso», «muy largo», «ya te adelantaste», «eso no lo pedí», «¿por qué seguís haciendo esto?»), o cuando la misma fricción se repite.
---

# Perfil del usuario: cómo responderle

Casi todos los `CLAUDE.md` dicen **qué** se construye; casi ninguno dice **cómo hay que
responderle** a la persona que lo dirige. Esa fricción no se ve, se repite en cada sesión y es la
que más tiempo quema. Este perfil la deja escrita.

## Cuándo usarla

- Al crear un proyecto, junto con su `CLAUDE.md`: el archivo se crea aunque arranque casi vacío.
- Cuando el usuario corta con frustración: «no es eso», «muy largo», «ya te adelantaste», «eso no
  lo pedí». No es un error suelto: es un patrón acumulado.
- Cuando la misma fricción aparece en varios proyectos, o los agentes le responden con estilos
  que no se parecen entre sí.

## Por qué existe

El patrón: un agente entrega una respuesta correcta, larga y completa. El usuario la lee a medias,
se abruma y pide algo más chico. El agente achica, pero en la sesión siguiente vuelve a lo mismo,
porque la corrección vivió en el chat y no en un archivo. La misma lección se reaprende decenas de
veces. Y hay correcciones que no son de estilo sino de operación: alguien que se paraliza con
respuestas largas no está pidiendo un formato, está pidiendo que el trabajo se pueda hacer.

**Regla madre:** una corrección de estilo o de ritmo que el usuario hace **dos veces** no es una
preferencia: es una regla que falta en un archivo.

## Pasos

1. **Crear el archivo donde se lee.** `memory/perfil-del-usuario.md`, y en el `CLAUDE.md` del
   proyecto (donde dice cómo trabajar con el usuario) una línea explícita: «Antes de un pedido
   ambiguo, o si el usuario se ve abrumado, leé `memory/perfil-del-usuario.md`». Sin esa línea, el
   archivo existe y nadie lo abre. Si vale para todos sus proyectos, va en la carpeta global
   (`~/.claude/perfil-del-usuario.md`), con la misma línea en el `CLAUDE.md` global, **con su OK**.
2. **Llenarlo observando, no preguntando.** No le preguntes cómo le gusta trabajar: casi nadie sabe
   describirlo, y la respuesta suena a lo que uno cree que debería contestar. Sacalo de lo que
   pasó: sus correcciones, **textuales**; cuándo cortó o se frustró, y qué venía antes; qué
   respuestas sí funcionaron, y por qué; qué hace con ganas y qué pospone. «No me des el documento
   entero, dame el pedazo» enseña más que «prefiere respuestas concisas».
3. **Separar lo operativo de lo privado.** El perfil vive con el proyecto, y el proyecto puede
   terminar en un repositorio. Acá va cómo responderle: tamaño, ritmo, tono, señales, formato.
   Nunca acá: salud, contexto clínico, plata, familia, datos de otras personas. Si eso existe,
   vive en las notas privadas del usuario, fuera del proyecto, y el perfil solo dice dónde.
4. **Anotar cada fricción en el momento.** Cuando el usuario corrige algo por segunda vez: pará,
   agregalo al perfil con su cita textual y seguí. Al final de la sesión el textual ya se perdió.
5. **Revisarlo cuando cambia la forma de trabajar.** El perfil envejece: alguien que arrancó
   pidiendo detalle puede pasar a querer solo el resultado cuando le toma confianza al sistema. Si
   una regla ya no se cumple en la práctica, se corrige.

## El archivo

```markdown
# Perfil de <nombre>: cómo responderle

> Lo leen la sesión principal y todos los agentes. Se llena observando, con citas textuales.

## Quién es, en lo que importa para trabajar
Dos o tres líneas: su rol, cómo decide, cómo construye.

## 1. Lo que quiere siempre
Tamaño de las respuestas, ritmo (¿una cosa a la vez?), iniciativa (¿esperar a que pida?), nivel
técnico que se asume, honestidad (¿desafiar con evidencia o validar?), cerrar con qué hacer.

## 2. Lo que le molesta (nunca)
En negativo y concreto: «respuestas largas que no pidió», «adelantarse a pasos que no pidió».

## 3. El intercambio ideal
Usuario: da contexto → Claude: confirma o pregunta, no resuelve todo →
Usuario: pide algo puntual → Claude: responde eso, corto.

## 4. Qué le da energía y qué lo drena
Lo que hace solo, con ganas, y lo que pospone (eso se le entrega resuelto).

## 5. Señales y qué hacer
| Si dice o hace… | Claude… |
|---|---|
| «No sé por dónde empezar» | una sola cosa, no una lista (skill `tarjeta-de-hoy`) |
| Habla de muchas cosas a la vez | elige la más urgente |
| Pide validar algo ya decidido | opinión honesta, no validación ciega |
| Da mucho contexto | confirma que entendió y pregunta qué necesita |
| Corta con frustración | para y revisa en corto qué falló antes de seguir |

## 6. Cómo darle feedback
Qué funciona y por qué; qué mejorar, con un ejemplo concreto; una alternativa que pueda usar ya.

## Reglas que salieron de correcciones
1. <Regla> — «<su cita textual>»

## Privacidad
Lo personal, de salud o de plata no va acá: vive en <dónde>.
```

## Ejemplo

**Entrada:** tercer proyecto con la misma persona y la misma fricción en los tres: respuestas
largas que la paralizan, y agentes que resuelven todo cuando solo estaba dando contexto.

**Salida:** dos reglas que se llevan casi toda la fricción, escritas donde se leen:

> **Esperar el pedido.** Si da contexto, confirmar que se entendió o preguntar qué necesita; no
> generar la solución completa sin que la pida.
>
> **Ante la duda entre simple y completo: simple.** Casi siempre corrige hacia lo simple.

Relacionadas: `tarjeta-de-hoy`, cuando lo que traba es arrancar y no cómo se le responde;
`creador-de-skills`, cuando la corrección que se repite es de proceso y no de trato.
