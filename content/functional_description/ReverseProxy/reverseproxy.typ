=== ReverseProxy
_Mario Wegmann_

Da die Webanwendung aus den zuvor beschriebenen verschiedenen Komponenten besteht wird ein Reverse Proxy benötigt, um diese unter einer URL zu vereinheitlichen. 

==== Auswahl der Technologie

===== Apache und Nginx
*Beschreibung:* Die bekanntesten ReverseProxys sind Apache und Nginx. 


*Vorteile:* Weit verbreitet 


*Nachteile:* Umständliche Konfigurationsdateien

===== Caddy
*Beschreibung:* Caddy ist ein Reverseproxy von der Firma ZeroSSL, welcher in Go geschrieben ist. 


*Vorteile:* Neben einer einfach zu lesenden Konfigurationsdatei, bietet Caddy weitere Funktionen an, welche die Aufgaben eines reinen Reverseproxy übersteigend. So ermöglicht Caddy unter anderem das automatische beantragen von SSL Zertifikaten über ACME Provider, einen integrierten Fileserver und die Möglichkeit die Konfigurationsdatei live neu zu laden, ohne den Caddy Servie neu starten zu müssen. 


*Nachteile:* Caddy ist nicht so weit verbreitet wie Apache oder Nginx. 

==== Konfiguration

Alle anfragen an die Web Application gehen über Port 80 (HTTP) auf den Caddy Reverseproxy. HTTPs wird in diesem Projekt nicht verwendet, da der FPGA nicht über eine öffentliche Domain erreichbar ist und somit kein SSL Zertifikat erstellt werden kann. Die simple Konfiguration besteht aus zwei Komponenten. Anfragen mit dem Pfad `/ws` Beginnen werden auf Port 8080 weitergeleitet, wo das Go Backend diese entgegennimmt. Unter diesem Pfad befindet sich somit die Werbindung von Client und Server über Websocket. Alle restlichen Anfragen werden als Dateianfragen betrachtet. Hierbei wird der Caddy Fileserver verwendet, welcher im Systempfad /var/www nach den passenden Dateien sucht. Dies können unter anderem die .HTML, .CSS und .js Dateien, welche das Frontend bilden sein, oder die .dbc und .json Dateien, die vom Server geladen werden sollen. 

Die Konfiguration wird in der Standard Konfigurationsdatei `/etc/caddy/Caddyfile` hinterlegt und Caddy wird als Dienst im Hintergrund ausgeführt. 

TODO Grafik einfügen