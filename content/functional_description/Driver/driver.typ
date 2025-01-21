== Driver

The driver provides the interface between the hardware CAN core and the Linux networking stack. The implementation follows the Linux kernel's New API (NAPI) model for network device polling.

=== Initialization

The initialization phase is critical for establishing proper communication with the hardware. During initialization, the driver performs memory mapping of the hardware registers and configures the network device interface. Each CAN core is allocated a 4KB memory region, accessed through memory-mapped I/O.

The driver supports two fixed bitrates: 500 kbit/s and 1 Mbit/s. One of these rates must be configured before the device can be enabled. The bitrate configuration sets specific timing parameters in the hardware:

For 500 kbit/s:
- Propagation Segment: 5
- Phase Segment 1: 7
- Phase Segment 2: 7
- Prescaler: 4

For 1 Mbit/s:
- Propagation Segment: 2
- Phase Segment 1: 4
- Phase Segment 2: 3
- Prescaler: 4

=== Processing Flow

The driver implements a state-based processing system as illustrated in @kernel-module-state Frame processing begins with checking the buffer usage register (REG_STATUS_BUFFER), which indicates the number of complete CAN frames available in the hardware FIFO.

#figure(
  image("../../../figures/kernel_module_state.png", height: 6in),
  caption: "Kernel Module State Diagram"
) <kernel-module-state>

=== Register Access

When a frame is available, the driver performs a synchronized read sequence of all frame-related registers. Register access is protected by a spinlock to prevent concurrent access issues with the AXI bus. The register read sequence follows a specific order:

+ Status registers for error detection
+ Frame type register for error classification
+ 64-bit timestamp registers
+ CAN ID and frame format registers
+ Data length code (DLC) register
+ CRC register
+ 64-bit data registers

=== Frame Processing

After reading the registers, the frame processing state examines the frame type register for any error flags and processes frames accordingly. When no errors are detected, the driver proceeds with frame processing in several stages.

The timestamp processing begins by combining the 64-bit hardware timestamp counter value with the system's boot time stored during initialization. The hardware provides timing in microseconds since driver initialization, which the driver converts to the standard kernel time format by adding the stored boot time offset. This generates an absolute timestamp that allows accurate tracking of frame reception times within the system.

Following timestamp processing, the driver then copies the frame data from the hardware's 64-bit data registers into a newly allocated socket buffer, maintaining proper byte ordering to ensure compatibility with the networking stack's requirements.

Finally, the processed frame is prepared for delivery to the networking stack. The driver constructs a standard socket buffer (sk_buff) structure containing the CAN frame data, timestamp, and frame format information. This structure provides all necessary information for the Linux networking stack to handle the frame appropriately.

=== Error Handling

When an error is detected, the driver creates a CAN error frame with appropriate error flags and information. Error reporting implements rate limiting to prevent excessive logging under poor bus conditions. The driver maintains separate counters for each error type.

=== Timer Operation

The entire process operates on a 5-millisecond timer cycle implemented through the standard kernel timer interface. If no frames are available for processing, the driver enters a wait state and reschedules the timer. This polling mechanism ensures regular checking of the hardware buffer while maintaining system responsiveness.