==== Input Module

#figure(
  image("../../img/CAN_Core_Input.drawio.png", width: 100%),
  caption: [Input Module structure]
)<fig:input_module_structure>

The "Input Module," introduced in @sec:can_core_struct, consists of four submodules.

#heading(level: 5, outlined: false, numbering: none)[Sync] 
First, the asynchronous input signal must be synchronized to prevent metastability in subsequent modules. 
In this design, a typical two-stage synchronizer from the Open Logic HDL library is used.

#heading(level: 5, outlined: false, numbering: none)[Warm Start] 
In a running CAN-Bus system, it is essential to avoid receiving 
and decoding a CAN frame during the transmission of a physical frame. 
This precaution is necessary because the .rbf file is loaded into the FPGA 
after a relatively long delay compared to the startup time of a typical CAN node. 
The "Warm Start" module ensures this behavior by forwarding the rxd_sync signal to the rest of the system 
only after detecting six consecutive recessive samples in the serial input.

#heading(level: 5, outlined: false, numbering: none)[Sampling] 
The "Sampling" module generates the sample pulses required for reading the received data. 
During this process, resynchronization is performed based on edge transitions between dominant and recessive states, and vice versa. 
Additionally, a hard reload is triggered when the bus transitions from idle to active.

#heading(level: 5, outlined: false, numbering: none)[Idle Detect] 
Since the sampling process differentiates between hard reload and resynchronization, 
it is crucial to maintain awareness of the bus state. 
The "Idle Detect" module tracks the bus state based on the frame_finished signal and the incoming CAN signal.
