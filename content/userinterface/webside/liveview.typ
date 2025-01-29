==== Subpage Liveview
_Mario Wegmann_

The Liveview page, which can be seen in @liveviewpage, consists of two halves. On the left side there is a sidebar and on the right side widgets can be freely placed in the Gridview. The sidebar itself is divided into two areas: the Grid Control and the DBC Control. 

#figure(
  image("../../../figures/liveviewpage.png", width: 100%),
  caption: [A screenshot of the Liveview page.]
)<liveviewpage>

===== Grid Control

The Grid Control shows whether there is a connection to the backend via websockets and allows you to control the behavior of the grid view with six buttons. The buttons are numbered in @gridcontrol for better understanding. For a more detailed analysis of the data, button no. 1 can be used to pause live updates of the CAN messages, so that no new incoming CAN messages are displayed. Button no. 2 can be used to re-establish the connection to the backend via Websockets if this has been interrupted. All previously received data can be deleted with button no. 3 to restart with empty widgets. It should be noted that only the last 10.000 CAN messages are currently reserved on a client so that the client's browser does not use too much memory. Button no. 4 can be used to save the currently created layout of the widgets in Gridview. The layout is stored in the browser's local storage and the name contains the currently selected CAN interface, so that one view per CAN interface and per browser is possible. Button no. 5 loads the layout saved in the local storage back into the gridview. Finally, button no. 6 can be used to delete the current widget layout. 

#figure(
  image("../../../figures/gridcontrol.png", width: 40%),
  caption: [A screenshot of the Grid Control component.]
)<gridcontrol>


===== DBC Control

If a .dbc file for the currently selected CAN interface is stored on the Settings page, it is parsed and displayed in DBC Control. The user thus has an overview of all messages and signals that are communicated on this CAN interface. If a signal is selected, a drop-down menu appears as shown in @dbccontrol. This can be used to select the type of widget with which the signal is to be visualized in the Gridview. In addition to individual signals, specific CAN messages and all CAN messages of the CAN interface can also be visualized. 

#figure(
  image("../../../figures/dbccontrol.png", width: 30%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<dbccontrol>

===== Widgets

Each widget has a title bar that shows which CAN message ID is currently displayed and what type of widget it is. By holding down the mouse button on the title bar, the widget can be moved freely in the Gridview. There is also a delete button to remove the widget and a resize button to adjust the size of the widget. 

\
*Number, Binary and Hex*

The three similar widget types can be recognized in @numberbinhexwidgets. All three show the current value of a signal. The name of the signal is displayed first, followed by the current value and the unit. Below this, the permitted range for the value and when the signal was last received is displayed. If a value is received that is outside the permitted range, the background of the widget turns red. 

#figure(
  image("../../../figures/numberbinhexwidgets.png", width: 100%),
  caption: [Number, Binary and Hex widget shown sidy by side.]
)<numberbinhexwidgets>

\
*Gauge*

The gauge widget, which can be recognized in @gaugewidget, displays the numerical value like the Number widget, but also visualizes a gauge so that the current value can be better assigned within the range. 

#figure(
  image("../../../figures/gaugewidget.png", width: 40%),
  caption: [Gauge widget with an value in range.]
)<gaugewidget>

\
*(Filtered) Table*

In addition to the currently received CAN message, the table widget also displays a history of previously received CAN messages. The payload is parsed with the .dbc and the signals of the CAN message are also output. In addition to the table with all CAN messages on the CAN interface, there is also a variant that is only filtered for one CAN message ID. The table widget can be recognized in @tablewidget. 

#figure(
  image("../../../figures/tablewidget.png", width: 100%),
  caption: [Table widget with all CAN messages.]
)<tablewidget>

\
*Line Chart*

In addition to the currently received value of a signal, the line chart widget also displays a history of previously received values. @linechartwidget shows the line chart widget. 

#figure(
  image("../../../figures/linechartwidget.png", width: 60%),
  caption: [A temperature curve visualized with the Line Chart widget.]
)<linechartwidget>

\
*Signals*

@signalswidget shows the signal widget, this widget displays the last received signals of a specific CAN message. 

#figure(
  image("../../../figures/signalswidget.png", width: 40%),
  caption: [The last receivced signals of a specific CAN message.]
)<signalswidget>

===== Gridview

If a widget for a signal or a CAN message has been selected in DBC Control, the widget appears in a free position in the grid view. The widgets can be freely arranged and resized within the Gridview. The Gridview automatically avoids the overlapping of widgets.