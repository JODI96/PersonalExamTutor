// Echte Kursübungen — Woche 10 (konvertiert am 2026-05-09)
// Quelle: DATANA_03_EX_Preprocessing_Part_2(2).pptx, DATANA_10_EX_Preprocessing_Pt2_Pt3.pdf, DATANA_10_EX_LSG_Preprocessing_Pt2_Pt3_Solution.pdf

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

```typst
== Übungen

=== Aufgabe 1 — Binning & Smoothing

Die Altersattributwerte der Datentupel lauten (in aufsteigender Reihenfolge):
13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70

**(a)** Wende Smoothing by Bin Means an (Bin-Tiefe = 3).

**(b)** Welchen Effekt hat das Smoothing auf die gegebenen Daten?

**(c)** Welche anderen Methoden gibt es für Smoothing?

**(d)** Wie könnten Ausreißer in den Daten identifiziert werden?

---

=== Aufgabe 2 — Korrelationskoeffizient

Ein Krankenhaus hat Alter und Glukosespiegel von 6 zufällig ausgewählten Erwachsenen gemessen:

#table(
  columns: 7,
  [*Alter*], [43], [21], [25], [42], [57], [59],
  [*Glukose*], [99], [65], [79], [75], [87], [81],
)

**(a)** Erstelle ein Streudiagramm (Scatter Plot) basierend auf diesen zwei Attributen.

**(b)** Berechne den Korrelationskoeffizienten per Hand und interpretiere das Ergebnis.

---

=== Aufgabe 3 — Chi-Quadrat-Test

Gegeben sind folgende Daten, die die beobachtete Anzahl von Bußgeldern in Relation zur Fahrzeuggröße zeigen:

#table(
  columns: 3,
  [*Fahrzeuggröße \ Anzahl Bußgelder*], [*Kompakt*], [*Luxus*],
  [1 oder weniger], [30], [0],
  [2 oder 3], [20], [10],
  [mehr als 3], [10], [30],
)

Auszug aus einer Chi-Quadrat-Verteilungstabelle:

#table(
  columns: 4,
  [*df*], [*$alpha = 0.10$*], [*$alpha = 0.05$*], [*$alpha = 0.01$*],
  [1], [2.706], [3.841], [6.635],
  [2], [4.605], [5.991], [9.210],
  [3], [6.251], [7.815], [11.345],
)

**(a)** Berechne die Randverteilungen und die erwarteten Werte, falls `Carsize` und `NrOfFines` unabhängig wären.

**(b)** Überprüfe, ob `Carsize` und `NrOfFines` voneinander abhängen (verwende DOF = 2, $alpha = 0.1$).

---

=== Aufgabe 4 — Datenzusammenführung

Diskutiere kurz die Probleme, die beim Zusammenführen von Daten aus verschiedenen Quellen zu beachten sind.

---

=== Aufgabe 5 — Normalisierungsmethoden

Welche Wertebereiche haben die folgenden Normalisierungsmethoden?

**(a)** Min-Max-Normalisierung

**(b)** Normalisierung durch Dezimalskalierung

**(c)** Z-Score-Normalisierung

---

=== Aufgabe 6 — Normalisierung (Altersattribut)

Die Altersattributwerte der Datentupel lauten (in aufsteigender Reihenfolge):
13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70

**(a)** Wende Min-Max-Normalisierung an, um den Wert 35 für das Alter auf den Bereich $[0, 1]$ und $[-1, 1]$ zu transformieren.

**(b)** Wende Normalisierung durch Dezimalskalierung an, um den Wert 35 zu transformieren.

**(c)** Wende Z-Score-Normalisierung an, um den Wert 35 zu transformieren, wobei die Standardabweichung des Alters $sigma = 12.94$ beträgt.

**(d)** Kommentiere, welche Normalisierungsmethode du für die gegebenen Daten bevorzugen würdest und warum.

---

=== Aufgabe 7 — Zweck der Normalisierung

Warum benötigen wir Normalisierung, und worin besteht der Unterschied zur Beibehaltung der Daten in ihrem ursprünglichen Format?

---

=== Aufgabe 8 — Diskretisierung (Equidepth & Equiwidth Binning)

Besucher eines Freizeitparks wurden nach verschiedenen Kriterien erfasst, einschließlich ihres Alters:

#table(
  columns: 13,
  [*Nr.*], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12],
  [*Alter*], [7], [22], [9], [12], [22], [36], [11], [13], [38], [64], [7], [8],
)

**(a)** Führe ein Equidepth-Binning auf dem Attribut Alter durch. Das Attribut soll danach genau 3 verschiedene Werte enthalten. Entscheide dich für sinnvolle Labels für die erstellten Bins. Gib immer die untere und obere Grenze der Bins an.

**(b)** Führe nun ein Equiwidth-Binning auf dem Attribut Alter durch — ebenfalls mit 3 Bins. Welche sinnvollen Labels würden sich diesmal für die Bins anbieten? Gib erneut die untere und obere Grenze der Bins an.

**(c)** Welchen diskreten Wert für das Attribut „Alter" erhalten die folgenden unbekannten Instanzen?

#table(
  columns: 3,
  [*Alter*], [*Equidepth*], [*Equiwidth*],
  [8 Jahre], [], [],
  [10 Jahre], [], [],
  [22 Jahre], [], [],
  [45 Jahre], [], [],
  [6 Jahre], [], [],
  [70 Jahre], [], [],
)

---

=== Aufgabe 9 — Stichprobenverfahren (Stratified Sampling)

Verwende die Daten aus Aufgabe 8 und skizziere Beispiele für jede der folgenden Stichprobenverfahren: SRSWOR, SRSWR und Stratified Sampling.

Verwende eine Stichprobengröße von 5 und die Schichten (_strata_) „Jugend" (youth), „Mittelalter" (middle-aged) und „Senior". Gehe davon aus, dass zur Kategorie Jugend alle Personen im Bereich 0–19 gehören, zur Kategorie Mittelalter alle Personen im Bereich 20–51, und alle Personen über 51 als Senior kategorisiert werden.
```

== Lösungen

=== Aufgabe 1 — Smoothing by Bin Means (Binning)

==== (a) Smoothing by Bin Means (Bin-Tiefe 3)

*Schritt 1 —* Die Daten sind bereits sortiert, da dies die Voraussetzung für Binning ist (wie in der Vorlesung unter „Prerequisite: ordered data" beschrieben).

$ 13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 $

*Schritt 2 —* Die 27 Werte werden in Gruppen (Bins) der Tiefe 3 (equidepth) aufgeteilt, d.h. jeder Bin enthält genau 3 Werte.

#table(
  columns: (auto, auto, auto),
  [*Bin*], [*Werte*], [*Mittelwert*],
  [Bin 1], [13, 15, 16], [$ frac(13+15+16, 3) = frac(44,3) approx 14.67 $],
  [Bin 2], [16, 19, 20], [$ frac(16+19+20, 3) = frac(55,3) approx 18.33 $],
  [Bin 3], [20, 21, 22], [$ frac(20+21+22, 3) = frac(63,3) = 21.00 $],
  [Bin 4], [22, 25, 25], [$ frac(22+25+25, 3) = frac(72,3) = 24.00 $],
  [Bin 5], [25, 25, 30], [$ frac(25+25+30, 3) = frac(80,3) approx 26.67 $],
  [Bin 6], [33, 33, 35], [$ frac(33+33+35, 3) = frac(101,3) approx 33.67 $],
  [Bin 7], [35, 35, 35], [$ frac(35+35+35, 3) = frac(105,3) = 35.00 $],
  [Bin 8], [36, 40, 45], [$ frac(36+40+45, 3) = frac(121,3) approx 40.33 $],
  [Bin 9], [46, 52, 70], [$ frac(46+52+70, 3) = frac(168,3) = 56.00 $],
)

*Schritt 3 —* Jeder Originalwert wird durch den Mittelwert seines Bins ersetzt (Smoothing by Bin Means).

*Ergebnis:*
$ 14.67, 14.67, 14.67, | 18.33, 18.33, 18.33, | 21, 21, 21, | 24, 24, 24, | $
$ 26.67, 26.67, 26.67, | 33.67, 33.67, 33.67, | 35, 35, 35, | $
$ 40.33, 40.33, 40.33, | 56, 56, 56 $

==== (b) Effekt des Smoothings auf die gegebenen Daten

*Schritt 1 —* Der Ausreißer 70 (deutlich über dem Rest der Daten) wird auf 56 reduziert, was dem Binmittelwert von Bin 9 entspricht.

*Ergebnis:* Der Einfluss von Ausreißern (hier insbesondere der Wert 70) wird reduziert. Schwankungen werden geglättet und Trends in den Daten werden sichtbarer. Der Wert 70 wird zu 56 „gezogen", was weniger extrem ist.

==== (c) Weitere Methoden zur Datenglättung

*Ergebnis:* Laut Vorlesung (Folie „Noisy Data") gibt es folgende weitere Methoden:
- *Smoothing by Bin Boundaries*: Jeder Wert im Bin wird durch die nächstgelegene Bin-Grenze ersetzt
- *Regression*: Glättung durch Anpassung der Daten an eine (multiple) lineare Regressionsfunktion
- *Filtering*: Filter erkennen und eliminieren verrauschte Instanzen

==== (d) Ausreißererkennung

*Schritt 1 —* Bei einer univariaten Verteilung (ein Attribut) empfiehlt die Vorlesung die Verwendung von Boxplots basierend auf dem IQR (Interquartile Range).

*Schritt 2 —* Ausreißer liegen außerhalb der Whisker-Grenzen, die typischerweise bei $1.5 times "IQR"$ definiert werden:

$ "Untere Grenze" = Q_1 - 1.5 times "IQR" $
$ "Obere Grenze" = Q_3 + 1.5 times "IQR" $

*Ergebnis:* Univariate Methode: Boxplot erstellen; Werte außerhalb von $Q_1 - 1.5 times "IQR"$ bzw. $Q_3 + 1.5 times "IQR"$ gelten als Ausreißer. Bei multivariaten Daten werden statistische Methoden oder distanzbasierte Verfahren eingesetzt.

---

=== Aufgabe 2 — Korrelationskoeffizient (Alter & Glukose)

==== (a) Streudiagramm

*Schritt 1 —* Die Datenpunkte werden in einem Koordinatensystem aufgetragen, wobei die x-Achse das Alter und die y-Achse den Glukosewert darstellt.

Die Datenpunkte sind: $(43, 99)$, $(21, 65)$, $(25, 79)$, $(42, 75)$, $(57, 87)$, $(59, 81)$.

*Ergebnis:* Das Streudiagramm zeigt eine leicht positive Tendenz: höheres Alter geht tendenziell mit höherem Glukosewert einher.

==== (b) Berechnung des Pearson-Korrelationskoeffizienten

*Schritt 1 —* Mittelwerte berechnen, da der Pearson-Korrelationskoeffizient laut Vorlesung auf den Abweichungen vom Mittelwert basiert.

$ bar(x) = frac(43 + 21 + 25 + 42 + 57 + 59, 6) = frac(247, 6) approx 41.17 $

$ bar(y) = frac(99 + 65 + 79 + 75 + 87 + 81, 6) = frac(486, 6) = 81.00 $

*Schritt 2 —* Differenzen $(x_i - bar(x))$ und $(y_i - bar(y))$ berechnen, da diese die Abweichungen vom Mittelwert darstellen.

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  [$i$], [$x_i$], [$y_i$], [$x_i - bar(x)$], [$y_i - bar(y)$], [$(x_i-bar(x))(y_i-bar(y))$], [$(x_i-bar(x))^2$], 
)

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  [1], [43], [99], [1.83], [18.00], [32.94], [3.35],
  [2], [21], [65], [-20.17], [-16.00], [322.72], [406.83],
  [3], [25], [79], [-16.17], [-2.00], [32.34], [261.47],
  [4], [42], [75], [0.83], [-6.00], [-4.98], [0.69],
  [5], [57], [87], [15.83], [6.00], [94.98], [250.79],
  [6], [59], [81], [17.83], [0.00], [0.00], [317.91],
)

*Schritt 3 —* Summen berechnen für den Zähler und Nenner der Korrelationsformel.

$ sum_(i=1)^(6) (x_i - bar(x))(y_i - bar(y)) = 32.94 + 322.72 + 32.34 + (-4.98) + 94.98 + 0.00 = 478.00 $

$ sum_(i=1)^(6) (x_i - bar(x))^2 = 3.35 + 406.83 + 261.47 + 0.69 + 250.79 + 317.91 = 1241.04 $

$ sum_(i=1)^(6) (y_i - bar(y))^2 = 18^2 + (-16)^2 + (-2)^2 + (-6)^2 + 6^2 + 0^2 = 324 + 256 + 4 + 36 + 36 + 0 = 656 $

*Schritt 4 —* Den Pearson-Korrelationskoeffizienten nach der Formel aus der Vorlesung berechnen.

$ r = frac(sum_(i=1)^{n}(x_i - bar(x))(y_i - bar(y))}{sqrt(sum_(i=1)^{n}(x_i - bar(x))^2 dot sum_(i=1)^{n}(y_i - bar(y))^2)} $

$ r = frac(478.00, sqrt(1241.04 dot 656)) = frac(478.00, sqrt(814122.24)) = frac(478.00, 902.29) approx 0.530 $

*Ergebnis:* $ r approx 0.530 $

*Interpretation:* Der Korrelationskoeffizient von ca. 0.53 zeigt eine *moderate positive Korrelation* zwischen Alter und Glukosewert. Das bedeutet: Tendenziell steigt der Glukosewert mit zunehmendem Alter. Es handelt sich jedoch um eine moderate (nicht starke) Beziehung, und der Datensatz mit nur 6 Beobachtungen ist sehr klein. Wichtig: *Korrelation ≠ Kausalität* (wie in der Vorlesung betont).

---

=== Aufgabe 3 — Chi-Quadrat-Test (Carsize & NrOfFines)

==== (a) Randverteilungen und Erwartungswerte

*Schritt 1 —* Die Zeilensummen (Randverteilungen) und Gesamtsumme berechnen, da diese für die Berechnung der Erwartungswerte benötigt werden.

#table(
  columns: (auto, auto, auto, auto),
  [*NrOfFines \\ Carsize*], [*Compact*], [*Luxury*], [*Zeilensumme*],
  [1 or less], [30], [0], [30],
  [2 or 3], [20], [10], [30],
  [more than 3], [10], [30], [40],
  [*Spaltensumme*], [*60*], [*40*], [*100*],
)

*Schritt 2 —* Die Erwartungswerte $E_(i j)$ berechnen. Laut Vorlesung gilt bei Unabhängigkeit zweier Merkmale:

$ E_(i j) = frac("Zeilensumme"_i times "Spaltensumme"_j, "Gesamtsumme") $

*Schritt 3 —* Jeden Erwartungswert einzeln ausrechnen:

$ E_(11) = frac(30 times 60, 100) = frac(1800, 100) = 18 quad ("1 or less", "Compact") $

$ E_(12) = frac(30 times 40, 100) = frac(1200, 100) = 12 quad ("1 or less", "Luxury") $

$ E_(21) = frac(30 times 60, 100) = frac(1800, 100) = 18 quad ("2 or 3", "Compact") $

$ E_(22) = frac(30 times 40, 100) = frac(1200, 100) = 12 quad ("2 or 3", "Luxury") $

$ E_(31) = frac(40 times 60, 100) = frac(2400, 100) = 24 quad ("more than 3", "Compact") $

$ E_(32) = frac(40 times 40, 100) = frac(1600, 100) = 16 quad ("more than 3", "Luxury") $

*Ergebnis:* Tabelle der Erwartungswerte (bei Unabhängigkeit):

#table(
  columns: (auto, auto, auto),
  [*NrOfFines \\ Carsize*], [*Compact*], [*Luxury*],
  [1 or less], [18], [12],
  [2 or 3], [18], [12],
  [more than 3], [24], [16],
)

==== (b) Chi-Quadrat-Test auf Abhängigkeit

*Schritt 1 —* Den Chi-Quadrat-Wert nach der Formel aus der Vorlesung berechnen:

$ chi^2 = sum_(i=1)^(r) sum_(j=1)^(c) frac((O_(i j) - E_(i j))^2, E_(i j)) $

*Schritt 2 —* Jeden Summanden einzeln berechnen:

$ frac((O_(11) - E_(11))^2, E_(11)) = frac((30 - 18)^2, 18) = frac(144, 18) = 8.00 $

$ frac((O_(12) - E_(12))^2, E_(12)) = frac((0 - 12)^2, 12) = frac(144, 12) = 12.00 $

$ frac((O_(21) - E_(21))^2, E_(21)) = frac((20 - 18)^2, 18) = frac(4, 18) approx 0.222 $

$ frac((O_(22) - E_(22))^2, E_(22)) = frac((10 - 12)^2, 12) = frac(4, 12) approx 0.333 $

$ frac((O_(31) - E_(31))^2, E_(31)) = frac((10 - 24)^2, 24) = frac(196, 24) approx 8.167 $

$ frac((O_(32) - E_(32))^2, E_(32)) = frac((30 - 16)^2, 16) = frac(196, 16) = 12.25 $

*Schritt 3 —* Alle Summanden addieren:

$ chi^2 = 8.00 + 12.00 + 0.222 + 0.333 + 8.167 + 12.25 = 40.972 $

*Schritt 4 —* Freiheitsgrade bestimmen. Laut Vorlesung gilt:

$ "DOF" = (r - 1) times (c - 1) = (3 - 1) times (2 - 1) = 2 times 1 = 2 $

*Schritt 5 —* Den berechneten Chi-Quadrat-Wert mit dem Tabellenwert vergleichen. Bei $"DOF" = 2$ und $alpha = 0.1$ beträgt der kritische Wert aus der Tabelle $chi^2_(0.1, 2) = 4.605$.

$ 40.972 >> 4.605 $

*Ergebnis:* Da $chi^2_("berechnet") = 40.97 > 4.605 = chi^2_("kritisch")$, wird die Nullhypothese (Unabhängigkeit von Carsize und NrOfFines) *abgelehnt*. Es besteht eine statistisch signifikante Abhängigkeit zwischen der Fahrzeuggröße und der Anzahl der Bußgelder.

---

=== Aufgabe 4 — Probleme beim Zusammenführen von Daten

*Ergebnis:* Beim Zusammenführen von Daten aus verschiedenen Quellen sind folgende Aspekte zu beachten (aus der Vorlesung: Redundanz, fehlende Werte, Rauschen):

- *Verschiedene Formate*: z.B. Datumsformate (DD.MM.YYYY vs. MM/DD/YYYY)
- *Tippfehler / Inkonsistenzen*: z.B. „Zürich" vs. „Zuerich" vs. „zürich"
- *Verschiedene Einheiten*: z.B. km vs. Meilen, CHF vs. EUR
- *Redundante Attribute*: Dasselbe Merkmal unter verschiedenen Namen
- *Irrelevante Features*: Attribute ohne Bezug zur Analyse
- *Duplikate*: Dieselbe Entität mehrfach in der kombinierten Tabelle
- *Sparsity*: Neue Attribute führen zu vielen fehlenden Werten (Missing Values) bei Tupeln, die diese Attribute nicht besitzen

---

=== Aufgabe 5 — Wertebereiche der Normalisierungsmethoden

==== (a) Min-Max-Normalisierung

*Ergebnis:* Der Wertebereich ist frei wählbar durch $R = [min_R, max_R]$. Standardmäßig wird auf $[0, 1]$ normalisiert. Der Bereich kann aber beliebig gesetzt werden, z.B. $[-1, 1]$.

==== (b) Normalisierung durch Dezimalskalierung

*Ergebnis:* Da durch $10^j$ dividiert wird und $j$ so gewählt wird, dass $|v'_i| < 1$, liegt der Wertebereich im Intervall $(-1, 1)$.

==== (c) Z-Score-Normalisierung

*Ergebnis:* Der Wertebereich ist theoretisch $(-infinity, +infinity)$, ausgedrückt in Standardabweichungen vom Mittelwert. In der Praxis liegen die meisten Werte im Bereich $[-3, 3]$ (bei Normalverteilung).

---

=== Aufgabe 6 — Normalisierung des Altersattributs (Wert 35)

*Vorbereitung —* Aus den Daten (13 bis 70) werden die benötigten Kennzahlen abgelesen:
$ min_A = 13, quad max_A = 70 $
$ bar(A) = frac(13+15+16+...+70, 27) = frac(809, 27) approx 29.96 $

==== (a) Min-Max-Normalisierung

*Schritt 1 —* Formel für Min-Max-Normalisierung aus der Vorlesung anwenden:

$ v'_i = frac(v_i - min_A, max_A - min_A) dot (max_R - min_R) + min_R $

*Schritt 2 —* Normalisierung auf $R = [0, 1]$:

$ v'_i = frac(35 - 13, 70 - 13) dot (1 - 0) + 0 = frac(22, 57) approx 0.386 $

*Schritt 3 —* Normalisierung auf $R = [-1, 1]$:

$ v'_i = frac(35 - 13, 70 - 13) dot (1 - (-1)) + (-1) = 0.386 dot 2 - 1 = 0.772 - 1 = -0.228 $

*Ergebnis:*
- $R = [0,1]$: $ v'_i = frac(22,57) approx 0.386 $
- $R = [-1,1]$: $ v'_i approx -0.228 $

==== (b) Normalisierung durch Dezimalskalierung

*Schritt 1 —* Den maximalen Absolutwert bestimmen, um $j$ zu finden (kleinste ganze Zahl, sodass $|v'_i| < 1$):

$ |max_A| = 70 $

*Schritt 2 —* $j$ bestimmen: $10^1 = 10$ (zu klein, da $70/10 = 7 >= 1$), also $j = 2$, da $70/100 = 0.7 < 1$.

$ v'_i = frac(v_i, 10^j) = frac(35, 10^2) = frac(35, 100) = 0.35 $

*Ergebnis:* $ v'_i = 0.35 $

==== (c) Z-Score-Normalisierung

*Schritt 1 —* Formel aus der Vorlesung anwenden mit $bar(A) = 29.96$ und $sigma_A = 12.94$:

$ v'_i = frac(v_i - bar(A), S_A) = frac(35 - 29.96, 12.94) = frac(5.04, 12.94) approx 0.389 $

*Ergebnis:* $ v'_i approx 0.389 $

==== (d) Kommentar zur bevorzugten Normalisierungsmethode

*Ergebnis:* Für das Altersattribut mit dem gegebenen Datensatz bietet sich die *Min-Max-Normalisierung* an, wenn sinnvolle Grenzen gewählt werden (z.B. 0 bis 100 Jahre für Alter). Dies ist intuitiv interpretierbar. Die Z-Score-Normalisierung wäre geeignet, wenn das Alter normalverteilt wäre — dies ist hier nicht eindeutig gegeben. Die Dezimalskalierung ist einfach, aber weniger präzise, da sie nur grob auf eine Einheitsgröße skaliert.

---

=== Aufgabe 7 — Warum Normalisierung?

*Ergebnis:* Normalisierung ist notwendig, weil:

- *Verschiedene Einheiten und Skalen*: Attribute mit großen numerischen Bereichen (z.B. Einkommen: 10.000–100.000) dominieren gegenüber Attributen mit kleinen Bereichen (z.B. Alter: 0–100) in Algorithmen wie k-NN oder Clustering — *nicht weil sie wichtiger sind, sondern weil ihre Zahlenwerte größer sind*.
- *Faire Gewichtung*: Normalisierung stellt sicher, dass das Gewicht eines Attributs nicht von der Wahl der Maßeinheit abhängt (wie in der Vorlesung erklärt: „The weight of an attribute shall not be dependent on the choice of measurement units").
- *Vergleichbarkeit*: Nach der Normalisierung können Modellgewichte verschiedener Parameter direkt verglichen werden (z.B. Gewicht 0.3 für Alter vs. 0.31 für Einkommen → ähnlicher Einfluss).

---

=== Aufgabe 8 — Diskretisierung (Equidepth & Equiwidth Binning)

*Vorbereitung —* Die Alterswerte werden sortiert, da Binning geordnete Daten voraussetzt:

$ 7, 7, 8, 9, 11, 12, 13, 22, 22, 36, 38, 64 $

Insgesamt $n = 12$ Instanzen.

==== (a) Equidepth Binning (3 Bins)

*Schritt 1 —* Bin-Tiefe berechnen: Bei 12 Instanzen und 3 Bins enthält jeder Bin $12 div 3 = 4$ Werte.

*Schritt 2 —* Werte auf die Bins aufteilen:

#table(
  columns: (auto, auto),
  [*Bin*], [*Werte*],
  [Bin 1], [7, 7, 8, 9],
  [Bin 2], [11, 12, 13, 22],
  [Bin 3], [22, 36, 38, 64],
)

*Schritt 3 —* Bin-Grenzen festlegen. Laut Vorlesung müssen die Grenzen *disjunkt* (keine Überlappungen) und *adjazent* (keine Lücken) sein, damit jede unbekannte Instanz eindeutig einem Bin zugeordnet werden kann.

Hinweis: Der Wert 22 kommt zweimal vor — eine Instanz gehört zu Bin 2, die andere zu Bin 3. Die Grenze muss daher so gewählt werden, dass $22$ entweder zu Bin 2 *oder* zu Bin 3 gehört (hier: $< 22$ für Bin 2, $>= 22$ für Bin 3).

*Schritt 4 —* Sinnvolle Grenzen mit Hintergrundwissen (Alter: 0–100) wählen:

#table(
  columns: (auto, auto, auto, auto),
  [*Bin*], [*Untere Grenze*], [*Obere Grenze*], [*Label*],
  [Bin 1], [$>= 0$ Jahre], [$< 11$ Jahre], [Children],
  [Bin 2], [$>= 11$ Jahre], [$< 22$ Jahre], [Youths],
  [Bin 3], [$>= 22$ Jahre], [$<= 100$ Jahre], [Adults],
)

*Ergebnis:* Equidepth-Bins: Children $[0, 11)$, Youths $[11, 22)$, Adults $[22, 100]$

==== (b) Equiwidth Binning (3 Bins)

*Schritt 1 —* Die Breite der Bins berechnen: Bei Equiwidth-Binning werden gleich breite Intervalle erzeugt.

$ "Breite" = frac(max - min, k) = frac(64 - 7, 3) = frac(57, 3) = 19 $

*Schritt 2 —* Bin-Grenzen berechnen:
- Bin 1: $[7, 7 + 19) = [7, 26)$
- Bin 2: $[26, 26 + 19) = [26, 45)$
- Bin 3: $[45, 64]$

*Schritt 3 —* Mit Hintergrundwissen (0–100) angepasste Grenzen:

#table(
  columns: (auto, auto, auto, auto),
  [*Bin*], [*Untere Grenze*], [*Obere Grenze*], [*Label*],
  [Bin 1], [$>= 0$ Jahre], [$< 26$ Jahre], [young],
  [Bin 2], [$>= 26$ Jahre], [$< 45$ Jahre], [middle],
  [Bin 3], [$>= 45$ Jahre], [$<= 100$ Jahre], [old],
)

*Ergebnis:* Equiwidth-Bins: young $[0, 26)$, middle $[26, 45)$, old $[45, 100]$

==== (c) Zuweisung unbekannter Instanzen

*Schritt 1 —* Jede unbekannte Instanz wird anhand der definierten Bin-Grenzen zugeordnet.

#table(
  columns: (auto, auto, auto),
  [*Alter*], [*Equidepth*], [*Equiwidth*],
  [8 Jahre], [Children $[0,11)$], [young $[0,26)$],
  [10 Jahre], [Children $[0,11)$], [young $[0,26)$],
  [22 Jahre], [Adults $[22,100]$], [young $[0,26)$],
  [45 Jahre], [Adults $[22,100]$], [old $[45,100]$],
  [6 Jahre], [Children $[0,11)$], [young $[0,26)$],
  [70 Jahre], [Adults $[22,100]$], [old $[45,100]$],
)

*Ergebnis:* Alle unbekannten Instanzen können eindeutig einem Bin zugeordnet werden, da die Grenzen adjazent und disjunkt sind. Instanzen außerhalb des Trainingsbereichs (z.B. 6 oder 70 Jahre) werden dem passenden Randbin zugewiesen.

---

=== Aufgabe 9 — Sampling-Methoden

*Vorbereitung —* Der Datensatz aus Aufgabe 1 wird verwendet: 13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 ($N = 27$, Stichprobengröße $s = 5$)

==== SRSWOR (Simple Random Sample Without Replacement)

*Schritt 1 —* Laut Vorlesung werden $s = 5$ Werte zufällig aus $D$ gezogen, wobei jeder Wert *genau einmal* gezogen werden kann (ohne Zurücklegen).

*Ergebnis (Beispiel):* $ {16, 20, 25, 35, 40} $
Jeder Wert erscheint höchstens einmal in der Stichprobe.

==== SRSWR (Simple Random Sample With Replacement)

*Schritt 1 —* Laut Vorlesung wird jeder gezogene Wert nach dem Ziehen zurück in $D$ gelegt und kann erneut gezogen werden.

*Ergebnis (Beispiel):* $ {15, 15, 22, 22, 22} $
Derselbe Wert kann mehrfach in der Stichprobe vorkommen.

==== Stratified Sampling

*Schritt 1 —* Den Datensatz gemäß den Strata aufteilen:
- *Youth* (0–19): $13, 15, 16, 16, 19$ → $n_"youth" = 5$
- *Middle