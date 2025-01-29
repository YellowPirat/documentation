=== CRC
_Benjamin Klarić_

The explained flow of the CRC calculation can be observed in @fig:crc_example.

#figure(
  image("../img/CRC.png", width: 100%),
  caption: [CRC calculation example]
)<fig:crc_example>

As explained in @sec:crc, the CRC calculation is controlled by the FSM. When the FSM sets the enable_crc_i signal to high, the calculation starts. 
The progress of the calculation is shown in 15 bit crc_registers, as it's final result, after the enable_crc_i goes low. The FSM then switches to an idle state, in which the comparison is done. 
The time point of the comparison, shown with the red arrow in @fig:crc_example, corresponds to the time point when the crc_valid_i signal is set high. If two CRC values contain the same value, the crc_error_o isn't set high. 
The crc_registers are at the end of the frame or immediately after the crc_error_o signal is set high.