==== CAN-Core structure <sec:can_core_struct>

#figure(
  image("../../img/CAN__Core_Overview.drawio.png", width: 100%),
  caption: [Overview of the CAN-Core]
)<fig:can_core_overview>

@fig:can_core_overview shows the structure of the CAN-Core. 
It consists of three parts. The "Input Module", "Processing Module" and the "Handling Module".

#heading(level: 5, outlined: false, numbering: none)[Input Module]
The "Input Module" is responsible for taking the asynchronus receive CAN signal
and providing a synchrouns receive CAN signal with sample pulses.
Additionally to that, the "Input Module" enables the destuffing process in the "Processing Module",
because this is only required during a active CAN-Frame. 
As an second input, the module takes an signal from the "Processing Module", which signals the end of a CAN-Frame.

#heading(level: 5, outlined: false, numbering: none)[Processing Module]
The "Processing Module" is responsible for decoding the serial CAN-Frame.
For decoding the CAN-Frame, a destuffing Logic excludes the sample pulses.
The Destuffing Logik is enabled by the "Input Module",
as soon as a dominant bit was detected.
During the decoding process, the this module can detect errors.
If this happens, error signals are passed to the Handling Module, which is responsible
for handling this situation. Additionally to that, the handling module also makes a 
seperate crc-check, which also can trigger an error. for that decode and crc-signals 
are also forwarded. In Case of an error, the "Processing Module" is resetet by the
Handling Module.

#heading(level: 5, outlined: false, numbering: none)[Handling Module]
Because the transmition of CAN-Frames can fail, it is importent to handle this situations.
For that the Handling Module is responsible for handling errors and managing the 
can-frame-valid signal. 
As mentioned, Additionally to the error-signals from the "Processing Module", a 
crc-check is performed, to detect errors. 
If an error occures, the "Handling Modules", tries to detect an error-frame before
setting the can_frame_valid signal, which is also enabled by an can-frame with an error.
To indicate that an can-frame contains an error, error-codes are append to that frame.
