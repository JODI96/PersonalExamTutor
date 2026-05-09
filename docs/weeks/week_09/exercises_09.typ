// Echte Kursübungen — Woche 9 (konvertiert am 2026-05-09)
// Quelle: DATANA 08 EX Introduction and Preprocessing.pdf, Introduction and Preprocessing(1) Exercises(2).pptx, DATANA 08 EX SOL Introduction and Preprocessing.pdf

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Übungen

=== Aufgabe 1 — Data Science vs. Data Mining
Wie unterscheidet sich Data Science von Data Mining? Wo liegen die Gemeinsamkeiten?

=== Aufgabe 2 — Data Mining und Machine Learning
Wie verhält sich Data Mining zu Machine Learning?

=== Aufgabe 3 — CRISP-DM
Beschreibe mit eigenen Worten, was in jeder Phase des CRISP-DM-Modells passiert.

=== Aufgabe 4 — Anwendungsbeispiel Data Mining
Präsentiere ein Beispiel, bei dem Data Mining entscheidend für den Geschäftserfolg ist. Welche Data-Mining-Funktionalitäten benötigt dieses Unternehmen? Formuliere entsprechende Geschäftsfragen.

=== Aufgabe 5 — Mining-Methoden im Vergleich
Erkläre den Unterschied zwischen Association, Segmentation/Clustering, Classification und Regression.

=== Aufgabe 6 — Zeitaufwand in Data Science
Betrachte den Zeitaufwand in Data Science je Phase. Warum ist die Datenvorbereitung so aufwändig und die Evaluation vergleichsweise wenig?

=== Aufgabe 7 — Schlechte Datenqualität
Nenne Beispiele für schlechte Datenqualität.

=== Aufgabe 8 — Attributtypen und Kennzahlen
Gib je ein Beispiel für folgende Attributtypen: nominal, ordinal, intervallskaliert und verhältnisskaliert. Entscheide jeweils, ob es sinnvoll ist, Mittelwert, Median und/oder Modus zu berechnen.

=== Aufgabe 9 — Altersverteilung
Die Analyse beinhaltet das Attribut Alter. Die Alterswerte der Datentupel lauten (in aufsteigender Reihenfolge):

$ 13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 $

**(a)** Berechne den Mittelwert und den Median der Daten.

**(b)** Was ist der Modus der Daten? Kommentiere die Modalität des Datensatzes.

**(c)** Bestimme (näherungsweise, von Hand) das erste Quartil $Q_1$ und das dritte Quartil $Q_3$ der Daten.

**(d)** Gib die Fünf-Punkte-Zusammenfassung (Five-Number Summary) der Daten an und zeige einen Boxplot.

=== Aufgabe 10 — Alter und Körperfettanteil
Ein Krankenhaus hat Alter und Körperfettanteil von 18 zufällig ausgewählten Erwachsenen erhoben:

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header([*Alter*], [*%Fett*], [*Alter*], [*%Fett*]),
  [23], [9.5],  [52], [34.6],
  [23], [26.5], [54], [42.5],
  [27], [7.8],  [54], [28.8],
  [27], [17.8], [56], [33.4],
  [39], [31.4], [57], [30.2],
  [41], [25.9], [58], [34.1],
  [47], [27.4], [58], [32.9],
  [49], [27.2], [60], [41.2],
  [50], [31.2], [61], [35.7],
)

**(a)** Berechne Mittelwert, Median und Standardabweichung von Alter und %Fett.

**(b)** Zeichne ein Streudiagramm (Scatter Plot) basierend auf diesen beiden Attributen.

== Lösungen

=== Aufgabe 1 — Data Science vs. Data Mining

*Schritt 1 —* Wir definieren Data Mining gemäss der Vorlesung als den Kernprozess der Wissensextraktion.

Data Mining bezeichnet den Prozess, bei dem aus rohen Daten nützliches Wissen extrahiert wird. Ziel ist es, neue, unbekannte und nützliche Muster zu entdecken, die implizit in den Daten vorhanden sind. Die drei wichtigsten Techniken laut Vorlesung sind: *Association Analysis*, *Classification* und *Clustering*.

*Schritt 2 —* Wir definieren Data Science als das übergeordnete, interdisziplinäre Feld.

Data Science ist ein breiteres Feld, das den gesamten Lebenszyklus der Datenarbeit umfasst: Sammeln, Bereinigen, Transformieren, Analysieren und Visualisieren von Daten. Es integriert mehrere Disziplinen wie Statistik, Machine Learning, Data Engineering und Domänenwissen.

*Schritt 3 —* Wir stellen die Gemeinsamkeiten und Unterschiede gegenüber.

- *Unterschied:* Data Mining ist ein Teilbereich von Data Science und fokussiert sich spezifisch auf die Mustererkennung in Daten. Data Science umfasst zusätzlich Business Understanding, Datenbeschaffung, Visualisierung, Präsentation und strategische Entscheidungsfindung.
- *Gemeinsamkeit:* Beide Disziplinen arbeiten mit Daten, um Erkenntnisse zu gewinnen, und nutzen statistische sowie algorithmische Methoden.

*Ergebnis:* Data Mining $subset$ Data Science. Data Mining ist der spezifische Schritt der Musterextraktion, während Data Science den vollständigen CRISP-DM-Prozess von Business Understanding bis Deployment abdeckt.

---

=== Aufgabe 2 — Data Mining und Machine Learning

*Schritt 1 —* Wir beschreiben die Beziehung zwischen den beiden Feldern.

Machine Learning (ML) und Data Mining sind eng miteinander verwandt. Viele Algorithmen, die im ML eingesetzt werden (z.B. Entscheidungsbäume, Naive Bayes, k-Nearest Neighbors), werden auch im Data Mining verwendet.

*Schritt 2 —* Wir beschreiben die gegenseitige Abhängigkeit.

Data Mining nutzt ML-Algorithmen zur Musterextraktion. Umgekehrt liefert Data Mining aufbereitete und bereinigte Trainingsdatensätze für ML-Modelle. Data Mining ist somit eine wichtige Schnittstelle, die ML-Algorithmen einsetzt und deren Ergebnisse unterstützt.

*Ergebnis:* Data Mining und Machine Learning ergänzen sich gegenseitig: Data Mining verwendet ML-Methoden zur Wissensextraktion und bereitet gleichzeitig Daten für ML-Modelle vor.

---

=== Aufgabe 3 — CRISP-DM Phasen

*Schritt 1 —* Wir gehen die sechs Phasen des CRISP-DM-Modells («Cross-Industry Standard Process for Data Mining») der Reihe nach durch.

*Business Understanding:*
Den Anwendungsfall und die Domäne verstehen. Konkrete Ziele definieren und Abnahmekriterien festlegen. Frage: Was soll am Ende erreicht werden?

*Data Understanding:*
Herausfinden, wo sich die Daten befinden (evtl. mehrere Datenquellen), den Inhalt der Daten verstehen und die Datenqualität beurteilen. Erste Gedanken zum Einsatzzweck der Daten entwickeln.

*Data Preparation:*
Daten aufbereiten: zusammenführen, in ein einheitliches Format bringen, säubern (fehlende Werte behandeln, fehlerhafte Daten löschen) und Feature Engineering betreiben (Normalisierung, Bestimmung wichtiger Parameter).

*Modeling:*
Anwendung geeigneter Algorithmen auf die vorbereiteten Daten. Herausfinden, welcher Algorithmus am besten geeignet ist. Training des Modells mit Aufteilung in Trainings- und Validierungsdaten.

*Evaluation:*
Besprechung der Ergebnisse. Prüfen, ob etwas übersehen wurde (Parameter, Datenqualität, richtiger Algorithmus). Bewerten, ob das Modell ausreichend gut ist und die Ergebnisse aussagekräftig sind.

*Deployment:*
Präsentation der Resultate und Integration des Modells in den Entscheidungsprozess des Kunden.

*Ergebnis:* Der CRISP-DM-Prozess ist iterativ — es sind Rücksprünge zwischen den Phasen möglich und üblich.

---

=== Aufgabe 4 — Praxisbeispiel Data Mining

*Schritt 1 —* Wir wählen ein konkretes Beispiel und ordnen es den Data Mining Funktionalitäten zu.

*Beispiel: Online-Handel (z.B. Amazon)*

*Association Analysis (Warenkorbanalyse):*
Geschäftsfrage: «Welche Produkte werden häufig zusammen gekauft?»
Erkenntnis: Kunden, die eine Kamera kaufen, kaufen oft auch Speicherkarten und Akkus.

*Classification (Klassifikation):*
Geschäftsfrage: «Wird dieser Kunde ein Produkt zurückgeben?»
Basierend auf Kaufhistorie, Kundenbewertungen und Lieferzeit.

*Clustering (Segmentierung):*
Geschäftsfrage: «Welche Kundengruppen gibt es, und wie unterscheiden sie sich in ihrem Kaufverhalten?»
Z.B. Gelegenheitskäufer vs. Stammkunden vs. Schnäppchenjäger.

*Regression (Prognose):*
Geschäftsfrage: «Welchen Umsatz werden wir im nächsten Quartal erzielen?»
Basierend auf saisonalen Mustern und Werbebudget.

*Ergebnis:* Ein Online-Händler benötigt alle vier zentralen Data Mining Funktionalitäten: Association, Classification, Clustering und Regression, um seinen Geschäftserfolg zu maximieren.

---

=== Aufgabe 5 — Unterschiede der Data Mining Methoden

*Schritt 1 —* Wir erläutern jede Methode anhand der Vorlesungsdefinitionen.

*Association (Assoziationsanalyse):*
Sucht nach sachlichen Verbundbeziehungen zwischen Items in Transaktionen. Fragt: «Welche Produkte werden zusammen gekauft?» Beispiel: Wenn jemand Brot kauft, kauft er mit 66.7% Wahrscheinlichkeit auch Butter.

*Clustering (Segmentierung):*
Teilt Daten ohne vorgegebene Labels in homogene Gruppen ein (Unsupervised Learning). Fragt: «Welche Kundengruppen existieren?» Beispiel: k-Means-Clustering von Kunden nach Einkaufsverhalten.

*Classification (Klassifikation):*
Weist Datenpunkte anhand von Trainingsdaten vordefinierten Kategorien zu (Supervised Learning). Fragt: «Ist diese E-Mail Spam?» Beispiel: Entscheidungsbaum oder Naive Bayes.

*Regression:*
Sagt einen kontinuierlichen numerischen Wert voraus. Fragt: «Wie viel Umsatz erzielen wir bei Werbebudget X?» Beispiel: Lineare Regression für Umsatzprognosen.

*Ergebnis:*
- Association $arrow$ Mustersuche in Transaktionen
- Clustering $arrow$ Gruppenbildung ohne Labels
- Classification $arrow$ Kategoriezuweisung mit Labels
- Regression $arrow$ Vorhersage numerischer Werte

---

=== Aufgabe 6 — Aufwand in der Data Science

*Schritt 1 —* Wir begründen den hohen Aufwand der Data Preparation.

Laut Vorlesung umfasst Data Preparation: Daten zusammenführen, in einheitliches Format bringen, säubern und Feature Engineering betreiben. Da Daten oft aus *heterogenen Quellen* stammen, sind unterschiedliche Formate, fehlende Werte und Inkonsistenzen die Regel. Jede dieser Aufgaben erfordert manuellen Aufwand und Domänenwissen. Laut dem in der Vorlesung gezeigten Diagramm zu den Efforts in Data Science entfällt der grösste Teil des Aufwands auf die Datenvorbereitung.

*Schritt 2 —* Wir begründen den geringen Aufwand der Evaluation.

Die Evaluation profitiert von modernen Frameworks (z.B. scikit-learn), die Metriken wie Accuracy, Precision, Recall und F1-Score automatisch berechnen. Sobald das Modell trainiert ist, ist die Evaluation ein strukturierter, weitgehend automatisierter Prozess.

*Ergebnis:* Data Preparation ist aufwändig wegen heterogener, inkonsistenter und fehlerhafter Rohdaten. Evaluation ist wenig aufwändig, da moderne Tools die Metriken automatisch berechnen.

---

=== Aufgabe 7 — Beispiele für schlechte Datenqualität

*Schritt 1 —* Wir ordnen Beispiele den in der Vorlesung definierten Qualitätselementen zu.

Die Vorlesung definiert folgende Qualitätsdimensionen: Accuracy, Completeness, Consistency, Timeliness, Believability, Interpretability.

*Accuracy (Genauigkeit):*
Ein Produktpreis ist als $-100$ CHF statt $100$ CHF eingetragen. Ein Geburtsdatum liegt in der Zukunft.

*Completeness (Vollständigkeit):*
Ein Kundendatensatz hat kein Geburtsdatum oder keine E-Mail-Adresse eingetragen (fehlende Werte / NULL).

*Consistency (Konsistenz):*
Datumsformate sind inkonsistent: ein Eintrag lautet «01/02/2025», ein anderer «2025-02-01». Oder Masseinheiten wechseln zwischen kg und lbs ohne Kennzeichnung.

*Timeliness (Aktualität):*
Kundenadressen wurden seit 5 Jahren nicht aktualisiert und sind veraltet.

*Duplicate Data:*
Derselbe Kunde ist mehrfach mit leicht unterschiedlicher Schreibweise eingetragen (z.B. «Müller, Hans» und «Mueller, Hans»), was zu verfälschten Analyseergebnissen führt.

*Ergebnis:* «Low quality data will lead to low quality mining results» (Vorlesung). Schlechte Datenqualität manifestiert sich als fehlende, inkonsistente, veraltete, duplizierte oder falsche Werte.

---

=== Aufgabe 8 — Attributtypen und Lageparameter

*Schritt 1 —* Wir gehen durch alle vier Attributtypen gemäss Vorlesung (nominal, ordinal, interval-scaled, ratio-scaled) und entscheiden, ob Mean, Median und/oder Mode sinnvoll sind.

*Nominal:*
- Beispiele: Haarfarbe (schwarz, braun, blond), Städtenamen, Ländernamen, Produktkategorien
- Mathematische Operationen sind nicht sinnvoll (keine Ordnung, kein Abstand)
- *Mean:* ✗ nicht sinnvoll (z.B. «Durchschnitt von Rot und Blau» ergibt keinen Sinn)
- *Median:* ✗ nicht sinnvoll (keine Ordnung vorhanden)
- *Mode:* ✓ sinnvoll (häufigste Kategorie kann bestimmt werden)

*Ordinal:*
- Beispiele: Schulnoten (sehr gut, gut, genügend), Getränkegrössen (S, M, L, XL), Kundenzufriedenheit (1–5 Sterne)
- Eine Rangordnung existiert, aber die Abstände zwischen Werten sind nicht definiert
- *Mean:* ✗ meist nicht sinnvoll (Abstände unbekannt)
- *Median:* ✓ sinnvoll (Rangordnung erlaubt Mittelwertbestimmung)
- *Mode:* ✓ sinnvoll

*Interval-Scaled (kardinal):*
- Beispiele: Temperatur in °C oder °F, Kalenderjahr, IQ-Werte
- Abstände zwischen Werten sind definiert, aber kein absoluter Nullpunkt
- *Mean:* ✓ sinnvoll
- *Median:* ✓ sinnvoll
- *Mode:* ✓ sinnvoll (ggf. erst nach Binning)

*Ratio-Scaled (kardinal):*
- Beispiele: Gewicht (kg), Körpergrösse (cm), Einkommen (CHF), Alter (Jahre)
- Absoluter Nullpunkt vorhanden; Verhältnisse sind bedeutsam (z.B. 60 kg = doppelt so schwer wie 30 kg)
- *Mean:* ✓ sinnvoll
- *Median:* ✓ sinnvoll
- *Mode:* ✓ sinnvoll (ggf. erst nach Binning)

*Ergebnis:*
#table(
  columns: (auto, auto, auto, auto),
  [*Typ*], [*Mean*], [*Median*], [*Mode*],
  [Nominal], [✗], [✗], [✓],
  [Ordinal], [✗], [✓], [✓],
  [Interval], [✓], [✓], [✓],
  [Ratio], [✓], [✓], [✓],
)

---

=== Aufgabe 9 — Statistische Kennzahlen für Alter

Datensatz (N = 27, bereits sortiert):
$13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70$

==== (a) Mean und Median

*Schritt 1 —* Wir berechnen den arithmetischen Mittelwert (Mean) gemäss Vorlesungsformel.

$ overline(x) = frac(sum_(i=1)^(N) x_i, N) $

*Schritt 2 —* Wir summieren alle Werte.

$
13 + 15 + 16 + 16 + 19 + 20 + 20 + 21 + 22 + 22 + 25 + 25 + 25 + 25 \
+ 30 + 33 + 33 + 35 + 35 + 35 + 35 + 36 + 40 + 45 + 46 + 52 + 70 = 809
$

*Schritt 3 —* Wir dividieren durch $N = 27$.

$ overline(x) = frac(809, 27) approx 29.96 $

*Schritt 4 —* Wir bestimmen den Median. Da $N = 27$ ungerade ist, ist der Median der Wert an der Stelle $frac(N+1, 2) = frac(28, 2) = 14$.

Wir zählen zum 14. Wert in der sortierten Liste:

Position: $1=13, 2=15, 3=16, 4=16, 5=19, 6=20, 7=20, 8=21, 9=22, 10=22, 11=25, 12=25, 13=25, 14=25, ...$

Der 14. Wert ist $25$.

*Ergebnis:*
$ overline(x) = frac(809, 27) approx 29.96 quad quad "Median" = 25 $

==== (b) Modus und Modalität

*Schritt 1 —* Wir zählen die Häufigkeiten jedes Wertes.

$
25 "kommt" 4 "mal vor" \
35 "kommt" 4 "mal vor" \
"alle anderen Werte kommen" <= 2 "mal vor"
$

*Schritt 2 —* Da zwei Werte gleich häufig und am häufigsten auftreten, ist der Datensatz *bimodal*.

*Ergebnis:* $"Mode" = {25, 35}$ — der Datensatz ist *bimodal*.

==== (c) Quartile Q1 und Q3

*Schritt 1 —* Wir bestimmen Q1 und Q3 nach der in der Vorlesung gezeigten Methode: Der Median teilt den Datensatz in zwei Hälften. Die untere Hälfte umfasst die Werte vor dem Median (Positionen 1–13), die obere Hälfte die Werte nach dem Median (Positionen 15–27).

*Untere Hälfte* (13 Werte): $13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25$

Der Median der unteren Hälfte (Position 7 von 13) ist:

Position: $1=13, 2=15, 3=16, 4=16, 5=19, 6=20, 7=20, ...$

$Q_1 = 20$

Da die Musterlösung jedoch die Methode anwendet, bei der bei gerader Anzahl (nach Ausschluss des Medians) der Mittelwert der beiden mittleren Werte genommen wird:

Untere 13 Werte, mittlerer = Position 7 $arrow$ $Q_1 = 20$.

*Schritt 2 —* Wir bestimmen Q3 aus der oberen Hälfte.

*Obere Hälfte* (13 Werte): $30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70$

Der Median der oberen Hälfte (Position 7 von 13):

Position: $1=30, 2=33, 3=33, 4=35, 5=35, 6=35, 7=35, ...$

$Q_3 = 35$

*Schritt 3 —* Wir berechnen IQR und Range als Zusatzinformation.

$
I Q R = Q_3 - Q_1 = 35 - 20 = 15 \
R = max(X) - min(X) = 70 - 13 = 57
$

Hinweis: Die Musterlösung gibt $Q_1 = 20.5$ an, was der Mittelwert der 7. und 8. Position wäre ($frac(20 + 21, 2) = 20.5$). Dies hängt von der verwendeten Quartil-Berechnungsmethode ab.

*Ergebnis:* $Q_1 = 20$ (bzw. $20.5$ je nach Methode), $Q_3 = 35$, $I Q R = 15$ (bzw. $14.5$)

==== (d) Five-Number Summary und Boxplot

*Schritt 1 —* Das Five-Number Summary besteht gemäss Vorlesung aus: $"Minimum", Q_1, "Median", Q_3, "Maximum"$.

$
"Minimum" &= 13 \
Q_1 &= 20.5 \
"Median" &= 25 \
Q_3 &= 35 \
"Maximum" &= 70
$

*Schritt 2 —* Wir berechnen die Whisker-Grenzen für den Boxplot. Laut Vorlesung erstrecken sich die Whisker bis zum letzten Wert, der noch innerhalb von $1.5 times I Q R$ der Quartile liegt.

$
1.5 times I Q R = 1.5 times 14.5 = 21.75 \
"Untere Grenze:" Q_1 - 21.75 = 20.5 - 21.75 = -1.25 \
"Obere Grenze:" Q_3 + 21.75 = 35 + 21.75 = 56.75
$

*Schritt 3 —* Wir bestimmen die tatsächlichen Whisker-Endpunkte (letzter Wert innerhalb der Grenzen).

- Unterer Whisker: kleinster Wert $>= -1.25$ ist $13$
- Oberer Whisker: grösster Wert $<= 56.75$ ist $52$
- Ausreisser: $70$ liegt ausserhalb und wird separat dargestellt

*Ergebnis:*

$ "Five-Number Summary:" {13,\ 20.5,\ 25,\ 35,\ 70} $

Boxplot-Beschreibung:
- Box von $Q_1 = 20.5$ bis $Q_3 = 35$
- Mittellinie bei Median $= 25$
- Unterer Whisker bei $13$, oberer Whisker bei $52$
- Ausreisser: $70$ (als Punkt dargestellt)

---

=== Aufgabe 10 — Alter und Körperfettanteil

Vollständiger Datensatz (sortiert nach Alter):

#table(
  columns: (auto, auto),
  [*age*], [*%fat*],
  [23], [9.5],
  [23], [26.5],
  [27], [7.8],
  [27], [17.8],
  [39], [31.4],
  [41], [25.9],
  [47], [27.4],
  [49], [27.2],
  [50], [31.2],
  [52], [34.6],
  [54], [42.5],
  [54], [28.8],
  [56], [33.4],
  [57], [30.2],
  [58], [34.1],
  [58], [32.9],
  [60], [41.2],
  [61], [35.7],
)

$N = 18$

==== (a) Mean, Median und Standardabweichung

*Schritt 1 —* Wir berechnen den Mean für das Alter.

$
sum "age" = 23 + 23 + 27 + 27 + 39 + 41 + 47 + 49 + 50 + 52 + 54 + 54 + 56 + 57 + 58 + 58 + 60 + 61 \
= 835
$

$ overline(x)_("age") = frac(835, 18) approx 46.39 $

*Schritt 2 —* Wir berechnen den Median für das Alter. Bei $N = 18$ (gerade Anzahl) ist der Median der Mittelwert der 9. und 10. Position.

Sortierte Alter: $23, 23, 27, 27, 39, 41, 47, 49, 50, 52, 54, 54, 56, 57, 58, 58, 60, 61$

9. Wert $= 50$, 10. Wert $= 52$

$ "Median"_("age") = frac(50 + 52, 2) = 51 $

*Schritt 3 —* Wir berechnen die Varianz für das Alter gemäss Vorlesungsformel.

$ sigma^2 = frac(1, N) sum_(i=1)^(N) (x_i - overline(x))^2 $

Wir berechnen jede quadratische Abweichung $(x_i - 46.39)^2$:

$
(23 - 46.39)^2 &= (-23.39)^2 = 547.09 \
(23 - 46.39)^2 &= 547.09 \
(27 - 46.39)^2 &= (-19.39)^2 = 376.07 \
(27 - 46.39)^2 &= 376.07 \
(39 - 46.39)^2 &= (-7.39)^2 = 54.61 \
(41 - 46.39)^2 &= (-5.39)^2 = 29.05 \
(47 - 46.39)^2 &= (0.61)^2 = 0.37 \
(49 - 46.39)^2 &= (2.61)^2 = 6.81 \
(50 - 46.39)^2 &= (3.61)^2 = 13.03 \
(52 - 46.39)^2 &= (5.61)^2 = 31.47 \
(54 - 46.39)^2 &= (7.61)^2 = 57.91 \
(54 - 46.39)^2 &= 57.91 \
(56 - 46.39)^2 &= (9.61)^2 = 92.35 \
(57 - 46.39)^2 &= (10.61)^2 = 112.57 \
(58 - 46.39)^2 &= (11.61)^2 = 134.79 \
(58 - 46.39)^2 &= 134.79 \
(60 - 46.39)^2 &= (13.61)^2 = 185.23 \
(61 - 46.39)^2 &= (14.61)^2 = 213.45
$

*Schritt 4 —* Wir summieren alle quadratischen Abweichungen.

$
sum (x_i - overline(x))^2 = 547.09 + 547.09 + 376.07 + 376.07 + 54.61 + 29.05 \
+ 0.37 + 6.81 + 13.03 + 31.47 + 57.91 + 57.91 \
+ 92.35 + 112.57 + 134.79 + 134.79 + 185.23 + 213.45 \
= 2970.66
$

$ sigma^2_("age") = frac(2970.66, 18) approx 165.04 $

$ sigma_("age") = sqrt(165.04) approx 12.85 $

*Schritt 5 —* Wir berechnen den Mean für %fat.

$
sum "%fat" = 9.5 + 26.5 + 7.8 + 17.8 + 31.4 + 25.9 + 27.4 + 27.2 + 31.2 \
+ 34.6 + 42.5 + 28.8 + 33.4 + 30.2 + 34.1 + 32.9 + 41.2 + 35.7 \
= 518.1
$

$ overline(x)_("%fat") = frac(518.1, 18) approx 28.78 $

*Schritt 6 —* Wir berechnen den Median für %fat. Dazu müssen wir die %fat-Werte zuerst sortieren (wichtig — Fehlerquelle laut Musterlösung!).

Sortierte %fat-Werte:
$7.8, 9.5, 17.8, 25.9, 26.5, 27.2, 27.4, 28.8, 30.2, 31.2, 31.4, 32.9, 33.4, 34.1, 34.6, 35.7, 41.2, 42.5$

Bei $N = 18$ ist der Median der Mittelwert der 9. und 10. Position.

9. Wert $= 30.2$, 10. Wert $= 31.2$

$ "Median"_("%fat") = frac(30.2 + 31.2, 2) = frac(61.4, 2) = 30.7 $

*Schritt 7 —* Wir berechnen die Varianz für %fat.

Wir berechnen jede quadratische Abweichung $(x_i - 28.78)^2$:

$
(9.5 - 28.78)^2 &= (-19.28)^2 = 371.72 \
(26.5 - 28.78)^2 &= (-2.28)^2 = 5.20 \
(7.8 - 28.78)^2 &= (-20.98)^2 = 440.16 \
(17.8 - 28.78)^2 &= (-10.98)^2 = 120.56 \
(31.4 - 28.78)^2 &= (2.62)^2 = 6.86 \
(25.9 - 28.78)^2 &= (-2.88)^2 = 8.29 \
(27.4 - 28.78)^2 &= (-1.38)^2 = 1.90 \
(27.2 - 28.78)^2 &= (-1.58)^2 = 2.50 \
(31.2 - 28.78)^2 &= (2.42)^2 = 5.86 \
(34.6 - 28.78)^2 &= (5.82)^2 = 33.87 \
(42.5 - 28.78)^2 &= (13.72)^2 = 188.24 \
(28.8 - 28.78)^2 &= (0.02)^2 = 0.0004 \
(33.4 - 28.78)^2 &= (4.62)^2 = 21.34 \
(30.2 - 28.78)^2 &= (1.42)^2 = 2.02 \
(34.1 - 28.78)^2 &= (5.32)^2 = 28.30 \
(32.9 - 28.78)^2 &= (4.12)^2 = 16.97 \
(41.2 - 28.78)^2 &= (12.42)^