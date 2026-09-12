# Sección C: Requerimientos de Software y Alcance - Papas Fritas RUTA

## 1. Actores y Roles del Sistema
* **Cliente Web:** Realiza pedidos a través de la página web de Ruta.
* **Encargado de Bodega:** Gestiona la preparación de los pedidos y actualiza su estado durante el proceso.
* **Administrador:** Consulta y supervisa los pedidos registrados, su estado y los tiempos asociados al proceso.

---

## 2. Delimitación del Alcance

### Dentro del Alcance (IN)
* Registro de pedidos de la página web.
* Consulta de todos los pedidos registrados.
* Visualización de pedidos pendientes.
* Visualización de cuándo se hizo el pedido.
* Registro de la fecha de preparación.
* Registro de la fecha de despacho.
* Notificación para recordar el pedido.

### Fuera del Alcance (OUT)
* Modificación o reemplazo de la página web.
* Gestión del proceso de producción de las papas.
* Gestión de proveedores.
* Gestión contable y financiera.
* Procesamiento de pagos.
* Sistema propio de transporte.
* Gestión de bodega.
  
---

## 3. Requerimientos Funcionales

1. **RF01:** El SIG tiene que permitir registrar los pedidos realizados por la página web, incluyendo los datos esenciales del mismo (fecha, cantidad, etc.).
2. **RF02:** El SIG debe permitir actualizar el estado de cada uno de los pedidos, mostrando si esta entregado, pendiente, despechado, etc.
3. **RF03:** El SIG tiene que calcular los días que lleva pendiente un pedido.
4. **RF04:** El SIG debe identificar los pedidos que superen el tiempo pensado entre preparación y despacho.
5. **RF05:** El SIG tiene que lograr filtrar lo pedidos según el estado en el que se encuentren.
6. **RF06:** El SIG debe mostrar un resumen de los pedidos, mostrando la cantidad de pedidos entregados, pendientes, etc.
7. **RF07:** El SIG puede generar un reporte con los pedidos y los tiempos de estos en ser entregados.
8. **RF08:** El SIG no seguirá el estado del pedido una vez se despache, es decir, sea entregado a transporte.

---

## 4. Requerimientos No Funcionales

1. **RNF01:** El sistema tiene que ser simple y fácil de usar.
2. **RNF02:** La información de cada pedido tiene que estar ordenada y evitar falta de datos.
3. **RNF03:** El SIG tiene que dejar que la información de cada pedido sea consultada fácilmente.
4. **RNF04:** El SIG tiene que contar con una contraseña de acceso.
5. **RNF05:** Deberá generar una copia de seguridad en base a algún periodo de tiempo o número de pedidos.
