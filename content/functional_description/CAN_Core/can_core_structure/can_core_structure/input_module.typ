==== Input Module

#figure(
  image("../../img/CAN_Core_Input.drawio.png", width: 100%),
  caption: [Input Module structure]
)<fig:input_module_structure>

The in @sec:can_core_struct introduced "Input Module" consists of four submodules.

#heading(level: 5, outlined: false, numbering: none)[Sync]
At first, the asynchronus input signal has to be synchronised to prevent the following
modules from metastability. In our case, this is a typicall two stage synchroniser from the 
open logik hdl library.

#heading(level: 5, outlined: false, numbering: none)[Warm_start]
In a running CAN-Bus system, it is necesserely to avoid starting receiving and decoding a can-frame,
during the transmition of a physical frame. In our case this is necesserely, because the .rbf-file 
is loaded into the FPGA after a relatively long time compared to the startup time of a normal CAN-addendant. The warmstart module is responsible for perfoming this behavior. To do that, 
the rxd_sync signal is only forwarded to the rest of the system after six recessive samples in a row of the serial input are detected.

#heading(level: 5, outlined: false, numbering: none)[Sampling]
The "Sampling" Module generates the required sample pulses for reading the received data. 
During this process the resynchronisation based on edges from dominant to recessive and in reverse are perfomed.
Additionally to the resynchronisation, a hard reload is performed after the bus goes from idle to active.

#heading(level: 5, outlined: false, numbering: none)[Idle detect]
Because the sampling process distinguises between hard reload and resynchronisation, it is crusial to keep track
of the bus-state.
For this, the "Idle detect" module holds state based on the frame_finished signal and the incomming can-signal.

