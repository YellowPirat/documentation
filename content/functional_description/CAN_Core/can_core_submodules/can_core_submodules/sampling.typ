==== Sampling

#figure(
  image("../../img/can_bus_bittime.png", width: 100%),
  caption: [bittime segments @can_bus_specification]
)<fig:bit_time_segments>

As shown in @fig:bit_time_segments, a standard bit-time on the CAN bus is divided into four segments. 
These segments are further divided into time quanta, which are generated using a time-quanta prescaler.
The purpose of this submodule is to align the pattern in @fig:bit_time_segments with the received data to generate the appropriate sample pulse during each bit-time. 
Additionally, these segments are used to synchronize with the bus based on a rule-based mechanism. 
To achieve this, a state machine is implemented.

#figure(
  image("../../img/sampling.drawio.png", width: 100%),
  caption: [overview of the sampling and resync process]
)<fig:sampling>

@fig:sampling provides a simplified overview of how the state machine controls the surrounding components. 
The process of resynchronization is not fully illustrated in @fig:sampling due to the complexity of visualization. 
However, the main concept involves shortening or extending the duration of the phase_seg1 
and phase_seg2 bit-time segments to adjust the sample pulse.
This behavior is based on detecting edges in the data signal:
- If an edge occurs during the sync_seg bit-time segment, no resynchronization is performed.
- If an edge occurs during the phase_seg2 segment, its duration is shortened by the difference in time quanta between the edge and the sync_seg phase.
- If an edge occurs in the prog_seg segment, the duration of phase_seg1 is extended by the difference between the end of sync_seg and the edge in prog_seg.
- if an hard reload signal occures, the fsm transits to the sync_seg state.
The FSM in @fig:sampling controls the quantum counters to execute these adjustments.
To adapt this behavior to different CAN bus baud rates, 
the duration of each time segment (in time quanta) and the time-quanta prescaler can be configured by the driver module.