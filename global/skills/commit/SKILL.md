---
name: commit
description: Guarda los cambios del proyecto en git con un mensaje claro, sin secretos y sin trabajar sobre main. Usar cuando el usuario diga «hacé commit», «guardá los cambios en git», «dejá esto versionado».
---

# Commit

## 1. Estado

`git status`, `git diff --cached` y `git branch --show-current`.

## 2. Nunca en main

Si la rama es `main` o `master`, pará y proponé una rama nueva (`feat/<nombre>`, `fix/<nombre>`,
`docs/<nombre>`). Seguí solo con la respuesta del usuario.

## 3. Sin secretos

Revisá lo que se va a guardar: archivos `.env`, claves (`sk-`, `AKIA`, `ghp_`…), contraseñas o
tokens escritos, datos sensibles. Si aparece algo, pará y avisá. Nunca se agrega un `.env`.

## 4. Qué entra

Si el usuario no dijo qué archivos, preguntá si van todos los cambios o algunos.

## 5. El mensaje

Formato `tipo: descripción breve`, en el idioma del proyecto, en imperativo. Tipos: `feat`, `fix`,
`docs`, `refactor`, `test`, `chore`. Ejemplo: `feat: agregar biblioteca de ejercicios`.

## 6. Confirmar y hacer

Mostrá el mensaje y los archivos, y hacé el commit con el OK del usuario. Después: el hash, la rama
y qué archivos entraron.

**Subir a GitHub (`git push`) es otro paso**, con su propio OK. Nunca a `main` sin que el usuario
lo pida.
