#import "/utils/todo.typ": TODO

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

=== Description
==== Wort 0
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [buffer_usage], [0], [4], [5],[],
  [_NOT USED_],[5],[31],[27], [addresspace is not used]
)

==== Wort 1
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [error_codes], [0], [9], [10], [],
  [frame_type],[10],[11],[2], [],
  [timestamp],[12],[31],[20], [bits 0 to 19]
)

==== Wort 2
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [timestamp], [0], [27], [28], [],
  [can_dlc],[28],[31],[4], []
)

==== Wort 3
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [can_id], [0], [28], [29], [],
  [rtr],[29],[29],[1], [],
  [eff],[30],[30],[1], [],
  [err],[31],[31],[1], [],
)

==== Wort 4
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [crc], [0], [14], [15], [],
  [crc_delimiter],[15],[15],[1], [],
  [_NOT USED_],[16],[31],[16], [addresspace is not used]
)

==== Wort 5
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [data], [0], [31], [32], [bits 0 to 31],
)

==== Wort 6
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
  [data], [0], [31], [32], [bits 32 to 63],
)