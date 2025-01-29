== CAN-Frame generator
In order to test the CAN-Core, and it's implemented entities in a flexible environment, a sort of test bench system was created. The idea for the test bench system was to read the CAN messages from a .csv file, where a single line holds a single bit, and to treat this as real CAN messages being received. 

A test bench in VDHL was written to read the data and a Python script was written to generate the data.
To compile and run the modules in CAN-Core, including the test bench and the generated data, the GHDL simulator for VHDL was used. The output is a .ghw file, a waveform file, which can be viewed using a wave viewer, like GTKWAve.

=== Generation of CAN messages
The CAN messages were generated following the official structure specified by Bosch @can_bus_specification. The script implements every specific feature of CAN specification needed to generate the CAN messages that correspond to the real ones. This includes, among other, bit stuffing, calculation of the CRC value, differentiation between messages with standard or extended ID and different types of frames.

The CAN protocol specifies different types of frames, from which the data and error frames were the only ones interesting to test for, as they are by far the most common ones. The remote frame was also implemented as an option, but rarely used in testing. The outdated and unused overload frame was completely ignored.

It is important to note, that in this way of testing, the generated CAN messages are just a sum of messages in a theoretical CAN bus, at some given point. This means, that the generated CAN messages aren't just messages from one node in CAN bus, but rather a collection of many, from different nodes.

The configuration of the generated messages is implemented through the use and later parsing of a YAML file. This way a user can specify how many CAN frames are generated, which type, what ID, containing what data, how long the bus idle period between the messages is and whether to include intentional errors. The last option is examined in greater detail in @sec:errors. An example of a configuration in a YAML file is shown below, which specifies two CAN data frames with distinct IDs and data, and no errors.

```yaml
Frames:
  - type: "data" #default value
    id: 0x777
    dlc: 2
    error: "none" #default value
    data:
    - 0xe7
    - 0x83
    bus_idle: "0" #default value
  - type: "data" #default value
    id: 0x981
    dlc: 5
    error: "none" #default value
    data:
    - 0xde
    - 0xad
    - 0xbe
    - 0xef
    - 0x33
    bus_idle: "0" #default value
```
As stated before, the generated CAN frames contain, when necessary, bit stuff bits and calculated CRC for the specific message. The different frames are then combined and saved in a single .csv file.

Using the script, a user can test with many CAN messages, to ensure that the CAN-Core implementation is indeed correct. However, a point already mentioned before is the implementation of the intentional errors into these generated CAN messages. This is also a crucial point in testing, since in real application, there are many factors, internal and external, that can cause errors in the transmitted messages.

=== Errors <sec:errors>
As mentioned, to make the best use of the test bench, the injection of different error types in CAN messages in necessary. This is done randomly, if possible, to test for many instances of error injections in CAN messages. The implementation of the errors follows the CAN specification from Bosch @can_bus_specification.

However, just implementing an error in a CAN message is not the whole process. In a real environment, the error is recognized by either the node in the CAN bus that is sending the message or other nodes in the same bus. They signal it by sending an error frame.
An error frame breaks the flow of the CAN message that was being sent, by forcefully introducing a bit stuff error, so the other nodes can also recognize the existence of an error. 

An error frame isn't necessarily sent immediately after the detection of an error, sometimes even a few bits later, depending on the error detected.

The following error types will be used for testing:
- bit stuff error,
- form error,
- ACK error,
- CRC error.

The following chapters will focus on of these specific errors.

==== Bit stuff error
Implementing a bit stuff error depends on the structure of the generated CAN message, since the script keeps track of the stuffed bits. If there are any stuffed bits, they are just removed, causing an error. If there are no stuffed bits, a position between SOF and end of CRC sequence is randomly chosen, as that part of the bit stream is coded by the method of bit stuffing.

A bit stuff error is followed immediately by an error frame, starting at the very next bit.

==== Form error
This type of error encompasses a violation of the fixed form of certain bits in a CAN message. The implementation randomly sets one of the bits of either a CRC delimiter or ACK delimiter to a dominant. With EOF bits, one random bit is set as dominant. This causes an error, since all these bits are recessive per default.

A form error is followed immediately by an error frame, starting at the very next bit.

==== ACK error
Implementing this type of error is pretty simple, since the error is only present, when a dominant bit isn't monitored in an ACK slot by the transmitter of the message. Therefore, simply setting this bit as a recessive bit causes an error, if monitored by the transmitter.

It is important to note, that this differs from the default setting of this bit to a recessive bit by the transmitter the first time sending the CAN message. The generated messages, as stated, don't capture the whole communication in a CAN bus, such as a transmitter sending a CAN message, then later receiving it and monitoring a recessive bit in the ACK slot. This behavior is simply simulated, that the transmitter monitored this state of the ACK slot at some point, which is what is generated.

An ACK error is followed immediately by an error frame, starting at the very next bit.

==== CRC error
The CRC error is implemented by randomly changing the values of some bits in the sequence. There is however something to consider, when randomly flipping the bits like this, a bit stuff error can occur, which is not what is wanted when testing for CRC errors. 

This is solved by flipping a random amount of bits inside the CRC sequence, then reapplying bit stuffing to the part of the frame relevant to the checking if the flipping of the bits caused a bit stuff error.

One thing to consider is that checking for bit stuff error inside a CRC sequence alone is not enough. The preceding bits in combination with the flipped bits of the CRC sequence can cause a bit stuff error, where there wasn't one before. Therefore, additional bits are taken into consideration when checking if a bit stuff error was caused.

The position of the error frame when a CRC error is detected, is specific in comparison to the other types of errors. It comes after the ACK delimiter, instead of immediately the next bit, which is a thing to consider.