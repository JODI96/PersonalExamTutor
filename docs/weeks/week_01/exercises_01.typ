// Echte Kursübungen — Woche 1 (konvertiert am 2026-05-09)
// Quelle: README.adoc, README_Bevoelkerungsdaten.adoc, Loesung_Bevoelkerungsdaten.adoc

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

```typst
== Übungen

=== Aufgabe 1 — Bevölkerungsdaten Schweiz visualisieren

Es sollen die "Bevölkerungsdaten im Zeitvergleich, 1950–2024" vom Bundesamt für Statistik (BfS)
(Quelle: #link("https://www.bfs.admin.ch/asset/de/36142050")[www.bfs.admin.ch])
aufbereitet und in einer Geschäftsgrafik visualisiert werden.
Konkret interessiert uns die zeitliche Entwicklung der "ständigen Wohnbevölkerung"
sowie deren Teilgruppe "Ausländer".

Wir bieten zwei Varianten dieser Übungsaufgabe an:

- mittels klassischer Spreadsheet-Software (z.B. Microsoft Excel oder LibreOffice Calc)
- mittels LLM-Chatbot (z.B. ChatGPT oder Microsoft Copilot)

Lösen Sie *mindestens eine* der beiden Varianten.

_Tipp: Wählen Sie die Variante, mit der Sie *weniger vertraut* sind, um mehr dazuzulernen._

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Variante A — mittels Spreadsheet-Software*

    Bei dieser Aufgabe geht es darum, eine Business-Grafik fachgerecht zu erstellen —
    mit Begründung der Wahl des Diagramms.

    - Starten Sie MS Excel (oder LibreOffice Calc) und laden Sie die Datei.
    - Wählen Sie ein passendes Diagramm.

    _Hinweis: Die Vorschläge und Defaults der Office-Programme sind nicht immer optimal!
    Probieren Sie im Zweifelsfall verschiedene Varianten aus und vergleichen Sie diese miteinander._

    *Abschluss:*
    - Speichern Sie das Ergebnis ab.
    - Notieren Sie Ihre Begründung der Wahl des Diagramms.
  ],
  [
    *Variante B — mittels LLM*

    Bei dieser Aufgabe geht es darum, in einer Gruppenarbeit eine Geschäftsgrafik (Business Chart)
    mit Hilfe von ChatGPT oder Microsoft Copilot professionell zu erstellen —
    mit anschliessender Bewertung und Reflexion des Ergebnisses.

    *Vorbereitung:*

    Setzen Sie sich in Gruppen zusammen, sodass in jeder Gruppe mindestens eine Person
    Zugang zu ChatGPT Plus und Microsoft Copilot hat
    (Studierende der OST sollten Zugang zu Microsoft Copilot haben).

    *Task 1.1 — Prompting (ca. 40 min.):*

    - Lassen Sie sich mit Hilfe eines passenden Prompts von der GenAI erklären,
      welche Geschäftsgrafiken dargestellt werden können.
    - Lassen Sie sich anschliessend die vorhandenen Limitationen erklären.
    - Laden Sie die Bevölkerungsdaten hoch und lassen Sie sich mithilfe eines
      entsprechenden Prompts ein passendes Diagramm erzeugen.
    - Lassen Sie sich eine Begründung geben, warum diese Geschäftsgrafik gewählt wurde.
    - Verbessern Sie das Resultat mit einem weiteren Prompt.

    _Hinweis: Microsoft Copilot erlaubt Datei-Uploads nur auf der eigenen Website;
    es sollten daher keine Integrationen oder dergleichen verwendet werden._

    *Task 1.2 — Diskussion (ca. 15 min.):*

    Diskutieren Sie zu zweit das Resultat: Hat das GenAI-Tool den besten
    Geschäftsgrafik-Typ gewählt? Ist das Resultat gut? Gibt es Prompt-Tricks?
    Müsste man es nachbearbeiten und wenn ja wie? Welche Limitationen hat das GenAI-Tool
    (als Zusammenfassung von dem, was das Tool von sich sagt, und von dem, was Sie erlebt haben)?
    Welches GenAI-Tool ist besser?

    *Task 1.3 — Abschluss mit Lieferobjekten (ca. 15 min.):*

    - Sichern Sie die Geschäftsgrafik als `.PNG`.
    - Lassen Sie die Geschäftsgrafik vom GenAI-Tool exportieren — als Excel mit
      Geschäftsgrafik, LibreOffice Calc oder als CSV.
    - Notieren Sie die wichtigsten Prompts, die Sie gewählt haben.
    - Halten Sie die Erkenntnisse der Diskussion fest (max. eine A4-Seite inkl. Grafik).
  ],
)


=== Aufgabe 2 — Apache Superset kennenlernen

Bei dieser Aufgabe geht es um das Kennenlernen des BI-Tools Apache Superset.

*Vorbereitungen:*

+ Starten Sie Apache Superset — entweder:
  - (*empfohlen*) auf Ihrem eigenen Gerät mit Docker Compose
    (#link("https://superset.apache.org/docs/quickstart")[Anleitung]), oder
  - (als *Alternative*) auf einem von uns bereitgestellten Server
    #link("https://coder.infs.ch/templates/dominicklinger/superset/workspace?mode=manual")[per Coder].

  _Hinweis: In beiden Varianten kann es etwas dauern, bis Superset ganz gestartet ist
  und samt Beispieldaten zur Verfügung steht._

+ Öffnen Sie Apache Superset im Browser mit folgenden Zugangsdaten:
  - *Username:* `admin`
  - *Password:* `admin`

+ Öffnen Sie in einem weiteren Browserfenster das folgende Arbeitsblatt,
  das auf dem Lernportal OpenSchoolMaps publiziert wurde:
  #link("https://openschoolmaps.ch/pages/materialien.html#einfuehrung-in-apache-superset-1")[
    "Einführung in Apache Superset: Ein Chart"
  ]
  (#link("https://openschoolmaps.ch/docs/lehrmittel/de/apache_superset/einfuehrung_in_apache_superset_one_chart.html")[HTML],
  #link("https://openschoolmaps.ch/docs/lehrmittel/de/_exports/einfuehrung-in-apache-superset-one-chart.pdf")[PDF])

Folgen Sie nun sorgfältig dem Arbeitsblatt "Einführung in Apache Superset: Ein Chart".
Als Input dient dort eine Datenbank-Tabelle mit einer weltweiten Bevölkerungsstatistik.

*Abschluss:*
- Publizieren Sie Ihr Dashboard mit Chart.
- Dokumentieren Sie den Link zum Dashboard mit der Chart (Copy & Paste).


=== Aufgabe 3 — Eigenes Dashboard mit selbst aufbereiteten Daten

Bei dieser Aufgabe geht es darum, ein Dashboard mit selbst aufbereiteten Daten zu publizieren.

Suchen Sie sich zuerst einen Statistik-Datensatz. Der Datensatz muss nicht grösser als derjenige
von Aufgabe 1 sein. Er soll mindestens ein quantitatives Attribut
(Skalenniveau Ordinal, Intervall oder Ratio) enthalten.

Mögliche Datenquellen: BfS, Opendata.swiss oder Kanton Zürich
(z.B. mit Stichwörtern wie Covid-19 etc.).

_Hinweis: Die Suche und Aufbereitung von strukturierten Daten (im CSV- oder ähnlichem Format)
kann anstrengend sein. In einer der nächsten Übungen wird das Thema "Data Integration"
nochmals vertiefter behandelt._

Der weitere Ablauf ist dann wie gehabt — mit einem Unterschied: Sie müssen die CSV-Datei
in Apache Superset hochladen. Wie das geht und was dabei beachtet werden muss,
ist im Arbeitsblatt
#link("https://openschoolmaps.ch/pages/materialien.html#apache-superset-fuer-fortgeschrittene")[
  "Apache Superset für Fortgeschrittene"
]
(#link("https://openschoolmaps.ch/docs/lehrmittel/de/apache_superset/apache_superset_fuer_fortgeschrittene.html")[HTML],
#link("https://openschoolmaps.ch/docs/lehrmittel/de/_exports/apache-superset-fuer-fortgeschrittene.pdf")[PDF])
beschrieben.

*Abschluss:*
- Publizieren Sie Ihr Dashboard mit Chart.
- Dokumentieren Sie den Link zum Dashboard mit der Chart (Copy & Paste).
- Notieren Sie allfällige Verbesserungen des Arbeitsblatts sowie von Apache Superset
  (ggf. Issue erstellen).
```

== Lösungen

=== Aufgabe 1 — Bevölkerungsdaten visualisieren

==== Variante A: Mittels Spreadsheet-Software

*Schritt 1 — Datei öffnen und Datensatz verstehen*

Wir öffnen die Datei `je-d-01.01.01.xlsx` in LibreOffice Calc oder MS Excel. Bevor wir ein Diagramm erstellen, müssen wir gemäss dem Konzept der *Datenkompetenz* (Data Literacy) aus der Vorlesung die Frage beantworten: „Was will ich mit den Daten machen?" — Wir wollen die zeitliche Entwicklung der ständigen Wohnbevölkerung und des Ausländeranteils visualisieren.

*Schritt 2 — Skalenniveau der Daten bestimmen*

Wir bestimmen das Skalenniveau der relevanten Attribute, da die Vorlesung lehrt: „Von Skalenniveau zu Business Chart" — die Wahl des Diagrammtyps hängt direkt vom Skalenniveau ab.

- *Jahreszahl* (z.B. 1950, 1960, …, 2024): *Intervallskala* — es gibt keinen absoluten Nullpunkt (kein „Jahr 0" im metrischen Sinne), die Abstände zwischen den Werten sind jedoch bedeutsam und vergleichbar.
- *Ständige Wohnbevölkerung in 1 000* und *Ausländer in 1 000*: *Verhältnisskala (Ratio)* — es gibt einen absoluten Nullpunkt (0 Personen), Verhältnisse sind sinnvoll (z.B. „doppelt so viele").

*Schritt 3 — Passenden Diagrammtyp wählen*

Gemäss den *7 quantitativen Nachrichten-Typen* nach Stephen Few (2004), die in der Vorlesung vorgestellt wurden, handelt es sich hier um eine *Zeitserie* (Typ 2):

#box(stroke: 1pt, inset: 8pt)[
  *Zeitserie* $=>$ Liniendiagramm (horizontal)
]

Zusätzlich lehrt die Vorlesung zur Intervall-/Verhältnisskala:

#box(stroke: 1pt, inset: 8pt)[
  Intervall- / Verhältnisskala $=>$ Liniendiagramme und Streudiagramme
]

Wir wählen konkret ein *XY-Streudiagramm mit Linien*, weil — wie in der Musterlösung begründet — die horizontalen Abstände im Diagramm den tatsächlichen *zeitlichen Abständen* zwischen den Messpunkten entsprechen. Dies ist entscheidend: Die Daten liegen nicht in gleichmässigen Jahresabständen vor (z.B. Dekaden bis ca. 1980, danach jährlich). Ein normales Liniendiagramm würde alle Punkte gleich weit auseinander darstellen und damit die Steigungen verzerren — eine *irreführende Darstellung*, die der Vorlesung zufolge vermieden werden muss.

*Schritt 4 — Relevante Daten identifizieren und auswählen*

Wir identifizieren in der geöffneten Tabelle die drei benötigten Zeilen:

- *Zeile 2*: Jahreszahlen (1950, 1960, … 2024) → die Zeitachse (X-Achse)
- *Zeile 4*: „Ständige Wohnbevölkerung in 1 000" → erste Datenreihe
- *Zeile 5*: „Ausländer" (ebenfalls in 1 000) → zweite Datenreihe

Wir wählen diese drei Zeilen *inklusive der Beschriftung in Spalte A* aus. In LibreOffice gelingt das mit kbd:[Ctrl]+Klick auf die Zeilennummern 2, 4 und 5.

*Schritt 5 — Diagramm einfügen*

Wir wählen im Menü: *Einfügen → Diagramm…*

Im Diagramm-Assistenten nehmen wir folgende Einstellungen vor:

#table(
  columns: (auto, auto),
  [*Einstellung*], [*Wert*],
  [Diagrammtyp], [XY (Streudiagramm)],
  [Variante], [„Punkte und Linien" oder „Nur Linien"],
  [Datenreihen in], [Zeilen],
  [Erste Zeile als Beschriftung], [✓ aktiviert],
  [Erste Spalte als Beschriftung], [✓ aktiviert],
)

Jede dieser Einstellungen ist notwendig: „Datenreihen in Zeilen" stellt sicher, dass jede Zeile als eigene Linie dargestellt wird; die Beschriftungsoptionen sorgen dafür, dass Achsenbeschriftungen und Legenden korrekt aus den Daten übernommen werden.

*Schritt 6 — Diagramm abschliessen und speichern*

Wir klicken auf *Fertigstellen*. Das Diagramm wird in das bestehende Tabellenblatt eingefügt. Empfehlenswert ist es, das Diagramm:

- zu *strecken*, damit die einzelnen Datenpunkte gut sichtbar sind,
- auf ein *neues Tabellenblatt* zu verschieben, damit die Originaltabelle nicht verdeckt wird.

Anschliessend speichern wir die Datei (z.B. als `.ods` oder `.xlsx`).

*Schritt 7 — Kritische Überprüfung der Darstellung (Data Literacy)*

Gemäss dem Konzept der *Datenkompetenz* aus der Vorlesung müssen wir die Visualisierung kritisch bewerten:

- ✓ Die Zeitabstände werden korrekt proportional dargestellt (Streudiagramm).
- ✓ Beide Zeitreihen sind als separate Linien erkennbar.
- ⚠ Die Legende zeigt nur „Ständige Wohnbevölkerung" und „Ausländer" — der Hinweis *„in 1 000"* geht für die zweite Reihe nicht klar aus der Legende hervor. Dies sollte in einem Diagrammtitel oder einer Fusszeile ergänzt werden.

*Ergebnis Variante A:*

#box(stroke: 1pt, inset: 8pt)[
  Ein *XY-Streudiagramm mit Linien* (Zeitserie nach Stephen Few) stellt die zeitliche Entwicklung der ständigen Wohnbevölkerung sowie des Ausländeranteils korrekt dar. Die Wahl des Streudiagramms (statt eines einfachen Liniendiagramms) ist entscheidend, weil nur so die *ungleichmässigen Zeitintervalle* in der Datenbasis korrekt und nicht irreführend wiedergegeben werden. Beide Datenserien haben *Verhältnisskala-Niveau*, was Linien- und Streudiagramme als geeignete Visualisierungsform bestätigt.
]

---

==== Variante B: Mittels LLM (ChatGPT / Microsoft Copilot)

*Schritt 1 — Grundlegende Möglichkeiten erfragen (Task 1.1, Prompting)*

Wir starten mit einem orientierenden Prompt, um zu verstehen, was das LLM im Bereich Datenvisualisierung leisten kann. Dies entspricht der Data-Literacy-Frage aus der Vorlesung: „*Was kann ich mit Daten machen?*"

Beispiel-Prompt:
#box(stroke: 1pt, inset: 8pt, fill: luma(240))[
  „Welche Arten von Geschäftsgrafiken (Business Charts) kannst du aus hochgeladenen Datensätzen erstellen? Erkläre kurz die Unterschiede und wann welcher Typ sinnvoll ist."
]

Das LLM erklärt typische Diagrammtypen (Balken-, Linien-, Kreis-, Streudiagramm etc.), die auch in der Vorlesung nach Stephen Few behandelt wurden.

*Schritt 2 — Limitationen erfragen*

Wir fragen nach den Grenzen des Werkzeugs — gemäss Datenkompetenz: „*Was kann ich mit Daten machen?*" beinhaltet auch das Wissen um Grenzen.

Beispiel-Prompt:
#box(stroke: 1pt, inset: 8pt, fill: luma(240))[
  „Was sind deine Limitationen beim Erstellen von Diagrammen aus Datendateien? Zum Beispiel: Dateigrösse, Diagrammqualität, Export-Formate?"
]

Typische Antworten des LLM: Eingeschränkte Dateigrössenverarbeitung, keine direkte Einbettung in Dritttools, eingeschränkte Interaktivität (kein interaktives Dashboard — kein *Apache Superset*-Äquivalent).

*Schritt 3 — Datei hochladen und Diagramm erzeugen lassen*

Wir laden die Datei `je-d-01.01.01.xlsx` hoch (in ChatGPT Plus direkt; in Microsoft Copilot über die eigene Website) und formulieren einen zielgerichteten Prompt.

Beispiel-Prompt:
#box(stroke: 1pt, inset: 8pt, fill: luma(240))[
  „Ich habe eine Excel-Datei mit Bevölkerungsdaten der Schweiz von 1950 bis 2024 hochgeladen. Bitte erstelle eine Geschäftsgrafik, die die Entwicklung der ständigen Wohnbevölkerung und des Ausländeranteils über die Zeit zeigt. Wähle den geeignetsten Diagrammtyp und begründe deine Wahl."
]

Ein gut funktionierendes LLM sollte — analog zur Musterlösung — ein *Linien- oder Streudiagramm* wählen, da es sich um eine *Zeitserie* handelt (Stephen Few, Typ 2).

*Schritt 4 — Begründung vom LLM einfordern*

Wir fragen explizit nach der Begründung, um die Antwort des LLMs mit dem Vorlesungswissen (Skalenniveaus, Diagrammwahl) vergleichen zu können.

Beispiel-Prompt:
#box(stroke: 1pt, inset: 8pt, fill: luma(240))[
  „Warum hast du diesen Diagrammtyp gewählt? Begründe anhand des Skalenniveaus der Daten und der Art der Nachricht, die das Diagramm transportieren soll."
]

*Schritt 5 — Verbesserung mit einem weiteren Prompt*

Wir verfeinern das Ergebnis, z.B. hinsichtlich Achsenbeschriftung, Titel oder korrekter Einheit.

Beispiel-Prompt:
#box(stroke: 1pt, inset: 8pt, fill: luma(240))[
  „Verbessere das Diagramm: Füge einen aussagekräftigen Titel hinzu, beschrifte beide Achsen klar (X-Achse: Jahr, Y-Achse: Bevölkerung in 1 000), und stelle sicher, dass die Legende beide Datenreihen klar unterscheidet."
]

*Schritt 6 — Diskussion und Reflexion (Task 1.2)*

Wir diskutieren das Ergebnis anhand folgender Leitfragen aus der Vorlesung:

#table(
  columns: (auto, auto),
  [*Frage*], [*Bewertungskriterium (aus Vorlesung)*],
  [Richtiger Diagrammtyp?], [Zeitserie → Liniendiagramm (Stephen Few)],
  [Korrekte Zeitabstände?], [Streudiagramm notwendig wegen ungleichmässiger Intervalle],
  [Skalenniveau korrekt erkannt?], [Verhältnisskala → Linien-/Streudiagramm],
  [Beschriftung vollständig?], [Einheit „in 1 000" auf beiden Reihen?],
  [Prompting-Aufwand?], [Anzahl nötiger Prompts bis zum akzeptablen Ergebnis],
)

*Schritt 7 — Lieferobjekte sichern (Task 1.3)*

Wir sichern:
- Die erzeugte Grafik als *PNG*-Export.
- Den Datensatz als *CSV oder Excel* (vom LLM exportieren lassen).
- Die verwendeten Prompts (notiert).
- Die Erkenntnisse der Diskussion (max. 1 A4-Seite inkl. Grafik).

*Ergebnis Variante B:*

#box(stroke: 1pt, inset: 8pt)[
  LLM-Tools können einfache Zeitreihen-Diagramme erstellen und korrekt als solche klassifizieren. Die *Qualität des Ergebnisses hängt stark von der Qualität des Prompts* ab. Kritisch zu prüfen ist immer, ob das LLM: (1) den richtigen Diagrammtyp gewählt hat, (2) die Zeitabstände korrekt darstellt, (3) Einheiten und Beschriftungen vollständig wiedergibt. Im Vergleich zu Spreadsheet-Software fehlt dem LLM die direkte Interaktivität und die Kontrolle über Layout-Details — dies entspricht dem Unterschied zwischen *DataViz* (einfache grafische Kodierung) und *InfoViz* (interaktives System mit UI/UX), wie in der Vorlesung definiert.
]

---

=== Aufgabe 2 — Apache Superset: Ein Chart erstellen

*Schritt 1 — Apache Superset starten*

Wir starten Apache Superset über Docker Compose gemäss der offiziellen Quickstart-Anleitung (empfohlene Variante). Dies entspricht dem BI-Tool-Konzept der Vorlesung: Apache Superset ist ein Open-Source-BI-Tool, das die vier BI-Kernfunktionen abdeckt: *Analysieren, Visualisieren, Präsentieren und Publizieren*.

*Schritt 2 — Anmelden*

Wir öffnen Apache Superset im Browser und melden uns an:
#table(
  columns: (auto, auto),
  [Username], [`admin`],
  [Password], [`admin`],
)

*Schritt 3 — Datenquelle verbinden (Dataset auswählen)*

Gemäss dem BI-Konzept der Vorlesung beginnt die Arbeit mit dem *Analysieren*: Daten selektieren und aufbereiten. Wir wählen den vorbereiteten Datensatz (weltweite Bevölkerungsstatistik) als Dataset aus, wie im Arbeitsblatt „Einführung in Apache Superset: Ein Chart" beschrieben.

*Schritt 4 — Chart-Typ auswählen*

Wir wählen einen geeigneten Chart-Typ. Da die Bevölkerungsdaten eine *Zeitserie* darstellen (Stephen Few, Typ 2), wählen wir ein *Liniendiagramm*. Damit wenden wir das in der Vorlesung behandelte Prinzip an:

$ "Zeitserie" => "Liniendiagramm" $

*Schritt 5 — Dimensionen und Metriken konfigurieren*

Wir konfigurieren:
- *X-Achse*: Zeitdimension (Jahr)
- *Y-Achse / Metrik*: Bevölkerungszahl (quantitatives Attribut, Verhältnisskala)
- *Gruppierung* (optional): nach Kontinent oder Land

Dies entspricht dem Datenperspektiven-Konzept der Vorlesung: *When?* (temporal) — „Beschreibt wann sich etwas verändert, indem Entwicklungen als Zeitreihen sichtbar gemacht werden."

*Schritt 6 — Chart speichern und zu Dashboard hinzufügen*

Wir speichern den Chart und fügen ihn einem neuen Dashboard hinzu. Dies entspricht der BI-Funktion *Präsentieren*: „Listen, Diagramme und Karten zu einem Cockpit/Dashboard zusammenfassen."

*Schritt 7 — Dashboard publizieren*

Wir publizieren das Dashboard über die Funktion „Publish" in Apache Superset. Dies entspricht der BI-Funktion *Publizieren*: „Die Cockpits/Dashboards über das Web mit anderen teilen."

*Ergebnis:*

#box(stroke: 1pt, inset: 8pt)[
  Das Dashboard mit dem Liniendiagramm zur weltweiten Bevölkerungsstatistik ist publiziert. Den Link zum Dashboard dokumentieren wir per Copy & Paste (z.B.: `http://localhost:8088/superset/dashboard/[ID]/`). Apache Superset demonstriert alle vier BI-Kernfunktionen aus der Vorlesung: Analysieren, Visualisieren, Präsentieren und Publizieren.
]

---

=== Aufgabe 3 — Eigenes Dashboard mit eigenem Datensatz

*Schritt 1 — Geeigneten Datensatz suchen*

Wir suchen einen Statistik-Datensatz, der *mindestens ein quantitatives Attribut* mit dem Skalenniveau Ordinal, Intervall oder Ratio enthält — wie in der Aufgabenstellung gefordert und in der Vorlesung unter dem Kürzel „NOIR" behandelt.

Mögliche Quellen (aus Aufgabenstellung):
- Bundesamt für Statistik (BfS): https://www.bfs.admin.ch
- Opendata.swiss
- Kanton Zürich (Covid-19-Daten etc.)

Beispiel-Datensatz: *Covid-19-Fallzahlen Schweiz* (tägliche Neuinfektionen) → quantitatives Attribut auf *Verhältnisskala* (Ratio), da ein absoluter Nullpunkt (0 Fälle) existiert.

*Schritt 2 — Datensatz als CSV aufbereiten*

Wir laden den Datensatz herunter und bereiten ihn als CSV auf. Dabei prüfen wir gemäss *Datenkompetenz* aus der Vorlesung:
- „*Was darf ich mit Daten machen?*" → Lizenz prüfen (z.B. Open Government Data).
- „*Was kann ich mit Daten machen?*" → Datenqualität und Vollständigkeit prüfen.

Ggf. bereinigen wir die Daten (fehlende Werte entfernen, Datumsspalte korrekt formatieren).

*Schritt 3 — CSV in Apache Superset hochladen*

Gemäss dem Arbeitsblatt „Apache Superset für Fortgeschrittene" laden wir die CSV-Datei in Apache Superset hoch:

- Menü: *Data → Upload a CSV*
- CSV-Datei auswählen und Trennzeichen konfigurieren
- Datenbank und Tabellenname festlegen
- Upload bestätigen

*Schritt 4 — Dataset in Superset registrieren*

Nach dem Upload registrieren wir die hochgeladene Tabelle als *Dataset* in Superset, damit wir darauf einen Chart erstellen können. Dies entspricht dem Schritt *Analysieren* im BI-Workflow.

*Schritt 5 — Geeigneten Chart-Typ bestimmen und erstellen*

Wir bestimmen erneut anhand des Skalenniveaus und der Botschaft (nach Stephen Few) den passenden Diagrammtyp. Für Zeitreihen-Daten auf Verhältnisskala gilt:

#box(stroke: 1pt, inset: 8pt)[
  Verhältnisskala + Zeitserie $=>$ Liniendiagramm\
  Verhältnisskala + Häufigkeitsverteilung $=>$ Histogramm / Bar Chart
]

Wir konfigurieren X-Achse (Zeit), Y-Achse (Messwert) und erstellen den Chart.

*Schritt 6 — Dashboard erstellen und Chart einbetten*

Wir erstellen ein neues Dashboard, benennen es aussagekräftig und fügen den erstellten Chart hinzu. Gemäss der Vorlesung ist ein Dashboard ein *„Cockpit"*, das mehrere Visualisierungen zu einem Thema zusammenfasst.

*Schritt 7 — Dashboard publizieren und Link dokumentieren*

Wir publizieren das Dashboard und kopieren den Link.

*Ergebnis:*

#box(stroke: 1pt, inset: 8pt)[
  Das eigene Dashboard mit dem selbst aufbereiteten Datensatz ist in Apache Superset publiziert. Der Link wird dokumentiert (z.B. `http://localhost:8088/superset/dashboard/[ID]/`). Die gesamte Übung demonstriert den vollständigen BI-Workflow: von der Datenbeschaffung (Datenkompetenz) über die Aufbereitung (CSV-Import) und Analyse (Skalenniveau, Diagrammwahl nach Stephen Few) bis zur Publikation im Web.
]