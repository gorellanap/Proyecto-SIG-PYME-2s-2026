# BPMN TO-BE Final y Automatización en n8n

> **Responsable:** [Nombre integrante encargado de BPMN / n8n]  
> **Corresponde a:** Sección 4 del Informe E2

---

## 1. Diagrama BPMN TO-BE Final
*(Subir imagen legible a `entrega-2/assets/bpmn-tobe-final.png`)*

![BPMN TO-BE Final](../assets/bpmn-tobe-final.png)

* **Explicación del flujo:** El proceso comienza con la recepción y revisión del pedido. Luego se identifica el canal de venta. Para los pedidos web, el sistema registra y consolida los pedidos y notifica al responsable para que inicie la preparación. Después se gestiona el despacho y se entrega el pedido al transporte. Los pedidos de supermercados y distribuidores regionales siguen una ruta común de preparación y despacho. En el canal web, la meta es que transcurran como máximo dos días desde la compra hasta la entrega al transporte.

---

## 2. Cambios respecto al BPMN de la Entrega 1
En el BPMN de la Entrega 1, la preparación del pedido aparecía antes de identificar el canal de venta. En la versión final, la decisión se trasladó inmediatamente después de la revisión del pedido. Esto permitió ubicar el registro, la consolidación y la notificación de los pedidos web antes de la preparación, de modo que el aviso indique al responsable cuándo iniciar su trabajo. Los canales de supermercado y distribuidor regionales se agruparon porque compartían el mismo plazo y destino de despacho. Además, el temporizador de dos días del canal digital se reemplazó por una anotación que explicita la meta y el tramo en que se mide. 

---

## 3. Automatización con n8n
La automatización tiene **3 flujos**. Los flujos exportados en JSON y la guía completa (instalación, credenciales y pruebas)

![Flujo n8n](../assets/flujo-n8n.png)
### Flujo 01 · Registrar y consolidar pedidos web (`01-registrar-pedido-web.json`)
1. **Disparador — Webhook *Recibir solicitud*:** la página web envía el pedido (cliente, fecha de compra, sabores) a `POST /webhook/ruta/pedido-web`. En la demo se envía con `curl`, porque modificar la web está fuera del alcance.
2. **Code *Revisar pedido*:** revisa el RUT (dígito verificador), que estén todos los datos del cliente (son `NOT NULL` en `cliente`) y que los productos sean válidos.
3. **IF *¿Datos completos?* / *¿Productos existen?*:** si falta algo, responde un error y **no guarda nada**.
4. **MySQL *Guardar cliente*:** inserta el cliente o actualiza sus datos si el RUT ya existe (`UNIQUE (rut)`).
5. **IF *¿Pedido ya registrado?*:** si la web reenvía el mismo pedido, no se duplica (idempotencia).
6. **MySQL *Registrar pedido web* → *Consolidar productos del pedido* → *Abrir registro de despacho*:** crea el pedido en estado `Pendiente`, las líneas de `detalle_pedido` con el **precio congelado** y la fila 1:1 de `despacho`.
7. **Respond to Webhook *Confirmar recepción del pedido*:** devuelve el N° de pedido, el total y el **plazo de despacho** (compra + 2 días).
8. **Gmail *Notificar al responsable de preparación*:** correo con el pedido y su plazo *(construido, pero desactivado: ver límites)*.

### Flujo 02 · Preparar pedido y entregar al transporte (`02-preparar-y-despachar-pedido.json`)
1. **Disparador — Form *Formulario de bodega*** (con usuario y clave, RNF04): el encargado ingresa el N° de pedido y la etapa.
2. **MySQL *Consultar pedido* → IF *¿Pedido sin despachar?*:** rechaza pedidos inexistentes o ya despachados (RF08).
3. **Switch *¿Qué etapa?*:**
   - *Preparar pedido:* guarda `despacho.fecha_preparacion` y deja el pedido `En preparacion`.
   - *Entregado al transporte:* exige la empresa de transporte y guarda `fecha_entrega_transporte`, la empresa y el código de seguimiento; deja el pedido `Despachado`.
4. **MySQL *Calcular tiempo de ciclo* → pantalla final:** muestra los días desde la compra y si cumple la meta de 2 días.

### Flujo 03 · Recordar pedidos atrasados (`03-recordar-pedidos-atrasados.json`)
Mismo patrón del ejemplo del curso (*base de datos → IF → correo*):
1. **Disparador — Schedule Trigger:** lunes a sábado a las 9:00 y 15:00 (más un disparador manual para la demo). Es el temporizador que vigila la anotación del BPMN *"Meta del canal digital: ≤ 2 días"*.
2. **MySQL *Consultar pedidos atrasados*:** la misma regla de la **Consulta 1** de `consultas.sql`: pedidos no despachados con más de 24 h → **Alerta**, más de 48 h → **Atrasado**, del más antiguo al más nuevo.
3. **IF *¿Hay pedidos atrasados?*:** si no hay, termina sin avisar.
4. **MySQL *Consultar resumen de pedidos*:** pedidos por estado (Consulta 2) y días promedio compra → transporte (Consultas 3 y 4).
5. **Gmail *Notificar al responsable de preparación*:** lista priorizada + resumen *(desactivado: ver límites)*.

### Resultados de las pruebas (ejecutadas en localhost con la base oficial)

| Prueba | Resultado |
|---|---|
| Pedido válido de un cliente del seed (RUT 21201076-6) | HTTP 201, pedido **#26** `Pendiente`, total $5.980; el cliente **no se duplicó** (siguen 20). |
| Mismo pedido enviado dos veces | HTTP 200 *"ya estaba registrado"*: no se duplica. |
| Pedido con datos incompletos | HTTP 400 con 7 errores; no se guarda nada. |
| Producto inexistente | HTTP 422; no se guarda nada. |
| Formulario: preparar → entregar sin empresa → entregar con empresa | *En preparacion* → *"Falta un dato"* → *Despachado*, con las fechas guardadas en `despacho`. |
| Formulario: pedido ya despachado o inexistente | *"No se pudo actualizar"* (RF08). |
| Flujo 03 sobre el seed | Detecta los pedidos **#21, #23, #24 y #25** como *Atrasado* (igual que la Consulta 1); resumen: **6,0 días** promedio y **0 de 21** dentro de la meta. |

### Límites
* **Correo no conectado:** los nodos Gmail están construidos pero **desactivados**, porque el equipo decidió no conectar una cuenta de Gmail (Google exige crear un proyecto en Google Cloud con credenciales OAuth). Los flujos terminan sin errores y el resto funciona; para activarlos basta crear la credencial *Gmail OAuth2* en n8n y reactivar esos nodos.
* La página web real no está conectada (fuera del alcance); el webhook queda listo para recibir sus pedidos.
* El flujo 01 guarda en varios nodos y no en una sola transacción; si MySQL falla entre dos nodos, el pedido puede quedar incompleto.



---

## 4. Trazabilidad: Tareas BPMN ↔ Nodos n8n ↔ Tablas MySQL

| Tarea BPMN *to-be* | Nodo / Acción en n8n | Tabla(s) en MySQL (`ruta`) |
| :--- | :--- | :--- |
| **Registro automático del pedido** | Guardar cliente → Registrar pedido web → Obtener número de pedido → Consolidar productos del pedido. | `cliente`, `pedido`, `detalle_pedido` |
| **Detección y alerta de retraso (>24h)** | Flujo 03: el disparador programado inicia la consulta SQL de pedidos pendientes. El flujo evalúa el tiempo transcurrido y genera una alerta según el umbral configurado.| `pedido`, `cliente` |
| **Gestionar preparación y despacho** | Abrir registro de despacho. El nodo crea el registro asociado al pedido para dar seguimiento al despacho. | `pedido`, `despacho` |
