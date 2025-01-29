== Websockets
Jannis Gröger 

=== WebSocket Integration

In this project, WebSockets are utilized to provide real-time communication between the Go-based backend and the Next.js frontend. This setup enables the transmission of CAN frames from the server to the client, ensuring that users receive up-to-date information without the need for manual refreshes or continuous polling.

=== Backend Implementation

The backend server is developed in Go and uses the ``` gorilla/websocket``` package to manage WebSocket connections. The server reads CAN frames from the socketcan interface and transmits them to connected clients in real-time. Key components of the backend implementation include:

\
1.  Importing Necessary Packages:
With 

``` 
import (
    "log"
    "net/http"
    "github.vcom/gorilla/websocket"
) 
``` 

the important packages are imported in the project. The ``` log ``` package provides functions for error logging and informational messages, the ``` net/http ``` package is responsible for handling HTTP requests and responses and the ``` github.com/gorilla/websocket ``` package contains methods for Websocket implementation.

\
2. Setting up the Websocket upgrader  

To use a Websocket connection, a normal HTTP connection needs to be upgraded. The following function 