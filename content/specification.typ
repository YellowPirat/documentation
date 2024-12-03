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
    [buffer_usage], [0], [9], [10],[usage of the output fifo buffer],
    [_NOT USED_],[4],[31],[28], [addresspace is not used. Filled with zeros]
  ), caption: [peripheral_status]
)<peripheral_status0>

- Baseaddress: 0x04
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [peripheral_error],[0],[15],[5], [16 bits indicate error states in the cancore periphery],
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
    [missed_frames],[0],[23],[24],[this 24 bits show how many can frames are lost],
    [missed_frames_overflow],[24],[24],[1],[this bit indicates whether the missed_frames counter has a overflow in the past. This means the countervalue is garbage],
    [_NOT USED_],[25],[31],[7], [addresspace is not used. Filled with zeros]
  ), caption: [peripheral_status]
)<peripheral_status2>



==== CAN Frame register description
The following registers include the recorded can-frame.

- Baseaddress: 0x00
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [error_codes], [0], [15], [16], [16 bits indicate various error cases during reception],
    [frame_type],[16],[23],[8], [this bits can indecate the following frame type, such as CAN-2.0, CAN FD or newer versions like CAN XL]
  ), caption: [CAN frame wort 0]
)<canframe_wort_0>

- Baseaddress: 0x04
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [this are the first 32 bits of the 64 bit timestamp]
  ), caption: [CAN frame wort 0]
)<canframe_wort_1>

- Baseaddress: 0x08
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [this are the second 32 bits of the 64 bit timestamp]
  ), caption: [CAN frame wort 0]
)<canframe_wort_2>



- Baseaddress: 0x0C
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

- Baseaddress: 0x10
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

- Baseaddress: 0x14
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [crc], [0], [14], [15], [cyclic redundancy check],
    [_NOT USED_],[16],[31],[16], [addresspace is not used. Filled with zeros]
  ), caption: [Wort 3]
)<canframe_wort_5>

- Baseaddress: 0x18
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 0 to 31],
  ), caption: [Wort 4]
)<canframe_wort_6>

- Baseaddress: 0x1C
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 32 to 63],
  ), caption: [Wort 5]
)<canframe_wort_7>
