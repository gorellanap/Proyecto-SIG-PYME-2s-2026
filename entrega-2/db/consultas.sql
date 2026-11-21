-- ============================================================
--  Proyecto SIG  "Ruta Snack SpA"
--  Consultas de negocio
--  ICN292 - Sistemas de Información para la Gestión
-- ============================================================
--  Se corre después de schema.sql y seed.sql.
--  Se usa como "hoy" el 20-11-2026 a las 09:00, que es cuando se
--  cortaron los datos. En el día a día se cambia por NOW().
-- ============================================================

USE ruta;

-- ============================================================
--  CONSULTAS  (las 3 primeras son las del informe)
-- ============================================================

-- Consulta 1
-- Pedidos que todavía no salen al transporte y cuántas horas llevan
-- esperando. Más de 24 h es alerta y más de 48 h (2 días) está atrasado
SELECT   p.id_pedido,
         c.nombre AS cliente,
         p.fecha_compra,
         p.estado_pedido,
         TIMESTAMPDIFF(HOUR, p.fecha_compra, '2026-11-20 09:00:00') AS horas_espera,
         CASE
             WHEN TIMESTAMPDIFF(HOUR, p.fecha_compra, '2026-11-20 09:00:00') > 48 THEN 'Atrasado'
             WHEN TIMESTAMPDIFF(HOUR, p.fecha_compra, '2026-11-20 09:00:00') > 24 THEN 'Alerta'
             ELSE 'En plazo'
         END AS semaforo
FROM     pedido  p
JOIN     cliente c ON p.id_cliente = c.id_cliente
WHERE    p.estado_pedido <> 'Despachado'
ORDER BY p.fecha_compra;

-- Consulta 2
-- KPI: días promedio desde la compra hasta la entrega al transporte, y
-- cuántos cumplen la meta de 2 días (48 horas). Los despachados tienen que
-- sumar lo mismo que en la consulta 5 (por mes)
SELECT   COUNT(*) AS despachados,
         ROUND(AVG(TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_entrega_transporte)) / 24.0, 1) AS dias_promedio,
         SUM(CASE WHEN TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_entrega_transporte) <= 48
                  THEN 1 ELSE 0 END) AS cumplen_meta
FROM     pedido   p
JOIN     despacho d ON p.id_pedido = d.id_pedido
WHERE    p.estado_pedido = 'Despachado';

-- Consulta 3
-- ¿Dónde se pierde el tiempo? Horas que el pedido espera antes de que
-- alguien empiece a prepararlo, y horas desde que se prepara hasta que
-- sale al transporte
SELECT   ROUND(AVG(TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_preparacion)), 1) AS horas_antes_de_preparar,
         ROUND(AVG(TIMESTAMPDIFF(HOUR, d.fecha_preparacion, d.fecha_entrega_transporte)), 1) AS horas_preparar_a_transporte
FROM     pedido   p
JOIN     despacho d ON p.id_pedido = d.id_pedido
WHERE    p.estado_pedido = 'Despachado';

-- ============================================================
--  CONSULTAS DE APOYO
-- ============================================================

-- Consulta 4
-- Cuántos pedidos hay en cada estado y qué porcentaje son del total
SELECT   estado_pedido,
         COUNT(*) AS pedidos,
         ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pedido), 1) AS porcentaje
FROM     pedido
GROUP BY estado_pedido
ORDER BY pedidos DESC;

-- Consulta 5
-- Por mes: pedidos despachados y días promedio desde la compra hasta
-- la entrega al transporte (horas / 24)
SELECT   MONTH(p.fecha_compra) AS mes,
         COUNT(*) AS despachados,
         ROUND(AVG(TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_entrega_transporte)) / 24.0, 1) AS dias_promedio,
         ROUND(MIN(TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_entrega_transporte)) / 24.0, 1) AS dias_min,
         ROUND(MAX(TIMESTAMPDIFF(HOUR, p.fecha_compra, d.fecha_entrega_transporte)) / 24.0, 1) AS dias_max
FROM     pedido   p
JOIN     despacho d ON p.id_pedido = d.id_pedido
WHERE    p.estado_pedido = 'Despachado'
GROUP BY MONTH(p.fecha_compra)
ORDER BY mes;

-- Consulta 6
-- Clientes que han comprado más de una vez
SELECT   c.nombre, COUNT(*) AS pedidos
FROM     cliente c
JOIN     pedido  p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING   COUNT(*) > 1
ORDER BY pedidos DESC, c.nombre;

-- Consulta 7
-- Tasa de recompra: clientes con más de un pedido sobre el total
SELECT   COUNT(*) AS clientes_que_recompran,
         (SELECT COUNT(*) FROM cliente) AS clientes,
         ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cliente), 1) AS tasa_recompra
FROM     cliente
WHERE    id_cliente IN (SELECT   id_cliente
                        FROM     pedido
                        GROUP BY id_cliente
                        HAVING   COUNT(*) > 1);

-- Consulta 8
-- Ventas de la web por variedad, con el precio que se cobró en cada pedido
SELECT   pr.nombre_variedad,
         SUM(dp.cantidad) AS unidades,
         SUM(dp.cantidad * dp.precio_unitario) AS ventas
FROM     producto       pr
JOIN     detalle_pedido dp ON pr.id_producto = dp.id_producto
GROUP BY pr.id_producto, pr.nombre_variedad
ORDER BY ventas DESC;
