==== Handling Module
_Maximilian Hoffmann_

#figure(
  image("../../img/CAN_Core_Handling.drawio.png", width: 100%),
  caption: [Overview of the handling module]
)<fig:overview_handling_module>

The "Handling Module," introduced in @sec:can_core_struct, consists of two submodules.

#heading(level: 5, outlined: false, numbering: none)[CRC] 
For logging CAN frames, it is crucial to distinguish between frames with correctly delivered CRC values 
and those with incorrect CRC values. 
To achieve this, the CRC value is calculated within the CAN-Core and compared to the delivered CRC value. 
If a discrepancy is detected, it is treated as a crc_error.

#heading(level: 5, outlined: false, numbering: none)[Error Handling] 
In a CAN network, all CAN nodes receive the transmitted CAN frames. 
Each node independently checks the received frame for errors. 
If an error is detected, the nodes respond by transmitting an error frame.
In this system, the "Error Handling" module manages this process separately. 
The module's primary task is to detect error frames. Once an error frame is detected, 
an error_frame_valid signal is sent to the "Frame Valid" module. 
The purpose of this mechanism is to treat error frames as normal frames but with an error code included in the frame.

#figure(
  image("../../img/error_frames.png", width: 80%),
  caption: [CAN-Bus error-frame @error_frame]
)<fig:error_frame_css>

@fig:error_frame_css illustrates a typical example of an Error Frame. It consists of a fixed passive error section with six dominant bits and a variable-length active error section, which can have a maximum of six dominant bits.
The goal of this module is to detect this bus behavior and transition the state machine of the processing module to the idle state as quickly as possible.

#heading(level: 5, outlined: false, numbering: none)[Frame Valid] 
The "Frame Valid" module manages the can_frame_valid signal, which becomes active when the decoded data is valid. 
This is typically the case from the end of one frame (regardless of whether it contains an error) 
to the beginning of a new frame.
