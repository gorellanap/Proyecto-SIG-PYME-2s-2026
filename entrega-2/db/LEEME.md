# Base de datos · Ruta Snack SpA (MySQL 8)

Ejecutar en MySQL Workbench, en este orden (cada archivo con el rayito):

| Orden | Archivo | Qué hace | Resultado esperado |
|---|---|---|---|
| 1 | `schema.sql` | Crea la base `ruta` desde cero con 5 tablas | 8 líneas en verde |
| 2 | `seed.sql` | Carga los datos de prueba | 3 productos, 20 clientes, 25 pedidos, 43 detalles, 25 despachos |
| 3 | `consultas.sql` | Consultas de negocio (1 a 3 son las del informe, 4 a 8 de apoyo) | C1: 4 pedidos atrasados · C2: 21 despachados, 6,0 días, 0 cumplen la meta · C3: 130,0 h / 13,3 h |
| 4 | `pruebas_integridad.sql` | Tres datos que la base debe rechazar (correrlas de a una con Ctrl+Enter) | Errores 3819, 1452 y 1062 |

`modelo_er_workbench.mwb` es el diagrama ER sacado de la base con Database → Reverse Engineer.
Las consultas usan como "hoy" el 20-11-2026 09:00 para que los resultados se puedan repetir.
