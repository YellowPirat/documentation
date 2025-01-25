==== Input Stream <sec:intput_stream>

#figure(
  image("../../img/decoding.drawio.png", width: 100%),
  caption: [decoding module overview]
)<fig:decoding_module_overview>

The module "Input Stream" is responsible for decoding the serial can-frame, as can be seen in @fig:can_frame_vector.

#figure(
  image("../../img/can_frame_vector.png", width: 100%),
  caption: [can_frame]
)<fig:can_frame_vector>

Because of the complexitiy and especially the size of the fsm i decided to dont visualise 
it in @fig:decoding_module_overview. 
But what can be seen in @fig:decoding_module_overview, is that the fsm stores the received, 
data fields during runtime in field buffers and bit buffers. 
These buffers are desigened to store the incomming data-fields and give feedback over the 
amount of stored bits, to reverse controll the fsm.
The fsm also provideds controll signals, such as start-of-frame signals, form-error-signals and so on.


