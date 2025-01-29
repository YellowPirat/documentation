== Test setups
_Benjamin Klarić_

In order to ensure that the implemented design of the Yellow Pirat is functional, different test setups were used.

Firstly, a test setup including a Raspberry Pi was established. With the use of the Raspberry Pi, and a custom shield board containing CAN transceivers, different CAN messages could be sent between CAN transceivers. During this, the Yellow Pirat is situated as a passive observer of this communication. This enables the Yellow Pirat to be a member of this communication without the need to take a part in it, by sending CAN messages. The idea behind this setup is to be able to test if, among other, the detection, and classification of the CAN messages and sampling of the received bits work, while sending known data and being a part of a real CAN bus system. The data received on the Yellow Pirat side is then displayed over UART to a monitor. This setup is shown in @fig:pi_test.

#figure(
  image("img/Pi_test.png", width: 65%),
  caption: [Test setup including Raspberry Pi]
)<fig:pi_test>

This setup is perfect for testing the system without the need to integrate the Yellow Pirat in a real CAN environment, for example into a car.

Secondly, expanding on the former test setup, the system was also integrated into a formula student racecar, where the CAN bus is used for the communication between different components. This test setup can be seen in @fig:real_test.

#figure(
  image("img/Real_test.png", width: 90%),
  caption: [Test setup incorporating a real life application]
)<fig:real_test>

The Yellow Pirat is set up here as a data logger in a real CAN bus, logging and displaying the CAN messages. This way, the whole system, from the design of the CAN-Core, to the driver receiving the processed messages forwarded from FPGA logic, which are then displayed live through the webserver. With this test setup, the whole functionality of the Yellow Pirat can be tested, thus providing a comprehensive validation of the entire system's integration, reliability, and real-time performance in real-world automotive network environments.