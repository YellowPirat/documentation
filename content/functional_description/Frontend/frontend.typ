=== Frontend
_Mario Wegmann_

==== Auswahl der Technologie
In @Backend_Auswahl_Technologie wurden bereits die verschiedenen Webframeworks erwähnt, welche im Rahmen dieser Projektarbeit evaluiert wurden. Auch wenn Next.js nicht als Backend technologie ausgewählt wurde, bietet es sich dennoch an das Framework im Frontend zu verwende. Eines der Gründe ist unter anderem der modulare Aufbau mittels React Components. Diese Components werden in Dateien definiert und können in anderen Dateien wiederverwendet werden. Ein weitere Grund ist die Möglichkeit von Next.js das Projekt statisch zu exportieren. Bei diesem Prozess wird der Next.js Code, die Node.js Libraries und der eigenen TypeScript Code kompiliert und als Ergebniss .html-, .css- und .js-Dateien ausgegeben. Diese Dateien können dann auf einem Webserver abgelegt werden ohne das dieser TypeScript ausführen muss. Der Webserver muss somit jediglich die angefragten Dateien an die Clients ausliefern. Dadurch kann der SoC auf dem FPGA entlastet werden und sämtliches Frontend Processing läuft auf den Clients ab. 

Aufgrund der Komplexität der Visualisierung wurden folgenden Bibliotheken verwendet: 

- *TailwindCSS*: Ermöglicht CSS Formatierung mit HTML Code zu schreiben
- *Lucide-Reacts*: Eine Bibliothek mit SVG-Icons
- *shadcn/ui*: Bietet UI Components
- *Gridstack.js*: Bietet ein draggable Grid Layout System with
- *Recharts*: Ist eine Charting Library

==== Funktion



==== Verwendung


Implementierung
Vorgehensweise
Zusammenspiel der Komponenten
Warum wurden Entscheidungen getroffen