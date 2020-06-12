# I, Robot

## HWS

HWS es una empresa de envíos de productos que quiere automatizar totalmente sus almacenes utilizando robots para armar los pedidos que luego se enviaran a los clientes.

Esta primera etapa del proyecto tiene como objetivo un modelo computable con las siguientes características:

## Productos

- Solo existen 2 tipos de producto: ProductoA y ProductoB (ésto es una simplificación de la vida real pero que sirve en esta primer instancia).

- Cada producto tiene un peso y altura asociados. Dos productos del mismo tipo no necesariamente tienen el mismo peso o altura.

## Los Robots

Los robots van circulando por los pasillos del almacén juntando los productos que tienen en su lista. Gracias a los sensores que tienen (GPS, cámaras, etc.) pueden ir tomando los productos que necesitan utilizando su brazo mecánico.

Para el modelo que estamos implementando necesitamos saber que:

### Estados del robot

- Los robots pueden estar en 4 estados (que afectan su funcionamiento):
  - Working Normal: Trabaja normalmente y no presenta ninguna falla.
  - Sensors Failure: Algún sensor interno presenta problemas.
  - Mechanical Failure: Algún componente mecánico presenta problemas.
  - Out of order: El robot está fuera de servicio y no puede realizar ningún trabajo.

### Tomar productos

- Cada robot cuenta con un trailer donde coloca los productos.

- **Puede tomar productos** en los siguiente estados:
  - Working Normal
  - Sensors Failure
  - Mechanical Failure

- Pero **no puede tomar productos** si está Out of order

### Cerrar orden de compra

- Cuando un robot termina la compra se le asigna un cajero automático (**cashier**) para cerrar la orden de compra.

- **Puede cerrar una compra** en los siguientes estados:
  - Working Normal
  - Mechanical Failure

- Pero **no puede cerrar una compra** en los siguientes estados:
  - Sensors Failure
  - Out of order.

## Cashier

- Recibe al robot y según el estado del mismo acepta o no los productos. Además de marcar al robot como "out of order" en caso de presentar fallas mecánicas. Ver la clase **Cashier** para más detalles de implementación.

## Trailers

Los trailers pueden llevar un peso y altura máximos (ambos configurables).

- Los productos A no se pueden apilar con lo cual no nos preocupa la altura a la hora de agregar un producto A (solo importa que no exceda el peso máximo del trailer)

- Con respecto a llevar Productos B, éstos son apilables (y solo se pueden llevar apilados!), por lo tanto además de interesarnos no exceder el límite de peso también importa que no excedan el máximo de altura que puede llevar el trailer. (Notar que solo importa no exceder el límite de altura **solo con los productos apilables**)

# Trabajo a Realizar:

1. Las implementaciones de `Robot` y `Cashier` no deben tener `ifs` cuando los mismos pueden ser reemplazados por polimorfismo.
2. Sacar el código repetido de las clases `Robot`, `Cashier` y `Trailer`.
3. Sacar el código repetido de los `test01`, `test02`, `test03` y `test04` de `Cashier`.
4. Mejorar los tests de `Trailer`:
    - mejores nombres.
    - sacar código repetido.

Usar las heurísticas de diseño vistas hasta ahora (buenos nombres, métodos cortos y categorizados, etc.)

**NOTA:** Los ítems 1. y 2. deben realizarse sin modificar los tests. En los items 3. y 4. no se debe modificar la funcionalidad del modelo que se testea.

Entrega:
1.- Entregar el fileout de la categoría de clase `ISW1-2020-1C-Parcial` que debe incluir toda la solución (modelo y tests). El archivo de fileout se debe llamar: `ISW1-2020-1C-Parcial.st`
2.- Entregar también el archivo que se llama `CuisUniversity-nnnn.user.changes`
3.- Probar que el archivo generado en 1) se cargue correctamente en una imagen “limpia” (o sea, sin la solución que crearon) y que todo funcione correctamente. Esto es fundamental para que no haya problemas de que falten clases/métodos/objetos en la entrega.
4.- Realizar la entrega enviando mail a la lista de Docentes: ingsoft1-doc@dc.uba.ar con el **Subject:** LU nnn/aa - Solucion 1er parcial 1c2020

**IMPORTANTE:** Al enviar la solución del parcial deben recibir una confirmación de recepción.
