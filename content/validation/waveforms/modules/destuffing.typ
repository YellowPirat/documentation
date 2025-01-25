=== Destuffing

The following gaves an example on the in section @sec:destuffing coverd destuffing function block.

#figure(
  image("../img/destuffing.png", width: 100%),
  caption: [destuffing example]
)<fig:destuffing_example>

@fig:destuffing_example shows a example where the destuffing logic has to mark a sample as a stuffbit.
It can be seen, that the destuffing logic holds state over the last sample and there values.
After reaching the state z4_s which is reached after 5 samples with a logical zero, the next state is bs_s,
which automatically set the stuffbit flag. This sample of a recessive bit is marked as a stuffbit.
Moreover it can be seen, that after the state bs_s, the state-machine dont trnasit to e0_s, insted it transit to e1_s, which is caused, because the stuffbit is also included to the destuffing algorithem.
