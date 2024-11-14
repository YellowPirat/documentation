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

The @peripheral_status register contains general informations about the Cancore peripheral device.


- Baseaddress: 0x00
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [fifo_usage], [0], [9], [10],[usage of the output fifo buffer],
    [peripheral_error],[10],[14],[5], [5 bits indicate error states in the cancore periphery],
    [core_active],[15],[15],[1],[this bit indicates whether the cancore is active or not],
    [fifo_overflow],[16],[16],[1],[this bit indicates whether a fifo overflow occured],
    [missed_frames],[17],[31],[15],[this 15 bits show how many can frames are lost]
  ), caption: [peripheral_status]
)<peripheral_status>


The following registers include the recorded can-frame.

- Baseaddress: 0x04
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [error_codes], [0], [9], [10], [10 bits indicate various error cases during reception],
    [frame_type],[10],[11],[2], [this two bits can indecate the following frame type, such as CAN-2.0, CAN FD or newer versions like CAN XL],
    [timestamp],[12],[31],[20], [this are the first 20 bits of the 48 bit timestamp]
  ), caption: [CAN frame wort 0]
)<canframe_wort_0>

- Baseaddress: 0x08
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp], [0], [27], [28], [this are the last 28 bits of the 48 bit timestamp],
    [can_dlc],[28],[31],[4], [these 4 bits show how many bytes are in the payload]
  ), caption: [CAN frame wort 1]
)<canframe_wort_1>

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
)<canframe_wort_2>

- Baseaddress: 0x10
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [crc], [0], [14], [15], [cyclic redundancy check],
    [crc_delimiter],[15],[15],[1], [],
    [_NOT USED_],[16],[31],[16], [addresspace is not used]
  ), caption: [Wort 3]
)<canframe_wort_3>

- Baseaddress: 0x14
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 0 to 31],
  ), caption: [Wort 4]
)<canframe_wort_4>

- Baseaddress: 0x18
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 32 to 63],
  ), caption: [Wort 5]
)<canframe_wort_5>
