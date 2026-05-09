// Echte Kursübungen — Woche 2 (konvertiert am 2026-05-09)
// Quelle: DW_01.adoc, DW_02.adoc, README.adoc, Erweiterung_DW.adoc, star_schema.adoc

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

```typst
== Übungen

=== Aufgabe 1 — Star Schema

Für unser Data Warehouse muss aus dem relationalen Modell ein Star Schema entworfen werden.
Bei einem Star Schema wird bewusst Redundanz eingefügt, so dass die Abfragen einfacher und die Antwortzeit besser werden.
Das Star Schema besteht aus einer oder mehreren Fakten-Tabellen, welche die primären Informationen beinhalten,
und mehreren Dimensions-Tabellen, welche dann genauere Informationen zu den Fakten speichern.

*Lernziele:*
- Sie können einfache Star-Schemata entwerfen
- Sie kennen die Grundbegriffe des Dimensional Modelings

Entwerfen Sie das Star-Schema, welches für unser Data Warehouse verwendet werden kann:

**(a)** Folgende Auswertungen sollen möglich sein: Abfragen der Verkaufszahlen (Anzahl, Preis) gruppiert nach Movie, Movie-Genre, Subgenre, Kunde, Datum, Monat, Halbjahr, Jahr.

**(b)** Bestimmen Sie die Fakten-Tabellen. — Enthalten alle für das Business relevanten Daten.

**(c)** Bestimmen Sie die Dimension Table(s). — Enthalten Zusatzinformationen zu den Daten in der/den Fakten-Tabelle(n).

**(d)** Zeichnen Sie das Stern-Schema.

**(e)** Was ist die Granularität der Fakten-Tabelle?

**(f)** Klassifizieren Sie die Fakten-Tabelle!

---

=== Aufgabe 2 — Erweiterung des DW

Unsere Firma wächst und betreibt ein Filialnetz. Die Filialen beziehen ihre Movies aus einem der regionalen Lager.
Die Lagerdaten sollen nun in unserem DW gespeichert werden. Das soll u. A. folgende Abfragen ermöglichen:

- Bestand eines Movies an einem Lagerort um 24h
- Durchschnittlicher Bestand pro Woche eines Movies an allen Lagerorten

Nachts finden in unserer Firma weder Movie-Bezüge durch Filialen noch Anlieferungen an die Lager statt.
Somit können die Daten aus den Standorten der regionalen Lager dann bezogen werden, ohne dass sie sich gleichzeitig ändern.
Dazu werden jede Nacht um 23 Uhr die aktuellen Daten der verschiedenen Lager via Internet geliefert
und im DW aktualisiert (ETL-Prozess). Zwischen 23h und 24h ist das DW für Abfragen nicht verfügbar.
Ab 24h ist der Lagerbestand aktualisiert.

Folgende Daten werden geliefert:

- Bezug von Movies, für jedes Lager: LagerId, FilialId, MovieId, Anzahl, Datum
- Anlieferung von Movies ins Lager, für jedes Lager: LagerId, LieferantenId, MovieId, Anzahl, Datum, Lieferpreis pro Stück

Erweitern Sie das DW um einen zusätzlichen „Lager-Stern"! Erweitern Sie dazu das Modell um die Dimension
Lager (LagerId, Bezeichnung) und um eine geeignete Fakten-Tabelle.
Diese darf auch Verweise auf bereits bestehende Dimensions-Tabellen haben.

---

=== Aufgabe 3 — Implementation MovieDW

In der vorherigen Aufgabe haben Sie das Star Schema für das Data Warehouse entworfen.
Um die Abfragen der folgenden Aufgaben einheitlich zu halten,
arbeiten Sie mit dem bereits in der Einführung installierten Schema,
welches der Musterlösung von Aufgabe 1 entspricht, weiter.

*Lernziele:*
- Sie können einfache ETL-Prozesse nachvollziehen
- Sie kennen das Prinzip von Slowly Changing Dimensions (SCD)
- Sie können SCD mit Historisierung (SCD2) auf Attribute von Dimensionstabellen anwenden

Studieren Sie das Skript von Aufgabe 1 und vergleichen Sie dieses mit Ihrem Star-Schema.
Analysieren Sie den SQL-Code aus der Einführung.
Beachten Sie speziell die Dateien, welche sich auf das Data Warehouse beziehen.

Beachten Sie, dass sich die OLTP-Datenbank und das Data Warehouse in derselben Datenbank `VideoDB` befinden:
Die OLTP-Datenbank im Schema `video_oltp`, das Data Warehouse im Schema `video_dw`.

*Hinweise:*

- Die Tabelle `dim_movie` erhält das Attribut `genre`, welches durch das Subgenre bestimmt wird.
- Genre wird auf `'Action'` gesetzt, wenn das Subgenre Action, Science-Fiction oder Thriller ist. Die restlichen MovieGenres werden auf `'Non-Action'` gesetzt.
- Das Geburtsdatum des Kunden wird in das Jahrzehnt und in Vierteljahrhunderte eingeteilt. Dazu existieren die Attribute `decade` und `quarter_century` in der Tabelle `customer`.
- Kunden, die im Jahr 1900 bis 1910 geboren wurden, erhalten `decade` = `0`, 1910 bis 1920 erhalten `decade` = `1`, usw. Dasselbe gilt für `quarter_century`. Kunden, die zwischen 1900 und 1925 geboren wurden, erhalten den Wert `0`, usw.
- Es gibt eine Tabelle `dim_time`: Diese wird abhängig vom Attribut Verkaufsdatum aus der Tabelle `sale` gefüllt.
- Das Attribut Season erhält den Wert `'Spring'` für die Monate 3–5, `'Summer'` für die Monate 6–8, `'Fall'` für die Monate 9–11 und `'Winter'` für die Monate 12–2.
- Mit der Funktion `to_char(sale_date, 'YYYY')` kann aus einem Datum das Jahr herausgelesen werden.
- Mit der Funktion `to_date('1900', 'YYYY')` kann aus einem String (z. B. Jahresangabe) ein Datum (`date`) erstellt werden.

*Tipp zu `psql`/pgAdmin:* Setzen Sie im SQL-Query-Fenster den Suchpfad auf das Schema `video_dw`:

```sql
SET SEARCH_PATH=video_dw;
```

(Sonst müssen Sie die Tabellen mit `<SchemaId>.<TableId>` angeben, z. B. `video_dw.dim_customer`.)

*Erweiterung der Tabelle `dim_customer`:*

Die Tabelle `dim_customer` enthält das Attribut `city`. Natürlich kann sich im Laufe der Zeit der Wohnort eines Kunden ändern.

**(a)** Historisieren Sie das Attribut `city` mit dem SCD2-Ansatz.

**(b)** Ändern Sie die Daten von `dim_customer` wie folgt:
Der Kunde `'Marxer, Markus'` wechselt per 1.2.2013 seinen Wohnsitz von Rapperswil nach Zürich.

**(c)** Fügen Sie die folgenden Neuzugänge in der Faktentabelle ein:
- `'Star Wars I'` am 2.2.2013, gekauft durch Kunde `'Marxer, Markus'`
- `'Star Wars II'`, gekauft am 1.3.2013 durch Kunde `'Marxer, Markus'`

**(d)** Testen Sie ihre Implementation:
- Ausgabe des Totals von `fact_sales.sales_amount` des Kunden `'Marxer, Markus'`
- Ausgabe des Totals von `fact_sales.sales_amount` des Kunden `'Marxer, Markus'` in `'Zuerich'`

---

=== Aufgabe 4 — `CUBE`- und `ROLLUP`-Operatoren

Mit den SQL-Operatoren `CUBE` und `ROLLUP` lassen sich einfach Übersichten und Zusammenfassungen erzeugen.

*Lernziele:*
- Sie können Anfragen mit `CUBE`- und `ROLLUP`-Operatoren formulieren.

*Hinweise:*
- Das Attribut `sales_amount` in der Tabelle `fact_sales` stellt bereits den Gesamtpreis (Film-Preis · Anzahl) dar.
- Die Genres sind bereits direkt in der Tabelle `dim_movie` abgelegt; dies erleichtert die Abfragen um einen weiteren Join.

Erstellen Sie folgende Übersichten, indem Sie den `CUBE`- und `ROLLUP`-Operator verwenden:

**(a)** Gesucht ist die Anzahl verkaufter Filme, gegliedert nach Monat und das Total über das ganze Jahr.
Ausgabe: Monat, Anzahl Verkäufe.
Verwenden Sie den `ROLLUP`-Operator.

**(b)** Gesucht ist die Anzahl verkaufter Filme, gegliedert nach Jahr, Jahreszeit (Season) und Monat.
Zusätzlich soll das Total für jede Jahreszeit und über das ganze Jahr ausgegeben werden.
Ausgabe: Jahr, Jahreszeit, Monat, Anzahl Verkäufe.
Verwenden Sie den `ROLLUP`-Operator.

Versuchen Sie ausgehend von den Resultaten folgende Fragen zu beantworten:
- Zu welcher Jahreszeit werden die meisten Filme verkauft?
- Mitte August 2015 wurde eine Werbekampagne gestartet. Brachte diese den gewünschten Erfolg?
- Wie sieht es mit dem Weihnachtsgeschäft aus? Ab wann muss mit vermehrten Einkäufen für Weihnachten gerechnet werden?

**(c)** Als nächstes interessiert uns, welche Filmsparte (Subgenre) von welchem Geschlecht bevorzugt wird.
Erstellen Sie dazu eine Übersicht mit den Filmsparten, Geschlecht und den verkauften Filmen.
Zusätzlich sollen das Total pro Filmsparte, das Total pro Geschlecht und das Total über alles ausgegeben werden.
Verwenden Sie den `CUBE`-Operator.

**(d)** Die vorherige Abfrage war zu genau. Jetzt sind wir nur noch daran interessiert,
welches Geschlecht mehr Action- und welches mehr Non-Action-Filme kauft.
Verwenden Sie den `CUBE`-Operator.

**(e)** Was für eine Filmsparte (Action, Non-Action) kaufen sich ältere Menschen,
und was für eine Sparte kaufen vorwiegend jüngere Menschen?
Untersuchen Sie diese Fragestellung mit Hilfe einer Abfrage,
welche die Verkäufe pro Sparte und Alter (QuarterCentury) auflistet.
Verwenden Sie den `CUBE`-Operator.

**(f)** Unterschied `ROLLUP`- und `CUBE`-Operator:
Vergewissern Sie sich den Unterschied zwischen dem `ROLLUP`- und dem `CUBE`-Operator.
Nehmen Sie dazu die Abfrage des obigen Beispiels und führen Sie diese mit dem `CUBE`- und dem `ROLLUP`-Operator aus.
Bilden Sie die Differenz der Resultate der beiden Abfragen.

---

=== Aufgabe 5 — Analytische Funktionen

Moderne DBMS bieten eine Reihe von analytischen Funktionen, um die Daten im Data Warehouse genauer zu untersuchen.
Dazu gehören unter anderem das Erstellen von Ranglisten, lineare Regression, Verteilung und hypothetische Ranglisten.

*Lernziele:*
- Sie können analytische Abfragen formulieren.

**(a)** Erstellen Sie eine Rangliste der Filmsparten (subgenre) nach Umsatz.
Ausgabe: Umsatz-Rang (tiefere Rang-Nr. = höherer Umsatz), Sparte, Anzahl Verkäufe, Umsatz;
sortiert nach Umsatz bzw. Rang (höchster Umsatz zuoberst).
Verwenden Sie für diese Abfrage die `RANK()`-Funktion.

**(b)** Erstellen Sie eine Rangliste der Geschlechter nach Anzahl verkaufter Filme.
Ausgabe: Rang (tiefere Rang-Nr. = höhere Anzahl), Geschlecht, Anzahl Verkäufe;
sortiert nach Anzahl bzw. Rang (höchste Anzahl zuoberst).

**(c)** Mit der `RANK()`-Funktion lassen sich auch Ranglisten innerhalb von Gruppen erstellen.

- Erstellen Sie dazu zuerst eine Übersicht über die Umsätze pro Filmsparten (Subgenre) und Geschlecht mit dem `CUBE`-Operator.
- Fügen Sie noch den Rang innerhalb der einzelnen Gruppen hinzu.
- Jetzt sollte es
  - eine Rangliste innerhalb der Verkäufe pro Sparte und Geschlecht,
  - eine Rangliste innerhalb der Verkäufe pro Sparte und
  - eine Rangliste innerhalb der Verkäufe pro Geschlecht
  geben.

Hinweis: Verwenden Sie `PARTITION BY GROUPING(...)` um nach der Gruppe zu partitionieren.

**(d)** Als nächstes interessieren uns die Anzahl verkaufter Filme pro Monat.
Es soll eine Zusammenfassung erstellt werden, die das Jahr, den Monat, die Anzahl verkaufter Filme
und zusätzlich die kumulierte Anzahl verkaufter Filme innerhalb des Kalenderjahres
(YTD = year to date) darstellt — also die Anzahl Filme,
die in vorangehenden Monaten des selben Jahres und im jeweiligen Monat selbst insgesamt verkauft wurden.

**(e)** Windowing: Modifizieren Sie die obige Anfrage so,
dass statt der YTD-Anzahl der Durchschnitt über die letzten 3 Monate erscheint (sog. Moving Average).
Ignorieren Sie dabei die beiden einzelnen Verkäufe in 2013.

**(f)** Erstellen Sie eine Anfrage, die die aktuellen Verkaufszahlen sowie die Verkaufszahlen des Vormonats ausgibt.
Hinweis: Verwenden Sie die `LAG`-Funktion.
```

== Lösungen

=== Aufgabe 1 — Star Schema (Video-Verleih DW)

==== Schritt 1 — Identifikation der Fakten (Measures)
*Schritt 1 —* Wir bestimmen zuerst die numerischen, aggregierbaren Kennzahlen (Measures/Fakten) laut Vorlesungsterminologie: Die Faktentabelle enthält nur numerische Werte und Fremdschlüssel auf Dimensionstabellen.

Aus den geforderten Auswertungen (Verkaufszahlen nach Anzahl und Preis) ergeben sich folgende Fakten:
- `quantity` (Anzahl verkaufter Exemplare eines Films)
- `sales_amount` (Gesamtpreis = Filmpreis × Anzahl)

==== Schritt 2 — Bestimmung der Dimensionen
*Schritt 2 —* Laut Stern-Schema-Konzept aus der Vorlesung beschreiben Dimensionstabellen die Fakten. Wir leiten die Dimensionen aus den geforderten Gruppierungskriterien ab:

- *DimMovie*: Movie, Subgenre, Genre → enthält Informationen zum Film
- *DimCustomer*: Kunde, Geschlecht, Geburtsjahrgruppe → enthält Kundeninformationen
- *DimTime*: Datum, Monat, Halbjahr, Jahr, Jahreszeit → enthält Zeitinformationen

==== Schritt 3 — Bestimmung der Faktentabelle
*Schritt 3 —* Die Faktentabelle `fact_sales` referenziert alle Dimensionen per Fremdschlüssel und enthält die Measures:

```
fact_sales:
  sale_id          (PK-Komponente)
  sale_detail_id   (PK-Komponente)
  movie_id         (FK → dim_movie)
  cust_id          (FK → dim_customer)
  time_id          (FK → dim_time)
  quantity         INTEGER
  sales_amount     DECIMAL(6,1)
```

==== Schritt 4 — Dimensionstabellen im Detail
*Schritt 4 —* Jede Dimensionstabelle erhält gemäss DW-Design-Grundsätzen einen Surrogatschlüssel:

```
dim_movie:
  movie_id     (PK, Surrogatschlüssel)
  name         VARCHAR(30)
  price        DECIMAL(5,2)
  subgenre_id  INTEGER
  subgenre     VARCHAR(20)
  genre        VARCHAR(10)   -- abgeleitet: 'Action' oder 'Non-Action'

dim_customer:
  cust_id          (PK, Surrogatschlüssel)
  name             VARCHAR(20)
  first_name       VARCHAR(20)
  city             VARCHAR(20)
  birthday         DATE
  gender           CHAR(1)
  decade           INTEGER   -- Geburtsjahrzenht (0=1900-1910, 1=1910-1920, ...)
  quarter_century  INTEGER   -- Vierteljahrundert (0=1900-1925, ...)

dim_time:
  time_id   (PK, Surrogatschlüssel)
  ddate     DATE
  month     INTEGER
  season    VARCHAR(10)  -- 'Spring','Summer','Fall','Winter'
  year      INTEGER
```

==== Schritt 5 — Stern-Schema-Diagramm (textuell)
*Schritt 5 —* Das resultierende Stern-Schema zeigt die zentrale Faktentabelle mit den umgebenden Dimensionstabellen (wie in der Vorlesung als "Eine Faktentabelle, mehrere Dimensionstabellen" beschrieben):

```
             dim_customer
                  |
                  | cust_id
                  |
dim_time ------- fact_sales ------- dim_movie
  time_id          |
                   | (sale_id, sale_detail_id = PK)
                   | quantity, sales_amount
```

*Ergebnis (Granularität):* Die Granularität der Faktentabelle entspricht einem *Sale Line Item*, d.h. dem Verkauf einer Anzahl Exemplare eines bestimmten Films an einen bestimmten Kunden zu einem bestimmten Zeitpunkt. Dies entspricht einer Zeile in der OLTP-Tabelle `sale_detail`.

*Ergebnis (Klassifikation):* Es handelt sich um eine *Transaction Fact Table* gemäss Vorlesungsklassifikation, da jeder Eintrag einem Ereignis (Kauftransaktion) entspricht, das sich zu einem bestimmten Zeitpunkt ereignete.

---

=== Aufgabe 2 — Erweiterung des DW (Lager-Stern)

==== Schritt 1 — Analyse der Anforderungen
*Schritt 1 —* Wir analysieren die geforderten Abfragen, um die passende Fakten-Tabellen-Klassifikation zu bestimmen: Bestand eines Films an einem Lagerort um 24h (Tagesendbestand) und Durchschnittsbestand pro Woche.

Da täglich um 23h ein Snapshot der Lagerbestände geliefert wird und wir den *resultierenden Bestand* (keine einzelnen Transaktionen) speichern wollen, handelt es sich um eine *Periodic Snapshot Fact Table* gemäss Vorlesungsklassifikation.

==== Schritt 2 — Neue Dimension identifizieren
*Schritt 2 —* Zusätzlich zu den bereits bestehenden Dimensionen `dim_movie` und `dim_time` (Conformed Dimensions gemäss Vorlesung, die für mehrere Faktentabellen einheitlich verwendet werden) wird eine neue Dimension `dim_warehouse` benötigt:

```
dim_warehouse:
  warehouse_id   (PK, Surrogatschlüssel)
  name           VARCHAR(30)
```

Die Angaben `FilialId`, `LieferantenId` und `Lieferpreis` werden beim ETL-Prozess verworfen, da sie für die geforderten Auswertungen nicht relevant sind.

==== Schritt 3 — Neue Faktentabelle definieren
*Schritt 3 —* Die neue Faktentabelle `fact_stock` bildet den täglichen Lagerbestand-Snapshot ab. Beim nächtlichen ETL-Prozess werden Bezüge (negativ) und Anlieferungen (positiv) aus den Vortagesbeständen verrechnet:

```
fact_stock:
  fact_stock_id       (PK, Surrogatschlüssel)
  warehouse_id        (FK → dim_warehouse)
  movie_id            (FK → dim_movie)
  time_id             (FK → dim_time)
  quantity_in_stock   INTEGER   -- Tagesendbestand um 24h
```

==== Schritt 4 — Lager-Stern-Schema (textuell)
*Schritt 4 —* Das vollständige Stern-Schema für den Lager-Stern mit Wiederverwendung der Conformed Dimensions:

```
           dim_warehouse
                 |
                 | warehouse_id
                 |
dim_time ------- fact_stock ------- dim_movie
  time_id          |
                   | fact_stock_id = PK
                   | quantity_in_stock
```

*Ergebnis (Klassifikation):* Die neue Faktentabelle `fact_stock` ist eine *Periodic Snapshot Fact Table*, da sie kumulative Grössen (Lagerbestand) in regelmässigen Intervallen (täglich um 24h) erfasst.

*Ergebnis (Conformed Dimensions):* `dim_movie` und `dim_time` sind *Conformed Dimensions*, die sowohl vom Verkaufs-Stern (`fact_sales`) als auch vom Lager-Stern (`fact_stock`) gemeinsam genutzt werden. Dadurch sind Abfragen über beide Faktentabellen möglich (z.B. Vergleich Verkaufszahlen mit Lagerbestand).

---

=== Aufgabe 3 — SCD2 für `city` in `dim_customer`

==== Schritt 1 — Konzept SCD Typ 2 aus der Vorlesung
*Schritt 1 —* Laut Vorlesung historisiert SCD Typ 2 Änderungen durch einen neuen Zeileneintrag mit Gültigkeitsattributen `valid_from` und `valid_to`. Der Surrogatschlüssel (PK) muss erweitert werden, damit für dieselbe Person mehrere Einträge existieren können. Der Business Key identifiziert die Entität eindeutig.

==== Schritt 2 — Tabelle `dim_customer` für SCD2 erweitern
*Schritt 2 —* Wir fügen die Historisierungsattribute gemäss SCD-Typ-2-Schema zur Tabelle `dim_customer` hinzu:

```sql
ALTER TABLE dim_customer
  ADD COLUMN valid_from DATE,
  ADD COLUMN valid_to   DATE,
  ADD COLUMN is_current BOOLEAN DEFAULT TRUE;
```

Die bestehenden Einträge erhalten initiale Gültigkeitswerte:

```sql
UPDATE dim_customer
SET valid_from = '1900-01-01',
    valid_to   = '9999-12-31',
    is_current = TRUE;
```

==== Schritt 3 — Wohnsitzwechsel von Marxer, Markus per 1.2.2013
*Schritt 3 —* Beim SCD-Typ-2-Ansatz wird der bestehende Eintrag als "abgelaufen" markiert (valid_to setzen) und ein neuer Eintrag mit der neuen Stadt und dem neuen Gültigkeitsbeginn eingefügt. Zuerst schliessen wir den alten Eintrag:

```sql
UPDATE dim_customer
SET valid_to   = '2013-01-31',
    is_current = FALSE
WHERE name = 'Marxer'
  AND first_name = 'Markus'
  AND is_current = TRUE;
```

Dann fügen wir den neuen Eintrag mit Zürich als Wohnort ein (neuer Surrogatschlüssel):

```sql
INSERT INTO dim_customer
  (cust_id, name, first_name, city, birthday, gender,
   decade, quarter_century, valid_from, valid_to, is_current)
SELECT
  (SELECT MAX(cust_id) + 1 FROM dim_customer),
  name, first_name,
  'Zuerich',   -- neuer Wohnort
  birthday, gender, decade, quarter_century,
  '2013-02-01',    -- valid_from = Datum des Wohnsitzwechsels
  '9999-12-31',    -- valid_to = offen (aktuell gültig)
  TRUE
FROM dim_customer
WHERE name = 'Marxer'
  AND first_name = 'Markus'
  AND is_current = FALSE
  AND valid_to = '2013-01-31';
```

==== Schritt 4 — Neue Verkäufe in `fact_sales` einfügen
*Schritt 4 —* Beim Einfügen neuer Fakten muss laut Vorlesung (SCD-Typ-2-Konzept) der jeweils richtige Dimensionseintrag via Business Key und Gültigkeitszeitraum gesucht werden:

```sql
-- Einfügen: 'Star Wars I' am 2.2.2013, Kunde 'Marxer, Markus'
-- (Marxer wohnt seit 1.2.2013 in Zürich → neuer cust_id-Eintrag gilt)
INSERT INTO fact_sales
  (sale_id, sale_detail_id, movie_id, cust_id, time_id,
   quantity, sales_amount)
SELECT
  (SELECT MAX(sale_id) + 1 FROM fact_sales),
  1,
  m.movie_id,
  c.cust_id,
  t.time_id,
  1,
  m.price * 1
FROM dim_movie m
CROSS JOIN dim_customer c
CROSS JOIN dim_time t
WHERE m.name       = 'Star Wars I'
  AND c.name       = 'Marxer'
  AND c.first_name = 'Markus'
  AND t.ddate      = '2013-02-02'
  -- SCD2: Nur den zum Kaufdatum gültigen Kundeneintrag verwenden
  AND '2013-02-02' BETWEEN c.valid_from AND c.valid_to;

-- Einfügen: 'Star Wars II' am 1.3.2013, Kunde 'Marxer, Markus'
INSERT INTO fact_sales
  (sale_id, sale_detail_id, movie_id, cust_id, time_id,
   quantity, sales_amount)
SELECT
  (SELECT MAX(sale_id) + 1 FROM fact_sales),
  1,
  m.movie_id,
  c.cust_id,
  t.time_id,
  1,
  m.price * 1
FROM dim_movie m
CROSS JOIN dim_customer c
CROSS JOIN dim_time t
WHERE m.name       = 'Star Wars II'
  AND c.name       = 'Marxer'
  AND c.first_name = 'Markus'
  AND t.ddate      = '2013-03-01'
  AND '2013-03-01' BETWEEN c.valid_from AND c.valid_to;
```

==== Schritt 5 — Test: Gesamtumsatz Marxer, Markus
*Schritt 5 —* Ausgabe des Totals von `fact_sales.sales_amount` über alle Einträge (unabhängig vom Wohnort), indem wir über den Business Key (Name + Vorname) aggregieren:

```sql
SELECT
  c.name,
  c.first_name,
  SUM(f.sales_amount) AS total_sales_amount
FROM fact_sales f
JOIN dim_customer c ON f.cust_id = c.cust_id
WHERE c.name       = 'Marxer'
  AND c.first_name = 'Markus'
GROUP BY c.name, c.first_name;
```

==== Schritt 6 — Test: Umsatz Marxer in Zürich
*Schritt 6 —* Ausgabe des Totals nur für Käufe, die dem Zürcher Eintrag (SCD2, `city = 'Zuerich'`) zugeordnet sind — dies demonstriert den Vorteil von SCD Typ 2: Die Kaufhistorie bleibt dem jeweils gültigen Wohnort zugeordnet:

```sql
SELECT
  c.name,
  c.first_name,
  c.city,
  SUM(f.sales_amount) AS total_sales_amount
FROM fact_sales f
JOIN dim_customer c ON f.cust_id = c.cust_id
WHERE c.name       = 'Marxer'
  AND c.first_name = 'Markus'
  AND c.city       = 'Zuerich'
GROUP BY c.name, c.first_name, c.city;
```

*Ergebnis:* Da beide neuen Käufe (Star Wars I am 2.2.2013, Star Wars II am 1.3.2013) nach dem Wohnsitzwechsel (1.2.2013) stattfanden, werden sie dem Zürich-Eintrag zugeordnet. Käufe vor dem 1.2.2013 bleiben dem Rapperswil-Eintrag zugeordnet — dies ist der Kernvorteil von *SCD Typ 2 (Historisierung)* gegenüber SCD Typ 1 (Overwrite).

---

=== Aufgabe 1 (Teil 2) — CUBE- und ROLLUP-Operatoren

==== (a) Anzahl verkaufter Filme pro Monat mit Jahrestotal (ROLLUP)

*Schritt 1 —* Wir verwenden `ROLLUP` gemäss Vorlesung: ROLLUP erstellt Gruppensummen von rechts nach links und eine Gesamtsumme. Mit `ROLLUP(year, month)` erhalten wir zuerst die Summe pro Jahr+Monat, dann pro Jahr (Zwischensumme), dann das Gesamttotal.

```sql
SET SEARCH_PATH = video_dw;

SELECT
  t.year,
  t.month,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY ROLLUP(t.year, t.month)
ORDER BY t.year, t.month;
```

*Schritt 2 —* Das Ergebnis enthält:
- Eine Zeile pro Jahr-Monat-Kombination (detailliert)
- Eine Zeile pro Jahr mit `month = NULL` (Jahrestotal)
- Eine Zeile mit `year = NULL, month = NULL` (Gesamttotal)

*Ergebnis:*
```
 year | month | anzahl_verkaeufe
------+-------+-----------------
 2014 |     1 |       ...
 2014 |     2 |       ...
  ... |   ... |       ...
 2014 |  NULL |   Jahrestotal
 2015 |     1 |       ...
  ... |   ... |       ...
 NULL |  NULL |   Gesamttotal
```

==== (b) Anzahl verkaufter Filme nach Jahr, Jahreszeit und Monat (ROLLUP)

*Schritt 1 —* Mit `ROLLUP(year, season, month)` werden die Subtotale hierarchisch von rechts nach links gebildet: Monat → Season → Jahr → Gesamttotal.

```sql
SELECT
  t.year,
  t.season,
  t.month,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
GROUP BY ROLLUP(t.year, t.season, t.month)
ORDER BY t.year, t.season, t.month;
```

*Schritt 2 —* Auswertung der Analysefragen:

- *Meiste Filme pro Jahreszeit:* Zeilen mit `month IS NULL AND season IS NOT NULL` vergleichen → die Jahreszeit mit dem höchsten `anzahl_verkaeufe`-Wert.
- *Werbekampagne August 2015:* Vergleich der Zeilen für `year=2015, season='Summer', month=8` mit `month=7` und `month=9`.
- *Weihnachtsgeschäft:* Zeilen für `season='Fall'` (Monate 9-11) und `season='Winter'` (Monat 12) in den Jahren vergleichen.

*Ergebnis:* $ "ROLLUP"(year, season, month) arrow 4 "Ebenen: " (year","season","month), (year","season), (year), () $

==== (c) Filmsparte nach Geschlecht (CUBE)

*Schritt 1 —* Wir verwenden `CUBE` gemäss Vorlesung: CUBE berechnet Subtotale für alle möglichen Kombinationen der Attribute — bei 2 Attributen also $ 2^2 = 4 $ Kombinationen: `(subgenre, gender)`, `(subgenre)`, `(gender)`, `()`.

```sql
SELECT
  m.subgenre,
  c.gender,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY CUBE(m.subgenre, c.gender)
ORDER BY m.subgenre, c.gender;
```

*Schritt 2 —* Das Ergebnis enthält:
- Eine Zeile pro Subgenre-Geschlecht-Kombination
- Eine Zeile pro Subgenre (`gender = NULL`) → Total pro Filmsparte
- Eine Zeile pro Geschlecht (`subgenre = NULL`) → Total pro Geschlecht
- Eine Zeile mit beiden `NULL` → Gesamttotal

*Ergebnis:* $"CUBE"(subgenre, gender) arrow 2^2 = 4 "Kombinationen"$

==== (d) Genre nach Geschlecht (CUBE, grober)

*Schritt 1 —* Statt Subgenre verwenden wir jetzt das abgeleitete Attribut `genre` (`'Action'` oder `'Non-Action'`) aus `dim_movie`, was direkt ohne zusätzlichen Join möglich ist (Vorteil des denormalisierten Star-Schemas).

```sql
SELECT
  m.genre,
  c.gender,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY CUBE(m.genre, c.gender)
ORDER BY m.genre, c.gender;
```

*Ergebnis:* $"CUBE"(genre, gender) arrow 2^2 = 4 "Kombinationen (nur 2 Genres: Action, Non-Action)"$

==== (e) Filmsparte nach Altersgruppe / QuarterCentury (CUBE)

*Schritt 1 —* Das Attribut `quarter_century` in `dim_customer` kodiert das Vierteljahrundert (0 = 1900–1925, 1 = 1925–1950, usw.) und ermöglicht Altersgruppen-Analysen.

```sql
SELECT
  m.genre,
  c.quarter_century,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY CUBE(m.genre, c.quarter_century)
ORDER BY m.genre, c.quarter_century;
```

*Ergebnis:* Zeilen mit `quarter_century IS NOT NULL AND genre IS NOT NULL` zeigen, welche Altersgruppe welche Filmsparte bevorzugt.

==== (f) Unterschied ROLLUP vs. CUBE (Differenzmenge)

*Schritt 1 —* Laut Vorlesung: ROLLUP ist asymmetrisch (hierarchisch von rechts nach links), CUBE berechnet alle $2^n$ Kombinationen. Bei 2 Attributen erzeugt ROLLUP $n+1 = 3$ Gruppierungsebenen, CUBE erzeugt $2^n = 4$ Kombinationen. Der Unterschied ist also die Zeile mit `genre IS NULL AND quarter_century IS NOT NULL` (nur in CUBE, nicht in ROLLUP).

```sql
-- Differenz: Zeilen in CUBE, die nicht in ROLLUP sind
SELECT m.genre, c.quarter_century,
       COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY CUBE(m.genre, c.quarter_century)

EXCEPT

SELECT m.genre, c.quarter_century,
       COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY ROLLUP(m.genre, c.quarter_century)

ORDER BY 1, 2;
```

*Ergebnis:* Die Differenz enthält genau die Zeilen mit `genre IS NULL AND quarter_century IS NOT NULL` (Subtotal pro Altersgruppe über alle Genres) — diese erzeugt CUBE, aber nicht ROLLUP.

---

=== Aufgabe 2 (Teil 2) — Analytische Funktionen (Window-Funktionen)

==== (a) Rangliste der Filmsparten nach Umsatz (RANK)

*Schritt 1 —* Gemäss Vorlesung berechnet `RANK() OVER (ORDER BY ...)` eine Rangliste. Niedrigere Rang-Nummer = höherer Umsatz (absteigende Sortierung).

```sql
SELECT
  RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS umsatz_rang,
  m.subgenre,
  COUNT(f.sale_detail_id)    AS anzahl_verkaeufe,
  SUM(f.sales_amount)        AS umsatz
FROM fact_sales f
JOIN dim_movie m ON f.movie_id = m.movie_id
GROUP BY m.subgenre
ORDER BY umsatz_rang;
```

*Ergebnis:* Eine Rangliste der Subgenres, wobei `umsatz_rang = 1` das Subgenre mit dem höchsten Umsatz anzeigt.

==== (b) Rangliste der Geschlechter nach Anzahl verkaufter Filme

*Schritt 1 —* Analog zu (a), jedoch gruppiert nach `gender` und sortiert nach Anzahl verkaufter Filme absteigend.

```sql
SELECT
  RANK() OVER (ORDER BY COUNT(f.sale_detail_id) DESC) AS rang,
  c.gender,
  COUNT(f.sale_detail_id) AS anzahl_verkaeufe
FROM fact_sales f
JOIN dim_customer c ON f.cust_id = c.cust_id
GROUP BY c.gender
ORDER BY rang;
```

*Ergebnis:* Die Rangliste zeigt, welches Geschlecht mehr Filme kauft.

==== (c) Rang innerhalb von Gruppen (RANK mit PARTITION BY)

*Schritt 1 —* Wir kombinieren `CUBE` für die Aggregation mit `RANK() OVER (PARTITION BY GROUPING(...))` für die Ranglisten innerhalb der Gruppen. Gemäss Vorlesung zerlegt `PARTITION BY` die Tupel in Mengen (ähnlich wie GROUP BY), gibt aber ein Resultattupel pro Tupel in der Partition zurück.

```sql
SELECT
  m.subgenre,
  c.gender,
  SUM(f.sales_amount) AS umsatz,
  -- Rang innerhalb Subgenre+Gender-Gruppe
  RANK() OVER (
    PARTITION BY GROUPING(m.subgenre, c.gender)
    ORDER BY SUM(f.sales_amount) DESC
  ) AS rang_gesamt,
  -- Rang innerhalb Subgenre (über alle Geschlechter)
  RANK() OVER (
    PARTITION BY m.subgenre, GROUPING(c.gender)
    ORDER BY SUM(f.sales_amount) DESC
  ) AS rang_in_sparte,
  -- Rang innerhalb Geschlecht (über alle Sparten)
  RANK() OVER (
    PARTITION BY c.gender, GROUPING(m.subgenre)
    ORDER BY SUM(f.sales_amount) DESC
  ) AS rang_in_geschlecht
FROM fact_sales f
JOIN dim_movie    m ON f.movie_id = m.movie_id
JOIN dim_customer c ON f.cust_id  = c.cust_id
GROUP BY CUBE(m.subgenre, c.gender)
ORDER BY m.subgenre, c.gender;
```

*Ergebnis:* Drei Ranglisten gleichzeitig: innerhalb Sparte+Geschlecht, innerhalb Sparte, und innerhalb Geschlecht.

==== (d) Anzahl verkaufter Filme pro Monat mit YTD (Year-to-Date)

*Schritt 1 —* Gemäss Vorlesungsbeispiel (Fallstudie Weinhandlung, Year-to-Date) verwenden wir `SUM(...) OVER (PARTITION BY year ORDER BY month)`. Die `PARTITION BY year`-Klausel setzt den YTD-Zähler bei jedem neuen Jahr zurück.

```sql
SELECT
  t.year,
  t.month,
  COUNT(f.sale_detail_id)  AS anzahl_monat,
  SUM(COUNT(f.sale_detail_id))
    OVER (PARTITION BY t.year ORDER BY t.month)
    AS ytd_anzahl
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
WHERE t.year >= 2014   -- Einzelne 2013-Käufe ignorieren
GROUP BY t.year, t.month
ORDER BY t.year, t.month;
```

*Ergebnis:* `ytd_anzahl` enthält die kumulative Anzahl der Filmverkäufe vom Januar bis zum jeweiligen Monat innerhalb desselben Jahres.

==== (e) Moving Average über die letzten 3 Monate

*Schritt 1 —* Laut Vorlesung (Fallstudie Weinhandlung: "Moving Average") verwendet man `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` um ein gleitendes Fenster der letzten 3 Zeilen zu definieren. Wir ignorieren die 2013-Einzelkäufe mit `WHERE t.year >= 2014`.

```sql
SELECT
  t.year,
  t.month,
  COUNT(f.sale_detail_id) AS anzahl_monat,
  ROUND(
    AVG(COUNT(f.sale_detail_id))
      OVER (ORDER BY t.year, t.month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
    1
  ) AS moving_avg_3monate
FROM fact_sales f
JOIN dim_time t ON f.time_id = t.time_id
WHERE t.year >= 2014
GROUP BY t.year, t.month
ORDER BY t.year, t.month;
```

*Schritt 2 —* Das `OVER`-Fenster definiert physische Zeilengrenzen (`ROWS`): Der Durchschnitt wird über die aktuelle Zeile und die 2 vorangehenden Zeilen (= 3 Monate) berechnet.

*Ergebnis:* `moving_avg_3monate` gibt den geglätteten Durchschnitt der Filmverkäufe über die jeweils letzten 3 Monate aus.

==== (f) Aktuelle Verkaufszahlen vs. Vormonat (LAG)

*Schritt 1 —* Gemäss Vorlesungsbeispiel (Fallstudie Weinhandlung: LAG/LEAD) liefert `LAG(ausdruck, n)` den Wert der n-ten vorhergehenden Zeile in der geordneten Partition. Mit `LAG(..., 1)` erhalten wir den Vormonatswert.

```sql
SELECT
  t.year,
  t.month,
  COUNT(f.sale_detail_id)  AS anzahl_aktuell