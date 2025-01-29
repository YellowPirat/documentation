== CAN Transceiver Shield
_Maximilian Hoffmann_

To connect the FPGA to a real CAN bus, it is necessary to develop an adapter circuit board.
The reason for this is that CAN relies on a differential "analog" signal. These signals
(CANH and CANL) cannot be directly connected to an FPGA GPIO pin.
A so-called transceiver is required. This IC is responsible for capturing the
differential signal and providing a TTL logic-based RXD signal to the FPGA.
Moreover, the transceiver allows message transmission via the TXD pin. However,
in our case of a CAN logger, this feature is not required.

#figure(
image("img/shield.drawio.png", width: 100%),
caption: [Structure of the shield circuit board]
)<fig:shield_circuit_board_struct>

@fig:shield_circuit_board_struct shows the structure of the developed circuit board
to meet the requirements.
In front of the transceiver IC, there are additional components to improve transmission.
A filter and ESD protection diodes are included. Moreover, a terminating resistor is present
to prevent signal reflections in the CAN bus system.

It is important to consider these resistors, as not every CAN node requires them.
Typically, the system must be set to a 60-ohm impedance,
which is achieved by placing one resistor at each end of the CAN bus system.

#figure(
image("img/Shield_platine.png", width: 100%),
caption: [Shield board]
)<fig:shield_circuit_board>

@fig:shield_circuit_board shows the final result. The circuit board was designed in KiCad.