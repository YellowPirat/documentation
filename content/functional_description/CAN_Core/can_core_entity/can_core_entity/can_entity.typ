=== Entity
_Maximilian Hoffmann_

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header( [*Name*], [*Type*], [*Direction*]),
    [clk], [std_logic], [in],
    [rst_n], [std_logic], [in],
    [rxd_async_i], [std_logic], [in],
    [can_frame_o], [can_core_out_intf_t], [out],
    [can_frame_valid_o], [std_logic], [out],
    [baud_config_i], [sample_intf_t], [in]
  ), caption: [CAN Core entity]
)<tab:can_core_entity>

The main input of the CAN-Core module is the rxd_async_i input provided by a CAN transreceiver which is physically connected
to the CAN-Bus. Moreover the Driver provides over the AXI interface a record typ containing config parameters for the bus-sampling
in sample_config_i.
The CAN-Core it self provides a record typ in can_frame_o containing the received CAN-Frame and a can_frame_valid_o signal,
which indicates whether the data in can_frame_o is valid. Furthermore the CAN-Core provides a nother record type containing 
some peripheral status data in peripheral_status_o.