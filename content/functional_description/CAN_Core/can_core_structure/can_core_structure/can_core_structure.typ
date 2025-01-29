==== CAN-Core structure <sec:can_core_struct>
_Maximilian Hoffmann_

#figure(
  image("../../img/CAN__Core_Overview.drawio.png", width: 100%),
  caption: [Overview of the CAN-Core]
)<fig:can_core_overview>

@fig:can_core_overview shows the structure of the CAN-Core. 
It consists of three parts. The "Input Module", "Processing Module" and the "Handling Module".

#heading(level: 5, outlined: false, numbering: none)[Input Module]
The Input Module is responsible for converting the asynchronous received CAN signal into a 
synchronous received CAN signal with sample pulses. Additionally, 
it enables the destuffing process within the Processing Module, 
as this is only required during an active CAN frame.
Additionally to that, the resynchronisation process is performed inside this moudle.
As a secondary input, the module receives a signal from the Processing Module indicating the end of a CAN frame.

#heading(level: 5, outlined: false, numbering: none)[Processing Module]
The Processing Module handles the decoding of the serial CAN frame. 
During this process, a destuffing logic removes the stuffed bits, 
which is enabled by the Input Module upon detecting a dominant bit.
The module can also detect errors during the decoding process. 
When an error is detected, error signals are forwarded to the Handling Module, 
which manages the situation. In the event of an error, the Processing Module is reset by the Handling Module.

#heading(level: 5, outlined: false, numbering: none)[Handling Module]
Since the transmission of CAN frames can fail, it is essential to address such situations. 
The Handling Module is responsible for managing errors and controlling the can_frame_valid signal.
In addition to handling error signals from the Processing Module, the Handling Module performs a CRC check to detect errors. 
If an error occurs, the module attempts to detect an error frame before setting the can_frame_valid signal. 
This signal is also triggered by CAN frames containing errors. 
To indicate that a CAN frame contains an error, error codes are appended to the frame.