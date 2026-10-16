---
name: reporte-de-traspaso
description: Arma el documento para que un proyecto no muera con quien lo hizo (de quién es cada cuenta, por qué está hecho así, cómo se trabaja y qué falta), para entregárselo a un cliente, a otra persona o a uno mismo dentro de meses. Usar cuando el usuario diga «entreguemos esto», «documentá todo para el cliente», «armá el traspaso», o al cerrar un proyecto.
---

# Reporte de traspaso

## Cuándo usarla

- El proyecto pasa a **otra persona** (el cliente, su equipo, otro desarrollador o vos mismo
  dentro de seis meses), termina la construcción y empieza el soporte, o se cierra el contrato.
- El cliente pregunta «¿qué pasa si mañana no estás?». Es la pregunta correcta, y se tiene que
  poder contestar con un link.
- Vas a cotizar mantenimiento: sin este documento no sabés qué vas a mantener.
- **Antes** de que haya apuro: con el proyecto ya frío se pierde la mitad que importa, el porqué.

## Por qué existe

Lo que hace funcionar un sistema vive en la cabeza de quien lo construyó y en el historial de un
chat. La cuenta donde vive la app es del cliente, pero la clave de la API es tuya; publicar tiene
un truco que no está escrito; una integración solo funciona si alguien renueva un token. Nada de
eso está en el código. El código dice **qué** hace el sistema; el traspaso contesta tres cosas más:

1. **De quién es cada cosa.** Cuentas, dominios, claves, tokens: quién es el dueño, quién paga,
   qué vence y cuándo. Es lo primero que se rompe y lo último que alguien documenta.
2. **Por qué está así.** Las decisiones con su motivo, sobre todo las raras. Sin el porqué, el que
   llega «arregla» algo que estaba así a propósito.
3. **Qué falta y de quién depende.** Separando lo tuyo de lo que espera al cliente.

## Pasos

### 1. Escribirlo con el proyecto caliente, y leyendo

El mejor momento es la última sesión de construcción, no la primera de soporte. Se escribe
leyendo el proyecto (el código, el `CLAUDE.md`, las decisiones y aprendizajes de `memory/`),
nunca de memoria: un traspaso que miente es peor que ninguno, porque el que llega le cree.

### 2. Las secciones

Probadas en un sistema real. Si no hay código, saltá de la 2 a la 6 y la 9; el resto vale igual.

```
 0. Resumen                 qué es, en qué estado está, qué falta. Media página.
 1. Historia                qué se construyó, cuándo y POR QUÉ.
 2. Las apps                cuántas, dónde vive cada una, cómo se publica cada una.
 3. Pantallas               TODAS, y qué rol ve cada una.
 4. Endpoints de la API     ruta, quién la llama, cómo se autentica.
 5. Datos                   tablas, reglas de acceso (RLS), vistas, funciones, archivos.
 6. Roles y permisos        qué roles hay y qué puede hacer cada uno.
 7. Integraciones           qué está conectado, con qué cuenta, qué vence.
 8. Accesos                 DE QUIÉN es cada cuenta. La más valiosa.
 9. Variables de entorno    y scripts: qué hace cada uno.
10. Cómo se trabaja         cómo se publica, cómo se cambia la base, trampas conocidas.
11. Skills                  el conocimiento reusable que salió del proyecto.
12. Pendientes              partidos por dueño.
13. Links                   paneles, dominios, repositorios, tableros.
```

La 11 va al final: es el último momento con el proyecto entero en la cabeza, y cuando mejor se ve
qué sirve para el próximo. Lo que valga se vuelve skill con `creador-de-skills`.

### 3. La sección 8 es la que salva el proyecto

Por cada cuenta (hosting, base de datos, GitHub, dominio, Google, Meta, correo, IA, WhatsApp):
**quién es el dueño, quién paga, qué clave o token vive ahí, cuándo vence y qué se rompe si se
cae.** Marcá lo que **vence** (tokens de larga duración, accesos de OAuth, certificados): un token
que vence un martes cualquiera es como mueren los sistemas entregados.

**Sin secretos en el documento.** Van los **nombres** de las variables y **dónde viven**
(«Vercel → Settings → Environment Variables, solo Production»), nunca los valores: este documento
se manda por WhatsApp y termina en un Drive.

### 4. Partir los pendientes por dueño

- **Bloqueados por el cliente:** necesitan que él haga algo (pasar una cuenta, dar una clave,
  confirmar un dato, probar algo). Con nombre y apellido.
- **Técnicos:** deuda real, tuya o de quien siga.
- **Comerciales:** lo que se cotiza aparte, con el motivo.

Sin esta partición, una lista de 20 pendientes se lee como 20 cosas que quedaste debiendo.

### 5. Las trampas de operación van sí o sí

Lo que no se deduce mirando el repositorio: cómo se publica de verdad (¿un `git push` publica?
Casi nunca en la cuenta del cliente); cómo se corren los cambios a la base, contra cuál y si hay
entorno de pruebas (si **no** hay, se dice); cada trampa conocida con su síntoma, para
reconocerla cuando aparezca; y qué no tocar, y por qué.

## Qué entrega

- `outputs/traspaso-<proyecto>.md`, completo, para quien lo va a mantener. Arriba y grande:
  «Estado al AAAA-MM-DD». Si el proyecto sigue vivo, se actualiza.
- Si hace falta, un HTML de un solo archivo para que el cliente lo lea en el celular, sin jerga.
- Cero secretos, los pendientes partidos por dueño y las skills nuevas listadas.

## Errores comunes

- **Callar lo incómodo:** una cuenta en un plan que no corresponde, un riesgo con los términos de
  un servicio, deuda técnica conocida. Va escrito, con su costo y su riesgo, para que el cliente
  decida. Callarlo lo vuelve tuyo.
- **Confundirlo con el manual de usuario.** Son dos documentos y dos lectores: el manual es para
  **usar** el sistema; el traspaso, para **mantenerlo**.

## Ejemplo

En un proyecto real entraba una persona nueva a mantener un sistema de tres apps en un mismo
repositorio, con seis roles y seis integraciones. El traspaso cubrió todas las secciones, con las
**tres formas distintas de publicar** cada app y de quién era cada cuenta (la del hosting era del
cliente; la de Meta estaba a nombre de quien lo construyó y había que pasarla). Escribirlo destapó
un `.env.example` desactualizado y una tabla de permisos rota: documentar obliga a mirar.
