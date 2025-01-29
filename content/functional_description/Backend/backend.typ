== WebApplication
_Jannis Gröger_

Die Webanwendung besteht aus drei Komponenten. ...
MCAP Logger ist auch dabei...

=== Backend
_Mario Wegmann_
==== Auswahl der Technologie <Backend_Auswahl_Technologie>
Am Anfang des Projekts wurden verschiedene Programmiersprachen und Frameworks für das Backend ausgetestet um eine geeignete Wahl für dieses Projekt zu treffen. 

===== Next.js in TypeScript
*Beschreibung:* Ein Fullstack Framework, welches auf React aufbaut und ermöglicht Backend und Frontend in einem zu schreiben. Unterstützt die Programmiersprachen JavaScript und TypeScript. 


*Vorteile:* Wurde von Teammitgliedern schon in vergangene Projekten genutzt, daher besteht hier bereits Erfahrung. Ebenso können Frontend und Backend mit der gleichen Programmiersprache und im gleichen Projekt geschrieben werden, womit doppelter Code vermieden wird. React ist ein beliebtes Framework für Frontendwebentwicklung.  


*Nachteile:* Das Backend wird in JavaScript bzw. TypeScript geschrieben, somit muss auf dem Server ein JavaScript Runtime Enviorment laufen um das Backend auszuführen. JavaScript ist jedoch eine interpretierte Programmiersprache und ist daher nicht so performant. 

===== Phoenix in Elixir
*Beschreibung:* Phoenix ist ein Webframework, welches in der Sprache Elixir geschrieben wird. Elixier wiederum baut auf der funktionalen Programmiersprache Erlang und der Erlang VM auf. 


*Vorteile:* In Elixir können Aufgaben leicht parallelsiert werden, da diese als Module strukturiert werden. Zusätzlich bietet die Modularisierung Stabilität, da in der Erlang VM Module automatisch neu gestartet werden, falls in diesen ein Fehler auftritt. 


*Nachteile:* Keine Erfahrung der Teammitglieder sowhol mit dem Framework, als auch mit der Programmiersprache. Steilerer Lernkurve, da funktionale Programmiersprachen statt objektorientierter Programmiersprache verwendet wird. Deutlich weniger Nutzung im Internet, als JavaScript, wodurch weniger Lernmaterial verfügbar ist. 

===== Go
*Beschreibung:* Go ist eine Programmiersprache, welche von Google entwickelt wurde und primär für Backend Entwicklung angedacht ist. Mit Go kommt auch eine umfangreiche Standardlibary mit, welche es ermöglicht ein einfaches Backend ohne Zusätzlich Frameworks zu erstellen. 

*Vorteile:* Go ist eine kompilierte Sprache und kann auf dem Server somit performant und ohne externe Abhängigkeiten laufen. 


*Nachteile:* Noch wenig Erfahrung im Team mit der Programmiersprache. 

Nach Tests mit allen drei Varianten haben wurde Go schlussendlich als Backend Lösung festgelegt. Entscheidende Faktoren waren dabei, dass das Go Backend kompiliert werden kann, wodurch die begrenzten CPU Ressourcen des SoC effizienter genutzt werden, als bei interpretierten Programmiersprachen. Zudem lässt sich nativ mit Go auf Syscalls zugreifen, was den Zugriff auf den CAN Socket erheblich vereinfacht. 

==== Funktion

Aufgrund der geringen Komplexität des Backends wurde das komplette Backend in einer Datei `main.go` verfasst. Es wird eine Library verwendet `Websocket`, welche eine Websockets in Go implementiert. Das Backend kann mit drei Parametern aufgerufen werden um das Verhalten zu ändern. So kann der Websocket Port mit `-port` angepasst werden. Mit `-debug` werden Debug Nachrichten auf der Komandozeile ausgegeben. Und mit `-interfaces` wird eine Liste der CAN Interfaces übergeben, auf denen die CAN Nachrichten ausgelesen werden sollen. Beim Start werden die Parameter geparsed und anschließend für jedes übergebene interface eine Goroutine gestartet, welche mithilfe von Syscalls kontinuierlich CAN Frames liest. Der Read Syscall ist dabei blockierend, wodurch die Routine erst weiter ausgeführt wird, wenn ein Frame gelesen wurde. Zudem wird ein Websocket-Server erstellt, welcher Websocket Anfragen annimmt und eine Liste aller verbundenen Clients vorhält. Ist ein CAN Frame erfolgreich ausgelesen, dann wird der Inhalt als JSON serialisiert und per Broadcast an alle verbundenen Clients über Websockets veröffentlicht. Die JSON enthält dabei die CAN Message ID, die Länge der Payload, die Payload selbst, ein Zeitstempel, wann der Frame ausgelesen wurde und auf welchen Interace der Frame gelesen wurde. Neben dem broadcasten der CAN Nachrichten ist das Backend auf für die Kontrolle des MCAP Loggers zuständig, es nimmt über HTTP Befehle vom Frontend entegen um den Logger zu konfigurieren und zu steuern. Des Weiteren stellt das Backend dem Frontend eine Übersicht über alle konfigurierten CAN Sockets zu Verfügung und ermöglicht dem Frontend das hochladen von .dbc und .yaml Dateien. 

==== Verwendung

Gestartet wird das Backend mit den passenden Parametern direkt auf der CLI. Es kann bei Bedarf auch in ein systemd-Dienst eingebaut werden um beim hochfahren automatisch gestartet zu werden. 


