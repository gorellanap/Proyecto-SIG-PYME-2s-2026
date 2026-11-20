# Contexto de la PYME y Problema de Negocio — Ruta Snack SpA

> **Responsable:** [Nombre integrante]  
> **Corresponde a:** Secciones 1 y 2 del Informe E2

---

## 1. Identificación de la PYME
* **Razón Social:** Ruta Snack SpA (RUT: `77.964.038-8`)
* **Ubicación:** San Vicente de Tagua Tagua, Región de O'Higgins, Chile.
* **Canales de Venta:** Canal tradicional/supermercados y canal digital (tienda web).

---

## 2. Problema Medible y Evidencia
* **Línea Base (Entrega 1):** Los pedidos del canal web demoran en promedio **6,0 días** (rango 5–7 días) desde la compra hasta la entrega al transporte, frente a **~2 días** en otros canales.
* **Causa Raíz:** Revisión manual esporádica y postergación de órdenes web sin alertas ni priorización.
* **Indicador de Impacto:** Tasa de recompra en canal web de apenas **20%**.

---

## 3. Objetivo del SIG y KPI Principal
* **Objetivo:** Automatizar el registro y seguimiento de pedidos web mediante base de datos relacional en MySQL 8 y flujo de alertas en n8n.
* **KPI Operativo:** Tiempo de ciclo desde `fecha_compra` hasta `fecha_entrega_transporte` (**Meta:** $\le 2\text{ días}$ / $48\text{ horas}$).
