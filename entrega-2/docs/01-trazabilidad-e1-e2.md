# Trazabilidad de Cambios (Entrega 1 → Entrega 2)

> **Corresponde a:** Sección 3 del Informe E2 y `CHANGELOG.md`

---

## 1. Qué se Mantuvo de la Entrega 1
* Caso real de negocio (**Ruta Snack SpA**) y problema medible (Lead Time de 6 días vs. meta $\le 2$ días).
* Requerimientos funcionales principales (`RF-01` a `RF-07`) y entidades troncales del modelo (`cliente`, `producto`, `pedido`, `detalle_pedido`, `despacho`).

---

## 2. Qué Cambió y Por Qué

| Elemento | En la Entrega 1 | En la Entrega 2 | Motivo del Cambio |
| :--- | :--- | :--- | :--- |
| **BPMN *to-be*** | Se preparaba el pedido antes de identificar el canal de venta. En el canal web, el registro y la notificación ocurrían después de la preparación. | Se identifica el canal después de revisar el pedido. En el canal web, se registran y consolidan los pedidos y se notifica al responsable antes de preparar. Los dos días se indican como meta desde la compra hasta la entrega al transporte.  | El aviso permite iniciar la preparación a tiempo. La meta de dos días aclara el plazo y el tramo que se mide.  |
| **Modelo ER** | Modelo preliminar con `monto_total`, `region` y `stock_disponible` | Modelo normalizado en **3FN estricta** (sin atributos derivados ni transitivos) | Evitar anomalías de actualización (`monto_total`, `region`) y respetar alcance `OUT` de bodega (`stock_disponible`). |
| **Motor de BD** | Propuesta conceptual | Implementación ejecutada en **MySQL 8** con 4 scripts SQL y datos de prueba | Validar restricciones de integridad (`PK`, `FK`, `UNIQUE`, `CHECK`) y KPIs reales. |
| **Automatización** | Sin prototipo ejecutado | Flujo funcional en **n8n** para alertas de pedidos atrasados ($>24\text{ h}$) | Eliminar el olvido operativo en la preparación de órdenes web. |
