= Introduction
_Stasa Lukić_

This documentation is about the design and implementation of a CAN Data Logger utilizing an Altera Terasic DE1-SoC development board for real-time reading and processing of Controller Area Network (CAN) frames from multiple CAN channels. The system integrates an FPGA-based CAN-Core, a FIFO storage mechanism, and a custom kernel module to for data exchange between kernel space and user space. The decoded frames are processed and made accessible through a SocketCAN-compatible interface, enabling live visualization and logging of CAN traffic.

To achieve efficient data handling, an AXI-based interface is used for hardware communication. The software stack includes a kernel driver for low-level data management and a web-based frontend with real-time visualization using WebSockets. The validation process involves CAN frame generation, waveform analysis, and error handling mechanisms, ensuring reliability in data logging and interpretation.

This documentation provides a comprehensive breakdown of the system architecture, covering hardware integration, software components, and validation methods. This project solution offers an efficient and scalable approach to CAN data logging, making it suitable for real-time automotive diagnostics and industrial applications.

#pagebreak()