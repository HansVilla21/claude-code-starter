---
name: proteger-main-con-hook
description: Instala en un proyecto un hook de git que no deja hacer commit directo en main ni en master, con una salida explícita para emergencias. Usar al crear un repositorio, cuando alguien hizo commit en main por error, o cuando el usuario dice «que no se pueda commitear en main», «protegé main», «bloqueá main», «que no se vuelva a subir nada directo a main».
---

# Proteger main con un hook

Una regla escrita se olvida; un hook no. En un proyecto real, la regla «nunca commit directo a
`main`» estaba escrita hacía semanas, y aun así un commit directo a `main` se publicó a producción
sin pasar por revisión. Nadie fue descuidado: la regla estaba en un documento, no en el momento del
error.

> Una regla escrita es una intención. Un hook es una barrera. La pregunta no es «¿está
> documentado?» sino «¿qué pasa si me olvido?».

## 1. Tres capas, no una

| Capa | Qué hace | Falla cuando |
|---|---|---|
| `CLAUDE.md` | explica la regla y el porqué | nadie lo leyó, o se le pasó |
| El hook | la hace cumplir, siempre | no se instaló (punto 4) |
| `.gitignore` | última línea de defensa | el archivo no coincide con el patrón |

## 2. Qué hace el hook

El archivo `pre-commit` que está junto a esta skill:

- **Bloquea** los commits en `main` y `master`, con un mensaje que dice qué hacer:
  `git switch -c feat/<nombre>` lleva tus cambios a una rama nueva.
- **Deja pasar un merge en curso:** mergear en `main` no es commitear directo.
- **Tiene una salida explícita** para una emergencia real, como revertir algo que ya está en
  producción: `ALLOW_MAIN_COMMIT=1 git commit -m "..."` (en Bash o Git Bash). Escribir eso es una
  decisión. `--no-verify` apaga **todos** los hooks y es un descuido con nombre de flag: no se usa.
- **Deja pasar el primer commit de un repo vacío:** todavía no hay rama que proteger.
- Funciona igual en Git Bash (Windows), Mac y Linux.

## 3. Instalarlo en un proyecto

Desde la carpeta del proyecto:

```bash
git config core.hooksPath     # si ya devuelve una carpeta (ej. .husky), no la pises: preguntá
mkdir -p .githooks
cp ~/.claude/skills/proteger-main-con-hook/pre-commit .githooks/pre-commit
chmod +x .githooks/pre-commit          # Mac y Linux; en Windows no hace falta
git config core.hooksPath .githooks
git config core.hooksPath              # tiene que decir: .githooks
```

- **Repo nuevo:** instalalo antes del primer commit y que `.githooks/` entre en ese commit. Pasa,
  porque todavía no hay rama que proteger; desde el segundo, `main` queda cerrado.
- **Repo que ya existe:** instalalo, probalo, y commitealo en una rama con pull request, como
  cualquier cambio.
- **Desde Windows**, sumá `.githooks/* text eol=lf` al `.gitattributes` del proyecto (con saltos de línea de Windows el hook no corre), y agregalo ejecutable para quien clone en Mac o Linux:
  `git add --chmod=+x .githooks/pre-commit`.

**Probalo:** parado en `main`, `git commit --allow-empty -m "prueba"` tiene que terminar en
`BLOQUEADO`. Si el commit se hizo, el hook no corre: deshacelo con `git reset --soft HEAD~1` y
revisá los pasos.

## 4. El detalle que hace que el hook no exista

`.git/hooks/` no se versiona: un hook puesto ahí no viaja al clon de nadie. Por eso este vive en
`.githooks/` (una carpeta normal, versionada) y **cada clon** apunta git ahí **una vez** con
`git config core.hooksPath .githooks`. Sin ese comando, el archivo está en el repo, da confianza y
no corre.

Anotá ese comando en el README y en el `CLAUDE.md` del proyecto, para quien clone después. (Si el
equipo crece: un script `prepare` de npm que lo corra solo, o Husky.)

## 5. Si alguien ya hizo commit en main

- **Sin subir:** `git switch -c feat/<nombre>` (la rama nueva se lleva los commits) y después
  `git branch -f main origin/main` (`main` vuelve a quedar como el remoto). De ahí, pull request.
- **Ya subido:** `main` no se reescribe (nunca `--force` sobre `main`). Lo que haya que corregir va
  en una rama nueva, por pull request. Y se instala el hook para que no se repita.

## 6. Cuándo una regla merece un hook

Poner un hook a todo es tan malo como no poner ninguno: los lentos o ruidosos se terminan salteando
con `--no-verify`, y ahí caen también los que importaban. Merece hook si las tres respuestas son sí:

1. ¿La consecuencia sale del repo? (un deploy, un secreto publicado, un mensaje a un cliente, un cobro)
2. ¿Se detecta sin juicio? (una rama, un patrón, un archivo; no «¿está bien escrito?»)
3. ¿Ya pasó una vez, o el costo de la primera es inaceptable?

No merecen hook las preferencias de estilo (eso es el linter), lo que requiere juicio, ni lo que el
CI ya agarra sin bloquear a nadie.

## 7. Si escribís un hook propio

- **Que explique, no solo bloquee:** el mensaje trae el comando exacto para salir.
- **Una salida explícita y con nombre** (`ALLOW_...=1`), para que nadie rompa la ventana con
  `--no-verify`.
- **Que conozca sus falsos positivos** (merges, rebases): uno que bloquea trabajo legítimo se
  desinstala en una semana.
- **El porqué, en un comentario adentro del archivo:** quien lo quiera borrar lo lee primero.
- **Probalo:** hacé justo lo que tiene que bloquear y confirmá que bloquea.
