== Timing analysis
_Benjamin Klarić_

To ensure that the CAN-Core design works with the set clock (50 MHz), a timing analysis is conducted. The goal of the timing analysis is to verify, that the data arrives at the right time between the registers, and if not, the timing violations can be easily identified.

In order to run the timing analysis on the synthesized design of the written CAN-Core modules, a constraints file, a .sdc file, specifying, among other, the used clock frequency is needed.

The timing analysis generates a lot of reports and summaries. One of the more important ones is the analysis of the critical path. A critical path is a path from an input to an output with the largest delay. A waveform analysis of a such path in the CAN-Core implementation can be observed in @fig:timing_analysis.

#figure(
  image("img/Waveform.png", width: 100%),
  caption: [Waveform of the critical path in CAN-Core design]
)<fig:timing_analysis>

The waveform shows, among other, a difference between the data arrival time and data required time, called slack. The positive slack time shown is the waveform diagram means that the data arrives with time to spare, before it needs to be stable.

Summarized data from the waveform and the path summary of the timing report can be examined in @tab:path_summary.

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    [*From Node*], [de1_core:de1_core_i0|de1_can_core:\can_core_gen:4:de1_can_core_i0|de1_sampling:sampling_i0|sample:sample_i0|seq_cnt:phase1_cnt_i0|cnt_s[18]~DUPLICATE], 
    [*To Node*], [de1_core:de1_core_i0|de1_can_core:\can_core_gen:4:de1_can_core_i0|de1_input_stream:core_i0|frame_detect:frame_detect_i0|current_state.idle_s],
    [*Launch Clock*], [CLOCK_50],
    [*Launch Clock Delay*], [3.879 ns],
    [*Latch Clock*], [CLOCK_50],
    [*Latch Clock Delay*], [3.284 ns],
    [*Relationship*], [20.000 ns],
    [*Data Arrival Time*], [15.223 ns],
    [*Data Required Time*], [23.154 ns],
    [*Data Delay*], [11.344 ns],
    [*Clock Skew*], [-0.555 ns],
    [*Slack*], [7.931 ns]
  ), caption: [Critical path summary]
)<tab:path_summary>

As observed, the critical path runs between the _From Node_ and _To Node_. A visual representation of this path can be seen @fig:path. This is the real path on the FPGA SoC chip between these two nodes.

#figure(
  image("img/Path.png", width: 30%),
  caption: [Graphical data path]
)<fig:path>

This design has a positive slack time of 7.931 ns, meaning that theoretically, the CAN-Core design can run at an even higher frequency. The maximum frequency, $F_"max"$, can be either calculated from the values gathered from the timing report or seen in the Fmax summary section of the timing analysis. When calculating the $F_"max"$, only slack time (S) and clock period (T) values are needed, since the $F_"max"$ is the reciprocal of the critical path delay. The critical path delay, $T_"cp"$, is calculated as the difference between the time period and slack time: \
$T_"cp" = T - S$ \
$T_"cp" = 20.000 "ns" - 7.931 "ns"$ \
$T_"cp" = 12.069 "ns"$. \
Now calculating the $F_"max"$ as reciprocal of the critical path delay: \
$F_"max" = 1/T_"cp"$ \
$F_"max" = 1/(12.069 "ns")$ \
$F_"max" = 82.86 "MHz"$. \
This can be confirmed with the Fmax summary of the timing analysis, which is shown in @fig:fmax.

#figure(
  image("img/Fmax.png", width: 80%),
  caption: [Fmax summary]
)<fig:fmax>

The second line in the summary shows the maximum frequency of the HPS SDRAM interface clock. It is limited by the memory device specifications rather than FPGA routing delays, as stated in the note column.