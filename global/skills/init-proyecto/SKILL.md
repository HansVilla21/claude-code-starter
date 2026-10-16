---
name: init-proyecto
description: Crea un proyecto nuevo de Claude Code, organizado como un equipo de agentes y listo para aprender con el uso — un CLAUDE.md orquestador que describe el trabajo real, la memoria y las carpetas de entrada y salida. Usar cuando el usuario diga «creemos un proyecto», «inicializá esto», «armemos un proyecto para…», o cuando se abre una carpeta sin CLAUDE.md y el usuario quiere empezar a trabajar ahí.
---

# Crear un proyecto

Todo proyecto es un proyecto de agentes: la sesión principal orquesta y los especialistas se
suman cuando aparece el rol. Funciona bien cuando su `CLAUDE.md` describe el trabajo real, con las
palabras del usuario, y su memoria se llena con el uso. **No se llena de agentes ni de
procedimientos antes de tiempo: lo que todavía no se usó, no se escribe.**

## 1. Mirar la carpeta

- Si ya hay un `CLAUDE.md`, no lo pises: preguntá si se completa o se deja como está.
- Si hay archivos del usuario (plantillas, documentos, ejemplos), anotalos: son contexto.

## 2. Entender el trabajo

Si el usuario ya contó el contexto, usalo y no lo vuelvas a preguntar. Si falta, preguntá **en un
solo mensaje**, como máximo esto:

1. ¿Cómo se llama el proyecto y qué va a hacer?
2. ¿Quién lo usa y para qué trabajo concreto? Qué hace hoy a mano, cuánto tarda, qué le pesa.
3. ¿Qué tiene que entregar? Un documento, un Excel, código, publicaciones…
4. ¿Va a manejar datos sensibles? De clientes, pacientes, plata.

No preguntes «qué tipo de proyecto es»: se deduce de lo que contó.

## 3. Crear la estructura

```
.
├── CLAUDE.md            el orquestador: qué es, cómo se trabaja, a quién se le delega qué
├── README.md            dos líneas: qué es y cómo se empieza
├── .gitignore
├── .claude/
│   ├── agents/          los especialistas (se suman con crear-agente)
│   └── skills/          los procesos (se suman con creador-de-skills)
├── memory/
│   ├── proyecto.md
│   ├── tareas-activas.md
│   ├── decisions.md
│   ├── learnings.md
│   └── perfil-del-usuario.md   cómo responderle (skill perfil-del-usuario)
├── inputs/              lo que trae el usuario: documentos, transcripciones, ejemplos
└── outputs/             lo que produce el proyecto
```

`.gitignore` siempre con `.env`, `.env.*`, `!.env.example` y `CLAUDE.local.md`, más las carpetas
con datos sensibles. `.env.example` solo si el proyecto va a usar claves.

Según lo que contó el usuario, sumá solo lo que aplica:

| Si el trabajo… | Se agrega |
|---|---|
| usa formatos que el usuario ya tiene (su Excel, su Word) | `plantillas/`, con esos archivos copiados tal cual |
| consulta registros seguido (clientes, catálogo, biblioteca) | `datos/`; si son sensibles, en `.gitignore` y nunca sale de la computadora |
| tiene código (app, web, script, automatización) | `src/` y `docs/`; con su OK, `git init` y la rama `feat/arranque` (skill `github`); en el `CLAUDE.md`, cómo se corre y cómo se prueba |
| es de contenido o marca | `memory/marca.md` (voz, audiencia, lo que sí y lo que no se dice) y `outputs/piezas/` |

## 4. Agentes de arranque

Si lo que contó el usuario ya muestra roles claramente distintos —por ejemplo, uno que arma el
entregable y otro que lo revisa—, proponé hasta tres agentes en una línea cada uno y crealos con
su OK, con la skill `crear-agente`. Si no, ninguno: el orquestador hace el trabajo y los agentes
aparecen con el uso.

## 5. Escribir el CLAUDE.md

Con las palabras del usuario, nunca genérico. Menos de 150 líneas. Lo que todavía no se sabe se
escribe «por definir», no se inventa.

```markdown
# <Nombre>

## Qué es
## Para quién y qué trabajo resuelve
Qué hace hoy a mano, cuánto le toma, qué quiere que cambie.
## Qué entrega
## Cómo se organiza
Esta sesión es la orquestadora. Tabla: pedido → quién lo hace (directo, agente o skill).
Arranca con «todo lo hace el orquestador» y crece con el uso.
## Cómo trabajar con <usuario>
Idioma, tono, cuánto detalle, qué preguntarle y qué no. Y la línea: «Antes de un pedido ambiguo,
o si el usuario se ve abrumado, leé memory/perfil-del-usuario.md».
## Reglas de este proyecto
Datos sensibles, lo que nunca se hace, lo que pide confirmación.
## Cómo aprende
- Lo que el usuario trae se guarda en inputs/ el mismo día.
- Al terminar algo que valga, se anota en memory/ sin pedir permiso.
- Un proceso que se hizo dos veces y funcionó se vuelve skill (creador-de-skills).
- Un rol que se repite se vuelve agente (crear-agente).
- Al cerrar la sesión: checkpoint.
## Lo primero que se lee
1. memory/tareas-activas.md
2. El session-handoff más reciente
3. memory/decisions.md y memory/learnings.md
## Estructura
```

## 6. La memoria inicial

- `memory/proyecto.md`: «Creado: AAAA-MM-DD», qué es y «Estado: recién creado».
- `memory/tareas-activas.md`: el primer trabajo real, con fecha.
- `memory/decisions.md`: el formato de abajo y la primera decisión: por qué existe el proyecto.
- `memory/learnings.md`: el formato de abajo, sin entradas.
- `memory/perfil-del-usuario.md`: con lo que el usuario ya dejó ver de cómo le gusta trabajar; si
  todavía no hay nada, la plantilla de la skill `perfil-del-usuario` casi vacía. Se llena
  observando, no preguntando.

```markdown
## AAAA-MM-DD — Título corto
**Decisión:** qué se decidió y quién.
**Por qué:** la razón, con las palabras del usuario si las dijo.
**Consecuencia:** qué cambia.
```

```markdown
## AAAA-MM-DD — Título corto
**Qué pasó:** los hechos.
**Causa raíz:** por qué pasó de verdad, no el síntoma.
**Qué hacemos distinto:** la regla nueva.
```

## 7. Cerrar

Un resumen corto: qué se creó y **un primer trabajo real**, concreto, con lo que el usuario ya
tiene a mano. Ese primer trabajo es el que empieza a entrenar el proyecto.
