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
* *(Listar qué se modificó en el diagrama y por qué).*

---

## 3. Automatización con n8n
*(Subir captura a `entrega-2/assets/flujo-n8n.png` y archivo exportado en `entrega-2/n8n/`)*

![Flujo n8n](../assets/flujo-n8n.png)

* **Disparador y nodos:** *(Explicar paso a paso: Trigger → Consulta SQL → Condición >24h / >48h → Notificación).*

---

## 4. Trazabilidad: Tareas BPMN ↔ Nodos n8n ↔ Tablas MySQL

| Tarea BPMN *to-be* | Nodo / Acción en n8n | Tabla(s) en MySQL (`ruta`) |
| :--- | :--- | :--- |
| **Registro automático del pedido** | *(Completar nodo)* | `cliente`, `pedido`, `detalle_pedido` |
| **Detección y alerta de retraso (>24h)** | *(Completar nodo)* | `pedido`, `cliente` |
| **Gestionar preparación y despacho** | *(Completar nodo)* | `pedido`, `despacho` |
