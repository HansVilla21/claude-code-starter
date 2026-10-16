---
name: archivar-en-vez-de-borrar
description: Poda las skills y los agentes que no se usan moviéndolos a la carpeta _archivo/ del proyecto, sin borrar nada, para que quede solo lo que trabaja y todo se pueda recuperar. Usar cuando hay skills o agentes que nadie usa, cuando el proyecto «tiene demasiadas cosas», o cuando el usuario diga «limpiemos», «sacá lo que no se usa», «ya no sé ni qué tengo acá».
---

# Archivar en vez de borrar

## Cuándo usarla

- El proyecto tiene **más piezas de las que usa**: skills que nunca se activaron, agentes a los
  que nadie les delega, comandos viejos.
- El usuario dice «esto está muy complicado», «hay demasiadas cosas», «limpiemos».
- Se está simplificando un proyecto trabado para que vuelva a avanzar (ver `tarjeta-de-hoy`).
- Alguien propone borrar algo y la conversación se traba discutiendo si algún día hará falta.

## Por qué existe

Lo que sobra **cobra renta**: cada skill o agente es una opción más que descartar antes de
trabajar y una línea más que mantener. Un proyecto con 17 skills que usa 6 paga el costo de 17 y
recibe el valor de 6. Igual cuesta podar, porque cada pieza tiene un caso a favor («¿y si algún
día hacemos carruseles?») imposible de refutar: habla del futuro. Y el proyecto solo crece.

Lo que destraba es cambiar la pregunta. «¿Esto sirve?» no tiene respuesta; «¿esto se usó en las
últimas semanas?» se comprueba, y contestarla no duele porque nada se pierde. **Archivar vuelve
reversible una decisión que no lo era**, y lo reversible se decide rápido. En un proyecto real
así se pasó de 17 skills a 11 y de 6 agentes a 4 en una sola sesión, sin una discusión.

## Pasos

### 1. Medir el uso, no el valor

Por cada skill y cada agente, una sola pregunta: **¿se usó en las últimas cuatro semanas?** Con
evidencia de los archivos, no de memoria: si se tocó hace poco, si otros archivos la nombran
(`CLAUDE.md`, `memory/`, otros agentes), si dejó algo en `outputs/`.

```bash
git log --oneline --since="4 weeks ago" -- .claude/skills/<nombre>
grep -rl "<nombre>" --include="*.md" . | grep -v "\.claude/skills/<nombre>"
```

Lo que la evidencia no resuelve se le pregunta al usuario: «¿esto lo usaste?». Nunca «¿esto
sirve?»: en abstracto todo sirve, y por eso nunca se poda nada.

### 2. Clasificar en tres grupos

- **Activo:** se usó, o algo que se usó depende de él.
- **Archivable:** no se usó, y sacarlo no rompe nada.
- **Muerto:** no se usó, está roto o quedó viejo. **También se archiva**, con una nota de por qué.

Mostrale los tres grupos al usuario, con la evidencia, y mové con su OK.

### 3. Mover, repitiendo la ruta original

Todo va a `_archivo/`, en la raíz del proyecto, con la ruta de origen sin el punto de `.claude`
para que Claude deje de cargarlo:

```bash
mkdir -p _archivo/claude/skills
git mv .claude/skills/<nombre> _archivo/claude/skills/<nombre>   # si el proyecto tiene git
mv .claude/skills/<nombre> _archivo/claude/skills/<nombre>       # si no tiene
```

Con git, siempre `git mv` y nunca borrar y volver a crear: se conserva el historial y el cambio se
ve como algo que se movió, no como un borrado masivo. Restaurar es el mismo movimiento al revés.

### 4. Escribir `_archivo/README.md`: lo que hace que funcione

Sin este archivo, `_archivo/` es un cementerio y en tres meses nadie sabe qué hay.

```markdown
# Archivo: piezas guardadas, no borradas
> Archivado el AAAA-MM-DD. Nada se perdió: para reactivar algo, movelo a su carpeta original.
## Por qué se archivó
[El problema concreto que causaba tener tanto.]
## Qué hay acá
[Cada pieza y, en una línea, cuándo reactivarla.]
## Qué quedó activo
[Cuántas skills y agentes quedaron, y cuáles.]
```

Lo más importante es el **cuándo reactivar**: vuelve lo archivado una decisión postergada, con su
condición para volver, en vez de un descarte.

### 5. Arreglar lo que apuntaba a lo archivado

Es el paso que siempre se olvida, y el que deja el proyecto peor que antes. Buscá cada nombre en
todo el proyecto, fuera de `_archivo/`, sobre todo en el `CLAUDE.md` (la tabla de quién hace qué),
el `README.md` y los agentes que delegan en otros. Un orquestador que le pasa trabajo a un agente
archivado falla sin avisar o improvisa, que es peor.

### 6. Dejar el conteo escrito

En el `CLAUDE.md` y, si hay git, en el commit (skill `commit`): cuántas skills y agentes había y
cuántos quedan. Es la prueba de que se podó y el freno para no volver a inflar sin darse cuenta.

## Ejemplo

Un proyecto con 17 skills, 6 agentes y 6 comandos, donde en cuatro semanas se usaron 6 skills y 3
agentes y el usuario evitaba abrirlo porque «hay demasiado». Se movieron 6 skills, 2 agentes y los
6 comandos a `_archivo/`; el README dice que las de formatos de contenido (carruseles, LinkedIn)
vuelven cuando esos formatos entren al plan; se corrigió la tabla del orquestador, y el commit
quedó: `refactor: archivar lo que no se usa (17→11 skills, 6→4 agentes)`.

## Señales de que salió mal

- Algo quedó archivado y un archivo todavía lo nombra: faltó el paso 5.
- `_archivo/` no tiene README: en tres meses es basura, no archivo.
- Decidir qué archivar llevó más de 15 minutos: se preguntó «¿sirve?» en vez de «¿se usó?».

Para el otro lado del ciclo, cuándo sumar una pieza, están `creador-de-skills` y `crear-agente`.
