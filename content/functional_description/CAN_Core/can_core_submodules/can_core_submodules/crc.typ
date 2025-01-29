==== CRC <sec:crc>
To ensure, that the received CAN frames are indeed valid, and contain no transmission errors, CRC is calculated within the CAN-Core, for comparison purposes. For calculation of the CRC value, an FSM for control of the CRC calculation, is implemented as shown in @fig:crc_overview.

#figure(
  image("../../img/CRC.png", width: 100%),
  caption: [CRC overview]
)<fig:crc_overview>

The FSM is controlled by the enable_i signal, which is active for the portion of the CAN frame for which the CRC is calculated, starting with the SOF (Start-of-Frame) bit and ending with the last bit of data. When the enable_i signal goes high, it starts the CRC calculation through the enable_crc signal.

The calculation of the CRC in CAN interface is implemented through the use of the CRC-15-CAN polynomial: $x^15 + x^14 + x^10 + x^8 + x^7 + x^4 + x^3 + 1$ @can_bus_specification. The CRC calculation follows an LFSR-like (Linear Feedback Shift Register) structure, where the feedback loop consists of the XOR-ed register outputs and the data coming in. The position of the XOR gates corresponds to the aforementioned polynomial. The result is a 15 bit value, seen as a remainder of the XOR operation with the input data.

After the calculation is finished, the comparison is done between the input CRC value, crc_i, but only when the crc_valid_i signal is set high, as it indicates that the crc_i value is ready for comparison. It is important to state, that the CRC is only calculated from unstuffed bits.

After the comparison is done, the result is indicated through the crc_error_o bit, which is set high when the two CRC values don't match. Otherwise, the value doesn't change, meaning it stays low.