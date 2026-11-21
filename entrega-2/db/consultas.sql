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
--  CONSULTAS
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
-- cuántos cumplen la meta de 2 días (48 horas)
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
