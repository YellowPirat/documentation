==== Processing Module

#figure(
  image("../../img/CAN_Core_Processing.drawio.png", width: 100%),
  caption: [Overview of the processing module]
)<fig:overview_processing_module>

The in @sec:can_core_struct introduced "Processing Module", also consists,
of four submodules.

It can be seen, that for simplicity, signals are merged into signal groups, by an circle with an plus sign
in the middle.

#heading(level: 5, outlined: false, numbering: none)[Destuffing]
Because of the bit stuffing mechanisem implemented in the CAN protocol, 
reading of received can-frames, needs an destuffing logik. 
This logic takes the sample pulse, the serial data and generates a stuffbit pulse, 
which is high active, when a stuff bit in the received data is detected.

#heading(level: 5, outlined: false, numbering: none)[Input Stream]
Because a can-frame is sectionized into id section, data section and so on, 
the serial data stream has to be parsed and decoded. 
The "Input Stream" module is responsible for this.
In addition to just extracting the transmitted data out of the can-frame,
control signals like end-of-frame or form_error signals are also generated for other modules.
The extracted CAN-Frame is than merged with the timestamp of the received message.

#heading(level: 5, outlined: false, numbering: none)[Timestamp]
For timestamping received CAN-Frames a simple 64 bit counter is implemented.
With each start_of frame (bus_active), the actual timer value is stored and
merged with the decoded CAN-Frame


