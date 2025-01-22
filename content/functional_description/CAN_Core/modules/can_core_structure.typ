=== CAN-Core structure

#figure(
  image("../img/CAN__Core_Overview.drawio.png", width: 100%),
  caption: [Overview of the CAN-Core]
)<fig:can_core_overview>

@fig:can_core_overview shows the structure of the CAN-Core. 
It consists of three parts. The "Input Module", "Processing Module" and the "Handling Module".

#heading(level: 4, outlined: false, numbering: none)[Input Module]
The "Input Module" is responsible for taking the asynchronus receive CAN signal
and providing a synchrouns receive CAN signal with sample pulses.
Additionally to that, the "Input Module" enables the destuffing process in the "Processing Module",
because this is only required during a active CAN-Frame. 
As an second input, the module takes an signal from the "Processing Module", which signals the end of a CAN-Frame.

#heading(level: 4, outlined: false, numbering: none)[Processing Module]
The "Processing Module" is responsible for decoding the serial CAN-Frame.
For doing this, the module is deeply connected with the "Handling Module".
After the completion of a CAN-Frame the received CAN-Frame is provided with a parallel interface.
A valid signal determins, whether the provided CAN-Frame is complete or not.

#heading(level: 4, outlined: false, numbering: none)[Handling Module]
Because the transmition of CAN-Frames can fail, it is importent to handle this situations.
For this the "Handling Module" uses signals from the "Processing Module".
Additionally to that, the rxd-signal with the sample signal is also provided.
With that, a CRC check is performed.
The main output of this module are the error-codes, which indicates, what kind of error occured.
The error codes are than append to the can-frame
