==== Processing Module

#figure(
  image("../../img/CAN_Core_Processing.drawio.png", width: 100%),
  caption: [Overview of the processing module]
)<fig:overview_processing_module>

The "Processing Module," introduced in @sec:can_core_struct, also consists of four submodules.

For simplicity, signals are grouped into signal bundles, represented by a circle with a plus sign at the center.

#heading(level: 5, outlined: false, numbering: none)[Destuffing] 
Due to the bit-stuffing mechanism implemented in the CAN protocol, 
reading received CAN frames requires a destuffing logic. 
This logic processes the sample pulse and serial data to identify and handle stuffed bits. 
When a stuffed bit is detected in the received data, a stuffbit pulse is generated, which is active high.

#heading(level: 5, outlined: false, numbering: none)[Input Stream] 
Since a CAN frame is divided into sections (e.g., ID section, data section), 
the serial data stream must be parsed and decoded. 
The "Input Stream" module is responsible for performing this task.
In addition to extracting the transmitted data from the CAN frame, 
this module generates control signals such as end_of_frame and form_error for other modules. 
The extracted CAN frame is then merged with the timestamp of the received message.

#heading(level: 5, outlined: false, numbering: none)[Timestamp] 
To timestamp received CAN frames, a simple 64-bit counter is implemented. 
When the start_of_frame (indicated by bus_active) signal is detected, 
the current timer value is stored and merged with the decoded CAN frame.


