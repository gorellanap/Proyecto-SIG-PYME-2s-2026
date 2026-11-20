# Modelo de Datos en 3FN y Diccionario de Datos — Ruta Snack SpA

## 1. Diagrama Entidad-Relación (3FN)

![Diagrama ER 3FN](../assets/er-3fn.png)

---

## 2. Proceso de Normalización Aplicado (1FN → 2FN → 3FN)

El esquema relacional de **Ruta Snack SpA** se construyó cumpliendo en orden las tres primeras formas normales. Con esto se busca que cada atributo dependa *"de la clave, de toda la clave y de nada más que de la clave"*.

### Primera Forma Normal (1FN: atomicidad y eliminación de grupos repetitivos)
* **Regla aplicada:** Cada atributo guarda un solo valor, indivisible. No hay columnas numeradas (`sabor1`, `sabor2`...) ni listas separadas por comas dentro de una misma celda.
* **Evidencia en el modelo:** En vez de almacenar listas de sabores o cantidades dentro de `PEDIDO`, los productos comprados pasaron a una entidad propia, `DETALLE_PEDIDO`, donde cada fila corresponde a un único producto dentro de un pedido. Además, la dirección del cliente se dividió en atributos atómicos (`direccion_despacho`, `comuna`, `region`) y el formato del producto se aisló en el atributo `gramaje_gr`.

### Segunda Forma Normal (2FN: eliminación de dependencias parciales y resolución de relaciones N:M)
* **Regla aplicada:** Todo atributo que no sea clave debe depender de la clave primaria o candidata completa, no solo de una parte de ella.
* **Evidencia en el modelo:** La relación muchos a muchos ($N:M$) entre `PEDIDO` y `PRODUCTO` (un pedido incluye varios sabores y un mismo sabor se vende en muchos pedidos) se resolvió dividiéndola en dos relaciones $1:N$. Para ello se usó la entidad asociativa `DETALLE_PEDIDO`, con una restricción única sobre `(id_pedido, id_producto)`. Los atributos propios del catálogo (`nombre_variedad`, `gramaje_gr`, `precio_lista` y `stock_disponible`) dependen solo de `id_producto` y no del pedido, así que quedan en `PRODUCTO`. En `DETALLE_PEDIDO` permanecen únicamente `cantidad` y `precio_unitario`, este último como el precio "congelado" al día de la venta.

### Tercera Forma Normal (3FN: eliminación de dependencias transitivas y datos derivados)
* **Regla aplicada:** Ningún atributo que no sea clave debe depender, de forma transitiva, de otro atributo que tampoco sea clave.
* **Evidencia en el modelo:**
  * Los datos personales y de ubicación del cliente (`rut`, `nombre`, `telefono`, `email`, `direccion_despacho`, `comuna` y `region`) dependen de `id_cliente` y no de `id_pedido`. Al trasladarlos a `CLIENTE` se elimina la dependencia transitiva `id_pedido` $\rightarrow$ `id_cliente` $\rightarrow$ `direccion_despacho`.
  * Respecto al modelo preliminar de la Entrega 1, se quitó el atributo `monto_total` de `PEDIDO`, ya que es un dato derivado que puede calcularse con consultas SQL a partir de `DETALLE_PEDIDO`.
  * El seguimiento logístico se separó en `DESPACHO`, que se relaciona $1:1$ con `PEDIDO` mediante una FK única. Así quedan aislados los hitos de tiempo (`fecha_preparacion` y `fecha_entrega_transporte`) y los datos del operador logístico (`empresa_transporte` y `codigo_seguimiento`).

---

## 3. Anomalías Evitadas gracias a la 3FN

Si la empresa siguiera trabajando con una sola planilla sin normalizar ("todo en uno"), tendría tres anomalías graves que este modelo elimina:

* **Anomalía de inserción:** Con el diseño en 3FN se puede registrar un cliente nuevo en `CLIENTE`, o una nueva variedad de papas fritas en `PRODUCTO`, sin que exista un pedido previo asociado.
* **Anomalía de actualización:** Si un cliente frecuente cambia su dirección o su teléfono, basta modificar una sola fila en `CLIENTE`, y el cambio se aplica automáticamente a todos sus pedidos futuros, sin repetir trabajo ni generar inconsistencias. Del mismo modo, si Ruta cambia el `precio_lista` de sus papas en `PRODUCTO`, los pedidos históricos mantienen intacto el `precio_unitario` que se cobró en `DETALLE_PEDIDO`.
* **Anomalía de eliminación:** Si se anula o elimina un pedido en `PEDIDO` (con eliminación en cascada de sus filas en `DETALLE_PEDIDO` y `DESPACHO`), no se pierde el registro del cliente ni la información del catálogo de productos.

---

## 4. Diccionario de Datos Consolidado (PostgreSQL)

| Entidad | Claves (PK / FK) | Atributos y Tipos | Reglas de Integridad y Negocio |
| :--- | :--- | :--- | :--- |
| **CLIENTE** | **PK:** `id_cliente` | `rut` (`VARCHAR(12)`), `nombre` (`VARCHAR(120)`), `telefono` (`VARCHAR(20)`), `email` (`VARCHAR(120)`), `direccion_despacho` (`VARCHAR(200)`), `comuna` (`VARCHAR(80)`), `region` (`VARCHAR(80)`) | `rut` es `UNIQUE` y `NOT NULL` (evita duplicados); todos los campos son `NOT NULL` para asegurar datos mínimos de despacho. |
| **PRODUCTO** | **PK:** `id_producto` | `nombre_variedad` (`VARCHAR(100)`), `gramaje_gr` (`INT`), `precio_lista` (`Decimal(10,2)`), `stock_disponible` (`INT`) | `nombre_variedad` es `UNIQUE` y `NOT NULL`; `CHECK`: `gramaje_gr > 0`, `precio_lista >= 0` y `stock_disponible >= 0`; `precio_lista` guarda el precio vigente hoy. |
| **PEDIDO** | **PK:** `id_pedido`, **FK:** `id_cliente` (`INT`) $\rightarrow$ `CLIENTE` | `fecha_compra` (`TIMESTAMP`), `estado_pedido` (`VARCHAR(30)`) | `fecha_compra` asigna `CURRENT_TIMESTAMP` por defecto; `CHECK` en `estado_pedido` (solo estados válidos); sin `monto_total` (3FN); `ON DELETE RESTRICT` en cliente. |
| **DETALLE_PEDIDO** | **PK:** `id_detalle`, **FK1:** `id_pedido` (`INT`) $\rightarrow$ `PEDIDO`, **FK2:** `id_producto` (`INT`) $\rightarrow$ `PRODUCTO` | `cantidad` (`INT`), `precio_unitario` (`Decimal(10,2)`) | `UNIQUE (id_pedido, id_producto)` evita repetir el mismo sabor en un pedido; `CHECK`: `cantidad > 0` y `precio_unitario >= 0`; `precio_unitario` congela el precio histórico de venta. |
| **DESPACHO** | **PK:** `id_despacho`, **FK:** `id_pedido` (`INT`) $\rightarrow$ `PEDIDO` | `fecha_preparacion` (`TIMESTAMP`), `fecha_entrega_transporte` (`TIMESTAMP`), `empresa_transporte` (`VARCHAR(80)`), `codigo_seguimiento` (`VARCHAR(60)`) | `id_pedido` es `UNIQUE` y `NOT NULL` (relación estricta 1:1); campos admiten `NULL` mientras el pedido está en estado `'Pendiente'`; `CHECK`: `fecha_entrega_transporte >= fecha_preparacion`. |
