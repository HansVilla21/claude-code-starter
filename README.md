# Claude Code Starter Kit

Lo que hace falta para que Claude Code trabaje bien desde el primer día: las reglas globales que
usamos en Momentum AI y las skills con las que trabajamos todos los días —crear proyectos, guardar
la memoria, revisar, cuidar la seguridad, trabajar con GitHub y hacer crecer cada proyecto con
el uso—. Se instala una vez y vale para todos tus proyectos.

## Qué incluye

**Un `CLAUDE.md` global**, con las reglas que valen en todos tus proyectos: hablar en lenguaje
natural, orquestar agentes, planificar antes de ejecutar, la memoria de cada proyecto, cómo crecen
las skills, seguridad y GitHub.

**Diecisiete skills.** No hace falta escribir comandos: se activan por lo que decís. Casi todas
salieron de errores reales en proyectos de verdad.

**Arrancar y ordenarse**

| Decí algo como… | Skill | Qué hace |
|---|---|---|
| «Creemos un proyecto para…» | `init-proyecto` | Arma el proyecto como un equipo de agentes: el `CLAUDE.md`, la memoria y las carpetas, liviano y listo para aprender |
| «Así me gusta que me respondas» | `perfil-del-usuario` | Aprende y respeta cómo responderte: cuánto detalle, qué tono, qué te molesta |
| «Estoy trabado» | `tarjeta-de-hoy` | Reduce todo a una sola cosa para hoy |

**Memoria y crecimiento**

| Decí algo como… | Skill | Qué hace |
|---|---|---|
| «Guardá todo», «vamos a cerrar» | `checkpoint` | Guarda decisiones, aprendizajes y tareas, y deja un resumen para la próxima sesión |
| «¿En qué vamos?» | `progress` | Qué está hecho, qué falta y qué está trabado |
| «Convertí esto en una skill» | `creador-de-skills` | Vuelve skill un proceso que ya funcionó |
| «Necesito un agente que…» | `crear-agente` | Suma un especialista cuando aparece el rol |
| «Limpiemos lo que no se usa» | `archivar-en-vez-de-borrar` | Saca skills y agentes que nadie usa, sin perderlos |

**Calidad**

| Decí algo como… | Skill | Qué hace |
|---|---|---|
| «¿Funciona de verdad?» | `verificar-que-funciona` | «Compila» o «se ve bien» no es «funciona»: lo prueba donde importa |
| «Revisá esto» | `review` | Revisa lo hecho contra las reglas del proyecto, por gravedad |
| «¿Hay algo inseguro?» | `security-check` | Busca claves y datos sensibles expuestos |
| «Que no suene a IA» | `matar-el-olor-a-ia` | Le saca a un texto las marcas de que lo escribió una IA |
| «Entreguemos esto» | `reporte-de-traspaso` | El documento para que un proyecto no muera con quien lo hizo |

**Git y GitHub**

| Decí algo como… | Skill | Qué hace |
|---|---|---|
| «Hacé commit» | `commit` | Guarda los cambios en git sin secretos y sin tocar `main` |
| «Subí esto a GitHub» | `github` | Repos privados, ramas, pull requests, merge y respaldo |
| «Abrí otra sesión» | `sesiones-en-paralelo` | Varias sesiones en el mismo proyecto sin pisarse, y cómo recuperar lo que «se perdió» |
| «Que no se pueda commitear en main» | `proteger-main-con-hook` | Un hook que bloquea los commits en `main` aunque alguien se olvide de la regla |

## Instalación

### La fácil: que Claude Code lo instale

Abrí Claude Code en cualquier carpeta y pegá esto:

```
Instalá el Claude Code Starter Kit desde https://github.com/HansVilla21/claude-code-starter: descargalo en una carpeta temporal, corré el instalador que corresponde a mi sistema (install.ps1 en Windows, install.sh en Mac o Linux), mostrame qué quedó instalado en mi carpeta .claude y borrá la carpeta temporal.
```

### Windows, a mano (PowerShell, no hace falta Git)

```powershell
$z="$env:TEMP\starter.zip"; Invoke-WebRequest https://github.com/HansVilla21/claude-code-starter/archive/refs/heads/main.zip -OutFile $z; Expand-Archive $z "$env:TEMP\starter" -Force; powershell -ExecutionPolicy Bypass -File "$env:TEMP\starter\claude-code-starter-main\install.ps1"
```

### Mac o Linux, a mano

```bash
git clone https://github.com/HansVilla21/claude-code-starter /tmp/claude-code-starter && bash /tmp/claude-code-starter/install.sh && rm -rf /tmp/claude-code-starter
```

El instalador respalda todo lo que reemplaza en `.claude/backups/` y no toca tu `settings.json`.

## Primer uso

Abrí Claude Code en una carpeta vacía y contale qué querés, como se lo contarías a alguien:

> «Creemos un proyecto para armar los planes de entrenamiento de mis clientes. Hoy los hago en
> Excel y cada uno me lleva dos horas.»

Claude arma el proyecto, te pregunta lo justo y te propone el primer trabajo real. Después
trabajás normal: al cerrar decís «guardá todo», y cuando algo se repite, Claude te propone
convertirlo en skill.

## Cómo funciona un proyecto

- **La sesión principal orquesta.** Entiende lo que pedís, decide quién lo hace y te responde.
  Los agentes especialistas se suman cuando aparece un rol que se repite.
- **La memoria vive en el proyecto** (`memory/`) y se actualiza sola: decisiones, aprendizajes,
  tareas y un resumen al cerrar cada sesión.
- **Las skills salen del uso.** Se escriben cuando un proceso ya funcionó, no antes. Un proyecto
  que arranca liviano y aprende trabajando le gana a uno lleno de procedimientos que nadie usó.
- **Los datos sensibles no salen de tu computadora.** Nunca a GitHub.

## Si tenías la versión 1

- El instalador mueve al respaldo los comandos viejos que ahora son skills (`init-proyecto`,
  `commit`, `review`, `progress`, `security-check`). Los demás quedan donde estaban.
- Si tu `settings.json` tiene el hook de la v1 (`verify-no-secrets.py` con `python3`) y te da
  error, sacalo de ahí: la v2 ya no lo usa.

## Qué cambió en la versión 2

- Skills en lugar de comandos: se activan hablando.
- `init-proyecto` ya no pregunta el tipo de proyecto: todo proyecto es de agentes, y arranca
  liviano.
- Skills nuevas: `checkpoint`, `github`, `creador-de-skills`, `crear-agente`,
  `verificar-que-funciona`, `perfil-del-usuario`, `tarjeta-de-hoy`, `sesiones-en-paralelo`,
  `proteger-main-con-hook`, `matar-el-olor-a-ia`, `archivar-en-vez-de-borrar` y
  `reporte-de-traspaso`.
- Las reglas globales, al día con cómo trabajamos hoy.
- El instalador respalda con fecha, no toca `settings.json`, no necesita Python y funciona en el
  PowerShell que trae Windows.

## Créditos

Hecho por [Hans Villalobos](https://instagram.com/hansvilla.ai) — Momentum AI.
