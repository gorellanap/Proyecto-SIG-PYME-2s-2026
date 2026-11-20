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
