== CAN-Frame generator

=== Errors
To make the best use of the test bench, we need to implement the artificial creation of different error types.
What is important when integrating errors consciously is that after an error is implemented, the whole CAN frame changes.
What is meant by that is that the usual behavior in error case is that to send an error frame.
An error frame breaks the flow of the CAN message that was being sent, replacing it with an error frame.
When an error is detected, the node in CAN bus that detected the error goes into an error active state.
In an error active state, the node send a (primary) error flag, which consists of 6 dominant bits.
Depending on when exactly the other CAN bus nodes discover the error, the (secondary) error flag consists of
superpositoning of other nodes sending error flags, ranging from 0 to 6 additional dominant bits.
After the 6-12 dominant bits, there is an error delimiter being sent, which consists of 8 recessive bits.
TODO: explain from error active -> error passive -> bus offset
Types of errors we will test for are:
- Bit stuffing error: Node detects a sequence of 6 bits of the same logical level between the SOF and CRC
- Form error: Node detects a bit of an invalid logical level in the SOF/EOF fields or ACK/CRC delimiters
- ACK error: Node transmits a CAN message, but the ACK slot is not made dominant by receiver(s)
- CRC error: Node calculates a CAN message that differs from the transmitted CRC field value