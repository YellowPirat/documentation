#import "/utils/todo.typ": TODO
#import "@preview/babble-bubbles:0.1.0": *



= Specification

== AXI Exchangeinterface
=== Functionality
To transfer data from the developed CAN core to the CPU running a Linux operating system for logging purposes, an AXI-Lite interface is utilized. 
The lightweight AXI interface of the HPS core is connected to an AXI-Lite slave interface within the exchange interface module. 
Read and write transactions in specific address spaces of the processing system are mapped to the AXI-Lite master interface of the HPS core.
The AXI-Lite interface supports 32-bit data transfers. 
A complete received CAN frame requires 7 accesses to sequential addresses. 
Upon accessing the final address, a new CAN frame is automatically loaded if one is available.
Data from different CAN cores can be accessed using offset values, calculated as follows: 
$"offset" = n_"word" * "word_size" = 7 * 32 = 224 "bits"$. This approach allows efficient handling of multiple CAN cores.

=== Register description

The @peripheral_status1 register contains general informations about the Cancore peripheral device.


==== Peripheral status register description
- Baseaddress: 0x00
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [buffer_usage], [0], [15], [16],[usage of the output fifo buffer],
    [_NOT USED_],[16],[31],[16], [addresspace is not used. Filled with zeros]
  ), caption: [peripheral_status]
)<peripheral_status0>

- Baseaddress: 0x04
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [peripheral_error],[0],[15],[16], [16 bits indicate error states in the cancore periphery],
    [_NOT USED_],[16],[31],[16], [addresspace is not used. Filled with zeros]
  ), caption: [peripheral_status]
)<peripheral_status1>

- Baseaddress: 0x08
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [missed_frames],[0],[23],[24],[these 24 bits show how many can frames are lost],
    [missed_frames_overflow],[24],[24],[1],[this bit indicates whether the missed_frames counter has a overflow in the past. This means the countervalue is garbage],
    [_NOT USED_],[25],[31],[7], [addresspace is not used. Filled with zeros]
  ), caption: [peripheral_status]
)<peripheral_status2>



==== CAN Frame register description
The following registers include the recorded can-frame.

- Baseaddress: 0x0C
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [stuff_error], [0], [0], [1], [Stuffbit error],
    [form_error], [1], [1], [1], [Form error],
    [sample_error], [2], [2], [1], [Sample error],
    [crc_error], [3], [3], [1], [CRC error],
    [unused_error_codes], [4], [15], [12], [16 bits indicate various error cases during reception],
    [frame_type],[16],[23],[8], [this bits can indecate the following frame type, such as CAN-2.0, CAN FD or newer versions like CAN XL],
    [_NOT USED_], [24], [31], [8], [addresspace is not used. Filled with zeros]
  ), caption: [CAN frame wort 0]
)<canframe_wort_0>

- Baseaddress: 0x10
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [these are the first 32 bits of the 64 bit timestamp]
  ), caption: [CAN frame wort 0]
)<canframe_wort_1>

- Baseaddress: 0x14
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [these are the second 32 bits of the 64 bit timestamp]
  ), caption: [CAN frame wort 0]
)<canframe_wort_2>



- Baseaddress: 0x18
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [can_id], [0], [28], [29], [this field contains the id of the received canframe],
    [rtr],[29],[29],[1], [retransmition request flag],
    [eff],[30],[30],[1], [extended frame format id],
    [err],[31],[31],[1], [error flag],
  ), caption: [CAN frame wort 2]
)<canframe_wort_3>

- Baseaddress: 0x1C
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [can_dlc],[0],[3],[4], [these 4 bits show how many bytes are in the payload],
    [_NOT USED_],[4],[31],[28], [addresspace is not used. Filled with zeros]
  ), caption: [CAN frame wort 1]
)<canframe_wort_4>

- Baseaddress: 0x20
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [crc], [0], [14], [15], [cyclic redundancy check],
    [_NOT USED_],[15],[31],[17], [addresspace is not used. Filled with zeros]
  ), caption: [Wort 3]
)<canframe_wort_5>

- Baseaddress: 0x24
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 0 to 31],
  ), caption: [Wort 4]
)<canframe_wort_6>

- Baseaddress: 0x28
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 32 to 63],
  ), caption: [Wort 5]
)<canframe_wort_7>


== Testbench
=== Errors
To make the best use of the test bench, we need to implement the artificial creation of different error types.
What is important when integrating errors consciously is that after an error is implemented, the whole CAN frame changes.
What is meant by that is that the usual behavior in error case is that to send an error frame.
An error frame breaks the flow of the CAN message that was being sent, replacing it with an error frame.
When an error is detected, the node in CAN bus that detected the error goes into an error active state.
In an error active state, the node send a (primary) error flag, which consists of 6 dominant bits.
Depending on when exactly the other CAN bus nodes discover the error, the (secondary) error flag consists of
superpositoning of other nodes sending error flags, ranging from 0 to 6 additional dominant bits.
After the 6-12 dominant bits, there is an error delimiter being sent, which consists of 8 recessive bits.
TODO: explain from error active -> error passive -> bus offset
Types of errors we will test for are:
- Bit stuffing error: Node detects a sequence of 6 bits of the same logical level between the SOF and CRC
- Form error: Node detects a bit of an invalid logical level in the SOF/EOF fields or ACK/CRC delimiters
- ACK error: Node transmits a CAN message, but the ACK slot is not made dominant by receiver(s)
- CRC error: Node calculates a CAN message that differs from the transmitted CRC field value