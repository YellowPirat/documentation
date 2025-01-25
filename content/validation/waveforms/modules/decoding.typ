=== Decoding

@fig:frame_decoding shows the process of decoding the transmitted data-frame
- ID: 0x777
- DLC: 1
- DATA: 0x11

#figure(
  image("../img/decoding.png", width: 100%),
  caption: [Frame decoding example]
)<fig:frame_decoding>

As @fig:frame_decoding shows, a core fsm holds state about the transmitted CAN-Frame.
Decoding and saving each section of a CAN-Frame occures online, with the help of the in section
@sec:intput_stream mentioned "Field & Bit Registers". These Registers also used to change state of the 
input_stream fsm after successfully saving data.