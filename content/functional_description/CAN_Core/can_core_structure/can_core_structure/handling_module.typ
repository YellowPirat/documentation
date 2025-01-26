==== Handling Module

#figure(
  image("../../img/CAN_Core_Handling.drawio.png", width: 100%),
  caption: [Overview of the handling module]
)<fig:overview_handling_module>

The in @sec:can_core_struct introduced "Handling Module" consists of two submodules.

#heading(level: 5, outlined: false, numbering: none)[CRC]
For logging can-frames it is crusial to distinguis between CAN-Frames with correct 
deliverd crc value and incorect deliverd crc value. 
For this the crc-value is calculated inside the CAN-Core and than compared to the 
deliverd crc-value. If this process detects a difference, it will be handled as a 
crc_error. 

#heading(level: 5, outlined: false, numbering: none)[Error Handling]
In a CAN-Network all CAN-Nodes are receiving the transmitted can-frames.
So every CAN-Node seperately checks the received CAN-Frame for errors.
If a error is detected, the answer is, that every node starts to send a error-frame.
In our case this process is handled seperately in the "Error Handling" module. 
The goal of this module is to detect this error-frame. After detecting an error-frame,
a error-frame-valid signal is passed to the Frame Valid Module. 
The aim of this, is to handle Error-Frames as normal Frames, but with an error-code inside the frame.

#heading(level: 5, outlined: false, numbering: none)[Frame Valid]
The Frame Valid Module is used to handle the can_frame_valid signal which is active, when 
the decoded data is valid. This is normaly the case, from the end of a frame (with error or without),
to the beginning of a new_frame.
