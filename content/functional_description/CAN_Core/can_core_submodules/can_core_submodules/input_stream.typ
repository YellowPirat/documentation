==== Input Stream <sec:intput_stream>
_Maximilian Hoffmann_

#figure(
  image("../../img/decoding.drawio.png", width: 100%),
  caption: [decoding module overview]
)<fig:decoding_module_overview>

The module "Input Stream" is responsible for decoding the serial can-frame, as can be seen in @fig:can_frame_vector.

#figure(
  image("../../img/can_frame_vector.png", width: 100%),
  caption: [can_frame]
)<fig:can_frame_vector>

Due to the complexity and size of the FSM, I decided not to visualize it in @fig:decoding_module_overview. However, 
what is illustrated in @fig:decoding_module_overview is that the FSM stores the received data fields during runtime in field buffers and bit buffers.
These buffers are designed to store the incoming data fields and provide feedback about the number of stored bits, 
enabling reverse control of the FSM.
Additionally, the FSM provides control signals such as start-of-frame signals, form-error signals, and others.

