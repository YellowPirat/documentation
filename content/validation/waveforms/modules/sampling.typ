=== Sampling
_Maximilian Hoffmann_

#figure(
  image("../img/sample.png", width: 100%),
  caption: [waveform sampling example]
)<fig:waveform_sampling>

@fig:waveform_sampling shows an example of resynchronization due to a higher baud rate than expected. 
As seen in the figure, the transition from a recessive (HIGH) to a dominant (LOW) bus state, 
known as an "edge," occurs during the prog_seg.
This means the sample pulse needs to be adjusted to occur earlier, 
so the bit is sampled at the correct position. 
In this case, the phase_seg_1 time segment is shortened by the distance between the end of the sync_seg and the position where the edge occurs.
@fig:waveform_sampling highlights the two different lengths of phase_seg_1 in this example. 
By doing this, the system can compensate for different baud rates, up to 2%.

