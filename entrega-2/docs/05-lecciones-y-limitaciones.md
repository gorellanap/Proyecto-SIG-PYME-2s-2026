# Lecciones Aprendidas y Limitaciones del Prototipo — Ruta Snack SpA
---
## 1. Lecciones Aprendidas (Paso de E1 a E2)

* **Alineación entre procesos, datos y automatización:** Al pasar del diseño conceptual (Entrega 1) a la implementación técnica (Entrega 2), se comprobó que cada tarea del diagrama BPMN *to-be* debe mapearse exactamente con las tablas y estados de la base de datos. Trasladar la identificación del canal web antes de la preparación permitió que los nodos de **n8n** y las tablas en **MySQL 8** operaran como un único sistema integrado.
* **Importancia práctica de la Tercera Forma Normal (3FN):** Eliminar atributos derivados como `monto_total` y transitivos como `region`, además de congelar `precio_unitario` dentro de `detalle_pedido`, evitó inconsistencias contables al simular alzas de precios entre septiembre ($2.790) y octubre ($2.990).
* **Control de calidad desde el motor de base de datos:** Definir restricciones `CHECK`, `UNIQUE` y llaves foráneas (`FOREIGN KEY`) en `schema.sql` protege la integridad de la operación mucho mejor que depender únicamente de revisiones manuales o validaciones externas.
* **Coherencia de nomenclatura entre artefactos:** Mantener nombres idénticos de tablas, atributos y estados entre el diagrama ER (`dbdiagram.io`), los scripts SQL (`schema.sql`, `seed.sql`, `consultas.sql`) y los nodos de `n8n` redujo errores de integración y facilitó el trabajo colaborativo en GitHub.

---

## 2. Limitaciones del Prototipo

* **Notificación por correo desactivada en entorno local:** En el flujo de ingreso de n8n, el nodo de Gmail para avisar al responsable de preparación quedó configurado pero desactivado, ya que Google exige crear un proyecto en Google Cloud con credenciales OAuth propias. En esta versión, el aviso se visualiza en la respuesta del sistema (con la fecha límite de despacho) y en el reporte programado de atrasos del Flujo 3.
* **Sin integración directa con el sitio web (`rutasnack.cl`):** Modificar la tienda web de la PYME estaba fuera del alcance del proyecto, por lo que en las pruebas los pedidos se enviaron manualmente al Webhook de n8n simulando el tráfico real.
* **Ejecución en `localhost`:** Tanto MySQL como n8n operan de forma local en un computador. Si dicho equipo se encuentra apagado, no se registran nuevos pedidos ni se ejecutan las alertas programadas; para pasar a producción se requiere desplegarlo en un servidor o equipo con disponibilidad continua.
* **Uso de datos sintéticos:** Los 20 clientes y 25 pedidos cargados en `seed.sql` fueron construidos a partir de los tiempos y parámetros reales levantados en la Entrega 1, pero aún falta desplegar el sistema con transacciones reales durante varias semanas para comprobar la reducción efectiva de 6 a $\le 2$ días.
* **Alcance medido hasta la entrega al transporte:** Tanto el diagrama BPMN como el KPI principal miden el tiempo interno desde la compra hasta la entrega del paquete al transportista, dejando fuera del alcance el tiempo de traslado final hacia el domicilio del cliente.
* **Sin control de inventario en bodega ni flujo de excepciones:** Al quedar el control de stock fuera del alcance en la E1, el sistema asume disponibilidad de bolsas terminadas y no contempla estados para pedidos cancelados o modificados tras la compra.
* **KPIs solo en SQL y dependencia del registro en bodega:** Obtener los indicadores históricos requiere ejecutar consultas en MySQL Workbench (sin una capa visual de BI) y la precisión del desglose de horas depende de que el operario registre oportunamente cada cambio de etapa en el formulario de bodega.
