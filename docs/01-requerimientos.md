# Sección C: Requerimientos de Software y Alcance - Papas Fritas RUTA

## 1. Actores y Roles del Sistema
* **Cliente Web:** Realiza pedidos a través de la página web de Ruta.
* **Encargado de Bodega:** Gestiona la preparación de los pedidos y actualiza su estado durante el proceso.
* **Administrador:** Consulta y supervisa los pedidos registrados, su estado y los tiempos asociados al proceso.

---

## 2. Delimitación del Alcance

### Dentro del Alcance (IN)
* Registrar y consultar los pedidos provenientes de la página web, visualizar pedidos pendientes y registrar fechas de preparación y despacho.
* Generar notificaciones automáticas para apoyar el seguimiento y control de los pedidos

### Fuera del Alcance (OUT)
* No se integrarán módulos de pago, contabilidad, producción, bodega ni transporte propio.
* El sistema finalizará su seguimiento cuando el pedido sea entregado a la empresa de transporte; no realizará seguimiento posterior.
  
---

## 3. Requerimientos Funcionales

1. **RF01:** El sistema debe permitir registrar los pedidos realizados mediante la página web, almacenando sus datos esenciales.
2. **RF02:** El sistema debe permitir actualizar el estado de un pedido.
3. **RF03:** El sistema debe calcular automáticamente cuántos días lleva pendiente un pedido desde su fecha de ingreso.
4. **RF04:** El sistema debe identificar los pedidos que superen un número definido de días pendientes.
5. **RF05:** El sistema debe permitir filtrar los pedidos según su estado.
6. **RF06:** El sistema debe mostrar un resumen con la cantidad de pedidos pendientes, preparados y despachados.
7. **RF07:** El sistema debe permitir generar un reporte simple con los pedidos y sus tiempos de preparación.
8. **RF08:** El sistema podrá permitir en el futuro exportar los pedidos a un archivo Excel o CSV.

---

## 4. Requerimientos No Funcionales

1. **RNF01:** El sistema tiene que ser simple y fácil de usar.
2. **RNF02:** La información de cada pedido tiene que estar ordenada y evitar falta de datos.
3. **RNF03:** El SIG tiene que dejar que la información de cada pedido sea consultada fácilmente.
4. **RNF04:** El SIG tiene que contar con una contraseña de acceso.
5. **RNF05:** Deberá generar una copia de seguridad en base a algún periodo de tiempo o número de pedidos.
