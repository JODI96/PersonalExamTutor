# Week 3 — Solutions (detailliert)

---

== Lösungen

=== Aufgabe 1 — Raumanalyse Vektordaten: Autobahn (OpenSchoolMaps-Arbeitsblatt)

#let note(body) = block(fill: luma(230), inset: 8pt, radius: 4pt, body)

> *Hinweis:* Das OpenSchoolMaps-Arbeitsblatt „Raumanalyse Vektordaten – Autobahn" führt durch eine vollständige GIS-Analyse mit QGIS. Die folgende Lösung dokumentiert jeden Arbeitsschritt mit der Terminologie aus der Vorlesung (EVAP-Modell, Ebenenprinzip, Vektor-Geodaten, Koordinatenreferenzsysteme).

---

==== Teil 1 — Vorbereitung: Daten beschaffen und laden (EVAP: Erfassung & Verwaltung)

*Schritt 1 —* Benötigte Datensätze identifizieren

Um die Raumanalyse durchzuführen, benötigen wir Vektor-Geodaten (vgl. Vorlesung: „Geometrische Datentypen – Punktkoordinaten, Linien und Flächen"). Für die Autobahn-Analyse sind folgende Layer erforderlich:

- *Autobahnen* (Geometrietyp: `LineString` / Liniendaten)
- *Kantone Schweiz* (Geometrietyp: `Polygon` / Flächendaten)
- *Ortschaften / Gemeinden* (Geometrietyp: `Point` oder `Polygon`)

Diese Daten stehen als GeoPackage (`.gpkg`) oder Shapefile (`.shp`) auf OpenSchoolMaps bereit. Gemäss Vorlesung ist GeoPackage dem veralteten Shapefile vorzuziehen:

$ "GeoPackage (.gpkg)" = "SQLite-Datenbank + Geometrie + Sachdaten (in einer Datei)" $

*Schritt 2 —* QGIS starten und ein neues Projekt anlegen

Man öffnet QGIS Desktop (Open-Source-GIS, GPL-Lizenz, vgl. Vorlesung) und erstellt ein neues Projekt über `Projekt → Neu`. Dies entspricht dem GIS-Basissystem („Werkzeugkasten") aus der Vorlesungs-Architektur:

$ "GIS-Architektur" = "Basissystem (Werkzeugkasten)" + "Applikation (Fachschale)" $

*Schritt 3 —* Koordinatenreferenzsystem (KRS) des Projekts festlegen

Gemäss Vorlesung verwenden Schweizer Geodaten typischerweise das *CHLV95* mit EPSG-Code 2056. Man setzt das Projekt-KRS auf:

$ "EPSG:2056" = "CHLV95 (Schweizer Landesvermessung 1995)" $

Der Weg in QGIS: `Projekt → Eigenschaften → KBS → EPSG:2056 suchen und auswählen`.

*Schritt 4 —* Datenlayer in QGIS laden

Man lädt die heruntergeladenen Dateien via `Layer → Layer hinzufügen → Vektorlayer hinzufügen`. Jeder geladene Datensatz erscheint als eigener *Layer* im Layer-Panel. Dies entspricht dem *Ebenenprinzip* aus der Vorlesung:

$ "GIS-Ebenenprinzip:" quad "BEVÖLKERUNG" | "AUTOBAHNEN" | "KANTONE" | "GEMEINDEN" $

Koordinaten ermöglichen dabei den Lagevergleich zwischen den unabhängigen Layern (vertikale Kombination).

---

==== Teil 2 — Exploration: Attributdaten und Geometrie inspizieren (EVAP: Analyse)

*Schritt 5 —* Attributtabelle des Autobahn-Layers öffnen

Man klickt mit Rechtsklick auf den Autobahn-Layer → `Attributtabelle öffnen`. Gemäss dem Vorlesungsmodell enthält jede Geodaten-Tabelle (auch „Feature Class" genannt):

- Genau *ein Geometrie-Attribut* (hier: `LineString`-Geometrie der Autobahn)
- Beliebig viele *Sachdaten/Attributdaten* (z.B. `name`, `ref`, `highway`)

*Schritt 6 —* Geometrietypen identifizieren

Man prüft den Geometrietyp jedes Layers in den Layer-Eigenschaften (`Rechtsklick → Eigenschaften → Information`). Die Vorlesung unterscheidet:

$ "Punkt" quad arrow.r quad "z.B. Raststätten, Auffahrten" $
$ "Linie (LineString)" quad arrow.r quad "z.B. Autobahnabschnitte" $
$ "Polygon" quad arrow.r quad "z.B. Kantonsflächen, Pufferzonen" $

*Schritt 7 —* KRS der einzelnen Layer prüfen

Alle Layer müssen dasselbe KRS verwenden, damit der räumliche Lagevergleich (Ebenenprinzip) korrekt funktioniert. Falls ein Layer in WGS84 (EPSG:4326) vorliegt, muss er transformiert werden:

$ "ST_Transform(geom, 2056)" quad arrow.r quad "Transformation von WGS84 nach CHLV95" $

In QGIS: `Vektor → Datenmanagement-Werkzeuge → Layer umprojizieren`.

---

==== Teil 3 — Räumliche Analyse: Puffer und Verschneidung

*Schritt 8 —* Pufferzone um Autobahnen erstellen (Buffer-Analyse)

Die *Puffer-Analyse* ist eine klassische Vektor-Raumanalyse. Sie erzeugt aus einem Linien-Layer einen Polygon-Layer mit definiertem Abstand. Für die Autobahn-Analyse wird typischerweise ein Puffer von 500 m oder 1000 m verwendet:

$ "Puffer" = "Geometrische Menge aller Punkte" P "mit" d(P, "Autobahn") <= r $

In QGIS: `Vektor → Geoverarbeitungswerkzeuge → Puffer`

- Input-Layer: Autobahn-Layer (LineString)
- Abstand: z.B. `1000` Meter (bei EPSG:2056 metrisch!)
- Ergebnis: neuer Polygon-Layer „Autobahn_Puffer_1000m"

*Wichtig:* Da wir EPSG:2056 (kartesisch-metrisch) verwenden, ist der Puffer-Abstand direkt in Metern angegeben. Bei WGS84 (EPSG:4326) wären die Einheiten Grad – ein häufiger Fehler.

*Schritt 9 —* Verschneidung (Spatial Join / Intersection)

Der *räumliche Join* ist das Kernprinzip der Vorlesung: „Koordinaten stellen einen grundsätzlich neuen Beziehungstyp dar, der das Kombinieren von Themen erlaubt." Man verschneidet den Puffer-Layer mit dem Gemeinde-Layer, um herauszufinden, welche Gemeinden im 1000-m-Korridor der Autobahn liegen:

$ "Spatial Join:" quad "Puffer" sect "Gemeinden" arrow.r "Gemeinden_im_Autobahn_Korridor" $

In QGIS: `Vektor → Geoverarbeitungswerkzeuge → Verschneiden (Intersection)`

- Input-Layer: Gemeinden-Polygon-Layer
- Overlay-Layer: Autobahn_Puffer_1000m
- Ergebnis: Nur die Gemeinden (oder Teile davon), die innerhalb des Puffers liegen

*Schritt 10 —* Flächen berechnen

Nach der Verschneidung berechnet man die Fläche der betroffenen Gemeindeteile. In QGIS über `Feldrechner` mit dem Ausdruck:

$ dollar.basic"area" = "$area" quad "(automatisch in m²  bei EPSG:2056)" $

Umrechnung:

$ A ["km"²] = frac(A ["m"²], 1'000'000) $

---

==== Teil 4 — Selektion und Filterung

*Schritt 11 —* Objekte nach Attribut selektieren

Man selektiert z.B. nur die Autobahn A1 über eine Attribut-Abfrage. Dies entspricht dem SQL-Filter aus der Vorlesung (PostPASS-Demo):

$ "SELECT * FROM autobahnen WHERE ref = 'A1'" $

In QGIS: `Layer → Objekte auswählen → Objekte nach Ausdruck auswählen` mit dem Ausdruck `"ref" = 'A1'`.

*Schritt 12 —* Räumliche Selektion (Select by Location)

Man selektiert alle Gemeinden, die den Autobahn-Puffer *berühren oder schneiden*. Dies ist ein klassischer räumlicher Filter:

$ "Räumliche Selektion:" quad "Gemeinde" in "Ergebnis" arrow.l.r "Gemeinde" sect "Puffer" eq.not emptyset $

In QGIS: `Vektor → Forschungswerkzeuge → Nach Position selektieren`

- Selektiere Objekte aus: Gemeinden
- Die folgende Bedingung erfüllen: `schneiden`
- Durch Vergleich mit: Autobahn_Puffer

---

==== Teil 5 — Präsentation: Kartografische Darstellung (EVAP: Präsentation)

*Schritt 13 —* Symbolisierung der Layer festlegen

Gemäss der Vorlesung gilt das *„Grafik-View-Prinzip"*: Daten sind grafiklos gespeichert; die Grafik wird real-time aus der Geodatenbank extrahiert und gerendert. Man definiert das Styling:

- Autobahn-Layer: Liniengeometrie, Breite 1,5 mm, Farbe Blau
- Puffer-Layer: Füllung transparent mit rotem Rand, Transparenz 50 %
- Gemeinden-Layer: Füllung hellgrau, Rand dunkelgrau

*Schritt 14 —* Massstabsabhängige Darstellung konfigurieren

Die Vorlesung erklärt den „GIS-Zoom" und die massstabsabhängige Darstellung. In QGIS setzt man Sichtbarkeitsskalen:

- Ortsnamen-Beschriftungen: nur sichtbar bei Massstab `> 1:100'000`
- Detaillierte Gemeindegrenzen: nur sichtbar bei `> 1:50'000`

In QGIS: `Layer-Eigenschaften → Darstellung → Skalierungsabhängige Sichtbarkeit`

*Schritt 15 —* Drucklayout erstellen

Man erstellt ein Drucklayout mit Karte, Legende, Massstabsleiste und Nordpfeil:

`Projekt → Neues Drucklayout`

Pflichtbestandteile einer kartografischen Darstellung:
- *Kartenrahmen* mit der Hauptkarte
- *Legende* (Erklärung der Signaturen)
- *Massstabsleiste* (z.B. 0 – 10 – 20 km)
- *Nordpfeil*
- *Titel* und *Datenquelle / Copyright*

---

==== Zusammenfassung der Analysekette

*Ergebnis:* Die vollständige Raumanalyse folgt dem EVAP-Prinzip aus der Vorlesung:

$ underbrace("Daten laden", "Erfassung") arrow.r underbrace("KRS prüfen / transformieren", "Verwaltung") arrow.r underbrace("Puffer + Verschneidung + Selektion", "Analyse") arrow.r underbrace("Drucklayout", "Präsentation") $

Die Analyse demonstriert das zentrale GIS-Prinzip: Der *Raumbezug als universeller Fremdschlüssel* erlaubt die Kombination unabhängiger Datenlayer (Autobahnen, Gemeinden, Kantone) ohne explizite Tabellenverknüpfung — allein durch ihre gemeinsamen Koordinaten im selben KRS (EPSG:2056).