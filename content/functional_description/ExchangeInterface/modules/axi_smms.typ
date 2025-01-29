=== AXI SMMS

#figure(
  image("../img/AXI_SMMS.drawio.png", width: 100%),
  caption: [AXI SMMS structure]
)<fig:axi_smms_structure>

Due to the requirement for a data logger to log a specific number of different counts in parallel, 
it is necessary to implement a small AXI interconnect. 
This interconnect enables the driver to read and write data to multiple CAN-Cores (via their exchange interfaces).
In this system, the AXI-bus-based architecture consists of one master interface (the HPS-Core) and a variable number of slaves (the CAN-Cores). 
To connect all slaves to the master, the address space is divided into n regions. 
Each region in the address space is assigned to a specific CAN-Core.
The AXI SMMS (Single Master Multiple Slave) interconnect manages read and write transactions by distributing them to the appropriate CAN-Cores based on the destination address. 
This is achieved using a simple address decoder.
To differentiate between read and write transactions (as these use different address channels), 
a simple state machine is implemented, as shown in @fig:axi_smms_structure.