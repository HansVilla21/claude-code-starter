---
name: crear-agente
description: Suma un agente especializado al proyecto cuando aparece un rol que conviene separar — un revisor, un investigador, alguien que arma un tipo de entregable. Usar cuando el usuario diga «necesito un agente que…», «armemos un equipo para…», o cuando el trabajo muestra un rol que se repite y pide su propio criterio.
---

# Crear un agente

En un proyecto de agentes, la sesión principal es la orquestadora: entiende lo que pide el
usuario, decide quién lo hace y consolida la respuesta. Los agentes son especialistas a los que
delega. **Se crean cuando aparece el rol, no antes:** un agente que nadie usa es peso muerto.

## Cuándo sí

- Un tipo de trabajo se repite y necesita su propio criterio: revisar, investigar, armar un
  entregable con reglas propias.
- Conviene que lo haga alguien con contexto limpio, sin todo lo de la conversación: por ejemplo,
  un revisor que no se enamore de lo que escribió el orquestador.
- Se pueden hacer varias cosas en paralelo.

**Cuándo no:** un paso que se hace una vez, o un proceso que alcanza con una skill. Una skill es
el *cómo* de una tarea; un agente es *quién* la hace, con su criterio.

## Cómo

1. Nombre corto en kebab-case, por el rol: `revisor`, `investigador`, `armador-de-planes`.
2. Creá `.claude/agents/<nombre>.md`:

```markdown
---
name: <nombre>
description: Qué hace y cuándo delegarle. Con ejemplos de pedidos.
tools: Read, Grep, Glob, Write, Edit
---

Sos <rol> de <proyecto>. <Qué hacés, para quién, con qué criterio.>

## Qué recibís
## Qué entregás (formato y dónde se guarda)
## Reglas
- Lo que nunca hacés.
- Cuándo parás y le preguntás al orquestador.
## Qué leés antes de empezar
```

3. `tools`: solo las que necesita. Un revisor no escribe: `Read, Grep, Glob`.
4. Sumalo a la tabla de orquestación del `CLAUDE.md` del proyecto: qué pedidos van a este agente.
5. Probalo con un pedido real antes de darlo por bueno.

## La prueba

Si el orquestador no sabe cuándo delegarle, la `description` está mal escrita. Si el agente
necesita preguntar lo que ya estaba en el proyecto, le falta decir qué leer antes de empezar.
