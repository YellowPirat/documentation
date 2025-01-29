=== Frontend

==== Selection of technology
_Mario Wegmann_

The various web frameworks that were evaluated as part of this project were already mentioned in @backend_selection_technology. Even if Next.js was not selected as the backend technology, it still makes sense to use the framework in the frontend. One of the reasons for this is the modular structure using React components. These components are defined in files and can be reused in other files. Another reason is the possibility of Next.js to export the project statically. In this process, the Next.js code, the libraries and the projects TypeScript code are compiled and .html, .css and .js files are output as a result. These files can then be stored on a web server without it having to execute JavaScript. The web server only has to deliver the requested files to the clients. This reduces the load on the SoC on the FPGA and all front-end processing runs on the clients. 

Due to the complexity of the visualization, the following React libraries were used: 

- *TailwindCSS*: Enables CSS formatting to be written with HTML
- *Lucide-Reacts*: A library with SVG icons
- *shadcn/ui*: Provides UI components
- *Gridstack.js*: Provides a draggable grid layout system
- *Recharts*: Is a charting library


==== Functionality
_Jannis Gröger_

\
The Frontend itself communicates via WebSockets and HTTP with the backend to ensure live updates of the incoming CAN frames and calls different API methods for example to handle file uploads or get the .dbc file to parse the CAN frames. It also provides the UI for the user to actually see the read CAN data and to manage the files and control the CLI logger. 

==== Usage

The compiled files of the frontend must be located in the `/var/www` directory on the FPGA. After starting the backend, the website can be accessed via `http://<IP_of_the_FPGA_SoC/` in the webbrowser.