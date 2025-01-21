== AXI Interface

=== CAN Core allignment

@tab:can_core_allignment shows how the initialised CAN-Cores are alligned in the addressspace.
The device names are not directly connected to the device names of the kernel modules.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Startaddress*], [*Length*], [*Device name*]),
    [0xff200000], [0x1000], [CAN1],
    [0xff201000], [0x1000], [CAN2],
    [0xff202000], [0x1000], [CAN3],
    [0xff203000], [0x1000], [CAN4],
    [0xff204000], [0x1000], [CAN5], 
    [...], [0x1000], [CAN_N]
  ), caption: [CAN Core allignment]
)<tab:can_core_allignment>

=== Register description

#heading(level: 4, outlined: false, numbering: none)[Buffer usage - 0x00 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [buffer_usage], [0], [15], [16],[usage of the output fifo buffer],
    [_NOT USED_],[16],[31],[16], []
  ), caption: [Buffer usage]
)<tab:0x00>

#heading(level: 4, outlined: false, numbering: none)[Peripheral error - 0x04 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [peripheral_error],[0],[15],[16], [16 bits indicate error states in the cancore periphery],
    [_NOT USED_],[16],[31],[16], []
  ), caption: [Peripheral error]
)<tab:0x04>

#heading(level: 4, outlined: false, numbering: none)[Missed frames - 0x08 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [missed_frames],[0],[23],[24],[these 24 bits show how many can frames are lost],
    [missed_frames_overflow],[24],[24],[1],[this bit indicates whether the missed_frames counter has a overflow in the past. This means the countervalue is garbage],
    [_NOT USED_],[25],[31],[7], []
  ), caption: [Missed frames]
)<tab:0x08>

#heading(level: 4, outlined: false, numbering: none)[Frame errors - 0x0C - (R)]
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
    [_NOT USED_], [24], [31], [8], []
  ), caption: [Frame errors]
)<tab:0x0C>

#heading(level: 4, outlined: false, numbering: none)[Timestamp[0-31] - 0x10 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [these are the first 32 bits of the 64 bit timestamp]
  ), caption: [Timestamp[0-31]]
)<tab:0x10>

#heading(level: 4, outlined: false, numbering: none)[Timestamp[32-63] - 0x14 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [timestamp],[0],[31],[32], [these are the second 32 bits of the 64 bit timestamp]
  ), caption: [Timestamp[32-63]]
)<tab:0x14>

#heading(level: 4, outlined: false, numbering: none)[Id + Flags - 0x18 - (R)]
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
  ), caption: [Id + Flags]
)<tab:0x18>

#heading(level: 4, outlined: false, numbering: none)[DLC - 0x1C - (R)]
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
  ), caption: [DLC]
)<tab:0x1C>

#heading(level: 4, outlined: false, numbering: none)[CRC - 0x20 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [crc], [0], [14], [15], [cyclic redundancy check],
    [_NOT USED_],[15],[31],[17], [addresspace is not used. Filled with zeros]
  ), caption: [CRC]
)<tab:0x20>

#heading(level: 4, outlined: false, numbering: none)[Data[0-31] - 0x24 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 0 to 31],
  ), caption: [Data[0-31]]
)<tab:0x24>

#heading(level: 4, outlined: false, numbering: none)[Data[31-63] - 0x28 - (R)]
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Startbit*], [*Endbit*], [*Length*], [*Comment*]),
    [data], [0], [31], [32], [bits 32 to 63],
  ), caption: [Data[31-63]]
)<tab:0x28>