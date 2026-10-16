---
name: sesiones-en-paralelo
description: Cómo trabajar con dos o más sesiones de Claude Code en el mismo proyecto sin que git pierda o mezcle trabajo en silencio, y cómo encontrar un cambio que «se perdió». Usar cuando el usuario abre dos sesiones en el mismo proyecto o dice «trabajemos en paralelo», «abrí otra sesión», «se perdió un cambio», «¿dónde quedó mi commit?», «los archivos volvieron atrás», y antes de escribir en memory/ o en un handoff con otra sesión abierta.
---

# Sesiones en paralelo

La skill `github` pone la base: una sesión, una carpeta. Esta cubre los errores de git que pierden o
mezclan trabajo **sin dar error**: todo parece en orden, y el trabajo se perdió o quedó en otro commit.

## 1. Antes de tocar nada: ¿hay alguien más?

`git branch --show-current && git status --short`. Si la rama no es la que esperabas, o cambió
entre dos comandos tuyos, hay otra sesión (o el usuario en otra terminal). Avisá y pasá a un worktree:

- Trabajá siempre con la ruta explícita (`git -C "<worktree>" status`). La carpeta del otro no se toca.
- Si la rama que necesitás está abierta en otra carpeta, git la rechaza (*is already used by
  worktree*). Trabajá sobre el remoto: `git worktree add --detach "<ruta>" origin/<rama>` y al final
  `git -C "<ruta>" push origin HEAD:<rama>`. Avisá que la otra copia necesita `git pull`.
- En Windows, una ruta muy larga hace fallar el worktree con `Filename too long`: usá una más corta.
- Al terminar: `git worktree remove "<ruta>"`, `git worktree prune` y `git worktree list`.

## 2. Al guardar: nunca `git add -A`

En un proyecto real, dos sesiones en la misma rama y la misma carpeta dejaron un commit que compilaba
y al que le faltaba la mitad del trabajo: un `git add -A` de una barrió lo que la otra no había
guardado, y el editor revirtió archivos que tenía abiertos.

- **Agregá archivo por archivo.** Nunca `git add -A` ni `git add .` con otras sesiones trabajando.
- Si se coló un archivo que no escribiste, es de otro: `git restore --staged <archivo>` y avisá.
  Si el commit ya se hizo y no se subió (`git branch -r --contains HEAD` vacío):
  `git reset --soft HEAD~1` y el mismo `restore --staged`. El trabajo ajeno vuelve a quedar como estaba.
- **Cerrá en el editor los archivos que Claude va a tocar:** la versión vieja abierta se guarda encima.

## 3. Scripts de varios pasos: que el paso que falla frene a los demás

Cada línea de un bloque corre aunque la anterior haya fallado. En un proyecto real falló un
`git worktree add`, falló el `cd`, y el `git add` y el `git commit` corrieron en la carpeta
principal: se llevaron el trabajo sin guardar de otra sesión con el mensaje de esta.

- En la terminal de Claude Code en Windows (Git Bash), **`set -e` no frena**:
  `(set -e; false; echo sigo)` imprime `sigo`. Probalo antes de confiar en él.
- **`|| exit 1` en cada paso que escribe**, y **confirmá la rama antes del primer `git add`**: un `cd`
  que falla te deja donde estabas, y hasta `git -C` sube al repo de arriba si la carpeta no es uno.

```bash
[ "$(git -C "$REPO" branch --show-current)" = "feat/mi-rama" ] || { echo "PARO: rama inesperada"; exit 1; }
git -C "$REPO" add docs/notas.md || exit 1
```

## 4. Antes de escribir en `memory/` o en un handoff

En un proyecto real, una sesión sobrescribió el handoff que otra acababa de crear. Antes de escribir:
`git status --short` y `ls -l <archivo>`. Si cambió desde que lo leíste, releelo y sumá; no lo pises.

## 5. Un archivo que todas las sesiones tocan

Un índice, un CHANGELOG, un catálogo numerado. En un proyecto real, cuatro sesiones agregaron al mismo
índice: tres de los cuatro PR reclamaron el mismo número, todos menos el primero quedaron en
conflicto y el total quedó mal en los cuatro. Ninguna se equivocó: el archivo asumía un solo escritor.

- **El número se reclama en el PR:** antes de usar uno, `gh pr list --state open`. Si otro PR abierto
  ya lo tiene, gana el que abrió primero: tomá el siguiente.
- **Los totales se cuentan contra el disco** después de cada merge, nunca «lo que había más lo mío».
- **El conflicto se resuelve con los dos bloques.** Elegir un lado borra el trabajo del otro, y como
  el archivo sigue siendo válido, nadie se entera. Peor aún: si los agregados caen en lugares
  distintos, git los mezcla solo, sin conflicto, y el total de arriba queda mintiendo.

## 6. Un push a una rama no es un cambio entregado

En un proyecto real, un cambio se subió a una rama cuyo PR se había mergeado un minuto antes: la rama
quedó al día, el PR decía `MERGED` y el cambio nunca llegó a `main`. Confirmalo siempre:

```bash
gh pr view <número> --json state,mergedAt     # después de subir: ¿el PR sigue abierto?
git fetch origin && git merge-base --is-ancestor <tu-commit> origin/main && echo "llegó" || echo "NO llegó"
```

## 7. Si algo «se perdió»: primero el reflog

¿Los archivos volvieron atrás solos, o `HEAD` apunta a otro lado? Casi siempre alguien hizo
`git checkout` en la misma carpeta desde otra terminal. Antes de dar nada por perdido:

```bash
git reflog -10                      # qué pasó, en orden
git branch -a --contains <sha>      # vacío = commit huérfano: existe, pero en ninguna rama
git diff <sha> HEAD -- <archivo>    # ¿el contenido ya llegó por otro camino?
git cherry-pick <sha>               # si no llegó, rescatalo ya: git limpia los huérfanos con el tiempo
```

## 8. Otras dos trampas que no avisan

**Dejar de versionar una carpeta borra lo que no estaba guardado.** En un proyecto real,
`git rm -r --cached memory` más un merge y un `git pull` borraron del disco ediciones sin commit.
Antes, copiala aparte (`cp -r memory ../memory-respaldo`) o commiteá su contenido. Desde ahí no tiene
respaldo en git: definí otro. `git status` limpio es «todo lo que git sigue está guardado», no «todo».

**Varias cuentas de GitHub en Windows.** Si el administrador de credenciales pregunta la cuenta en
cada push, o sube con la equivocada, fijala por repo, nunca global:
`git config credential.https://github.com.username <tu-usuario>` y
`git remote set-url origin https://<tu-usuario>@github.com/<dueño>/<repo>.git`. Si sigue, borrá en
el Administrador de credenciales de Windows las entradas `git:https://github.com` de otras cuentas.

## Anexo: commitear en otra rama sin tocar una carpeta con trabajo ajeno

Avanzado. Sin worktree posible y con trabajo ajeno sin guardar en la carpeta, armá el commit con la
plomería de git, sin tocar el índice de nadie. Rutas absolutas (en Windows, estilo `C:/`):

```bash
export MSYS_NO_PATHCONV=1    # Git Bash: que no convierta "origin/main:ruta" en una ruta de Windows
git -C "$REPO" fetch origin || exit 1
git -C "$REPO" cat-file blob origin/main:docs/notas.md > "$TMP/copia.md" || exit 1
# editar $TMP/copia.md respetando sus finales de línea
blob=$(git -C "$REPO" hash-object -w --no-filters "$TMP/copia.md") || exit 1
export GIT_INDEX_FILE="$TMP/indice"; rm -f "$GIT_INDEX_FILE"   # un índice aparte, no el de la carpeta
git -C "$REPO" read-tree origin/main || exit 1
git -C "$REPO" update-index --cacheinfo "100644,$blob,docs/notas.md" || exit 1
tree=$(git -C "$REPO" write-tree) || exit 1; unset GIT_INDEX_FILE
sha=$(git -C "$REPO" commit-tree "$tree" -p origin/main -m "docs: actualizar notas") || exit 1
git -C "$REPO" diff --numstat origin/main "$sha"   # solo lo tuyo; el archivo entero = finales de línea
git -C "$REPO" push origin "$sha:refs/heads/docs/notas" || exit 1
```
