=== FIFO buffered exchange Interface

#figure(
  image("../img/ExchangeInterface.drawio.png", width: 100%),
  caption: [Exchnage Interface structure]
)<fig:exchange_interface_structure>

As shown in @tab:can_core_entity, the CAN-Core itself does not have a built-in interface for communicating with the HPS-Core over an AXI interface. 
To address this, a separate exchange interface was developed.
The advantage of this design is that the CAN-Core can be adapted to different bus interfaces without modifying the core itself. 
Instead, only the exchange interface needs to be updated or replaced to support a new interface.
In this implementation, the exchange interface includes an AXI4-Lite Slave function block. 
Incoming data from the CAN-Core, validated by the can-frame-valid signal, is first stored in a FIFO buffer. 
The benefit of using a FIFO buffer is the improved flexibility for tuning the driver that reads CAN frames.
The exchange interface, shown in @fig:exchange_interface_structure, processes the can-frame and can-frame-valid signals. 
To manage access to the FIFO buffer, a "FIFO Input Control" block is responsible for coordinating this process. 
This block implements the AXI-handshake mechanism used by the FIFO buffer. 
If the control block fails to generate a successful handshake with the FIFO, the missed-frames counter is incremented. 
Conversely, for a successful write transaction, the buffer usage-counter is incremented.
The AXI4-Lite Slave Interface in @fig:exchange_interface_structure provides read and write access. 
A read operation automatically retrieves data from the FIFO when it contains at least one CAN frame. 
For tuning the access, the buffer usage-counter is included in the read transaction. 
Using this value, the driver can manage access to the FIFO more efficiently.
Additionally, the interface supports loading configuration parameters into the CAN-Core from the driver, enhancing its flexibility and usability.