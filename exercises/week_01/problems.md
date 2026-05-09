# Week 1 — Exercises

> Quelle: README.adoc, README_Bevoelkerungsdaten.adoc, Loesung_Bevoelkerungsdaten.adoc

---

= Übung VoWo 01: Business Intelligence: Data Visualization: Modul Data Analytics (M_DatAna), Bachelor Informatik
Prof. Stefan Keller; Raphael Das Gupta
FS 2022
:lang: de

.Themen und Ziele:
* Das Thema dieser Übung ist die Datenvisualisierung und die Publikation von Datengrafiken
* Ziel ist es, eine (eigene) Geschäftsgrafik (Business Chart) zu erstellen und ein BI-Tool (Apache Superset) kennenzulernen, um Datenquellen auszuwählen, Geschäftsgrafiken und Dashboards zu erstellen und diese schliesslich im Web zu veröffentlichen.

.Verwendete Software:
* Browser.
* ChatGPT Plus und/oder Microsoft Copilot im Edge Browser.
* Tabellenkalkulationsprogramm MS Excel (oder LibreOffice Calc).
* (Als Vorbereitung für die nächsten Übungen ein PostgreSQL mit aktueller Version installieren).

.Zeitbudget:
* Eine Übungs-Doppelstunde plus Nachbereitung (wie üblich).

Der Ablauf dieser Übungen ist wie folgt:

. Zuerst soll in Aufgabe 1 in der Gruppe mittels Spreadsheet-Software oder mittels LLM eine passende Darstellung für den Datensatz "`Bevölkerungsdaten Schweiz`" erstellt werden.
  Anschliessend wird das Ergebnis analysiert und diskutiert.
. Dann soll in Aufgabe 2 das Dashboard-Tool Apache Superset kennengelernt werden mit den Grundbegriffen.
  Als Input ist eine Tabelle mit einer weltweiten Bevölkerungsstatistik vorgegeben.
. Schliesslich soll in Aufgabe 3 ein eigener Statistik-Datensatz gesucht werden, um ihn fachgerecht mit Apache Superset als Dashboard zu veröffentlichen.



== Aufgabe 1

Es sollen die "`Bevölkerungsdaten im Zeitvergleich, 1950-2024`" vom Bundesamt für Statistik (BfS) (Quelle: https://www.bfs.admin.ch/asset/de/36142050[www.bfs.admin.ch]) aufbereitet und in einer Geschäftsgrafik visualisiert werden. Konkret interessiert uns die zeitliche Entwicklung der "`ständigen Wohnbevölkerung`" sowie die deren Teilgruppe "`Ausländer`".

Wir bieten zwei Varianten dieser Übungsaufgabe an:

* mittels klassischer Spreadsheet-Software (z.B. Microsoft Excel oder LibreOffice Calc)
* mittels LLM-Chatbot (z.B. ChatGPT oder Microsoft Copilot)

Lösen Sie *mindesten eine* der beiden Varianten.

TIP: Wählen Sie die Variante, mit der Sie *weniger vertraut* sind, um _mehr dazuzulernen_.

[cols="1a,1a"]
|===

| mittels Spreadsheet-Software | mittels LLM

| // mittels Spreadsheet-Software
Bei dieser Aufgabe geht es darum, eine Business-Grafik fachgerecht zu erstellen -- mit Begündung der Wahl des Diagramms.

Starten Sie MS Excel (oder LibreOffice Calc), laden Sie die Datei.

Dann wählen Sie ein passendes Diagramm.

NOTE: Die Vorschläge und Defaults der Office-Programme sind nicht immer optimal!
Probieren Sie im Zweifelsfall verschiedene Varianten aus und vergleichen Sie diese miteinander.)

.Abschluss

* Speichern Sie das Ergebnis ab.
* Notieren Sie Ihre Begründung der Wahl des Diagramms.


| // mittels LLM
Bei dieser Aufgabe geht es darum, in einer Gruppenarbeit eine Geschäftsgrafik (Business Chart) mit Hilfe der erweiterten Funktionalität von ChatGPT oder Microsoft Copilot professionell zu erstellen -- mit anschliessender Bewertung und Reflexion des Ergebnisses.

.Vorbereitung: 

* Setzen Sie sich in Gruppen zusammen, sodass in jeder Gruppe mindestens eine Person Zugang zu ChatGPT Plus (ggf. Aktivierung des Plus Plans durch Übungsbetreuer) und Microsoft Copilot hat (Studenten der OST sollten Zugang zu Microsoft Copilot haben). 

.Tasks 1.1 -- Prompting (ca. 40 min.): 

* Lassen Sie sich mit Hilfe eines passenden Prompts von der GenAI erklären, welche Geschäftsgrafiken dargestellt werden können. 
* Anschliessend können Sie sich erklären lassen, welche Limitationen vorhanden sind.
* Laden Sie nun die Bevölkerungsdaten hoch und lassen Sie sich mithilfe eines entsprechenden Prompts ein passendes Diagramm erzeugen.
* Lassen Sie sich eine Begründung geben, warum diese Geschäftsgrafik gewählt wurde.
* Verbessern Sie das Resultat mit einem weiteren Prompt.

NOTE: Microsoft Copilot erlaubt Datei-Uploads nur auf der eigenen Website, daher sollten keine Integrationen oder dergleichen verwendet werden.

.Task 1.2 -- Diskussion (ca. 15 min.):

Diskutieren Sie nun zu zweit das Resultat: Hat das GenAI-Tool den besten Geschäftsgrafik-Typ gewählt? Ist das Resultat gut? Gibt es Prompt-Tricks? Müsste man es nachbarbeiten und wenn ja wie? Welche Limitationen hat das GenAI-Tool (als Zusammenfassung von dem was das Tool von sich sagt und von dem was Sie erlebt haben). Welches GenAI-Tool ist nun besser?

.Task 1.3 -- Abschluss mit Lieferobjekten (ca. 15 min.):

* Sichern Sie Geschäftsgrafik als Grafik (.PNG) 
* Lassen Sie die Geschäftsgrafik vom GenAI-Tool exportieren und zwar als Excel mit Geschäftsgrafik, oder LibreOffice Calc, oder als CSV.
* Notieren Sie die wichtigsen Prompts, die Sie gewählt haben. 
* Halten Sie die Erkentnisse der Diskussion (vgl. die Punkte oben) fest, im Umfang von max. einer A4-Seite (inkl. Grafik).    

|===

== Aufgabe 2

Bei dieser Aufgabe geht es um das Kennenlernen des BI-Tools Apache Superset.

.Vorbereitungen
* Starten Sie Apache Superset
+
--
.. _entweder_ (*empfohlen*) auf Ihrem eigenen Gerät mit Docker Compose
    (https://superset.apache.org/docs/quickstart[Anleitung])
.. _oder_ (als *Alternative*) auf einem von uns bereitgestellten Server https://coder.infs.ch/templates/dominicklinger/superset/workspace?mode=manual[per Coder]
--
+
NOTE: In beiden Varianten kann es etwas dauern, 
bis Superset ganz gestartet ist 
und samt Beispieldaten zur Verfügung steht.
* Öffnen Sie Apache Superset im Browser
Username:: `admin`
Password:: `admin`
* Öffnen Sie in einem weiteren Browserfenster folgendes Arbeitsblatt, das auf dem Lernportal OpenSchoolMaps publiziert wurde:
https://openschoolmaps.ch/pages/materialien.html#einfuehrung-in-apache-superset-1["`Einführung in Apache Superset: Ein Chart`"]
(https://openschoolmaps.ch/docs/lehrmittel/de/apache_superset/einfuehrung_in_apache_superset_one_chart.html[HTML],
https://openschoolmaps.ch/docs/lehrmittel/de/_exports/einfuehrung-in-apache-superset-one-chart.pdf[PDF])

Folgen Sie nun sorgfältig dem Arbeitsblatt "`Einführung in Apache Superset: Ein Chart`".
Als Input dient dort eine Datenbank-Tabelle mit einer Bevölkerungsstatistik weltweit.

.Abschluss
* Als Abschluss publizieren Sie Ihr Dashboard mit Chart.
* Dokumentieren Sie den Link zum Dashboard mit der Chart (Copy & Paste).



== Aufgabe 3

Bei dieser Aufgabe geht es darum, dass Sie ein Dashboard mit selber aufbereiteten Daten publizieren.

Dazu müssen Sie sich zuerst einen Statistik-Datensatz suchen! Der Datensatz muss nicht grösser als derjenige von Aufgabe 1 sein.
Er soll mindestens ein quantitatives Attribut (Skalenniveau Ordinal, Intervall, Ratio) enthalten.

Hier einige Tipps zu Datenquellen: BfS, Opendata.swiss oder Kt. Zürich mit Stichwörtern Covid-19, etc.

NOTE: Die Suche und Aufbereitung von strukturierten Daten (im CSV oder ähnlichem Format) kann anstrengend sein 😉.
In einer der nächsten Übungen wird das Thema "`Data Integration`" nochmals vertiefter behandelt.

Der weitere Ablauf ist dann wie gehabt -- mit einem Unterschied: Sie müssen die CSV-Datei in Apache Superset hochladen.
Wie das geht und was dabei beachtet werden muss, kann in diesem Arbeitsblatt
https://openschoolmaps.ch/pages/materialien.html#apache-superset-fuer-fortgeschrittene["`Apache Superset für Fortgeschrittene`"]
(https://openschoolmaps.ch/docs/lehrmittel/de/apache_superset/apache_superset_fuer_fortgeschrittene.html[HTML],
https://openschoolmaps.ch/docs/lehrmittel/de/_exports/apache-superset-fuer-fortgeschrittene.pdf[PDF])
nachgelesen werden.

.Abschluss
* Als Abschluss publizieren Sie Ihr Dashboard mit Chart.
* Dokumentieren Sie den Link zum Dashboard mit der Chart (Copy & Paste).
* Notieren Sie allfällige Verbesserungen des Arbeitsblatts sowie von Apache Superset (ggf. Issue erstellen).



== Musterlösungen

Es gibt keine "`mustergültige`" Lösung, da "`gute`" Lösungen individuell unterschiedlich sein.
Es gibt jedoch viele schlechte Lösungen -- besonders in der Visualisierung.

Eine gute Lösung von Aufgabe 1 mit Diagramm ist in der Datei
`Bevölkerungsdaten im Zeitvergleich, 1950-2024/je-d-01.01.01_Lösung.ods`.
Der entsprechende Lösungsweg ist beschrieben in
`Bevölkerungsdaten im Zeitvergleich, 1950-2024/Lösung.adoc`.

Eine Beispiellösung für Aufgabe 2 finden Sie
https://openschoolmaps.ch/pages/materialien.html#einfuehrung-in-apache-superset-1[auf OpenSchoolMaps]
(https://openschoolmaps.ch/docs/lehrmittel/de/apache_superset/einfuehrung_in_apache_superset_one_chart_loesung.html[HTML],
https://openschoolmaps.ch/docs/lehrmittel/de/_exports/einfuehrung-in-apache-superset-one-chart-loesung.pdf[PDF]).

.Tipps
[TIP]
--
* zur Datenaufbereitung in MS Excel: Copy & Paste mit Transponieren
--


---

= Bevölkerungsdaten im Zeitvergleich, 1950-2024

Quelle::
Herausgeber::: Bundesamt für Statistik
Titel::: Bevölkerungsdaten im Zeitvergleich, 1950-2024
Link zum Datensatz::: https://www.bfs.admin.ch/asset/de/36142050
Nutzungsbedingungen::: "`https://www.bfs.admin.ch/bfs/de/home/bfs/bundesamt-statistik/nutzungsbedingungen.html[OPEN-BY-ASK]`"{blank}footnote:[{blank}“Freie” Nutzung. Quellenangabe ist Pflicht. Kommerzielle Nutzung nur mit Bewilligung des Datenlieferanten zulässig.]
