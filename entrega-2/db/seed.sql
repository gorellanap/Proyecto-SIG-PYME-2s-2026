-- ============================================================
--  Proyecto SIG  "Ruta Snack SpA"
--  Datos de prueba
--  ICN292 - Sistemas de Información para la Gestión
-- ============================================================
--  Se corre después de schema.sql.
--  Pedidos web entre el 04-09-2026 y el 17-11-2026 (datos
--  cortados el 20-11-2026 a las 09:00).
--  Los datos de los clientes son ficticios.
-- ============================================================

USE ruta;

-- ============================================================
--  DATOS DE PRUEBA
-- ============================================================

-- Precio de hoy. Hasta el 30-09-2026 el precio era 2790
INSERT INTO producto (nombre_variedad, gramaje_gr, precio_lista) VALUES
('Sal de Mar',       150, 2990.00),  -- 1
('Crema de Cebolla', 150, 2990.00),  -- 2
('Merkén Ahumado',   150, 2990.00);  -- 3

SELECT * FROM producto;

INSERT INTO cliente (rut, nombre, telefono, email, direccion_despacho, comuna) VALUES
('21201076-6', 'Clemente Luoni Ortega',       '+56988973404', 'clemente.luoni@usm.cl',         'Germán Riesco 1200',        'Valparaíso'),    -- 1
('20063027-0', 'Antonia Valenzuela Riquelme', '+56942644510', 'antonia.valenzuela@usm.cl',     'Av. Brasil 800',            'Ñuñoa'),         -- 2
('20192865-6', 'Yamilet Ortega Moraga',       '+56963362775', 'yamilet.ortega@gmail.com',      'Los Carrera 1350',          'Santiago'),      -- 3
('21214670-6', 'Gonzalo Ortega Luoni',        '+56971318092', 'gonzalo.ortega@usm.cl',         'Camino a Tagua Tagua 1300', 'Viña del Mar'),  -- 4
('21493477-9', 'Florencia Palma',             '+56963572759', 'florencia.palma@usm.cl',        'Camino a Tagua Tagua 850',  'Providencia'),   -- 5
('20210417-7', 'Antonia Mancilla Luoni',      '+56997004069', 'antonia.mancilla@gmail.com',    'Av. Libertador 1350',       'Pichidegua'),    -- 6
('21118949-5', 'Florencia Riquelme Luoni',    '+56911178974', 'florencia.riquelme@usm.cl',     'Av. España 1050',           'Santiago'),      -- 7
('20475862-K', 'Florencia Riquelme Ortega',   '+56912912635', 'florencia.riquelme29@usm.cl',   'Av. España 1450',           'Providencia'),   -- 8
('13242261-3', 'Marcelo Valenzuela Moraga',   '+56946588625', 'marcelo.valenzuela@gmail.com',  'Av. Brasil 800',            'San Vicente'),   -- 9
('20883521-1', 'Marcelo Moraga Valenzuela',   '+56997071370', 'marcelo.moraga@usm.cl',         'Av. España 450',            'San Vicente'),   -- 10
('20470801-0', 'Gonzalo Moraga Ortega',       '+56930041965', 'gonzalo.moraga@gmail.com',      'Los Aromos 950',            'San Vicente'),   -- 11
('19886917-1', 'Antonia Luoni Mancilla',      '+56932263500', 'antonia.luoni@gmail.com',       'Av. Libertador 950',        'San Vicente'),   -- 12
('19226468-5', 'Florencia Luoni Riquelme',    '+56933039133', 'florencia.luoni@gmail.com',     'Av. Libertador 750',        'Rancagua'),      -- 13
('21279956-4', 'Antonia Riquelme Valenzuela', '+56936418944', 'antonia.riquelme@usm.cl',       'Germán Riesco 1050',        'Valparaíso'),    -- 14
('9843489-5',  'Clemente Valenzuela Luoni',   '+56992995029', 'clemente.valenzuela@gmail.com', 'Membrillar 350',            'Rancagua'),      -- 15
('19287022-4', 'Gonzalo Riquelme Ortega',     '+56990976657', 'gonzalo.riquelme@usm.cl',       'Camino a Tagua Tagua 900',  'San Fernando'),  -- 16
('21459260-6', 'Marcelo Luoni Mancilla',      '+56985589073', 'marcelo.luoni@gmail.com',       'Camino a Tagua Tagua 850',  'Providencia'),   -- 17
('19939444-4', 'Gonzalo Orellana',            '+56958117116', 'gonzalo.orellana@gmail.com',    'Pasaje Las Rosas 200',      'Rancagua'),      -- 18
('19601859-K', 'Marcelo Ortega Valenzuela',   '+56952158540', 'marcelo.ortega@usm.cl',         'Los Carrera 1000',          'San Fernando'),  -- 19
('20549083-3', 'Florencia Ortega Orellana',   '+56936536440', 'florencia.ortega@usm.cl',       'Errázuriz 300',             'Valparaíso');    -- 20

SELECT * FROM cliente;

-- Pedidos ordenados por fecha de compra. Los últimos todavía no
-- salen al transporte
INSERT INTO pedido (id_cliente, fecha_compra, estado_pedido) VALUES
(14, '2026-09-04 14:30:00', 'Despachado'),      -- 1
(7,  '2026-09-19 08:45:00', 'Despachado'),      -- 2
(4,  '2026-09-24 14:00:00', 'Despachado'),      -- 3
(2,  '2026-09-29 10:45:00', 'Despachado'),      -- 4
(9,  '2026-09-30 08:15:00', 'Despachado'),      -- 5
(17, '2026-09-30 10:15:00', 'Despachado'),      -- 6
(14, '2026-10-02 19:30:00', 'Despachado'),      -- 7
(11, '2026-10-03 20:30:00', 'Despachado'),      -- 8
(3,  '2026-10-05 18:45:00', 'Despachado'),      -- 9
(12, '2026-10-08 13:45:00', 'Despachado'),      -- 10
(1,  '2026-10-10 14:45:00', 'Despachado'),      -- 11
(6,  '2026-10-14 08:00:00', 'Despachado'),      -- 12
(19, '2026-10-15 12:15:00', 'Despachado'),      -- 13
(17, '2026-10-20 20:00:00', 'Despachado'),      -- 14
(10, '2026-10-28 18:00:00', 'Despachado'),      -- 15
(14, '2026-10-29 09:15:00', 'Despachado'),      -- 16
(3,  '2026-10-31 19:15:00', 'Despachado'),      -- 17
(15, '2026-11-01 16:45:00', 'Despachado'),      -- 18
(16, '2026-11-04 20:00:00', 'Despachado'),      -- 19
(8,  '2026-11-07 21:30:00', 'Despachado'),      -- 20
(18, '2026-11-13 11:45:00', 'En preparacion'),  -- 21
(6,  '2026-11-13 17:30:00', 'Despachado'),      -- 22
(13, '2026-11-14 17:30:00', 'Pendiente'),       -- 23
(20, '2026-11-17 15:15:00', 'Pendiente'),       -- 24
(5,  '2026-11-17 21:00:00', 'Pendiente');       -- 25

SELECT * FROM pedido;

-- El precio unitario es el del día de la compra: 2790 en septiembre
-- y 2990 desde octubre
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1,  3, 2, 2790.00),
(2,  1, 3, 2790.00),
(2,  3, 3, 2790.00),
(3,  1, 2, 2790.00),
(3,  3, 1, 2790.00),
(4,  1, 1, 2790.00),
(4,  2, 1, 2790.00),
(4,  3, 2, 2790.00),
(5,  2, 2, 2790.00),
(5,  3, 3, 2790.00),
(6,  1, 3, 2790.00),
(6,  3, 3, 2790.00),
(7,  2, 2, 2990.00),
(8,  2, 4, 2990.00),
(9,  2, 2, 2990.00),
(10, 1, 1, 2990.00),
(10, 2, 3, 2990.00),
(10, 3, 2, 2990.00),
(11, 2, 2, 2990.00),
(11, 3, 3, 2990.00),
(12, 2, 2, 2990.00),
(13, 2, 3, 2990.00),
(14, 1, 2, 2990.00),
(14, 3, 2, 2990.00),
(15, 1, 1, 2990.00),
(15, 3, 1, 2990.00),
(16, 1, 3, 2990.00),
(16, 2, 1, 2990.00),
(16, 3, 3, 2990.00),
(17, 3, 4, 2990.00),
(18, 2, 2, 2990.00),
(18, 3, 3, 2990.00),
(19, 2, 1, 2990.00),
(19, 3, 1, 2990.00),
(20, 1, 2, 2990.00),
(21, 1, 2, 2990.00),
(21, 2, 2, 2990.00),
(22, 1, 2, 2990.00),
(22, 2, 2, 2990.00),
(23, 2, 4, 2990.00),
(24, 3, 1, 2990.00),
(25, 2, 3, 2990.00),
(25, 3, 1, 2990.00);

SELECT * FROM detalle_pedido;

-- Un despacho por pedido. Mientras el pedido no avanza, las fechas
-- y la empresa quedan en NULL
INSERT INTO despacho (id_pedido, fecha_preparacion, fecha_entrega_transporte, empresa_transporte, codigo_seguimiento) VALUES
(1,  '2026-09-11 08:00:00', '2026-09-11 15:30:00', 'Blue Express', 'BX-1001'),
(2,  '2026-09-25 08:00:00', '2026-09-25 11:00:00', 'Chilexpress',  'CX-1002'),
(3,  '2026-09-30 11:30:00', '2026-09-30 13:30:00', 'Starken',      'ST-1003'),
(4,  '2026-10-03 17:00:00', '2026-10-04 11:30:00', 'Chilexpress',  'CX-1004'),
(5,  '2026-10-06 10:30:00', '2026-10-06 15:30:00', 'Starken',      'ST-1005'),
(6,  '2026-10-06 09:00:00', '2026-10-06 17:30:00', 'Chilexpress',  'CX-1006'),
(7,  '2026-10-08 16:30:00', '2026-10-09 15:30:00', 'Chilexpress',  'CX-1007'),
(8,  '2026-10-10 11:00:00', '2026-10-10 13:30:00', 'Starken',      'ST-1008'),
(9,  '2026-10-10 19:30:00', '2026-10-11 14:30:00', 'Blue Express', 'BX-1009'),
(10, '2026-10-14 19:00:00', '2026-10-15 13:00:00', 'Starken',      'ST-1010'),
(11, '2026-10-16 08:00:00', '2026-10-16 12:30:00', 'Chilexpress',  'CX-1011'),
(12, '2026-10-19 17:30:00', '2026-10-20 13:30:00', 'Chilexpress',  'CX-1012'),
(13, '2026-10-20 17:30:00', '2026-10-21 17:30:00', 'Starken',      'ST-1013'),
(14, '2026-10-25 16:30:00', '2026-10-26 10:00:00', 'Starken',      'ST-1014'),
(15, '2026-11-02 18:00:00', '2026-11-03 15:30:00', 'Starken',      'ST-1015'),
(16, '2026-11-05 12:00:00', '2026-11-05 15:30:00', 'Chilexpress',  'CX-1016'),
(17, '2026-11-05 16:30:00', '2026-11-06 10:00:00', 'Blue Express', 'BX-1017'),
(18, '2026-11-06 15:00:00', '2026-11-07 16:30:00', 'Chilexpress',  'CX-1018'),
(19, '2026-11-09 11:00:00', '2026-11-09 13:30:00', 'Starken',      'ST-1019'),
(20, '2026-11-11 16:30:00', '2026-11-12 15:30:00', 'Blue Express', 'BX-1020'),
(21, '2026-11-19 17:00:00', NULL,                  NULL,           NULL),       -- en preparación
(22, '2026-11-17 15:00:00', '2026-11-18 10:30:00', 'Starken',      'ST-1022'),
(23, NULL,                  NULL,                  NULL,           NULL),       -- pendiente
(24, NULL,                  NULL,                  NULL,           NULL),       -- pendiente
(25, NULL,                  NULL,                  NULL,           NULL);       -- pendiente

SELECT * FROM despacho;
