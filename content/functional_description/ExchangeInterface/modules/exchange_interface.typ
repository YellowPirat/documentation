=== FIFO buffered exchange Interface

#figure(
  image("../img/ExchangeInterface.drawio.png", width: 100%),
  caption: [Exchnage Interface structure]
)<fig:exchange_interface_structure>

As it can be seen in @tab:can_core_entity, the CAN-Core its self has no build in interface, 
for communicating with the HPS-Core over an AXI interface.
For this a seperate exchange interface was developed. 
The adventage for this is, that the CAN-Core can be addapted to different bus-interfaces.
For this, it is not needed to modify the CAN-Core its self, it is enough to just build a new
exchange interface.

In our case, the exchange interface implements a AXI4-Lite Slave function block.
Incomming data from the CAN-Core, which is validated by the can-frame-valid signal is
first stored to a FIFO buffer. The adventage of doing this, is the ability of better tuning the driver, 
which reads can-frames. 

The exchange interface @fig:exchange_interface_structure, takes the can-frame and the can-frame valid signals.
To control the access to the fifo buffer, a "FIFO Input Control" block is responsible for doing this. 
This functionblock implements the AXI-Handshake mechanisem, which is used by the FIFO-Buffer.
For the case that the Controll-Block cant generate a successfull handshake with the fifo, it counts the 
missed frames counter up. For a successfull write transaction in the fifo, the buffer usage-counter is count up.

The AXI4-Lite Slave Interface int @fig:exchange_interface_structure is responsible for providing read and wirte 
access, a read-access automatically reads from the fifo, when it is filled with at least one can-frame.
For better tuning this access. the buffer usage-counter is also part of a read-transaction.
With the value provided by it, the driver can manage the access more effeciently.
Moreover the interface implements the ability to load config params to the can-core from the driver.