-- ============================================================
--  Proyecto SIG  "Ruta Snack SpA"
--  Pedidos web: clientes, productos, pedidos y despachos (5 tablas)
--  ICN292 - Sistemas de Información para la Gestión
-- ============================================================

-- 1) Crear y seleccionar la base
DROP DATABASE IF EXISTS ruta;
CREATE DATABASE ruta;
USE ruta;

-- ============================================================
--  TABLAS
-- ============================================================

-- Tabla base: se crea primero porque pedido la referencia
CREATE TABLE cliente (
    id_cliente          INT AUTO_INCREMENT,
    rut                 VARCHAR(12)  NOT NULL,
    nombre              VARCHAR(120) NOT NULL,
    telefono            VARCHAR(20)  NOT NULL,
    email               VARCHAR(120) NOT NULL,
    direccion_despacho  VARCHAR(200) NOT NULL,
    comuna              VARCHAR(80)  NOT NULL,
    PRIMARY KEY (id_cliente),
    UNIQUE (rut)
);

-- Tabla base: se crea primero porque detalle_pedido la referencia
CREATE TABLE producto (
    id_producto      INT AUTO_INCREMENT,
    nombre_variedad  VARCHAR(100)  NOT NULL,
    gramaje_gr       INT           NOT NULL,
    precio_lista     DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_producto),
    UNIQUE (nombre_variedad),
    CHECK (gramaje_gr > 0),
    CHECK (precio_lista >= 0)
);

-- Tabla con clave foránea hacia cliente
CREATE TABLE pedido (
    id_pedido      INT AUTO_INCREMENT,
    id_cliente     INT         NOT NULL,
    fecha_compra   TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_pedido  VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE RESTRICT,
    CHECK (estado_pedido IN ('Pendiente', 'En preparacion', 'Despachado'))
);

-- Tabla con clave foránea hacia pedido y hacia producto
CREATE TABLE detalle_pedido (
    id_detalle       INT AUTO_INCREMENT,
    id_pedido        INT           NOT NULL,
    id_producto      INT           NOT NULL,
    cantidad         INT           NOT NULL,
    precio_unitario  DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_detalle),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    UNIQUE (id_pedido, id_producto),
    CHECK (cantidad > 0),
    CHECK (precio_unitario >= 0)
);

-- Tabla con clave foránea hacia pedido (un despacho por pedido)
CREATE TABLE despacho (
    id_despacho               INT AUTO_INCREMENT,
    id_pedido                 INT         NOT NULL,
    fecha_preparacion         TIMESTAMP   NULL,
    fecha_entrega_transporte  TIMESTAMP   NULL,
    empresa_transporte        VARCHAR(80),
    codigo_seguimiento        VARCHAR(60),
    PRIMARY KEY (id_despacho),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    UNIQUE (id_pedido),
    CHECK (fecha_entrega_transporte >= fecha_preparacion)
);
