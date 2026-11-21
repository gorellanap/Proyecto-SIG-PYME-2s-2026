# Lecciones Aprendidas y Limitaciones del Prototipo

> **Responsable:** Equipo completo  
> **Corresponde a:** Secciones 7 y 8 del Informe E2

---

## 1. Lecciones Aprendidas (Paso de E1 a E2)
* *(Completar: ej. importancia de normalizar a 3FN antes de escribir DDL para evitar recalcular totales o duplicar regiones).*
* *(Completar: utilidad de congelar `precio_unitario` en `detalle_pedido` para proteger reportes históricos ante alzas de precios).*

---

## 2. Limitaciones Actuales
* **Datos sintéticos:** Los registros de `seed.sql` simulan fielmente la operación levantada en E1, pero no corresponden a transacciones productivas en vivo.
* **Medición post-implementación:** El impacto real en la reducción de 6 a $\le 2$ días y el alza en la tasa de recompra requiere seguimiento tras poner el sistema en marcha.
* **Actualización de estados:** El paso a `'En preparacion'` y el registro de `codigo_seguimiento` dependen de que el responsable actualice el estado oportunamente.
En la automatización con n8n, la notificación por correo al responsable de preparación quedó armada en los flujos, pero desactivada, porque no alcanzamos a conectar una cuenta de Gmail. Para hacerlo, Google pide crear un proyecto en Google Cloud con credenciales propias. Por eso, en esta versión el aviso se ve en la respuesta del sistema, que entrega la fecha límite de despacho, y en la lista de pedidos atrasados que genera el flujo 3, pero no llega como correo.
* **Alcance del seguimiento de pedidos web.** El BPMN cubre desde la compra hasta la entrega del pedido al transportista. El traslado y la entrega al cliente quedan fuera del tramo modelado, por lo que la meta de dos días mide el tiempo hasta que Ruta entrega el pedido al transporte.
* **Tratamiento del plazo en el diagrama.** En la versión final, el plazo de dos días se indica mediante una anotación. El diagrama muestra cuándo empieza y termina la medición, mientras que la detección de los pedidos que superan el plazo queda a cargo del flujo de seguimiento.
* **Nivel de detalle de los otros canales.** Los pedidos de supermercados y distribuidores regionales se agruparon en una sola rama porque compartían el plazo y el destino de despacho. Con ese nivel de detalle, el diagrama permite distinguir la gestión de los pedidos web, pero no analizar por separado las actividades de supermercados y distribuidores.

Además, la página web de Ruta no está conectada a n8n, porque modificarla estaba fuera del alcance del proyecto. En las pruebas, los pedidos se enviaron manualmente al sistema, simulando lo que haría la web.

Otra limitación es que n8n está instalado en un solo computador. Si ese computador está apagado, los pedidos no se registran y no se revisan los atrasos. Para usarlo en la empresa habría que dejarlo en un equipo que esté siempre encendido.

Por último, como los datos de prueba son ficticios, todavía no podemos medir si el sistema realmente baja el tiempo de despacho de 6 a 2 días. Eso solo se podría comprobar usándolo con pedidos reales durante algunas semanas.
