# Automatización con n8n

En esta carpeta están los flujos de n8n del SIG de Ruta. Trabajan sobre la base `ruta` en MySQL, la que se crea con `db/schema.sql` y `db/seed.sql`. La explicación de cada flujo y su relación con el BPMN está en `docs/02-bpmn-y-n8n.md`.

## Contenido

| Archivo | Qué hace |
|---|---|
| `workflows/01-registrar-pedido-web.json` | Recibe el pedido de la página web, revisa los datos y lo guarda en `cliente`, `pedido`, `detalle_pedido` y `despacho`. Responde con el número de pedido y la fecha límite para entregarlo al transporte. |
| `workflows/02-preparar-y-despachar-pedido.json` | Formulario para bodega: registra cuándo se empieza a preparar un pedido y cuándo se entrega al transporte. Muestra los días que pasaron desde la compra. |
| `workflows/03-recordar-pedidos-atrasados.json` | Se ejecuta de lunes a sábado a las 9:00 y 15:00. Busca los pedidos que llevan más de 24 h (Alerta) o más de 48 h (Atrasado) sin entregarse al transporte. |
| `ejemplos/` | Un pedido válido y uno con errores para probar el flujo 01. |

## Cómo ejecutarlo

Se necesita MySQL 8 con la base `ruta` cargada y Node.js 22.

1. Crear en MySQL un usuario para n8n (solo puede leer, insertar y actualizar):

```sql
CREATE USER 'n8n_ruta'@'localhost' IDENTIFIED BY 'una_clave';
GRANT SELECT, INSERT, UPDATE ON ruta.* TO 'n8n_ruta'@'localhost';
```

2. Iniciar n8n (usamos la versión 1.123, porque las versiones 2.x piden Node 24):

```bash
GENERIC_TIMEZONE=America/Santiago npx n8n@1.123.100 start
```

3. Entrar a http://localhost:5678 y crear la cuenta de n8n.
4. En **Credentials** crear:
   - una credencial **MySQL** con host `localhost`, puerto `3306`, base `ruta`, usuario `n8n_ruta` y la clave del paso 1;
   - una credencial **Basic Auth** con el usuario y la clave que va a usar bodega para entrar al formulario.
5. En **Workflows → Import from file** importar los 3 archivos de `workflows/` y asignar las credenciales en los nodos que lo pidan.
6. Activar los flujos 01 y 02.

## Cómo probarlo

Desde la carpeta `entrega-2`:

```bash
curl -X POST http://localhost:5678/webhook/ruta/pedido-web -H "Content-Type: application/json" -d @n8n/ejemplos/pedido-web-ejemplo.json
```

- Con `pedido-web-ejemplo.json` se crea el pedido 26 y la respuesta trae el total y la fecha límite de despacho.
- Si se envía el mismo pedido otra vez, responde que ya estaba registrado y no lo duplica.
- Con `pedido-web-invalido.json` responde la lista de errores y no guarda nada.
- El formulario de bodega está en http://localhost:5678/form/ruta-bodega.
- El flujo 03 se puede ejecutar a mano con el botón **Execute workflow**. Con los datos del seed muestra los pedidos 21, 23, 24 y 25 como atrasados.

## Observaciones

- Los nodos de Gmail que envían el aviso al responsable están desactivados porque no conectamos una cuenta de correo. Para usarlos hay que crear una credencial Gmail OAuth2 en n8n y activarlos.
- La página web de Ruta no está conectada (quedó fuera del alcance), por eso en la prueba el pedido se envía con `curl`.
