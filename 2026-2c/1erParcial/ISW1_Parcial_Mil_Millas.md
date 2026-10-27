# ISW1 – 1.er Parcial – Parte práctica: *Mil Millas*

Un fabricante de juegos de mesa quiere desarrollar una versión digital del clásico juego de cartas *Mil Millas* y nos contrató para construir el modelo de una primera versión.

En el juego completo, dos o más jugadores compiten por ser el primero en recorrer 1000 millas. Juegan por turnos: en cada turno un jugador puede jugar una carta de distancia sobre sí mismo o un ataque sobre un rival. **Nada de eso se modela en este parcial**: ni los turnos, ni el rival, ni el final de la partida (eso queda para una versión más avanzada). El alcance es un único **automovilista**, que conduce un **vehículo** (hay distintos tipos) y comienza la partida con una carta de **seguridad** ya jugada, las cartas de distancia que juega y los ataques que recibe.

El automovilista comienza con **0 millas recorridas** y **0 puntos**.

## Cartas de distancia y vehículos

Las cartas de distancia válidas son de **25, 50, 75, 100 y 200 millas**.

Las distancias se expresan con la unidad `milla`, que ya va a estar creada al cargar el .st inicial, de modo que una carta de 100 millas se escribe `100 * milla`. Su modelo debe trabajar con esas medidas, no con números pelados.

La cantidad de millas que efectivamente avanza un automovilista depende del vehículo que conduce.

El vehículo **Deportivo** es rápido: en condiciones normales, cada carta de distancia le permite avanzar el **doble** de las millas indicadas por la carta.

El **Camión** es más lento: ninguna carta le permite avanzar más de **100 millas**. Por ejemplo, una carta de 200 le permite avanzar 100 millas, mientras que una carta de 50 le permite avanzar 50.

Para esta primera versión sólo existen estos dos vehículos: **Deportivo** y **Camión**.

## Ataques y seguridades

Durante la carrera un automovilista puede recibir ataques. **Qué ocurre al recibir un ataque depende del ataque recibido, del vehículo que conduce y de la seguridad que posee.**

Una seguridad puede **anular** un ataque. Cuando esto ocurre, el automovilista no sufre los efectos de ese ataque, lo que implica un **contraataque**, que suma **300 puntos**. Sumar esos puntos es el **único** efecto del contraataque: no le pasa nada a quien realizó el ataque. Los puntos obtenidos por distintos contraataques se acumulan.

### Accidente

Un **Accidente** deja al automovilista accidentado. Mientras esté accidentado no puede avanzar jugando cartas de distancia.

El **As del volante** anula los accidentes, independientemente de si el automovilista conduce un Deportivo o un Camión. En ese caso el automovilista no queda accidentado y obtiene los 300 puntos correspondientes al contraataque.

La **Vía libre** no protege contra accidentes. Si el automovilista conduce un Deportivo, además de quedar accidentado pierde **100 millas** de las que ya había recorrido, sin que su cantidad de millas pueda quedar por debajo de cero.

Si conduce un Camión, también queda accidentado, pero el vehículo es suficientemente robusto como para que **no pierda millas**.

### Límite de velocidad

El **Límite de velocidad** afecta de manera diferente a cada vehículo.

Al **Deportivo**, mientras esté bajo un límite de velocidad, cualquier carta de distancia le permite avanzar solamente **25 millas**, independientemente del valor indicado por la carta.

La **Vía libre** anula este ataque. Por lo tanto, un Deportivo con Vía libre no queda limitado y obtiene 300 puntos por el contraataque.

El **As del volante**, en cambio, no protege contra un límite de velocidad: el Deportivo queda limitado y no obtiene puntos.

Al **Camión**, un límite de velocidad **no le produce ningún efecto**, cualquiera sea la seguridad que tenga. En particular, si el Camión tiene Vía libre tampoco hay contraataque: como el ataque no afecta al vehículo, la seguridad no tiene nada que anular.

En resumen, para esta primera versión:

| Familia     | Opciones                       |
|-------------|--------------------------------|
| Vehículos   | Deportivo, Camión              |
| Ataques     | Accidente, Límite de velocidad |
| Seguridades | As del volante, Vía libre      |

## Alcance de esta versión

Los efectos de los ataques se acumulan. Recibir un nuevo ataque no elimina los efectos que ya estuvieran vigentes, y recibir dos veces el mismo ataque produce dos veces su efecto: por ejemplo, dos accidentes seguidos a un Deportivo sin As del volante le hacen perder 200 millas.

Por ahora no es necesario modelar mazo, turnos, defensas ni otros aspectos del juego. El alcance se limita a un automovilista con su vehículo y su seguridad, las cartas de distancia que juega y los ataques que recibe.

Los casos de uso y las situaciones que debe soportar el modelo se encuentran especificados en los tests provistos.

## Trabajo a realizar

Deben utilizar los tests que se proveen y construir un modelo que los pase (¡o al menos todos los que puedan!). Dicho modelo debe organizar el dominio siguiendo las heurísticas de diseño vistas hasta ahora en el curso. Se evaluará qué tan bien representa su declaratividad, si tiene o no código repetido, el reemplazo de ifs por polimorfismo donde corresponde, la asignación de responsabilidades, los nombres de sus variables, mensajes y categorías, la presencia de objetos válidos y completos desde su creación, la no violación del encapsulamiento de los objetos, etc.

## Aclaraciones

- **No se pueden modificar los tests.** El trabajo a realizar está en el modelo, no en los tests. Sin embargo, la clase de tests posee mensajes que esperan por su implementación (`#nuevoAutomovilistaAlVolanteDe:conCartaDeSeguridad:`, `#jugarCartaDe:para:`, `#atacarCon:a:`, `#millasRecorridasPor:`, `#puntosAcumuladosPor:`, `#estaAccidentado:` y los de creación de vehículos, seguridades y ataques): son el único punto de contacto entre los tests y su modelo, y ustedes deciden cómo implementarlos.
- La clase `Automovilista` ya existe, sólo con sus descripciones de error.
- La unidad `milla` se crea en `MilMillasTest class >> #initialize`, que se ejecuta al hacer el file in del archivo. No hace falta que la creen ustedes.
- Mantenga el castellano que se eligió para escribir los tests.
