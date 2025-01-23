== CAN transreceiver shield

For connecting the FPGA with a real CAN-Bus it is necesserely to develop a adapter circuit board.
The reason for this is, is that CAN relais on a differential "analog" signal. This signals
(CANH and CANL) cant be directly connected to a FPGA GPIO pin. 
A so called transreceiver is required. This IC is responsible for capturing the 
differential signal and providing a TTL logic based rxd signal to the FPGA.
Moreover, the transreceiver provides the possibility to transmitt messages over the 
txd pin. In our case of a CAN-Logger, this feature is not required.

#figure(
  image("img/shield.drawio.png", width: 100%),
  caption: [structure of the shield circuit board]
)<fig:shield_circuit_board_struct>

@fig:shield_circuit_board_struct shows the structure of the developed circuit board to 
ment the requirements.
In front of the transreceiver IC there are some additional blocks to improve the transmition.
A filter and ESD protection diods are part of this. Moreover, there is a 
terminating resistor to avoid reflections in the CAN-Bus system.
It is importent to have a look at these resistors, because not every CAN-node needs 
this kind of resistor. Typically the system have to be set on a 60 Ohm impedance.
This is reached by, placing one resitor on each end of can-bus system.

#figure(
  image("img/Shield_platine.png", width: 100%),
  caption: [shield board]
)<fig:shield_circuit_board>

@fig:shield_circuit_board shows the end result of this.
