=== Decoding

@fig:frame_decoding shows the process of decoding the transmitted data-frame
- ID: 0x777
- DLC: 1
- DATA: 0x11

#figure(
  image("../img/decoding.png", width: 100%),
  caption: [Frame decoding example]
)<fig:frame_decoding>

As shown in @fig:frame_decoding, a core FSM maintains the state of the transmitted CAN frame. 
Decoding and saving each section of a CAN frame occurs in real time, 
facilitated by the "Field & Bit Registers" mentioned in @sec:intput_stream. 
These registers are also used to update the state of the input stream FSM after successfully saving data.