# Diseño SQL y Consultas de Negocio (MySQL 8)

> **Responsable:** [Nombre compañero SQL]  
> **Corresponde a:** Sección 6 del Informe E2 y carpeta `entrega-2/db/`

---

## 1. Scripts de la Base de Datos (`entrega-2/db/`)
La base de datos `ruta` se implementó en **MySQL 8** mediante 4 scripts ejecutables en orden:
1. `schema.sql` — Creación de base y 5 tablas en 3FN con restricciones `PK`, `FK`, `UNIQUE` y `CHECK`.
2. `seed.sql` — Carga de 20 clientes, 3 productos, 25 pedidos, 43 líneas de detalle y 25 despachos.
3. `consultas.sql` — 8 consultas de negocio trazadas a los requerimientos y KPIs.
4. `pruebas_integridad.sql` — 3 pruebas negativas rechazadas por el motor (errores `3819`, `1452` y `1062`).

---

## 2. Principales Resultados Obtenidos
* **Pedidos abiertos (`Consulta 1 y 2`):** 4 pedidos pendientes/en preparación (16% del total), todos superando las 48 horas de espera (máximo: 165 horas en pedido #21).
* **KPI Lead Time (`Consulta 3 y 4`):** Promedio histórico de **6,0 días** hasta entrega a transporte (`0` de 21 despachados cumplen la meta de $\le 2$ días).
* **Cuello de botella (`Consulta 5`):** El pedido espera en promedio **130,0 horas** antes de iniciar preparación, frente a solo **13,3 horas** de armado y despacho.
* **Tasa de recompra (`Consulta 6 y 7`):** **20,0%** (4 de 20 clientes con más de 1 compra).
* **Ventas web (`Consulta 8`):** **$272.870 CLP** acumulados (liderado por *Crema de Cebolla* y *Merkén Ahumado*).

*(Subir las capturas de Workbench a `entrega-2/assets/` y enlazarlas aquí).*
