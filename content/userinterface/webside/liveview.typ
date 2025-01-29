==== Subpage LiveView
_Mario Wegmann_

Die Liveview Seite, welche in @liveviewpage ersichtlich ist, besteht aus zwei Hälften. Auf der linken Seite befindet sich eine Seitenleiste und auf der rechten Seite können im Gridview Widgets frei platziert werden. Die Seitenleiste selber ist wiederum in zwei Bereiche unterteilt dem Grid Control und dem DBC Control. 

#figure(
  image("../../../figures/liveviewpage.png", width: 100%),
  caption: [A screenshot of the Liveview page.]
)<liveviewpage>

===== Grid Control

Das Grid Control zeigt an, ob eine Verbindung zum Backend über Websockets besteht und ermöglicht mit sechs Knöpfen das Verhalten des Gridviews zu kontrollieren. Für eine bessere verständniss sind in @gridcontrol die Knöpfe nummeriert dargestellt. Für eine genauere Analyse der Daten kann mit dem Knopf Nr. 1 Live aktualisierung der CAN Nachrichten pausiert werden, somit werden keine neu eintreffenden CAN Nachrichten mehr angezeigt. Mit dem Knopf Nr. 2 kann die Verbindung über Websockets zum Backend neu aufgebaut werden, sollte diese einmal unterbrochen worden sein. Alle bisherigen empfangen Daten können mit dem Knopf Nr. 3 gelöscht werden um mit leeren Widgets neu zu starten. Hierbei sei angemerkt das derzeit nur die letzen 10.000 CAN Nachrichten auf einem Client vorbehalten werden, damit der Browser des Clients nicht zu viel Arbeitsspeicher belegt. Mit dem Knopf Nr. 4 kann das aktuell erstellte Layout der Widgets im Gridview abgespeichert werden. Das Layout wird dabei im Local storage vom Browser abgelegt und der Name enthält das aktuell ausgewählte CAN Interface, dadurch ist eine Ansicht pro CAN Interface und pro Browser möglich. Der Knopf Nr. 5 lädt das im local storage gespeicherte Layout wieder in die Gridview. Zuletzt kann mit Knopf Nr. 6 das aktuelle Widget Layout gelöscht werden. 

#figure(
  image("../../../figures/gridcontrol.png", width: 40%),
  caption: [A screenshot of the Grid Control component.]
)<gridcontrol>


===== DBC Control

Wenn auf der Settings Page eine .dbc Datei für das derzeit ausgewählte CAN Interface hinterlegt ist, dann wird diese in DBC Control geparsed und angezeigt. Der Benutzer hat somit eine Übersicht über alle Nachrichten und Signale, die auf diesem CAN Interface kommuniziert werden. Wird ein Signal ausgewählt, erscheint ein Dropdown Menü wie in @dbccontrol dargestellt. Damit kann ausgewählt werden mit welcher Art von Widget das Signal in der Gridview visualisiert werden soll. Neben einzelnen Signalen können auch CAN Messages, sowie alle CAN Messages des CAN Interface visualisert werden. 

#figure(
  image("../../../figures/dbccontrol.png", width: 30%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<dbccontrol>

===== Widgets

Jedes Widget hat eine Titelleiste, wo anzeigt welche CAN Message ID gerade dargestellt wird und um welche Art von Widget es sich handelt. Mit gedrückter Maustaste auf der Titelleiste kann das Widget frei in dem Gridview verschoben werden. Zusätzlich gibt es ein löschen Knopf um das Widget zu entfernen und ein Resize Knopf um die Größe des Widgets anzupassen. 

\
*Number, Binary and Hex*

In @numberbinhexwidgets sind die drei ähnliche Widgetarten erkennbar. Alle drei zeigen den aktuellen Wert eines Signals an. Dabei wird erst der Name des Signals angezeigt, gefolgt von dem aktuellen Wert und der Einheit. Darunter wird die Erlaubte Range für den Wert und wann das Signal das letze mal empfangen wurde. Wird ein Wert empfangen der  sich außerhalb erlaubten Range befindet färbt sich der Hintergrund des Widgets rot. 

#figure(
  image("../../../figures/numberbinhexwidgets.png", width: 100%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<numberbinhexwidgets>

\
*Gauge*

Das Gauge Widget, welches in @gaugewidget erkennbar ist, zeigt wie das Number Widget den Zahlenwert an, visualisert jedoch zusätzlich noch eine Gauge, damit der aktuelle Wert innerhalb der Range besser zugeordnet werden kann. 

#figure(
  image("../../../figures/gaugewidget.png", width: 40%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<gaugewidget>

\
*(Filtered) Table*

Das Table Widget zeigt neben der aktuell empfangen CAN Message auch eine Historie der zuvor empfangen CAN Messages an. Dabei wird die Payload mit der .dbc geparsed und die Signale der CAN Message ebenso ausgegeben. Neben der Tabelle mit allen CAN Nachrichten auf dem CAN Interface gibt es auch eine variante, die nur auf eine CAN Message ID gefiltert ist. Das Table Widget ist in @tablewidget erkennbar. 

#figure(
  image("../../../figures/tablewidget.png", width: 100%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<tablewidget>

\
*Line Chart*

Das Line Chart Widget zeigt neben dem aktuell empfangen Wert, eines Signals, auch eine Historie der zuvor empfangen Werte an. @linechartwidget zeigt das Line Chart Widget. 

#figure(
  image("../../../figures/linechartwidget.png", width: 60%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<linechartwidget>

\
*Signals*

In Abbildung @signalswidget ist das Signal Widget erkennbar, dieses Widget gibt die zuletzt empfangen Signale einer spezifischen CAN Message aus. 

#figure(
  image("../../../figures/signalswidget.png", width: 40%),
  caption: [A screenshot of the DBC Control component with widget selector.]
)<signalswidget>

===== Gridview

Wurde im DBC Control ein Widget für ein Signal oder eine CAN Message ausgewählt, dann taucht das Widget an einer freien Stelle im Gridview auf. Innerhalb des Gridview können die Widgets frei angeordnet und resized werden. Die Gridview vermeidet dabei automatisch das überlappen von Widgets. 