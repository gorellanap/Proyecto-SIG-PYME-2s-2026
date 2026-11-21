-- ============================================================
--  Proyecto SIG  "Ruta Snack SpA"
--  Pruebas de integridad: datos que la base tiene que rechazar
--  ICN292 - Sistemas de Información para la Gestión
-- ============================================================
--  Se corre después de schema.sql y seed.sql.
--  Cada prueba TIENE que dar error. Workbench se detiene en el
--  primer error, así que conviene correrlas de a una (Ctrl+Enter).
-- ============================================================

USE ruta;

-- Prueba 1
-- Se intenta guardar un pedido con un estado que no está permitido.
-- Tiene que dar error por el CHECK de estado_pedido
INSERT INTO pedido (id_cliente, fecha_compra, estado_pedido)
VALUES (1, '2026-11-20 10:00:00', 'Entregado');

-- Prueba 2
-- Se intenta guardar un pedido de un cliente que no existe (id 99).
-- Tiene que dar error por la clave foránea hacia cliente
INSERT INTO pedido (id_cliente, fecha_compra, estado_pedido)
VALUES (99, '2026-11-20 10:00:00', 'Pendiente');

-- Prueba 3
-- El pedido 1 ya tiene Merkén Ahumado (producto 3). Se intenta agregar
-- otra línea con el mismo producto. Tiene que dar error por el UNIQUE
-- (id_pedido, id_producto)
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (1, 3, 1, 2790.00);
