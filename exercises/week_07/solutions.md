# Week 7 — Solutions (detailliert)

---

== Lösungen

=== Aufgabe 1 — Daten sichten, bereinigen und integrieren mit OpenRefine

#block[
*Vorbemerkung:* OpenRefine ist laut Vorlesung ein Desktop-Tool zum Sichten (Explorieren), Bereinigen, Integrieren und Anreichern von Daten. Es arbeitet RAM-basiert, verändert niemals die Quelldaten direkt und kennt keine Datentypen für Kolonnen – ausser man weist sie explizit zu. Die folgenden Schritte decken den vollständigen ETL-Prozess (hier primär den *Transform*-Schritt) ab, wie er in der Vorlesung beschrieben wurde.
]

---

==== Teil 1 — OpenRefine installieren und starten

*Schritt 1 —* Installation prüfen bzw. durchführen, damit das Werkzeug zur Verfügung steht.

OpenRefine ist eine Java-Applikation und wird von https://openrefine.org heruntergeladen. Nach dem Entpacken wird OpenRefine durch Doppelklick auf `openrefine.exe` (Windows) bzw. `./refine` (Linux/Mac) gestartet. Der Browser öffnet sich automatisch unter `http://127.0.0.1:3333`.

*Schritt 2 —* Sicherstellen, dass Java (mind. Version 11) installiert ist, da OpenRefine auf der JVM läuft.

```
java -version
```

*Ergebnis:* OpenRefine läuft lokal im Browser und ist bereit für den Datenimport (den *Extract*-Schritt des ETL-Prozesses).

---

==== Teil 2 — Daten importieren (Extract-Schritt)

*Schritt 1 —* Das Arbeitsblatt gibt vor, einen Datensatz von OpenStreetMap-Sitzbänken (oder ähnliche offene Daten) zu verwenden. Die Quelldaten werden heruntergeladen (z. B. als CSV oder JSON vom OpenSchoolMaps-Portal).

*Schritt 2 —* In OpenRefine auf «Create Project» → «This Computer» → «Choose Files» klicken und die heruntergeladene Datei auswählen. Dies entspricht dem *Extract*-Schritt im ETL-Prozess: Selektion eines Ausschnitts der Daten aus den Quellen und Bereitstellung.

*Schritt 3 —* In der Vorschau (Preview) prüfen:
- Zeichenkodierung: UTF-8 auswählen (Vorlesung: technisch-strukturelle Heterogenität – Kodierung)
- Trennzeichen: Komma (`,`) für CSV-Dateien einstellen
- Erste Zeile als Spaltennamen (Header) aktivieren

*Schritt 4 —* Projektnamen vergeben (z. B. `sitzbänke_integration`) und auf «Create Project» klicken.

*Ergebnis:* Die Rohdaten sind in OpenRefine geladen und werden tabellarisch dargestellt. OpenRefine hat den Extract-Schritt abgeschlossen; die Daten liegen nun im RAM-basierten Arbeitsbereich (Staging Area) vor.

---

==== Teil 3 — Daten sichten und erkunden

*Schritt 1 —* Gesamtanzahl der Zeilen ablesen (oben links, z. B. «2'341 rows»), um einen ersten Überblick über den Datensatz zu bekommen.

*Schritt 2 —* Mittels «Facet» → «Text Facet» auf relevanten Spalten (z. B. `material`, `colour`, `backrest`) die Werteverteilung analysieren. Dies entspricht der Datenbereinigungsfunktion aus der Vorlesung: Erkennen von Duplikaten, ungültigen oder fehlenden Werten.

*Schritt 3 —* «Facet» → «Customized Facets» → «Facet by blank» auf jeder Spalte anwenden, um fehlende Werte (NULL-Werte) zu identifizieren. In der Vorlesungsterminologie handelt es sich um *Datenfehler* gemäss der Klassifikation (fehlende/unkorrekte Daten).

*Schritt 4 —* Den «Text Facet» auf der Spalte `backrest` (Rückenlehne: yes/no) öffnen und alle unterschiedlichen Schreibweisen notieren, z. B.:

```
yes, Yes, YES, y, no, No, NO, n, (leer)
```

Dies zeigt *Datenkonflikte* im Sinne der Vorlesung: unterschiedlich codierte Aufzählwert-Werte und unterschiedliche Aufzählwert-Ausdrücke.

*Ergebnis:* Es wurden Heterogenitäten identifiziert — insbesondere *Datenkonflikte* (unterschiedliche Schreibweisen) und fehlende Werte — die im nächsten Schritt bereinigt werden.

---

==== Teil 4 — Daten bereinigen: Duplikate entfernen (Deduplizierung)

*Schritt 1 —* Auf der Spalte mit dem eindeutigen Schlüssel (z. B. `@id` oder `osm_id`) einen «Text Facet» öffnen, um doppelte Einträge sichtbar zu machen. Deduplizierung ist laut Vorlesung eine der zentralen Transformations-Funktionen.

*Schritt 2 —* «Sort» auf der Schlüsselspalte anwenden: Spaltenmenü → «Sort…» → «text» → «a-z». Damit werden identische Werte nebeneinander angeordnet.

*Schritt 3 —* Im Menü oben «Sort» → «Reorder rows permanently» wählen, damit die Sortierung dauerhaft übernommen wird.

*Schritt 4 —* Spaltenmenü → «Edit cells» → «Blank down» anwenden. Dadurch werden in aufeinanderfolgenden identischen Werten alle ausser dem ersten geleert.

*Schritt 5 —* «Facet» → «Customized Facets» → «Facet by blank» auf der Schlüsselspalte anwenden und alle *leeren* (d. h. doppelten) Zeilen selektieren.

*Schritt 6 —* «All» → «Edit rows» → «Remove matching rows» klicken, um die Duplikate zu entfernen.

*Ergebnis:* Jede Zeile im Datensatz ist nun eindeutig identifiziert. Die Deduplizierung — eine der Transformationsfunktionen aus der Vorlesung («Identifizieren und Entfernen doppelter Datensätze, um die Eindeutigkeit der Daten zu gewährleisten») — ist abgeschlossen.

---

==== Teil 5 — Daten bereinigen: Inkonsistente Werte vereinheitlichen

*Schritt 1 —* Text Facet auf der Spalte `backrest` öffnen, um alle Varianten der Werte zu sehen. Dies adressiert den *Beschreibungskonflikt* (unterschiedliche Werte desselben Attributs) aus der Vorlesungsklassifikation.

*Schritt 2 —* Im Facet-Bereich auf «Cluster» klicken. OpenRefine bietet verschiedene Clustering-Methoden an:
- *key collision* (schnell, für offensichtliche Varianten)
- *nearest neighbour* (für ähnliche, aber nicht identische Strings)

*Schritt 3 —* Methode «key collision» mit Funktion «fingerprint» auswählen. OpenRefine schlägt Cluster vor, z. B.:

```
Cluster: {yes, Yes, YES, y} → Zielwert: "yes"
Cluster: {no, No, NO, n}   → Zielwert: "no"
```

*Schritt 4 —* Für jeden Cluster den gewünschten Zielwert in «New Cell Value» eintragen (z. B. `yes` bzw. `no`) und «Merge Selected & Re-Cluster» klicken. Dies entspricht der *Kodierung und Dekodierung* (Umwandlung von Datenformaten, Klassifizierung) aus der Vorlesung.

*Schritt 5 —* Verbleibende Einzelfälle manuell im Text Facet durch Klick auf den Wert und «Edit» korrigieren.

*Ergebnis:* Die Spalte `backrest` enthält nun ausschliesslich die normierten Werte `yes`, `no` und ggf. leere Felder. Die *String-Operationen* (Gross-/Kleinschreibung vereinheitlichen) sind abgeschlossen.

---

==== Teil 6 — Daten bereinigen: Fehlende Werte behandeln

*Schritt 1 —* «Facet by blank» auf relevanten Spalten anwenden, um den Anteil fehlender Werte zu quantifizieren. Laut Vorlesung gehört der «Umgang mit fehlenden Daten» zu den Transformationsfunktionen (Imputation oder Markierung).

*Schritt 2 —* Entscheiden, welche Strategie angewendet wird:
- *Option A (Markieren):* Leere Zellen mit einem Platzhalterwert befüllen, z. B. `unknown`. Spaltenmenü → «Edit cells» → «Fill down» (nur wenn sinnvoll) oder «Transform…» mit GREL-Ausdruck:
```
if(isBlank(value), "unknown", value)
```
- *Option B (Entfernen):* Zeilen mit fehlenden Pflichtfeldern löschen (wie in Schritt 4 beschrieben).

*Schritt 3 —* Den gewählten GREL-Ausdruck in «Edit cells» → «Transform…» eingeben und mit «OK» bestätigen.

*Ergebnis:* Fehlende Werte sind entweder gefüllt oder die betreffenden Zeilen wurden entfernt. Dies gewährleistet die *Datenqualität* — laut Vorlesung ein zentrales Kriterium sowohl für Data Warehouses (Konsistenz) als auch für Machine Learning (Aktualität, Bias, Feature-Qualität).

---

==== Teil 7 — Datentransformation: Spalten aufteilen und umbenennen

*Schritt 1 —* Falls eine Spalte mehrere Werte enthält (z. B. Koordinaten als `"47.123, 8.456"`), wird sie aufgeteilt. Dies entspricht der Transformationsfunktion *Feldaufteilung* aus der Vorlesung.

*Schritt 2 —* Spaltenmenü → «Edit column» → «Split into several columns…» → Trennzeichen `,` eingeben → «OK». OpenRefine erstellt automatisch neue Spalten (z. B. `koordinaten 1` und `koordinaten 2`).

*Schritt 3 —* Spalten umbenennen: Spaltenmenü → «Edit column» → «Rename this column» → neuen Namen eingeben (z. B. `lat` und `lon`). Dies entspricht der Transformationsfunktion *Umbenennen von Feldern* aus der Vorlesung.

*Schritt 4 —* Überflüssige Spalten entfernen: Spaltenmenü → «Edit column» → «Remove this column». Dies entspricht der Transformationsfunktion *Löschen von Feldern*.

*Ergebnis:* Das Schema des Datensatzes ist bereinigt und strukturiert. Die *Schema-Abbildung* (Datentransformation laut Vorlesung: Ändern der Struktur von Daten) ist abgeschlossen.

---

==== Teil 8 — Datentransformation: Datentypen konvertieren

*Schritt 1 —* Numerische Spalten (z. B. `lat`, `lon`) sind nach dem Import als Text (String) gespeichert, da OpenRefine laut Vorlesung «Kolonnen keine Datentypen» kennt. Für korrekte Analysen müssen sie konvertiert werden. Dies entspricht der Transformationsfunktion *Typumwandlung und Konvertierung*.

*Schritt 2 —* Spaltenmenü → «Edit cells» → «Transform…» → folgenden GREL-Ausdruck eingeben:

```
toNumber(value)
```

*Schritt 3 —* Für Datumsspalten analog:

```
toDate(value, "dd.MM.yyyy")
```

*Ergebnis:* Die Spalten besitzen nun den korrekten Datentyp, was spätere Berechnungen und Aggregationen ermöglicht. Die *Typumwandlung* («Ändern von Datentypen, z. B. Konvertierung von Strings in Ganzzahlen oder Datumswerte») laut Vorlesung ist abgeschlossen.

---

==== Teil 9 — Datenaggregation und -filterung

*Schritt 1 —* Filtern von Zeilen, die bestimmten Kriterien entsprechen (z. B. nur Bänke mit Rückenlehne): Im Text Facet der Spalte `backrest` auf `yes` klicken. Dies entspricht der Transformationsfunktion *Filtern und Löschen von Zeilen* (WHERE-Bedingung in SQL-Analogie laut Vorlesung).

*Schritt 2 —* Über «Facet» → «Numeric Facet» auf numerischen Spalten lassen sich Wertebereiche einschränken (z. B. nur Koordinaten innerhalb der Schweiz: `lat` zwischen 45.8 und 47.8).

*Schritt 3 —* Die Anzahl der gefilterten Zeilen oben links ablesen («X matching rows»), um die Filterung zu validieren.

*Ergebnis:* Der Datensatz ist auf die relevante Teilmenge eingeschränkt. Die *Datenfilterung* («Auswahl von Datensätzen») laut Vorlesung ist durchgeführt.

---

==== Teil 10 — Datenanreicherung (optional)

*Schritt 1 —* OpenRefine bietet die Möglichkeit, Daten über externe Dienste anzureichern (Vorlesung: *Datenanreicherung* — «Hinzufügen von Daten aus externen Quellen, z. B. Geocoding»).

*Schritt 2 —* Spaltenmenü → «Edit column» → «Add column by fetching URLs…» → URL-Template eingeben, z. B. für Nominatim-Geocoding:

```
"https://nominatim.openstreetmap.org/reverse?lat=" + cells["lat"].value + "&lon=" + cells["lon"].value + "&format=json"
```

*Schritt 3 —* Throttle Delay auf mind. 1000 ms setzen (Nutzungsbedingungen von Nominatim beachten). Das Ergebnis wird als JSON in einer neuen Spalte gespeichert.

*Schritt 4 —* Aus der JSON-Antwortspalte einzelne Felder extrahieren mit GREL:

```
value.parseJson().address.city
```

*Ergebnis:* Der Datensatz ist mit externen Informationen (z. B. Stadtname) angereichert. Dies ist ein Beispiel für *Nachschlagen/Datenanreicherung* laut Vorlesung.

---

==== Teil 11 — Daten exportieren (Load-Schritt)

*Schritt 1 —* Oben rechts «Export» → gewünschtes Format auswählen. Dies entspricht dem *Load*-Schritt des ETL-Prozesses: das physische Einbringen der bereinigten Daten in die Zielsenke.

*Schritt 2 —* Für den Export in eine Datenbank (ELT-Ansatz laut Vorlesung): Format «CSV» wählen und anschliessend mit `COPY`-Befehl in PostgreSQL laden:

```sql
COPY sitzbänke(osm_id, lat, lon, backrest, material)
FROM '/pfad/zur/datei.csv'
DELIMITER ',' CSV HEADER;
```

*Schritt 3 —* Für direkten Export: «Export» → «Comma-separated value» → Datei speichern.

*Schritt 4 —* Die exportierten Daten in der Zieldatenbank validieren:

```sql
SELECT COUNT(*) FROM sitzbänke;
SELECT * FROM sitzbänke WHERE backrest NOT IN ('yes', 'no', 'unknown');
```

*Ergebnis:* Der vollständige ETL-Prozess ist abgeschlossen:
- *Extract:* Rohdaten aus CSV/JSON importiert
- *Transform:* Deduplizierung, Wertebereinigung, Typkonvertierung, Spaltentransformation, Filterung, Anreicherung durchgeführt
- *Load:* Bereinigte Daten in die Zielsenke (CSV oder Datenbank) exportiert

---

==== Zusammenfassung der angewandten Datenintegrations-Funktionen

Gemäss Vorlesungsklassifikation wurden folgende Funktionen angewandt:

#table(
  columns: (auto, auto),
  [*Funktion (Vorlesung)*], [*Schritt in OpenRefine*],
  [Datenbereinigung], [Clustering, Facets, Blank-Entfernung],
  [Datentransformation (Schema-Abbildung)], [Spalten aufteilen, umbenennen, löschen],
  [Typumwandlung und Konvertierung], [`toNumber()`, `toDate()`],
  [Datenfilterung], [Text Facet, Numeric Facet],
  [Deduplizierung], [Sort + Blank Down + Remove],
  [Datenanreicherung], [Fetch URLs + JSON parsen],
  [Datenexport (Load)], [CSV-Export / DB-Import],
)