Proyecto SIG PYME: Ruta Snack SpA (*Papas Fritas RUTA*)

**Asignatura:** Sistemas de Información para la Gestión (ICN-292) — Paralelo 100  
**Institución:** Universidad Técnica Federico Santa María — Departamento de Industrias  
**Semestre:** Segundo Semestre 2026  
**Profesor:** Patricio Cifuentes Reyes  
**Equipo:** Antonia Valenzuela, Clemente Luoni, Florencia Palma, Gonzalo Orellana  

---

## 1. Contexto de la PYME y Problema de Negocio

* **Empresa:** **Ruta Snack SpA** (*Papas Fritas RUTA*, RUT `77.964.038-8`), fabricante y distribuidora de papas fritas artesanales ubicada en San Vicente de Tagua Tagua, Región del Libertador General Bernardo O'Higgins.
* **Problema identificado (Entrega 1):** Los pedidos recibidos a través del canal web demoran en promedio **6 días** (entre 5 y 7 días) desde la compra hasta su entrega al transporte, frente a los **~2 días** de supermercados y distribuidores regionales. Esto ocurre porque los pedidos web se revisan manualmente y se posterga su consolidación, afectando la experiencia de compra y limitando la tasa de recompra web a un **20 %**.
* **Objetivo y KPI del SIG:** Consolidar los pedidos web y automatizar su seguimiento y notificación al responsable de bodega para reducir el tiempo de ciclo (compra $\rightarrow$ entrega al transporte) a un **máximo de 2 días ($\le 48\text{ horas}$)**.

---

## 2. Solución Implementada en la Entrega 2

En la segunda entrega se llevó el diseño conceptual a un prototipo funcional ejecutado en entorno local (`localhost`), articulado en tres componentes:

1. **Rediseño de Proceso (BPMN *to-be* final):** Se trasladó la identificación del canal de venta inmediatamente después de la revisión del pedido, asegurando que los pedidos web se registren, consoliden y notifiquen al responsable *antes* de iniciar la preparación, explicitando la meta de $\le 2\text{ días}$ en el diagrama.
2. **Base de Datos Relacional en 3FN (`MySQL 8`):** Esquema `ruta` normalizado en Tercera Forma Normal con 5 tablas (`cliente`, `producto`, `pedido`, `detalle_pedido`, `despacho`), restricciones de integridad (`PK`, `FK`, `UNIQUE`, `CHECK`), precio unitario histórico congelado por compra y consultas SQL para control de atrasos, KPI de ciclo y descomposición de tiempos.
3. **Automatización de Flujos (`n8n` en `localhost`):**
   * **Flujo 1 — Registro automático de pedidos web:** Recepción vía Webhook, validación de datos y RUT, control de duplicados, inserción en MySQL y cálculo de fecha límite de despacho ($+2\text{ días}$).
   * **Flujo 2 — Control de estados en bodega:** Formulario autenticado para actualizar etapas (`Pendiente` $\rightarrow$ `En preparacion` $\rightarrow$ `Despachado`), registro de empresa transportista y verificación del cumplimiento de meta.
   * **Flujo 3 — Monitor programado de alertas:** Ejecución de lunes a sábado (09:00 y 15:00 hrs) para detectar pedidos sin despachar con $>24\text{ h}$ (*Alerta*) y $>48\text{ h}$ (*Atrasado*).

---

## 3. Mapa del Repositorio

```text
Proyecto-SIG-PYME-2s-2026/
├── README.md                              # Guía general del proyecto (portada)
│
├── assets/                                # [Entrega 1] Diagramas iniciales (BPMN AS-IS, TO-BE y ER preliminar)
├── docs/                                  # [Entrega 1] Documentación de diagnóstico, MoSCoW y plan inicial
│
├── entrega-2/                             # [Entrega 2] Implementación técnica del prototipo SIG
│   ├── assets/                            # Diagramas finales (BPMN to-be, ER 3FN, flujo n8n) y capturas_informe/
│   ├── db/                                # Base de datos MySQL 8
│   │   ├── LEEME.md                       # Instrucciones específicas de ejecución SQL
│   │   ├── schema.sql                     # Creación de BD 'ruta', tablas y restricciones de integridad
│   │   ├── seed.sql                       # Carga de datos de prueba (20 clientes, 3 productos, 25 pedidos)
│   │   ├── consultas.sql                  # Consultas de negocio, semáforo de atrasos y cálculo de KPIs
│   │   ├── pruebas_integridad.sql         # Pruebas negativas rechazadas por restricciones SQL
│   │   └── modelo_er_workbench.mwb        # Archivo editable del modelo en MySQL Workbench
│   ├── docs/                              # Documentación modular E2 (00 a 05) y DECLARACION_IA.md
│   └── n8n/                               # Automatización en n8n (workflows/, ejemplos/ y README.md)
│
└── informe/                               # Informes oficiales de Entrega 1 y Entrega 2 (.pdf y .docx)
```

---

## 4. Guía Rápida de Reproducción (`localhost`)

### A. Base de Datos en MySQL Workbench
Ejecutar los scripts ubicados en [`entrega-2/db/`](./entrega-2/db/) en el siguiente orden estricto (más detalles en [`entrega-2/db/LEEME.md`](./entrega-2/db/LEEME.md)):
1. [`schema.sql`](./entrega-2/db/schema.sql): Crea la base de datos `ruta` y las 5 tablas con sus reglas `CHECK`, `UNIQUE` y llaves foráneas.
2. [`seed.sql`](./entrega-2/db/seed.sql): Pobla la base con los 20 clientes, 3 variedades de papas fritas, 25 pedidos y 25 registros de despacho.
3. [`consultas.sql`](./entrega-2/db/consultas.sql): Ejecuta el semáforo de pedidos en espera, el KPI de días promedio al transporte (línea base de `6,0 días`) y el desglose de horas por etapa.
4. [`pruebas_integridad.sql`](./entrega-2/db/pruebas_integridad.sql): Comprueba el rechazo controlado ante estados inválidos, clientes inexistentes y productos duplicados.

### B. Flujos de Automatización en n8n
Seguir las instrucciones detalladas en [`entrega-2/n8n/README.md`](./entrega-2/n8n/README.md):
1. Iniciar **n8n** en `localhost`.
2. Importar los archivos `.json` ubicados en [`entrega-2/n8n/workflows/`](./entrega-2/n8n/workflows/) mediante **Import from File**.
3. Configurar la credencial local de **MySQL** apuntando a la base `ruta` y activar los flujos.

---

## 5. Accesos Directos a Entregables

* 📁 **Carpeta de Informes (E1 y E2 en PDF y Word):** [`/informe/`](./informe/)
* 🗄️ **Scripts SQL y Modelo Workbench:** [`/entrega-2/db/`](./entrega-2/db/)
* ⚙️ **Flujos n8n y Ejemplos JSON:** [`/entrega-2/n8n/`](./entrega-2/n8n/)
* 📊 **Diagramas Finales (BPMN y ER 3FN):** [`/entrega-2/assets/`](./entrega-2/assets/)
* 📝 **Documentación Detallada y Declaración de IA:** [`/entrega-2/docs/`](./entrega-2/docs/)
* 🗂️ **Respaldo Conceptual Entrega 1:** [`/docs/`](./docs/) y [`/assets/`](./assets/)**
