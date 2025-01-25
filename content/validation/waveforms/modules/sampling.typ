=== Sampling

#figure(
  image("../img/sample.png", width: 100%),
  caption: [waveform sampling example]
)<fig:waveform_sampling>

@fig:waveform_sampling shows a example of a resync. This is due to a higher baudrate than expected.
What can be seen, is that the transition from a recesive (HIGH) to a dominat (LOW) bus state, which is called
edge, occured during the prob_seg_s.
This means that the sample-pulse have to be earlier, to sample the bit at the rigth position.
In this case, the   phase_seg_1 time-segment is shortened by the distance from finishing the sync_seg to the
position where the edge occures. 
@fig:waveform_sampling emphesises the two different lenghts of phase_seg_1 in this example.
Doing this, can compensate different baudrates up to 2%.

