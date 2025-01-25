==== Destuffing <sec:destuffing>

For destuffing the rxd signal, a fsm is implemented as shown in @fig:destuffing.

#figure(
  image("../../img/destuffing.drawio.png", width: 100%),
  caption: [destuffing fsm of the rxd signal]
)<fig:destuffing>

The fsm holds state about the last transmitted bits, to detect a bit sequence with 
five low bits transmitted or five high bits transmitted. 
The rule says, that after five similar bits, the transmitter has to insert a inverted bit.
This behavior is implemented reversed in this fsm, so it can detect the appropiate stuffbit 
and a stuffbit error.