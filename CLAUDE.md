# STICK LIFE (antes STICK FIT) — Bitácora del proyecto

## v3.3.0 — solo hábitos; vista Año con metas de racha (2026-11-24)

El Señor Stick probó el panel y dijo que **no le gustan el ánimo ni las prioridades**: por ahora
solo usaría los hábitos. Se le propusieron cuatro ideas (recordatorio con Atajos, mapa anual por
hábito, hábitos por momento del día, hábitos de dejar) y **eligió solo el mapa anual**.
**Esto deroga la decisión 4 de v3.0.0** en lo que toca a ánimo y prioridades.

- **Fuera de la interfaz:** check-in de ánimo y tres prioridades en Hoy; en Resumen, el ánimo del
  mes, el año en píxeles por ánimo y el diario. Su CSS y su JS se borraron. **Los datos ya escritos
  (`life.moods`, `life.prio`) se conservan**, solo que nada los muestra.
- **Resumen:** el cuarto número pasa a «Constancia 30 días»; el año en píxeles queda solo por
  hábitos cumplidos (`vdRejillaAnio`, que ahora comparten Resumen y Hábitos).
- **Hábitos → Año** (tercer botón del segmentado): una tarjeta por hábito con la racha y la
  **siguiente meta** (7 · 14 · 30 · 60 · 100 · 200 · 365 días; 4 · 8 · 12 · 26 · 52 semanas en los
  semanales) con su barra, las metas ya logradas según la mejor racha, mejor racha, días cumplidos
  en el año y constancia, y la rejilla del año (12 filas × 31 días; se eligió sobre la tira de 53
  semanas de GitHub porque a 375 px esa deja cuadros de 4 px). Tocar un día dice su estado; los
  días anteriores a crear el hábito salen apagados, no como fallados.

**Verificado en vivo** a 375 px en oscuro: Hoy y Resumen sin rastro de ánimo ni prioridades, 41
registros viejos de ánimo intactos en el almacenamiento, seis tarjetas de año con metas y rejilla,
navegación a 2025 y de vuelta, sin desborde y sin errores de consola.

## v3.2.0 — modo oscuro v3 «Negro puro» del STICK UI SYSTEM (2026-11-24)

Pedido del Señor Stick: la app seguía en el oscuro v2 (grafito `#15161b`, campo y vidrio). Ahora
sigue el `nucleo/index.css` v3 (§25 del sistema): negro real `#000`, tarjetas opacas `#1c1c1e` sin
borde ni filo ni sombra, `#2c2c2e` (`--v-fondo-2`) para lo que va dentro de una tarjeta, grises
neutros de Apple en `--zinc-*`, colores de sistema de iOS (`--emerald:#30d158`, `--rose:#ff375f`,
`--amber:#ffd60a`, `--sky:#0a84ff`; violeta, naranja y turquesa de hábito se quedaron en los suyos
del apéndice), cifras sin resplandor, sin masas ni grano en oscuro, dock `rgba(28,28,30,.72)`.
**El modo claro no cambió.**

- Casi todo entró por los tokens de `:root`. Lo que tenía un blanco translúcido escrito a mano
  (`.ex`, `.stat`, `.chip`, campos, `.weekstrip`…) se corrige en un bloque final
  `html:not(.light) …` — solo oscuro, así que el claro no puede romperse por esto.
- Regla aplicada: pieza suelta sobre la página = `--v-fondo`; pieza dentro de una tarjeta u hoja =
  `--v-fondo-2`. Sin eso, las filas de ejercicio dentro de su tarjeta desaparecían (mismo gris).

**Verificado en vivo** a 375 px: cuerpo `#000`, tarjeta y fila suelta `#1c1c1e`, fila dentro de
tarjeta, ánimo y nota `#2c2c2e`, masas ocultas; 9 vistas × 2 temas sin desborde; el claro sigue con
su vidrio. Cierra la divergencia «esta app sigue en v2» que estaba en Pendientes.

## v3.1.0 — hábito fijo «Entrenar» sincronizado con el gimnasio (2026-11-24)

Pedido del Señor Stick: el gimnasio es un hábito por defecto, y marcarlo en un lado lo marca en el
otro. **Supera la decisión 7 de v3.0.0** (allí el entreno NO era hábito, solo una tarjeta).

- **Un solo dato, dos vistas.** El hábito `{id:"gym", sistema:"gym"}` no escribe en `S.life.log`:
  `vdValor` lo lee de `S.days` (entrenado o libre = hecho) y `vdPoner` escribe con
  `marcarEntrenado`/`desmarcarDia`. Por eso no hay sincronización que pueda desfasarse.
- **Frecuencia `rutina`:** toca los días en que la rutina activa no descansa (`esDescanso`). Un día
  de descanso entrenado igual aparece en Hoy y cuenta como hecho.
- **Siempre existe:** `vida()` lo crea al inicio de la lista si falta, con `created` = el primer día
  registrado en el gimnasio (así su racha y su % no cuentan como fallados días previos a la app).
  En el editor se puede cambiar nombre, ícono y color; tipo y frecuencia quedan fijos y no se
  puede archivar ni eliminar.
- La tarjeta «Cuerpo · hoy» perdió su botón «Entrené» (dos botones para lo mismo en una pantalla):
  queda como enlace al Entreno. El estado vacío pasa a «Agrega tus hábitos» y se muestra mientras
  no haya hábitos propios además de Entrenar.

**Verificado en vivo:** marcar el hábito → el día queda `entrenado` y la tarjeta del gimnasio sale
marcada; quitar desde el gimnasio → el hábito se desmarca; marcar desde el gimnasio → el hábito
sale hecho; marcar y desmarcar ayer desde la semana de Hábitos mueve la asistencia de ayer;
persiste al recargar; un solo hábito gym; domingo de descanso no toca; sin desborde a 375 px.

## v3.0.0 — de app de gimnasio a panel de vida (2026-11-24)

**Origen.** El Señor Stick no usaba la app como gimnasio y pidió que evolucionara a un **panel de
vida**, con prioridad absoluta en **hábitos diarios**: crearlos, personalizarlos, marcarlos cada día
y verlos por semana y por mes. Libertad creativa en el resto, con un criterio suyo: **«que sí se
use»**. Se investigaron plantillas «Life OS» de Notion, apps de hábitos (Loop, Streaks) y proyectos
de GitHub (Neohabit, JournalOS, Atomic Tracker, LifeForge).

### Decisiones (no re-litigar sin discusión)
1. **Nombre STICK LIFE.** Decidido por el Señor Stick sabiendo que renombrar el repo cambia la URL.
   Hecho en la app (título, portada, header, manifest, caché SW `sticklife-v1`), en el repo, la URL
   de Pages y la carpeta (ver «Logo y renombrado»).
2. **El gimnasio sigue entero, como módulo «Cuerpo».** No se borró nada: sus cinco vistas conservan
   sus ids (`hoy`, `calendario`, `rutinas`, `ejercicios`, `nutricion`) y ahora cuelgan de una
   sub-navegación segmentada (`#cuerpoNav`). El botón Cuerpo del dock abre la última sección usada
   (`ultimaCuerpo`). Peso corporal, medidas y respaldo siguen en Perfil (header).
3. **Dock de 4:** `Hoy · Hábitos · Cuerpo · Resumen` (ids `inicio`, `habitos`, `cuerpo`, `resumen`;
   `cuerpo` no es vista, es un atajo).
4. **Módulos elegidos por fricción mínima**, porque la lección de v2 fue que lo que pide escribir no
   se usa: hábitos, **check-in de ánimo (un toque) + una línea opcional**, **tres prioridades del
   día** y la tarjeta del entreno de hoy. **Descartados**: metas trimestrales y revisión semanal
   (escritura larga que no se sostiene); finanzas (ya vive en STICK BUDGETS, no se duplica).
5. **Tipos de hábito:** sí/no o **cantidad** con meta y unidad (agua 8 vasos, caminar 8.000 pasos).
   **Frecuencias:** diario, días fijos de la semana, o **N veces por semana** (patrón de Loop y
   Neohabit). Personalización: 24 íconos SVG propios (sin emojis) y 8 colores con variante clara.
6. **Rachas y porcentajes se derivan del log, nunca se guardan** (misma regla que la asistencia
   v1.10.0). Un día que no toca ni suma ni rompe; hoy sin marcar no rompe; los semanales cuentan
   semanas cumplidas. Antes de `created` un hábito no "tocaba" (salvo días marcados hacia atrás).
7. **El entreno no es un hábito duplicado:** la tarjeta "Cuerpo · hoy" escribe en el mismo `S.days`
   del calendario del gimnasio. Dos verdades sobre el mismo hecho terminarían contradiciéndose.
8. **Clave `sticklife-v1`.** Al primer arranque copia `stickfit-v2` si existe (mismo dispositivo y
   URL): rutinas, asistencia, peso y medidas pasan solos. `stickfit-v2` **no se borra**.
9. **Regla del scroll respetada:** marcar un hábito, una celda, el ánimo o una prioridad repinta solo
   sus nodos (`vdRepintar`), nunca la vista. Medido: 0 px de salto.
10. **Visual:** se mantuvo el lenguaje v2 «Campo y Vidrio» de la app; lo nuevo va en un apéndice CSS
    con prefijo `vd-` (ya existían `.hrow`, `.weeknav`).

### Modelo de datos nuevo (`S.life`)
- `habits[]` `{id,name,icon,color,kind:"check"|"count",target,unit,freq:{type:"daily"|"days"|"weekly",days[0..6 lunes=0],times},created,archived}`
- `log[iso][habitId]` = número (sí/no guarda 1; cantidad guarda lo acumulado).
- `moods[iso]` = `{m:1..5, note}` · `prio[iso]` = `[{t,d}]` ×3.

### Vistas nuevas (`index.html`, bloque «PANEL DE VIDA»)
- **Hoy (`renderInicio`)**: saludo, anillo del día, hábitos que tocan hoy (los semanales mientras
  falten veces), ideas de un toque cuando no hay hábitos, ánimo + nota, prioridades, Cuerpo · hoy.
- **Hábitos (`renderHabitos`)**: segmentado Semana/Mes. Semana = cuadrícula tocable por hábito con
  navegación hacia atrás y % por día; Mes = calendario por hábito con racha, mejor racha y % del mes.
  Editor (`vdHojaHabito`): nombre, ícono, color, tipo, frecuencia, subir, archivar, eliminar.
  Archivados conservan historial y se restauran.
- **Resumen (`renderResumen`)**: % de la semana con delta contra la pasada, días perfectos del mes,
  mejor racha activa, ánimo del mes, **año en píxeles** (ánimo o hábitos), constancia 30 días y diario.

### Verificado en vivo (2026-11-24, 375×812, servidor local)
Crear desde ideas y desde el editor; marcar en Hoy, en Semana y en Mes sin salto de scroll; hoja de
cantidad; ánimo, nota y prioridades persistiendo; Entrené sincronizado con el calendario del
gimnasio; las cinco secciones de Cuerpo y Perfil; migración desde `stickfit-v2` (días y peso
intactos, `stickfit-v2` sin borrar). Sin desborde horizontal en 10 vistas × 2 temas, cero errores
de consola. **Defecto corregido:** `.vd-stats3 div` pintaba cajas dentro de cajas → `.vd-stats3>div`.

### Logo y renombrado (2026-11-24, autorizado por el Señor Stick: «cambia todo»)
- **Marca nueva:** cuadrícula de hábitos 3×3 en la que las casillas cumplidas (sólidas) suben en
  escalera hacia la derecha y las pendientes van en contorno. Misma estética de la suite: glifo
  blanco plano, esquinas redondeadas, sobre `#1E1F1F`, ~50 % del lienzo. `tools/gen-icons.ps1`
  dibuja **todo** desde la geometría (no hay maestro que medir): `LOGO.png` 2000, `icon-512`,
  `icon-192`, `apple-touch-icon` 180 y `favicon` 64. La marca SVG del header y la portada es la
  misma geometría (viewBox 35,6; casilla 10, separación 2,8, radio 3). La mancuerna queda solo
  en el historial de git y como ícono del módulo Cuerpo.
- **Repo `ZafiroSad/STICK-FIT` → `ZafiroSad/STICK-LIFE`**; Pages pasa a
  https://zafirosad.github.io/STICK-LIFE/ . Carpeta `05. STICK FIT` → `05. STICK LIFE`.
- **Los datos NO se pierden con el cambio de URL:** `localStorage` es por origen
  (`zafirosad.github.io`), no por ruta, así que `/STICK-LIFE/` lee lo mismo que `/STICK-FIT/` y la
  migración de `stickfit-v2` corre sola. Lo que sí cambia: la app instalada en la pantalla de
  inicio apunta a la URL vieja y hay que volver a agregarla (la vieja devuelve 404).

### Pendientes
- Reinstalar la app en el teléfono (y en los de la familia) desde la URL nueva.
- ~~Divergencia con el sistema (oscuro en v2)~~ — **cerrada en v3.2.0**.
- Recordatorios/notificaciones de hábitos: no hay (PWA sin servidor).
- `.claude/launch.json` quedó en la carpeta por error y no se pudo borrar (protegida); va ignorada en git.

## Rediseño v2.0.0 — de bitácora de cargas a app de adherencia (2026-09-07)

**Origen.** El Señor Stick declaró que **no usa el registro de series y pesos**: lo llamó
impráctico. Diagnóstico acordado en el grill: no era impráctico por existir, sino por su
granularidad — 4 filas por serie × 7 ejercicios son 28 campos por sesión. La app pasa a girar
alrededor de **tener rutinas y marcar qué días se entrenó**, no de documentar cargas.

**Objetivo nuevo:** subir masa muscular. Sustituye al anterior "físico atlético, magro y funcional".
No le gusta entrenar pierna; quiere priorizar brazos. Ambas cosas están resueltas en la rutina, no
ignoradas.

### Las 13 decisiones (cerradas en grill, no re-litigar sin discusión)

1. **Un peso por ejercicio**, opcional, pre-cargado con el de la última vez, editable con +/-.
   Muere el desglose serie por serie, y con él el 1RM Epley como eje. Sobrevive lo único que la
   hipertrofia necesita: saber si el peso de esta semana supera al de la pasada.
2. **El día es la verdad del calendario.** Las casillas por ejercicio son ayuda durante la sesión y
   no condicionan el registro de asistencia: se puede entrenar sin marcar un solo ejercicio.
   Motivo: si el calendario depende de la disciplina de marcar, un día real sin ganas de tocar el
   teléfono sale como día perdido y el historial miente.
3. **Cuatro estados de día:** `Descanso` (lo dicta la rutina), `Entrenado` (un toque), `Libre`
   (entrenó otra cosa), `Fallado` (**automático**: día pasado con plan y sin marca). El Señor Stick
   nunca marca un fracaso — lo hace el paso del tiempo.
4. **Hipertrofia con base de fuerza.** Primer movimiento del día en 5-8; el resto en 8-15. Volumen
   12-18 series/grupo/semana. Nutrición por defecto en **superávit magro**, no superávit a secas.
5. Domingo descanso. Hombro y brazo reciben trabajo directo **también** en los días de pecho y
   espalda (laterales y face pull el lunes; curl y tríceps el viernes), para darles frecuencia 2 sin
   gastar un sexto día de entrenamiento.
6. **Martes pierna completa; sábado pierna corta + brazo.** La pierna conserva frecuencia 2 porque
   es la mayor masa del cuerpo y quitarla se paga en proporción, pero el sábado deja de ser "día de
   pierna": son 2-3 movimientos al principio, con energía, y el resto es brazo. El peaje va primero
   justamente para que no se salte.
7. **Sigue siendo un solo `index.html` sin build** (ratifica la decisión nº 1 original) y sigue en
   **GitHub Pages sirviendo `main` directo, sin workflows**. La mejora de animación no viene de
   migrar a React+Motion sino de **View Transitions API**, muelles con `linear()` y
   `@starting-style`. Condición explícita del Señor Stick: "B si y solo si seguimos como estamos
   GitHub Pages".
8. **Dock:** `Hoy · Calendario · Rutinas · Ejercicios · Nutrición`. "Progreso" se elimina como
   concepto — su nombre era tan vago que todo cabía, y por eso todo terminó ahí. Peso corporal,
   medidas y respaldo se van a un **Perfil** en el header, construido con el centro de ajustes
   canónico del sistema (§11), no inventado aquí.
9. **"Hoy" es solo hoy.** Fuera las flechas de semana, las siete píldoras de día y el concepto de
   `weekOffset` en esa vista. Marcar días pasados se hace **solo** desde Calendario.
10. **Clave nueva `stickfit-v2`, sin migración.** Decisión del Señor Stick contra mi recomendación
    de migrar; la acepté porque la migración correría a ciegas en su teléfono, donde no puedo
    probarla, y una migración con un fallo es peor que empezar limpio. Consecuencia asumida: la
    racha y el historial de asistencia arrancan de cero. **`stickfit-v1` no se borra**: queda
    intacto y recuperable.
11. **Rescate único y opcional** al primer arranque: si detecta `stickfit-v1`, ofrece traer solo
    **perfil, peso corporal y medidas** — nunca rutinas, checks ni historial de series. Se muestra
    una vez.
12. **Tira de semana de solo lectura en Hoy** (siete puntos + racha, sin navegación ni lógica de
    fechas). Resuelve el problema de que el CTA vive en Hoy y su consecuencia vive en Calendario:
    la acción tiene efecto visible donde ocurrió. Reparto de tiempos de la §17: pulsación **140ms**
    (respuesta a gesto), consecuencias **~400ms decelerando y sin rebote**.
13. **Entrega en tres etapas con checkpoint:** (1) datos y rutina · (2) navegación y pantallas ·
    (3) movimiento.

### La rutina nueva

| Día | Sesión |
|---|---|
| Lun | Pecho -> Espalda + laterales y face pull |
| Mar | Pierna completa |
| Mié | Brazo y hombro (día dedicado) |
| Jue | Descanso |
| Vie | Espalda -> Pecho + curl y tríceps |
| Sáb | Pierna corta (cuádriceps · femoral · gemelo) -> Brazo |
| Dom | Descanso |

El orden invertido de lunes (pecho->espalda) y viernes (espalda->pecho) es intencional: ninguno de
los dos grupos se entrena siempre cansado.

### Etapa 1 COMPLETA y verificada en vivo (2026-09-07)

Lo que entró en el código:

- **Clave `stickfit-v2`** con `estadoInicial()` y red de seguridad: si un respaldo viejo importado
  trae una clave ausente, se rellena desde el estado base en vez de reventar.
- **`S.days[iso] = {s:"done"|"free", label?}`** es la nueva verdad de la asistencia. `S.checks`
  sigue existiendo pero ya **no** decide si un día cuenta como entrenado.
- **`dayState(iso)`** resuelve los cinco casos: `libre`, `entrenado`, `descanso`, `fallado`
  (pasado con plan y sin marca) y `pendiente` (hoy o futuro). `freeOf`/`setFree`/`clearFree`
  quedan como envoltorios de compatibilidad sobre el modelo nuevo.
- **`currentStreak()` reescrita:** el descanso ni suma ni rompe (castigarlo premiaría
  sobreentrenar); un `fallado` rompe; `pendiente` de hoy no rompe.
- **`markCard()`** — el CTA "Entrené" en Hoy, con su CSS. Un día marcado se pinta lleno en el
  calendario aunque queden ejercicios sin tildar.
- **`ofrecerRescate()`** — hoja de rescate único desde `stickfit-v1`: trae perfil, peso corporal
  con su meta, y medidas. **No** trae historial, rutinas ni checks.
- **Rutina `masa-brazos` («Masa · Brazos»)**, `SEED_VERSION` a 1, caché SW a `stickfit-v19`.
- Portada: el eslogan pasa de "protocolo de fuerza / atlético y magro" a masa y constancia.

**Volumen semanal medido en vivo** (5 días de entreno, 99 series):
Pecho 13 · Espalda 15 · Hombro 17 · Pierna 28 (20 de cuádriceps/femoral + 8 de gemelo) ·
Brazo 26 · Core 6.

> **El `weeklyVolume()` agrupa bíceps y tríceps como un solo "Brazo" y por eso marca 26, fuera de
> la banda 10-20.** No es exceso: son **13 de bíceps y 13 de tríceps**, cada uno dentro de banda.
> La banda por grupo no sabe representar un split bíceps/tríceps. Pendiente decidir si se parte el
> grupo o si se anota la excepción.

**Core entró después de la verificación:** la rutina salía con 0 series de core. Se añadió plancha
(martes) y elevación de piernas colgado (sábado) — frecuencia 2, 6 series, sin alargar la sesión.

**Dos defectos corregidos durante la verificación en vivo:**
1. Un día marcado anunciaba " · 0/6 ejercicios" en el calendario. Contradice la decisión 2: la
   marca es la verdad. Ahora dice " · entrenado" cuando no hay ejercicios tildados.
2. `.markcard.on .mk-btn` usaba `--sup-2`, que en modo claro es `rgba(255,255,255,.92)`: el botón
   "Quitar" se leía como un CTA primario blanco sobre la tarjeta esmeralda. Pasó a secundario sin
   relleno.

El override de tema se escribió desde el principio re-declarando el estado activo
(`html.light .markcard.on`), que es la trampa de especificidad que mordió a `.daypill` en v1.19.
Verificado en vivo a 375×812 en oscuro y claro, con la marca persistiendo al recargar.

**Pendiente de la etapa 2:** el campo único de peso por ejercicio (hoy sigue abriendo la hoja
serie-por-serie), quitar la barra de semana y las píldoras de día de Hoy, el dock a Calendario,
el Perfil, y la entrada manual al rescate (hoy, si la hoja se cierra por el scrim, vuelve a
preguntar en el siguiente arranque — se eligió repetir la pregunta antes que dejar los datos
inalcanzables por un toque accidental).

### Etapas 2 y 3 COMPLETAS y verificadas en vivo (2026-09-07)

**Etapa 2 — navegación y pantallas**

- **Dock:** `Hoy · Calendario · Rutinas · Ejercicios · Nutrición`. `progreso` desaparece como
  identificador; su icono de curva pasa a ser un calendario.
- **`renderHoy()` reducida a hoy:** fuera las flechas de semana, las siete píldoras de día y el
  aviso de "estás completando otro día". `weekOffset` queda como `const 0` — `dateOfDay()` y
  `checkKey()` lo siguen leyendo, pero ya nadie lo mueve.
- **Peso único por ejercicio** (`pesoDe` / `pesoPrevio` / `guardarPeso` + `openPesoSheet`): un solo
  número, pre-cargado con el de la última vez, con −/+ de 5 lb. Se sigue escribiendo en
  `history[]` con la forma de siempre (`sets:[{weight}]`) para no partir el respaldo. La fila del
  ejercicio muestra el delta contra la última vez (`+5 lb` en verde), que es lo único que la
  hipertrofia necesita leer.
- **`renderCalendario()`**: calendario protagonista + peso por ejercicio + volumen semanal.
  Tocar un día abre **`openDaySheet()`** y se marca ahí mismo; ya no salta a Hoy.
- **`renderPerfil()`** — vista fuera del dock, se entra por el header: peso corporal, medidas,
  respaldo y `recuperarCard()`, la entrada manual al rescate de `stickfit-v1`.
- `bindProgreso()` se partió en `bindCalendario()` y `bindPerfil()`.

**Etapa 3 — movimiento**

- **Muelles reales con `linear()`.** Tokens `--muelle` (spring .45 / bounce .18) y `--muelle-suave`
  (bounce .14), generados muestreando un oscilador amortiguado, así que son la MISMA curva que
  `{type:'spring'}` produce en el resto de la familia (§17.2). Sobrepaso ~1%: se asienta, no
  rebota. La píldora del dock deja `cubic-bezier(.34,1.56,.64,1)` y pasa a `--muelle`.
- **View Transitions API** en `go()`: salida 100ms, entrada 220ms con `y:10→0`, cruzándose
  (equivalente al `popLayout` de §17.3). `_go()` hace el trabajo y `conTransicion()` lo envuelve;
  sin soporte o con movimiento reducido, ejecuta el cambio tal cual.
- **`celebrarMarca(iso)`** — la consecuencia del CTA. Repinta **solo** la tira de semana y la
  tarjeta, no la vista entera: un `renderHoy()` completo destruiría el nodo del punto y la
  animación no tendría de dónde partir (mismo motivo por el que el dock separa `montarDock()` de
  `renderDock()`). El punto de hoy se llena y la racha rueda hacia arriba en ~400ms.

**Código muerto eliminado:** `openExLog`, `setRowHTML`, `setPills`, `setsSummary`, `setsRange`,
`weekLabel`, `openDate`, `weekOffsetOf`, `nextTarget`, `nextTargetObj`. `strengthBlock()`
reescrita: sin 1RM de Epley, sin series y sin "próximo objetivo", porque los tres salían de las
repeticiones y esas ya no se guardan.

**Cuatro defectos corregidos durante la verificación en vivo:**
1. `lbl[0]` daba `L M M J V S D` en la tira de semana y en la cabecera del calendario — martes y
   miércoles indistinguibles. Pasan a dos letras.
2. En Perfil ningún botón del dock quedaba `.on`, así que la píldora blanca se quedaba bajo un
   icono gris. Se añadió `ultimaPestana`: la píldora no se mueve, pero el botón de debajo sigue
   pintado en claro.
3. La leyenda del calendario mantenía "A medias", un estado que ya no existe (desde v2 un día
   marcado se pinta lleno).
4. El párrafo de ayuda del calendario describía el modelo viejo entero ("se marca solo en cuanto
   marcas un ejercicio", "se abre en Hoy"). Reescrito.

Verificado en vivo a 375×812, recorriendo las cinco pestañas y el Perfil sin un solo error de
consola, en oscuro y claro.

### Auto-llenado del día y catálogo de 82 ejercicios (2026-09-07)

Dos peticiones del Señor Stick, más una regla suya que casi vuelvo a romper.

**1. Marcar todos los ejercicios llena el día.** `autoMarcarSiCompleto()`: al llegar al 100 %, el
día se marca solo. **Solo enciende, nunca apaga** — destildar un ejercicio después no borra un
entrenamiento que sí ocurrió. No contradice la decisión 2: el día sigue siendo la verdad y se puede
marcar sin tildar nada; esto solo añade el camino inverso.

**2. El catálogo pasa de 32 a 82 ejercicios** (Pecho 12 · Espalda 15 · Pierna 21 · Hombro 10 ·
Brazo 13 · Core 11), todos con ejecución, errores y tip, y usando **solo las 14 claves de músculo
del diagrama SVG** — una clave inventada no resaltaría nada en la ficha. Verificado en vivo: cero
ids duplicados, cero nombres duplicados, cero claves inválidas, cero fichas incompletas.

Con 82 ejercicios la lista del selector mide más de 6.000 px, así que **buscar a ojo dejó de ser
viable**: el filtro pasa a mirar nombre, músculo, equipo y grupo (`normalizar()` quita tildes, para
que "triceps" encuentre "tríceps"), y se añaden chips de grupo. El mismo criterio se aplicó al
buscador de la vista Ejercicios, que buscaba solo por nombre.

**3. La regla del scroll (v1.13.0), que había roto en tres sitios.** El Señor Stick avisó a mitad
del trabajo. Nada que se toque durante una sesión puede llamar a `renderHoy()`: reconstruir el
`innerHTML` relanza el escalonado de toda la lista, mata la animación del elemento que cambió y
**salta el scroll**. Yo la había roto al guardar un peso, al quitarlo y al desmarcar el día.

Se añadieron tres funciones de repintado en sitio: **`pintarMarca(iso,animar)`** (tira de semana +
tarjeta), **`pintarFilaPeso(i)`** (solo el botón y los metadatos de una fila, sin sustituir el nodo
para no relanzarle la animación de entrada) y **`bindMarkCard()`**. `celebrarMarca()` quedó
absorbida por `pintarMarca`.

> **Defecto que solo apareció midiendo:** aun sin re-renderizar, el scroll se movía **17 px** al
> marcar. Causa: la tarjeta medía 99 px sin marcar y 82 px marcada, y al encoger empujaba la lista.
> Resuelto con `min-height:99px`. **Un cambio de estado no puede cambiar la altura de su propio
> contenedor** — la lección general de este defecto.

Verificado en vivo: **0 px de movimiento** al marcar cada uno de los seis ejercicios, al completar
el día y al guardar un peso. Sin desbordamiento horizontal en las seis vistas × dos temas, y sin
un solo error de consola. Caché SW → `stickfit-v21`.

También se eliminó la regla CSS `.week`, huérfana desde que Hoy perdió las píldoras de día.

### Qué queda derogado de la versión anterior

- La decisión nº 6 vieja ("Split 4 días Torso/Pierna") y la nº 10 ("registro de peso/reps con
  historial") ya no rigen.
- El objetivo declarado deja de ser "físico atlético, magro y funcional --no de culturista--" y pasa
  a ser **masa muscular con base de fuerza**.
- La vista "Progreso" deja de existir.


## Pantalla de carga unificada (2026-08-24)

Regla del Señor Stick: **todas las apps de la familia comparten la misma animación de carga**, la de
STICK BUDGETS — un anillo de 32px girando sobre el campo. Es lo primero que se ve al abrir cualquiera
de las siete, así que es donde más se nota si una se comporta distinta. Documentado en
`STICK_UI_SYSTEM.md` §16.1 y §21 (regla 12-bis).

Componente compartido `PantallaCarga.tsx`: anillo de 32px, aro `border-zinc-700`, segmento
`border-t-white` (la tinta, que en modo claro se invierte sola), `animate-spin` de 1s lineal, con
`role="status"` y `aria-busy`. Acepta `mensaje` y `detalle` opcionales para esperas que de verdad
tardan.

No tiene pantalla de carga (es un HTML autónomo que abre al instante), pero se añadió la clase
`.cargando-anillo` al CSS para cuando haga falta. **Bug corregido en la verificación en vivo:** con
`display:inline` por defecto de un `<span>`, el navegador ignora `width`/`height` y el anillo salía
de 4px — resuelto con `display:inline-block`.

## La barra de navegación jamás lleva texto (2026-08-24)

Regla del Señor Stick para toda la familia: la navegación inferior es **solo íconos**, en cualquier
ancho de pantalla y en cualquier estado, incluida la pestaña activa. El nombre de cada pestaña va en
`aria-label` y `title` — el lector de pantalla lo anuncia igual y el puntero fino muestra el
tooltip, así que no se pierde información, solo deja de ocupar espacio. Un dock de solo íconos
además mide lo mismo en cualquier pantalla, que es lo que lo hace idéntico entre las seis apps.
Anotada en `STICK_UI_SYSTEM.md` §4.5 (recuadro) y §8 (regla 3-ter-d).

En esta app se quitó la regla `.dock-btn .dl{display:inline}` y su media query de 640px.
Verificado en vivo: cero etiquetas visibles a 400px y a 900px, dock constante en 269px.

## Sincronización con STICK UI SYSTEM (2026-08-24)

Pasada de consistencia visual de toda la familia Stick, con **STICK BUDGETS como referencia**. Al
ser una app de un solo HTML, el sistema se replica sobre variables CSS propias con los mismos
valores. Qué cambió:

- **Presupuesto de duración** (`--t-toque` 140ms … `--t-lienzo` 420ms) y **resplandor de signo**
  (`--glow-gain/-loss/-amber`), en ambos temas.
- **Header sin barra**: `header.top` deja `sticky`, la superficie
  (`color-mix(... var(--bg) 55% ...)` + `backdrop-filter`) y el `border-bottom`; ahora flota sobre
  el campo con `padding-top: calc(env(safe-area-inset-top) + 2rem)`.
- **Dock reescrito al canónico** (§4.5): ceñido a su contenido (antes `width:92%`), `bottom` a 16px
  + safe area, `padding:6px`, `gap:4px`, y **una sola píldora blanca que viaja** — escrita en CSS+JS
  porque acá no hay Motion: el JS solo escribe `--px` y `--pw`, el muelle lo pone la transición.
  `renderDock` se partió en **`montarDock()`** (construye una vez) y **`renderDock()`** (solo mueve
  la píldora): reescribir el `innerHTML` en cada cambio de vista destruía la píldora y la hacía
  nacer de nuevo en su sitio, que es justo el efecto que el sistema no quiere. Recoloca en `resize`
  y sale sin hacer nada si el dock está oculto (medir con `offsetWidth === 0` la dejaba en el borde).
- **Las etiquetas del dock solo desde 640px**: con 5 pestañas y sus nombres el dock mide 574px y por
  debajo de ese ancho se desbordaba de la pantalla (medido en vivo).
- **Las 11 reglas `:hover` movidas a `@media (hover: hover) and (pointer: fine)`** — en táctil el
  navegador dispara un hover falso al tocar y el elemento se queda levantado.
- Botones-ícono de 32px a **40px táctil / 36px desde 640px**; contenido a 20px de padding
  horizontal; `interactive-widget=resizes-content` en el viewport.

**Verificado en vivo** (servidor HTTP local, no `file://`), en oscuro y claro: header `relative` sin
fondo ni borde, dock de 302px centrado en 560px de viewport, píldora alineada al botón activo al
píxel y viajando al cambiar de vista, botón de tema de 36px, padding de 20px. Nota: al abrir esta
sesión, `service-worker.js` ya figuraba modificado en git — ese cambio no es de esta pasada.

## Descripción y objetivo
> **Desde v3.0.0 la app es STICK LIFE, un panel de vida** (ver la sección v3 al inicio). Lo que
> sigue describe el origen del módulo Cuerpo.

App personal de entrenamiento de **fuerza** para el Señor Stick. Objetivo: construir un físico
atlético, magro y funcional —no de culturista— mediante sobrecarga progresiva. Pensada para usarse
**desde el celular**. Reemplaza a un prototipo anterior de temática superheroica, ya descartada.

**Convención:** no se nombra a ninguna persona real ni marca de ficción en la app ni en este
repositorio. Los objetivos se describen por sus características físicas, no por referencias.

## Ubicación
`C:\Users\kevin\Documents\KEVIN\02. WORK\03. STICK INDUSTRIES\01. STICK SUITE\05. STICK LIFE\` (antes `05. STICK FIT`, renombrada el 2026-11-24; movida desde Downloads
el 2026-08-01, junto a las demás apps de la familia Stick).

## Estado actual — ESTABLE (Tier 1 y 2 completos)
- **Versión:** 1.19.0 — **UI SYSTEM v2 «Campo y Vidrio» + modo claro**.
- v1.19.0 (2026-08-09, migración v2): quinta y última app de la familia migrada al
  `STICK_UI_SYSTEM.md` v2, cuyo referente visual es ahora el **PORTAFOLIO** de Kevin Gil.
  Al ser un solo HTML sin Tailwind, la migración va sobre las variables CSS propias:
  (1) **rampa grafito** — las variables `--zinc-*` conservan sus nombres y cambian todos sus valores
  a los grises fríos del portafolio; entran `--tinta` (`#f7f8fa`) y `--contratinta` (`#15161b`), que
  sustituyen a los `#fff`/`#000` fijos (el blanco y el negro puros salen de la paleta);
  (2) **el campo** (`.campo` + 4 `.masa` + `.grano`) sustituye al `background-image` radial del
  `body`, con todo el contenido dentro de `.lienzo` y los overlays fuera de él;
  (3) **vidrio líquido** en tarjetas (26 px), topbar, dock, botones secundarios, botones ícono,
  filas de ejercicio, pastillas de día, stats y campos;
  (4) **píldoras** en todo lo pulsable; (5) **modo claro obligatorio** (§10) con botón Sol/Luna en la
  topbar, `html.light`, persistencia en `localStorage` (`stick:tema`) y script anti-destello.
  `theme-color` a `#15161b`. Caché SW → `stickfit-v17`.
- **Nota de fusión (v1.19.0):** esta migración se hizo partiendo de v1.16.0 en paralelo a los
  cambios funcionales de v1.17.0/v1.18.0 (calendario ancho, fecha correcta, `weekOffset`), que ya
  estaban en el remoto. `index.html` fusionó sin conflicto —los cambios de ellos viven en el JS y
  los míos en el CSS y el marcado— pero **las piezas de UI nuevas de v1.17/v1.18 llegaron con los
  colores oscuros fijos del sistema viejo** y hubo que pasarlas a tokens aparte. Por eso el número
  salta de 1.18.0 a 1.19.0, no a 1.17.0.
- **Decisión (v1.19.0):** el `--brand:#ffffff` de la mancuerna **no** se toca. El logo va sobre su
  placa oscura en los dos temas; convertirlo a `--tinta` lo volvería invisible en modo claro.
- **Defecto corregido durante la verificación (v1.19.0):** los overrides `html.light .daypill` y
  `html.light .ex-log` tienen la **misma especificidad** que `.daypill.on` y `.ex-log.logged`, y al ir
  después en el archivo los vencían: la pastilla del día activo salía blanca sobre blanco. Se
  re-declaran los estados activos con `html.light .daypill.on` / `html.light .ex-log.logged`. Regla a
  recordar: **al añadir un override de tema a una clase base, hay que re-declarar también sus
  estados** (`.on`, `.logged`, `.active`).
- Verificado en vivo con Chrome headless sobre la app servida por HTTP (430×900, ancho de teléfono),
  portada e interior, en ambos temas.
- v1.18.0 — **completar días de semanas anteriores** (tocar el calendario abre ese día).
- v1.18.0 (semanas pasadas): resuelve el pendiente de v1.17.0. `dateOfDay(dayId,off)` acepta ahora un
  desfase de semanas y la vista Hoy guarda ese desfase en `weekOffset` (0 = semana actual, 1 = la
  pasada…). Tres formas de llegar a un día viejo: **tocar su cuadrito** en el calendario de asistencia
  (`openDate()` calcula el `weekOffset` con `weekOffsetOf()` y salta a Hoy), las flechas ‹ › de la
  nueva barra de semana en Hoy, o el botón **Hoy** de esa barra para volver. El botón Hoy del dock
  también reinicia la semana. Caché SW → `stickfit-v16`.
- v1.18.0 (detalles): las píldoras de la semana llevan el **número de día** (`LUN 27`), porque al
  poder viajar entre semanas "Lun" solo ya no identifica una fecha. `lastEntry(exId,antes)` acepta un
  tope: al completar un día pasado el objetivo sugerido sale de la sesión **anterior a ese día**, no
  de una posterior que ya esté registrada.
- **Decisión (v1.18.0):** el calendario **no** deja abrir días posteriores al domingo de la semana en
  curso; ahí el toque sigue mostrando solo el detalle (toast). Hacia atrás no hay límite. Marcar un
  día futuro de la semana en curso se mantiene permitido (con el aviso ámbar de v1.17.0): es el caso
  de quien entrena de noche y adelanta el registro, no el de inventar sesiones de un mes que no llega.
- **Decisión (v1.18.0):** `weekOffset` vive en memoria, no en `localStorage`, igual que `mzOpen`: es
  posición de vista, y abrir la app siempre en la semana actual es lo predecible.
- **Decisión (v1.18.0):** la etiqueta de la semana dice "Esta semana" / "Semana pasada" y solo usa el
  rango de fechas ("20 jul – 26 jul") de dos semanas atrás. Con el rango completo, "Semana pasada ·
  27 jul – 02 ago" se cortaba en un iPhone; los días exactos ya están en las píldoras y en la cabecera.
- **Versión:** 1.17.0 — **calendario a todo el ancho** + el día que marcas se guarda en SU fecha.
- v1.17.0 (fecha correcta): **bug corregido**. `checkKey()` y el registro de pesos usaban siempre
  `todayKey()`, así que elegir el martes en el selector de Hoy y marcar ahí guardaba el check (y la
  entrada de `history`) con la fecha de **hoy**: el calendario pintaba el día equivocado y el día
  olvidado quedaba en "no fuiste". Nuevo `dateOfDay(dayId)` devuelve la fecha real de ese día dentro
  de la **semana en curso** (lunes→domingo, igual que el selector); de ahí salen ahora `checkKey()`,
  `dayEntry()` (antes `todayEntry`) y el `date` de la entrada de historial. Efecto colateral bueno:
  las píldoras de la semana muestran el progreso real de cada día, no el de hoy repetido siete veces.
  Caché SW → `stickfit-v15`.
- v1.17.0 (calendario ancho): `.calgrid` pasa de `repeat(7,13px)` + `width:max-content` a
  `repeat(7,1fr)` con `width:100%` y celdas de `aspect-ratio:1` (≈41 px en un iPhone). Con ese
  tamaño el cuadrito **recupera el número de día** y vuelve la cabecera L-M-M-J-V-S-D; el número
  toma el color del estado (verde a medias, rosa "no fuiste", oscuro sobre el verde sólido).
- **Decisión (v1.17.0):** el día "mudo" de v1.11.0 existía porque el cuadrito medía 13 px y el
  número no cabía. Al llegar a ~41 px la razón desaparece y el número es justo lo que permite
  verificar de un vistazo que lo marcado cayó en el día correcto — que es el bug que se corrigió.
- **Decisión (v1.17.0):** el selector de Hoy mapea a la **semana en curso**, no a "la ocurrencia
  más reciente de ese día". Tocar un día que aún no llega da una fecha futura; se permite (el dato
  es del usuario) pero la vista lo advierte en ámbar, y cuando el día es pasado lo dice en gris
  ("Estás completando el 05 de ago de 2026"). La cabecera de Hoy y la hoja de registro llevan ahora
  la fecha, para que nunca haya duda de dónde se está escribiendo.
- **Pendiente conocido (v1.17.0):** no se podía marcar un día de semanas anteriores. **Resuelto en
  v1.18.0.**
- v1.16.0 — **logo blanco** (el maestro `LOGO.png` cambió de rojo a blanco).
- v1.16.0 (identidad): el Señor Stick reemplazó el maestro `LOGO.png` (2000×2000) por la misma
  mancuerna de 3 discos por lado pero en **blanco `#ffffff`** sobre `#1e1f1f`. La geometría es
  idéntica a la que ya estaba medida en `tools/gen-icons.ps1` (discos de 79.5 px a ±293.5/±415/±535.5
  del centro, altos 262/390/518; barra 424×76), verificado píxel a píxel contra el archivo nuevo, así
  que **solo cambió el color**: `$RED` → `$FG` blanco en el script, `--brand:#9f1313` → `#ffffff` en
  `index.html`, y los cuatro PNG (512/192/180/64) regenerados con el script. Caché SW → `stickfit-v14`.
- **Decisión (v1.16.0):** el halo rojo de la placa de la portada (`#cover .mark-lg`,
  `0 0 34px rgba(159,19,19,.18)`) pasa a `rgba(255,255,255,.09)`. Era el último rastro del rojo: con
  la mancuerna blanca quedaba un aro rojizo alrededor del ícono que ya no correspondía a la marca.
- **Versión:** 1.15.0 — **zoom bloqueado también por pinch y doble toque en iPhone**.
- v1.15.0 (anti-zoom endurecido): el Señor Stick pidió que fuera **imposible** hacer zoom desde el
  iPhone, priorizando esta app y STICK AROS. El bloque de v1.14.0 solo cubría trackpad y teclado.
  Ahora la guardia vive en `document` (no en `window`) con `passive:false` y añade: `touchstart` y
  `touchmove` con **dos dedos** → `preventDefault` (el pinch real de iOS), y `touchend` doble en el
  **mismo punto** (<30px, <300ms) → `preventDefault` (doble toque para hacer zoom).
  Caché SW → `stickfit-v13`. Verificado con eventos sintéticos sobre el archivo real en Chrome
  headless: **12/12** — se cancelan pinch, doble toque, `gesture*` y Ctrl+rueda, y NO se cancelan el
  scroll de un dedo ni dos toques seguidos en puntos lejanos. Con puntero grueso emulado el input
  mide 16px; en escritorio sigue en 14px.
- **Decisión (v1.15.0):** el guardia de doble toque compara **posición además de tiempo**. Un guardia
  solo por tiempo (300ms) habría comido el segundo toque al marcar dos ejercicios seguidos en la
  vista Hoy — exactamente el problema de "toques que se comen" que ya se corrigió en AROS. Con el
  umbral de 30px, dos toques en filas distintas pasan intactos.
- v1.14.0 (anti-zoom): pedido del Señor Stick para toda la familia Stick — al tocar un campo, el
  iPhone hacía zoom y la app perdía el acabado de producto. Tres piezas: meta viewport con
  `maximum-scale=1.0, user-scalable=no`; `html{touch-action:manipulation;text-size-adjust:100%}`; y
  bajo `@media (pointer:coarse)` todos los `input/select/textarea` a `font-size:16px !important`.
- **Decisión (v1.14.0):** la pieza que realmente corrige el caso es la de **16px**, no el meta
  viewport: desde iOS 10 Safari **ignora** `maximum-scale`/`user-scalable`, y hace zoom automático al
  enfocar cualquier campo cuya fuente mida menos de 16px (los `.field` estaban en 14px). El meta se
  deja porque sí sirve en Android y en escritorio. El zoom por atajo de teclado (`Ctrl` + `+`/`-`)
  lo reserva el navegador y no siempre es anulable desde la página. Regla en `STICK_UI_SYSTEM.md`
  §6.6.1.
- v1.13.0 — **marcar un ejercicio ya no re-renderiza la vista Hoy**.
- v1.13.0 (marcado fluido): marcar el check llamaba a `renderHoy()`, que reconstruía el `innerHTML`
  entero. Efecto: la animación del check nunca se veía (el nodo nacía ya marcado, sin estado previo
  desde el cual animar), la entrada escalonada `list-stagger` se relanzaba en toda la lista y el
  scroll saltaba. Ahora el click toca solo lo que cambia (`setCheck` + `paintDayProgress`): la clase
  de la fila, el ancho de la barra (`#dayBar`), el porcentaje (`#dayPct`) y la píldora del día.
  "Reiniciar día" usa el mismo camino. Caché SW → `stickfit-v11`.
- v1.13.0 (animación): el visto entra con rebote corto (`cubic-bezier(.34,1.56,.64,1)`) y la casilla
  hace un `chkpop` del 116 %. El tachado del nombre pasa de `text-decoration:line-through` —que no es
  animable— a un degradado de fondo que crece de izquierda a derecha.
- **Decisión (v1.13.0):** el tachado usa `display:inline` + `box-decoration-break:clone` para que un
  nombre que ocupe dos líneas quede tachado en las dos; con `inline-block` o un `::after` absoluto
  habría salido una sola raya a media altura del bloque.
- **Decisión (v1.13.0):** desmarcar ahora **borra** la clave de `S.checks` en vez de guardar `false`.
  El calendario de asistencia ya filtraba por valor verdadero, así que no cambia nada de la lógica,
  pero deja de acumular basura en el respaldo exportado.
- **Pendiente conocido (v1.13.0):** guardar o eliminar un registro de peso desde la hoja sí sigue
  llamando a `renderHoy()`. Ahí cambia también el contenido del botón de la fila, y el re-render
  ocurre mientras la hoja se cierra, así que no se percibe como salto. Si molesta, hay que reconstruir
  el botón `.ex-log` en sitio.
- **Versión:** 1.12.0 — **tarjeta de Medidas plegable**.
- v1.12.0 (medidas plegables): la tarjeta de Medidas corporales llegaba a ~900 px y dominaba Progreso.
  Ahora arranca **cerrada**: solo el título, un resumen de una línea (`measureSummary()`) y el chevron.
  Al tocar la cabecera se despliega **todo** de una vez: diagrama, las 9 tarjetas de zona, la nota de
  próxima toma y los botones Historial/Todas, que bajaron de la cabecera al pie del contenido.
  Caché SW → `stickfit-v10`.
- **Decisión (v1.12.0):** el resumen de la cabecera cerrada **carga el aviso**: en ámbar cuando toca
  medirse ("Toca medirte · última 02 ago") o cuando no hay ninguna toma; en gris el estado normal
  ("Última: 02 ago · 6 de 9 zonas"). Sin esto, plegar la tarjeta habría escondido el recordatorio,
  que es justo lo que dispara el ciclo de medición.
- **Decisión (v1.12.0):** el despliegue se anima con `grid-template-rows: 0fr → 1fr` (clase `.fold-body`)
  en vez de un `max-height` con un número inventado: así llega a la altura real del contenido, que
  cambia según cuántas zonas haya registradas. El toggle se aplica **sobre el DOM ya pintado**
  (`classList.toggle`), no re-renderizando: si la clase llegara puesta desde el render, el navegador
  no tendría estado previo desde el cual animar y el despliegue sería un salto.
- **Decisión (v1.12.0):** `mzOpen` vive en memoria, no en `localStorage` — es preferencia de vista, no
  dato del usuario, y arrancar siempre plegado es el comportamiento predecible. Única excepción: el
  aviso de **Hoy** pone `mzOpen=true` antes de navegar, para que la tarjeta reciba abierta a quien
  llega desde el recordatorio.
- v1.11.0 — **medidas con diagrama corporal tocable** + calendario de asistencia compacto.
- v1.11.0 (medidas): las medidas pasan de 4 zonas genéricas a **9**: hombro, pecho, bíceps izq/der,
  cintura, muslo izq/der y pantorrilla izq/der. La tarjeta de Medidas muestra un **diagrama frontal
  tocable** (`bodyMeasureSVG`): la zona ya registrada se pinta en verde tenue y al tocarla se alumbra
  y abre la hoja de **esa** medida (consejo de cómo medirla, última toma con fecha, campo en cm,
  botón Quitar si ya hay dato de hoy). Debajo, 9 tarjetas con el valor y el cambio vs. la primera
  toma. Se conserva "Todas" (toma completa de las 9 zonas) e "Historial". Caché SW → `stickfit-v9`.
- v1.11.0 (recordatorio): la app dice **cuándo volver a medirse** según el ritmo de la meta de peso
  (`MEASURE_EVERY`): ±0.5 kg/sem → cada 2 semanas · ±0.25 → 3 semanas · mantener → 4 semanas · sin
  meta → 21 días. La nota en Progreso muestra la próxima fecha y el motivo; cuando ya toca (o si
  nunca se han tomado) aparece además un aviso ámbar en **Hoy** que lleva a Progreso.
- v1.11.0 (asistencia): los cuadritos del mes bajan a **13 px y pierden el número**, se quita la
  cabecera L-M-M-J-V-S-D y la leyenda se compacta; las flechas ‹ › quedan en la misma línea del mes.
  El detalle del día ahora sale al **tocar** el cuadrito (toast) o al pasar el cursor (`title`).
- **Decisión (v1.11.0):** las zonas pares se guardan **por lado** (`biceps_izq`/`biceps_der`, etc.),
  no promediadas: la asimetría entre brazos o piernas es justo lo que hay que vigilar y un promedio
  la escondería. Migración one-shot con la bandera `measureSchema:2` — `brazo` → `biceps_der` y
  `muslo` → `muslo_der` (una medida vieja se tomó de un solo lado; asumir el dominante pierde menos
  información que duplicarla a los dos).
- **Decisión (v1.11.0):** el diagrama es la **vista frontal de la persona**, así que su lado izquierdo
  se dibuja a la derecha de la pantalla (como al mirarla de frente). Los `<rect class="mzhit">`
  transparentes al final del SVG agrandan el área de toque: los músculos dibujados miden pocos
  píxeles en un celular.
- **Decisión (v1.11.0):** el recordatorio **no guarda nada nuevo**; se deriva de la fecha del último
  registro de `measures[]` y del `rate` de `weightGoal`. Misma razón que la asistencia: un estado
  aparte se desincronizaría al corregir o borrar un registro.
- **Versión:** 1.10.0 — **asistencia mensual** (calendario de cuadritos en Progreso).
- v1.10.0 (asistencia): primer bloque de **Progreso**. Calendario del mes con un cuadrito por día
  (semana de lunes a domingo), navegación ‹ › entre meses (el botón "siguiente" se deshabilita en el
  mes actual), leyenda y dos stats: **racha** y **sesiones del mes / días programados**. Estados del
  cuadrito: verde sólido = día completo · verde tenue = entrenó a medias · borde rosa = tocaba y no
  fue · gris = descanso según la rutina · atenuado = futuro · anillo blanco = hoy. Caché SW →
  `stickfit-v8`.
- **Decisión (v1.10.0):** la asistencia **no guarda datos nuevos**; se deriva de `checks` (cuya clave
  ya empieza por la fecha) y de `history[].date`. Un día cuenta como entrenado con marcar un ejercicio
  o registrar un peso, y como completo cuando los checks del día igualan los ejercicios de la rutina.
  Guardar un estado aparte habría duplicado la verdad y se desincronizaría al reiniciar un día.
- **Decisión (v1.10.0):** `currentStreak()` recorre hacia atrás **saltando los días de descanso** de la
  rutina, así que la racha cuenta sesiones consecutivas, no días de calendario. El día de hoy sin
  entrenar todavía no rompe la racha (`i>0` para cortar); si no, la racha se vería en 0 cada mañana.
- **Versión:** 1.9.0 — **registro por ejercicio, serie por serie, en libras**.
- v1.9.0 (registro): desaparece el botón único "Registrar pesos" del día. Cada fila de **Hoy** lleva su
  propio botón a la derecha ("+ Peso"); al tocarlo se abre la hoja de **ese** ejercicio con una fila por
  serie (pre-cargadas con el objetivo), botón "Añadir serie" hasta 12, historial completo del ejercicio
  serie por serie y "Eliminar registro de hoy". Guardar **marca el ejercicio como hecho**; si ya hay
  registro de hoy el botón muestra el rango de carga (`85-100 lb`) y nº de series, y la hoja **edita**
  esa entrada en vez de duplicarla. Las cargas pasan de **kg a lb**; el peso corporal y la nutrición
  siguen en kg (Mifflin-St Jeor y g/kg lo exigen). Caché SW → `stickfit-v7`.
- **Decisión (v1.9.0):** ninguna vista colapsa ya las series en un solo número. `setPills()` pinta cada
  serie tal como se registró (`S1 100 lb × 10 · S2 95 lb × 9 …`) en Hoy, en la ficha del ejercicio y en
  Progreso, con la mejor serie resaltada en verde. `weight`/`reps` de la entrada se conservan = mejor
  serie (1RM Epley) porque son lo que alimenta la progresión, pero dejan de ser lo que se muestra.
- **Decisión (v1.9.0):** migración de unidades one-shot con la bandera `liftUnit`. Al cargar, si no es
  `"lb"` se multiplica ×2.20462 todo `history[].weight` y `history[].sets[].weight` y se marca. Sin eso
  los registros viejos en kg se leerían como libras y la progresión daría saltos falsos. Incrementos de
  sobrecarga en `nextTargetObj()`: **5 lb** en barra/máquina/prensa, **2.5 lb** en el resto.
- v1.8.0 — **Protocolo Base revisado** (hombro corregido + acondicionamiento).
- v1.8.0 (rutina semilla): auditoría de la rutina contra el objetivo declarado (físico atlético magro).
  El hombro estaba en **7 series/semana**, por debajo de la banda mínima de 10, siendo el deltoides
  medio el músculo que define la silueta buscada. Correcciones: `elevaciones-laterales` 3×12-15 a
  **Torso A** y `face-pull` 3×15-20 a **Torso B** → hombro **7 → 13** series con frecuencia 2×,
  repartidas en dos días en vez de amontonadas en uno. Añadido `hiit-sprints` 6×(30 s / 90 s) al
  final de **Pierna B**, que era la única carencia frente a la alternativa evaluada: la rutina no
  tenía acondicionamiento y el % de grasa gobierna la mitad del resultado. Se mantiene el esquema de
  3 días de descanso (jue/sáb/dom) poniendo el HIIT el mismo día de fuerza, no en un día libre.
  Sesiones resultantes: Lun 25 · Mar 18 · Mié 23 · Vie 18 series (~65-90 min). `SEED_VERSION` → **3**.
  Caché SW → `stickfit-v6`.
- **Decisión (v1.8.0):** `ex()` acepta un 11.º parámetro `cardio`; `weeklyVolume()` **excluye** los
  ejercicios con `cardio:true`. Sin esto las 6 series de sprints sumaban al grupo Pierna (26 → 32) y
  la tarjeta de volumen pintaba "alto" un dato que no es volumen de hipertrofia — corrompía la única
  métrica que gobierna las decisiones de la rutina. El catálogo semilla pasa a **32 ejercicios**.
- **Pendiente conocido (v1.8.0):** Brazo (9) y Core (6) siguen bajo la banda 10-20 en Protocolo Base.
  Es un rasgo del diseño Torso/Pierna, no un error; corregirlo exige alargar las sesiones. No se tocó
  porque no formaba parte del encargo.
- v1.7.0 — **historial de peso y medidas** con corrección y borrado.
- v1.7.0 (historial): botón "Historial" en los bloques de Peso corporal y Medidas corporales (solo
  aparece si hay registros) que abre una hoja con la lista completa, más reciente arriba. Peso: fecha,
  valor y diferencia contra el registro anterior, con resumen (nº de registros, días transcurridos y
  cambio total). Medidas: chips por zona con el valor y su diferencia contra la medida anterior **de
  esa misma zona** (no contra el registro anterior, que puede no incluirla). Cada fila permite
  **corregir** (hoja en `overlay2`) o **eliminar** (`confirmSheet`). Helpers nuevos `fechaCorta`/
  `fechaLarga` (parten el string ISO; `new Date()` interpreta medianoche UTC y en Colombia mostraría
  el día anterior). Clase `.card-head` para que en pantallas angostas los botones bajen a su línea en
  vez de partir el título. Caché SW → `stickfit-v5`.
- **Decisión (v1.7.0):** al corregir o borrar un registro de peso, `syncGoalStart()` recalcula
  `weightGoal.startKg`/`startDate` desde el registro más antiguo que quede. Sin eso, la proyección de
  "esperado hoy" seguiría anclada a un dato borrado. No se toca en el registro normal del día.
- v1.6.1 — dock alineado al `STICK_UI_SYSTEM.md` §4.5 y scrim de modales al §4.7.
- v1.6.1 (auditoría UI): el dock mostraba las 5 etiquetas a la vez (9 px mayúsculas, "Nutrición" se
  cortaba). Ahora sigue el **TabBar canónico**: solo la pestaña activa lleva label en píldora
  (`rgba(255,255,255,.10)` + borde `/10`), las demás quedan solo con ícono; geometría exacta del
  sistema (alto 62 px, ancho 92 % / máx. 384 px, `bottom` 20 px + safe-area, ícono 19 px con
  `stroke-width` 1.75 → 2 al activarse, label 11 px). Scrim de `.overlay`: `rgba(4,5,9,.72)`+blur 6
  → `rgba(0,0,0,.8)`+blur 4 (§4.7). Verificado en vivo: 5 vistas OK, 1 sola etiqueta visible,
  dock 384×62 centrado, sin scroll horizontal, sin errores de consola.
- **Versión:** 1.6.0 — **identidad visual del logo aplicada** (mancuerna roja sobre grafito).
- v1.6.0 (identidad): logo oficial = mancuerna de 3 discos por lado, rojo `#9f1313` sobre `#1e1f1f`.
  Maestro en `logo.png` (2000×2000, antes "LOGOS APPS.png"). Íconos PNG **regenerados vectorialmente**
  a cada tamaño (512/192/180/64) con el script de dibujo, no por reescalado. La marca dentro de la app
  (portada y header) se rehízo como SVG fiel al logo, con token CSS `--brand:#9f1313`; ocupa ~62 % de
  la placa, igual proporción que el ícono. Añadidos meta `og:`/`twitter:` para el enlace compartido.
  Caché SW → `stickfit-v4`. El resto de la paleta sigue siendo zinc dark-first con CTA blanco.
- v1.5.1 — QA final integral en vivo (22/22), sin errores de consola ni recursos fallidos.
- v1.5.1 (pulido de cierre): eliminado código muerto (`lastLog`); Medidas muestra "primer registro"
  en el primer dato; gramática del aviso corregida ("1 ejercicio registrado"). Caché SW → `stickfit-v3`.
- v1.5.0 (Tier 2): **registro set por set** en "Registrar pesos" — una fila por serie (según `item.sets`),
  pre-cargadas con el objetivo sugerido. Entrada de historial ahora lleva `sets:[{weight,reps}]` y
  `weight`/`reps` = **mejor serie** (mayor 1RM Epley), que alimenta tendencia/progresión. Backward
  compatible con entradas viejas (sin `sets`).
- v1.4.0 (Tier 2 + pulido): **Hojas del sistema** en vez de `prompt()`/`confirm()` nativos
  (`promptSheet`/`confirmSheet` sobre `#overlay2`). **Medidas corporales** en Progreso (cintura/pecho/
  brazo/muslo con tendencia; `S.measures[]`). **Volumen semanal por grupo muscular** (series/grupo de
  la rutina activa, con banda 10-20 y color ámbar/verde/azul).
- v1.3.2: **fix** — el constructor de rutinas no permitía añadir ejercicios a un día porque el selector
  (`pickExercise`) reutilizaba el mismo overlay y destruía el editor. Solución: **segundo overlay
  apilado** (`#overlay2`/`#sheet2` + `openSheet2`/`closeSheet2`). Detectado por la suite de QA.
- v1.3.1: **Temporizador eliminado por completo** a pedido del Señor Stick (descanso automático al
  marcar, FAB, modal, CSS y funciones). Se conserva la vibración breve al marcar. No reintroducir.
- **Deploy:** GitHub Pages, repo público `ZafiroSad/STICK-LIFE` (antes `STICK-FIT`, renombrado el 2026-11-24) → https://zafirosad.github.io/STICK-LIFE/
  (2026-08-01). Actualizar = commit + push a `main`; Pages redepliega solo. Repo git independiente
  (no confundir con el repo del home). Datos personales NO viven en el repo (solo localStorage).
- v1.3.0 (Tier 1 de mejoras): **PWA real** (`manifest.json` + `service-worker.js` network-first +
  íconos PNG 192/512/180/48) → instalable con ícono y offline. **Timer integrado**: al marcar un
  ejercicio auto-inicia el descanso con duración por ejercicio (≤8 reps 180 s · ≤12 90 s · resto 60 s)
  + vibración. **Progresión conectada**: Hoy muestra "objetivo X kg × Y" según la última sesión y
  pre-carga ese valor en "Registrar pesos". Fix: `fmt()` del timer (redondeo min/seg).
- v1.2.1: **Respaldo de datos** (Exportar/Importar JSON) en Progreso, para no perder el avance.
- v1.2.0: nueva pestaña **Progreso** (meta de peso corporal con tendencia y estimación de si vas en
  línea/adelantado/atrasado según el ritmo del objetivo; fuerza por ejercicio con sparkline, 1RM
  estimado por Epley y próximo objetivo por sobrecarga progresiva). Nutrición ahora genera **3 días
  de comidas** de ejemplo escalados a las kcal objetivo.
- v1.1.0: Protocolo Base con Jueves de descanso; diagramas musculares rediseñados. Migración `seedVersion`.
- Las 5 vistas, la ficha muscular, el registro de pesos, el progreso y la nutrición funcionan.

## Arquitectura
- **Un solo archivo** `index.html` autónomo (HTML + CSS + JS vanilla). Sin build, sin dependencias.
- `tools/gen-icons.ps1`: regenera los cuatro PNG de ícono dibujando el logo vectorialmente
  (PowerShell + System.Drawing) a partir de la geometría medida de `LOGO.png`. Ejecutar solo si
  cambia el logo; no forma parte de la app. Si cambia la **forma** (no solo el color) hay que volver
  a medir el maestro y actualizar las constantes del script.
- Persistencia en **`localStorage`** bajo la clave `sticklife-v1` (desde v3.0.0; antes `stickfit-v2`
  y `stickfit-v1`, que se conservan sin borrar).
- Se abre directo en el navegador del celular (doble click al archivo, o servir por HTTP).
- Lenguaje visual: **sistema STICK v2 «Campo y Vidrio»** replicado en CSS puro (desde v1.17.0):
  campo de luz animado en vez de fondo plano, vidrio líquido en vez de paneles, rampa grafito bajo
  los nombres `--zinc-*`, píldoras en todo lo pulsable, sin emojis, CTA de tinta, mono para valores,
  dock inferior y **botón de modo claro obligatorio**. Tipografía: stack Century Gothic (variante AROS).
- **Identidad:** logo mancuerna **blanco** `--brand:#ffffff` sobre placa grafito (desde v1.16.0; antes
  rojo `#9f1313`). Maestro: `LOGO.png` en la raíz. La marca no aporta color propio: los datos y las
  acciones siguen en zinc/emerald/amber/sky.

## Estructura funcional
- **Portada** → botón "Entrenar hoy" (flag `onboarded`).
- **Dock (5 vistas):** Hoy · Progreso · Rutinas · Ejercicios · Nutrición.
- **Progreso:** asistencia del mes (calendario a todo el ancho con el número de día, flechas ‹ ›,
  racha, % de cumplimiento; tocar un día lo abre en Hoy para completarlo)
  + peso corporal (meta con ritmo, barra inicio→meta, sparkline, "esperado hoy" vs real,
  **historial** con corrección y borrado)
  + medidas corporales (**tarjeta plegable**: cerrada muestra solo el resumen; abierta, diagrama
  tocable de 9 zonas + recordatorio de próxima toma + Historial/Todas) + fuerza por ejercicio (sparkline,
  1RM Epley, próximo objetivo) + volumen semanal por grupo muscular (series/grupo de la rutina activa,
  banda 10-20) + respaldo Exportar/Importar. Datos: `weightLog[]`, `weightGoal`, `measures[]`.
- **Hoy:** barra de semana (‹ › + "Hoy" para volver, `weekOffset`), selector de día con la fecha
  (`LUN 27`), checklist del día activo, barra de progreso y, **por ejercicio**, su
  propio botón de registro (hoja con una fila por serie en **lb**, pre-cargadas con el objetivo).
  Los checks se guardan por fecha (`checks[fecha|dia|idx]`), y esa `fecha` es la del **día y la semana
  que se estén viendo** (`dateOfDay(dayId,weekOffset)`), no la de hoy: marcar ayer queda en ayer.
- **Rutinas:** lista de planes; crear / renombrar / duplicar / activar / eliminar. Editor por día
  (enfoque, descanso, añadir/quitar ejercicios del catálogo, series/reps).
- **Ejercicios:** catálogo de 31 ejercicios de fuerza agrupados por músculo. Ficha al click con
  diagrama SVG frente/espalda (resalta músculos), ejecución, errores, tips, campo URL de imagen.
  Botón "Crear" para ejercicios propios.
- **Nutrición:** Mifflin-St Jeor → TDEE (factor de actividad) → objetivo (recomp / superávit magro /
  déficit) → kcal + macros (proteína 2 g/kg, grasa 25%, carbos resto) + agua (35 ml/kg). Guarda perfil.

## Modelo de datos
- `rutina` = plan semanal completo (7 días). Varias guardadas, una activa (`activeRoutineId`).
- Rutina semilla: **Protocolo Base**, split Torso/Pierna ×2 (Lun Torso A · Mar Pierna A · Mié Torso B
  · Vie Pierna B; Jue/Sáb/Dom descanso). Cambiar la semilla exige subir `SEED_VERSION` en el código.
- Ejercicio: `{id,name,group,muscles,sets,reps,eq,steps,errors,tips,cardio}`. `cardio:true` marca
  acondicionamiento (solo `hiit-sprints`): cuenta como ejercicio del día pero **no** suma en
  `weeklyVolume()`.
- `history[]`: registros {date, exId, weight, reps, sets:[{weight,reps}]} en **lb**. `sets[]` es la
  verdad (cada serie tal cual se hizo) y es lo que se muestra; `weight`/`reps` = mejor serie por Epley,
  se usan solo para la progresión. Una entrada por ejercicio y día: volver a guardar la edita.
- `liftUnit`: bandera de la migración kg→lb del historial de fuerza. El peso corporal (`weightLog`,
  `weightGoal`) y la nutrición siguen en kg; las medidas en cm.
- `measures[]`: un registro por día `{date, hombro, pecho, biceps_izq, biceps_der, cintura,
  muslo_izq, muslo_der, pantorrilla_izq, pantorrilla_der}` en **cm**; cada zona es opcional.
  `measureSchema`: bandera de la migración de las 4 zonas viejas a las 9 por lado.

## Decisiones tomadas (no re-litigar sin discusión)
1. Un solo HTML + localStorage (no React/Vite) — elegido por portabilidad.
2. Navegación por dock inferior (5 secciones: Hoy · Progreso · Rutinas · Ejercicios · Nutrición).
3. Ficha de ejercicio con diagrama SVG + técnica (no fotos incrustadas por peso; URL opcional).
4. Rutina = plan semanal completo.
5. Nutrición completa (kcal + macros + agua).
6. Split 4 días Torso/Pierna.
7. Entrada: mini-portada + dashboard.
8. Nombre: STICK FIT.
9. Tipografía: Century Gothic (variante AROS).
10. Progreso: checklist + registro de peso/reps con historial.

## Completado
- **Tier 1:** PWA real (instalable, offline, ícono propio), progresión conectada al día. (El timer
  integrado se construyó y luego se retiró a pedido del Señor Stick.)
- **Tier 2:** medidas corporales, volumen semanal por grupo muscular, registro set por set.
- **Deploy:** GitHub Pages + repo git independiente `ZafiroSad/STICK-LIFE` (antes `STICK-FIT`).

## Pendientes / ideas futuras (Tier 3, opcional)
- Plan de comidas con kcal reales por alimento y porciones escaladas.
- Reordenar ejercicios en el constructor.
- Nutrición: Katch-McArdle (si conoce % grasa) y semana de descarga (deload).
- Ampliar catálogo de ejercicios si el Señor Stick lo pide.
