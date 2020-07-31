Video de la solución: https://youtu.be/ez0kDLoeVLk

Comentarios sobre la solución alternativa ISW1-2020-1C-2doParcial-SolucionDecoratorRobotShipper.st:

El primer punto (limpieza de productos/empaque de productos) evita modificar la clase Trailer utilizando un decorator para resolver el problema. Adicionalmente, la modificación del indice de contaminación/protección la hace a través de un mensaje que reduce/incrementa tal valor por otro. Esta forma de hacerlo evita el acoplamiento de los productos con los limpiadores, aunque está al borde de violar encapsulamiento del producto. Ambas maneras consideramos válidas de todas maneras.

Con respecto al segundo punto, esta solución decide no modelar el centro de distribución, y por lo tanto no otorgarle responsabilidades, y en cambio sólo se queda con no es más que una colección de vehículos. ¿Quién se encarga de responder el mensaje #ship:...? En este caso es el robot a quien se le indica que debe shippear su trailer y debe elegir algún vehículo de la colección de vehículos para depositarlo.

Por último, la solución va un poquito más allá de lo pedido en el enunciado del parcial, e intenta solucionar que pasa si un robot sin trailer o que ya shippeo se le ordena ir a tomar un producto o cerrar una orden o volver a shippear. Esto no era pedido en el parcial (creo que el último párrafo del mismo lo aclaraba), pero lo dejamos en esta solución como curiosidad.
