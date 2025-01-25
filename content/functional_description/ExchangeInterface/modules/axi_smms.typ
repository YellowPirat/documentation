=== AXI SMMS

#figure(
  image("../img/AXI_SMMS.drawio.png", width: 100%),
  caption: [AXI SMMS structure]
)<fig:axi_smms_structure>

Because the requirement to a data-logger is to log a specific number of different counts parallel, 
It is necesserely to implement a small AXI-Interconnect wich gives the driver the ability to read and write
data to different can-cores (exchange interfaces of can-cores).

In our case the AXI-Bus based system has one master interface (HPS-Core) and
a varying number of slaves(CAN-Cores).
To connect all slaves with the master, the address space is splited into n areas. 
Each are in the address-space, is assigned to a specific CAN-Core.
The AXI SMMS interconnect (Single Master Multible Slave), distributes the read and write transactions,
based on the destination address to the specific CAN-Cores. For this a simple address-decoder is used.

To distinguis between a read and write transaction (they uses different address channels), a simple
state-machine is implemented, as it can be seen in @fig:axi_smms_structure.