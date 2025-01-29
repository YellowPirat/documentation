== Webapplication
_Jannis Gröger_

The application itself consists of three parts: the backend, the frontend and a reverse proxy which together are making it able for the user to see the CAN data and manage different settings. To actually log the data shown in the website, this project makes use of a CLI tool called socketcan_mcap_logger. This logger is not part of the actual project, but connected closely since our project can control this specific logger. The following paragraphs focus on the three parts of the project and explain the selection of each technology, what the function of the technology is and how it is used in this project.

=== Backend
_Mario Wegmann_
==== Selection of the technology <backend_selection_technology>
At the beginning of the project, various programming languages and frameworks for the backend were tested in order to make a suitable choice for this project. 

===== Next.js in TypeScript
*Description:* A fullstack framework that builds on React and enables backend and frontend to be written in one. Supports the programming languages JavaScript and TypeScript. 


*Advantages:* Has already been used by team members in past projects, so there is already experience here. Frontend and backend can also be written with the same programming language and in the same project, which avoids duplicate code. React is a popular framework for frontend web development.  


*Disadvantages:* The backend is written in JavaScript or TypeScript, so a JavaScript runtime environment must be running on the server to execute the backend. However, JavaScript is an interpreted programming language and is therefore not as performant. 


===== Phoenix in Elixir
*Description:* Phoenix is a web framework written in the Elixir language. Elixir in turn is based on the functional programming language Erlang and the Erlang VM. 


*Advantages:* In Elixir, tasks can be easily parallelized as they are structured as modules. In addition, modularization offers stability, as modules are automatically restarted in the Erlang VM if an error occurs in them. 


*Disadvantages:* No experience of the team members with either the framework or the programming language. Steeper learning curve, as functional programming languages are used instead of object-oriented programming languages. Significantly less use on the Internet than JavaScript, which means that less learning material is available. 

===== Go
*Description:* Go is a programming language that was developed by Google and is primarily intended for backend development. Go also comes with an extensive standard library, which makes it possible to create a simple backend without additional frameworks. 

*Advantages:* Go is a compiled language and can therefore run on the server with high performance and without external dependencies. 


*Disadvantages:* Still little experience in the team with the programming language. 


After testing all three variants, Go was finally chosen as the backend solution. Decisive factors were that the Go backend can be compiled, which means that the limited CPU resources of the SoC are used more efficiently than with interpreted programming languages. In addition, syscalls can be accessed natively with Go, which considerably simplifies access to the CAN interfaces over sockets. 

==== Function

Due to the low complexity of the backend, the complete backend was written in a `main.go` file. A library `Websocket` is used, which implements a websocket in Go. The backend can be called with three parameters to change the behavior. The Websocket port can be adjusted with `-port`. Debug messages are output to the command line with `-debug`. And `-interfaces` is used to pass a list of CAN interfaces on which the CAN messages are to be read. At startup, the parameters are parsed and then a goroutine is started for each interface passed, which continuously reads CAN frames using syscalls. The read syscall is blocking, which means that the routine is only executed once a frame has been read. A web socket server is also created, which accepts Websocket requests and keeps a list of all connected clients. Once a CAN frame has been successfully read, the content is serialized as JSON and published via broadcast to all connected clients via web sockets. The JSON contains the CAN message ID, the length of the payload, the payload itself, a time stamp, when the frame was read and on which interface the frame was read. In addition to broadcasting the CAN messages, the backend is also responsible for controlling the MCAP logger; it receives commands from the frontend via HTTP to configure and control the logger. Furthermore, the backend provides the frontend with an overview of all configured CAN sockets and enables the frontend to upload .dbc and .yaml files. 

==== Usage

The backend is started directly on the CLI with the appropriate parameters. If required, it can also be built into a systemd service to be started automatically while booting. 


