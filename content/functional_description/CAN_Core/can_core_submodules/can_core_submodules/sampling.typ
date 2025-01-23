==== Sampling

#figure(
  image("../../img/can_bus_bittime.png", width: 100%),
  caption: [bittime segments @can_bus_specification]
)<fig:bit_time_segments>

As it can be seen in @fig:bit_time_segments, a normal bit-time of the CAN-Bus is seperated into four segements. These segements are divided into time quanta, which are 
generated through a time quanta presacaler. 
The goal of this submodule is to fit this pattern @fig:bit_time_segments into the
received data, to generate the appropiate samplepuls in each bit-time. 
Moreover, these segements are used to synchronise to the bus on a rule based schematic.
To achive this a statemachine is implemented.

#figure(
  image("../../img/sampling.drawio.png", width: 100%),
  caption: [overview of the sampling and resync process]
)<fig:sampling>

@fig:sampling shows a simple overview how the statemachine controlls the surounded components. 
The process of resynchronisation is not completely coverd in @fig:sampling because of the
complexitiy of visualisation. But the main idea behind this is to shortening or
extend the duration of the phase_seg1 and phase_seg2 bit time segment to adjust the
sample pulse. This behavior is generated by observing the edges on the data-signal. 
If a edge occures during the sync_seg bit time, no resync is performed.
If a edge occures in the phase_seg2 time, the duration will be shortening by the difference of time-quanta to the sync_seg phase. If a edge occures in the prog_seg segment, the time duration of phase_seg1 is extended to the difference between end of 
sync_seg and edge in prob_seg. 
For doing this, the fsm in @fig:sampling controlls the quantum counters.
To adapt this behavior to different baudrates of the CAN-Bus, the duration in time-quanta,
of each time-seqment and the time-quanta presacaler can be configured by the driver module.