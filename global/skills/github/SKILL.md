---
name: github
description: Cómo se trabaja con git y GitHub sin perder nada ni filtrar secretos — crear el repositorio, ramas, pull requests, merge, varias sesiones en paralelo y respaldo. Usar cuando el usuario diga «subí esto a GitHub», «creá el repo», «abrí un PR», «mergealo», «hagamos un respaldo», o antes de trabajar con git en un proyecto que todavía no tiene reglas.
---

# Trabajar con GitHub

Estas reglas salen de errores reales: sesiones que se pisaron el trabajo, un `.env` subido a un
repo de respaldo, cambios de rama que rompieron lo que otra sesión estaba haciendo.

## 1. Crear el repositorio

- **Privado por defecto.** Público solo si el usuario lo decide para ese repo.
- Antes del primer commit: `.gitignore` con `.env`, `.env.*`, `!.env.example`,
  `CLAUDE.local.md`, las dependencias y las carpetas con datos sensibles. Verificá con
  `git status` que nada de eso aparece.
- Con la CLI de GitHub: `gh repo create <nombre> --private --source . --push`, con el OK del
  usuario.

## 2. Cada trabajo en su rama

- Nunca se trabaja ni se hace commit en `main`.
- Una rama por tarea: `feat/<nombre>`, `fix/<nombre>`, `docs/<nombre>`, `refactor/<nombre>`.
- Commits chicos, que se entiendan solos: `tipo: descripción`, en el idioma del proyecto.
- Antes de cada commit: sin secretos, sin `.env`, sin datos sensibles (skill `commit`).

## 3. Pull request y merge

- El trabajo vuelve a `main` por un pull request (`gh pr create`), con un título claro y en el
  cuerpo qué cambia, por qué y cómo se probó.
- **Se mergea solo cuando el usuario lo dice.** En proyectos con deploy automático, mergear es
  publicar: el OK es explícito, cada vez.
- **Antes de mergear, mirá a dónde va:** `gh pr view <n> --json baseRefName`. Que el PR diga
  «mergeable» no dice a qué rama entra; en un proyecto real, dos PRs quedaron «mergeados» en otra
  rama y nunca llegaron a producción.
- Después del merge: volver a `main`, `git pull`, borrar la rama. Un push a una rama no es un
  cambio entregado: lo entregado es lo que está en `main`.
- Para que nadie commitee en `main` por error, aunque se olvide la regla: skill
  `proteger-main-con-hook`.

## 4. Varias sesiones a la vez

- **Una sesión, una carpeta.** Si dos sesiones de Claude trabajan en el mismo proyecto, cada una
  usa su propio worktree (`git worktree add ../<proyecto>-<tarea> -b feat/<tarea>`).
- Nunca cambies de rama en la carpeta donde otra sesión está trabajando: le cambiás los archivos
  bajo los pies.
- Antes de escribir en `memory/` o en un handoff, mirá `git status` y la fecha del archivo: otra
  sesión pudo haberlo actualizado. Se suma, no se pisa.
- El detalle, y cómo recuperar algo que «se perdió»: skill `sesiones-en-paralelo`.

## Antes de hacer público un repo

- Sin claves, sin rutas absolutas de tu computadora, sin nombres de clientes ni datos personales.
- Revisá el `.gitignore`: una regla mal escrita puede esconder archivos que sí querías publicar,
  o mostrar los que no.
- Los commits muestran tu correo. Para no publicarlo, usá el correo privado que te da GitHub
  (`git config --local user.email <id>+<usuario>@users.noreply.github.com`) desde el primer commit.

## 5. Respaldo

- El respaldo es el repositorio privado en GitHub, al día: commit y push al cerrar cada sesión
  de trabajo, con el OK del usuario.
- **Nunca** se copia un `.env` a un repo de respaldo ni a un espejo: queda en el historial para
  siempre. Las claves se respaldan en un gestor de contraseñas. Si una clave ya llegó a git, se
  cambia en el servicio que la emitió; borrarla del archivo no alcanza.
- Antes de sacar una carpeta del control de git (`git rm --cached`), copiala aparte: en un
  proyecto real, sacar `memory/` de git y hacer un `pull` borró trabajo que no tenía copia.

## 6. Lo que pide OK explícito

Crear un repo, hacer público uno privado, `push`, mergear, borrar ramas remotas, reescribir
historia (`rebase` de lo ya subido, `push --force`). Nunca `--force` sobre `main`.
