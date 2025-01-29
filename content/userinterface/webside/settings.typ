#import "/utils/todo.typ": *

== Settings
_Jannis Gröger_

\
The Settings page of this project as shown in @settingspage serves as a tool to manage CAN configurations, handle logger operations, and upload necessary configuration files. The page itself is split in two sections: Logger Control and File Upload. With the sections provided, users get an intuitive interface to control various aspects of the system, ensuring a easy interaction between the frontend and backend. 


#figure(
  image("../../../figures/settingspage.png"),
  caption: [A screenshot of the Settings page.]
)<settingspage>
\

=== Managing CAN Assignments and Logger Operations

In the Logger Control section, the user can view and modify CAN assignments. Each assignment consists of a CAN interface, e.g. can0 or can1, a DBC file, which defines the CAN signals of the CAN frames, and a YAML file, which contains the configuration for the socketcan mcap data logger - a CLI tool to log CAN data into .mcap files.

Users can create a new assignment by clicking the "New Assignment" button, which adds a new row to the assignment table. In each row, users can manually enter the CAN Socket and select the corresponding DBC and YAML files from dropdown menus. The dropdown menus show a list of the available files stored in the upload directory "/var/www" on the FPGA, so the user can easily assign a DBC file to a specific CAN socket. This DBC is then used in the Live View page to parse the incoming CAN Frames and present the data in a visually structured way. The user can also assign a YAML file to a can core so that the CLI logger specified to this can core can be controlled correctly. If an assignment is no longer needed, it can be removed by clicking the trash icon. To ensure changes are saved, users can click the "Save" button (save icon), storing all assignments as a JSON formatted file in the "/var/www/assignments" directory. This ensures that the assignments are saved permanently and other parts of the website can easily look up the assignments. 

Once assignments are set up, users can control the logging process with simple actions. Clicking the "Start" button (play icon) initiates the logger for a specific assignment, sending a request to the backend to begin recording data. Similarly, the "Stop" button (square icon) halts the logger, stopping the logging process on the server. In this regard the backend uses a tool to start or stop the logger over CLI as a new process. 

As users interact with the logger, they receive real-time feedback on its status, ensuring transparency in the logging process. If an error occurs, such as missing configuration files, the system notifies the user immediately.

=== Uploading and Managing Configuration Files

To configure the CAN assignments effectively, users first need to upload the required .dbc and .yaml files. This is handled in the File Upload section.

Users can select a file from their computer and click "Upload" to send it to the server. The system then processes the file and provides feedback on whether the upload was successful. The files are uploaded to the same directory the drop down menus read from "/var/www". So once uploaded, the files become available in the dropdown menus within the Logger Control section, allowing users to assign them to specific CAN interfaces.

To keep the file list up to date, the system periodically fetches the available files from the backend. This ensures that newly uploaded files appear in the selection menus directly after the upload without requiring a page refresh.