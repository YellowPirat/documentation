==== Destuffing <sec:destuffing>

For destuffing the rxd signal, a fsm is implemented as shown in @fig:destuffing.

#figure(
  image("../../img/destuffing.drawio.png", width: 100%),
  caption: [destuffing fsm of the rxd signal]
)<fig:destuffing>

The FSM maintains the state of the last transmitted bits to detect a sequence of five consecutive low bits 
or five consecutive high bits. 
According to the CAN protocol rules, after five identical bits, 
the transmitter must insert an inverted bit (a stuff bit).
In this FSM, the behavior is implemented in reverse, allowing it to detect the appropriate stuff bit 
and identify a stuff bit error.
For performing this behavior, the last bit is also included into the decision.