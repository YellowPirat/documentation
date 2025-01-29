== Logging

For logging incoming CAN messages, a SocketCAN-based data logger was developed.
This logger is called socketcan_mcap_logger.
Its task is to receive incoming CAN messages and log them to a log file.
The chosen log file format is MCAP, which was developed by Foxglove and is the
primary log format in ROS2. It offers many features, especially those that
enhance consistency, which is crucial in robotics applications.

Moreover, MCAP comes with useful visualization tools such as PlotJuggler and
Foxglove Studio, which improve data analysis.
@fig:socket_can_mcap_logger_struct illustrates the logger's implementation.

#figure(
image("img/socketCANMcapLogger.drawio.png", width: 100%),
caption: [SocketCAN MCAP Logger structure]
)<fig:socket_can_mcap_logger_struct>

A global configuration file is used to set up the logger during startup.
This configuration file contains information about the SocketCAN channels to log:

    Socket name
    DBC file name
    Log file name
    Receiver IP for UDP transmission
    Receiver port for UDP transmission
    Flags for enabling MCAP and UDP logging
    Messages from the DBC file that should be ignored

Based on the configuration file, the logger reads data from SocketCAN asynchronously.
The incoming raw CAN frames are then decoded based on the provided .dbc file.
The decoded frames are subsequently transformed into Protocol Buffers (protobuf).
These protobuf messages are dynamically generated from the .dbc file.
Thus, they can be stored as dynamically created MCAP messages or published via UDP
to a defined destination. The logger creates a separate .mcap file for each
SocketCAN channel.

The reason for encoding into Protocol Buffers is that MCAP allows storing the
protobuf definitions for the logged data (which is based on the .dbc file).
Unlike logging formats such as .blf (Binary Logging File), there is no need to
provide message definitions separately for later data analysis, as everything is
contained within a single file.

Moreover, the data size is only slightly larger than that of a .blf file.