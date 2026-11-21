# CHANGELOG — cambios relevantes desde la Entrega 1

## v1.0-e2 (21-11-2026)

### Proceso (BPMN to-be)
- La identificación del canal de venta se movió justo después de revisar el pedido (en la E1 el pedido se preparaba antes de saber el canal).
- En el canal web, el registro, la consolidación y el aviso al responsable ahora ocurren **antes** de preparar el pedido.
- Supermercados y distribuidores regionales quedaron en una sola rama (mismo plazo y destino).
- El temporizador de 2 días se reemplazó por una anotación con la meta y el tramo que se mide (compra → entrega al transporte).
- Diagrama final: `entrega-2/assets/bpmn-tobe-final.png`.

### Modelo de datos
- Se normalizó el ER preliminar a 3FN (5 tablas: cliente, producto, pedido, detalle_pedido, despacho).
- Se quitó `monto_total` de pedido (dato derivado; se calcula desde detalle_pedido).
- Se quitó `region` de cliente (depende de la comuna: dependencia transitiva).
- Se quitó `stock_disponible` de producto (bodega fuera de alcance en la E1).
- `precio_unitario` queda congelado en detalle_pedido con el precio del día de la compra.
- Diagrama final: `entrega-2/assets/er-3fn.png`.

### Base de datos y SQL (`entrega-2/db/`)
- En la E1 el modelo era solo conceptual; en la E2 se implementó en MySQL 8 (MySQL Workbench).
- `schema.sql` con PK, FK, UNIQUE y CHECK; `seed.sql` con datos de prueba (20 clientes, 25 pedidos); `consultas.sql` con las 3 consultas del informe; `pruebas_integridad.sql` con 3 pruebas que la base rechaza.

### Automatización (`entrega-2/n8n/`)
- Nuevo: 3 flujos en n8n (registro de pedidos web, preparación y despacho, aviso de pedidos atrasados), conectados a la base `ruta`.

### Documentación
- Nueva carpeta `entrega-2/` con docs 00 a 05, `DECLARACION_IA.md`, informe E2 (PDF y Word) y presentación.
