# Week 2 — Exercises

> Quelle: DW_01.adoc, DW_02.adoc, README.adoc, Erweiterung_DW.adoc, star_schema.adoc

---

= Übung VoWo 02: Data Warehouse und OLAP: Modul Data Analytics (M_DatAna), Bachelor Informatik
Prof. Stefan Keller; Raphael Das Gupta
FS 2022
:lang: de
:dwscripts-relative-path: ../../DWScripts
:datana-pages: http://db.pages.gitlab.ost.ch/datana
:angproj-gitlab: https://gitlab.dev.ifs.hsr.ch/ifs/AngProj

.Themen und Ziele
* Einführung, Star-Schema, DW-Design, DW laden und erweitern.
* Ziele Kennenlernen des Entwurfsprozesses eines Data-Warehouses sowie
Kennenlernen der SQL-Erweiterungen für OLAP.

.Umgebung
* Datenbank-Server: PostgreSQL 9.6 oder neuer (z.B. PostgreSQL 14)
* Datenbank-Client: pgAdmin 4 (Version 4 oder neuer) sowie `psql`

.Zeitbudget
* Übungs-Doppelstunde plus ggf. Nachbereitung


== Vorbereitung

Als Grundlage wird folgendes logische Datenmodell (Schema) verwendet:

[plantuml]
----
@startuml

package "schema video_oltp" << Frame >> {

  note as Note_not_a_conceptual_model
    This diagram shows
    the //logical// relational DB schema,
    **not** a conceptual domain model.
  end note

  note as Note_formatting
    <b>bold</b> = PK components
    <i>italic</i> = FKs
  end note

  customer <-- sale : cust_id
  sale <-- sale_detail : sale_id
  sale_detail -> movie : movie_id
  subgenre <-- movie : subgenre_id

  class subgenre << (T, lightgray) Table >> {
    {field} <b>subgenre_id</b> : INTEGER,
    {field} subgenre : VARCHAR(20)
  }

  class customer << (T, lightgray) Table >> {
    {field} <b>cust_id</b> : INTEGER
    {field} name : VARCHAR(20)
    {field} first_name : VARCHAR(20)
    {field} city : VARCHAR(20)
    {field} birthday : DATE
    {field} gender : CHAR(1)
  }

  class movie << (T, lightgray) Table >> {
    {field} <b>movie_id</b> : INTEGER
    {field} name : VARCHAR(30)
    {field} <i>subgenre_id</i> : INTEGER
    {field} price : DECIMAL(5,2)
  }

  class sale << (T, lightgray) Table >> {
    {field} <b>sale_id</b> : INTEGER
    {field} <i>cust_id</i> : INTEGER
    {field} sale_date : DATE
  }

  class sale_detail << (T, lightgray) Table >> {
    {field} <b><i>sale_id</i></b> : INTEGER
    {field} <b>sale_detail_id</b> : INTEGER
    {field} <i>movie_id</i> : INTEGER
    {field} quantity : INTEGER
  }
}

hide methods

@enduml
----

In der Tabelle `sale` werden alle Einkäufe,
welche die Kunden tätigen, gespeichert.
Die Filme sind in verschiedene Kategorien (Genres und Subgenres) eingeteilt,
wobei ein Film genau zu einem Genre und einem Subgenre gehört.

Die Genres sind wie folgt in Subgenres aufgeteilt:

|===
h| Genre | Action | Non-Action
h| Subgenres
a|
* Action
* Science-Fiction
* Thriller
a|
* Romance
* Comedy
* Drama
|===

Da sich das Genre aus dem Subgenre ergibt,
wird nur das Subgenre in der OLTP-Datenbank gespeichert.
(Auf ein Attribut, das angibt,
in welchem Genre ein Subgenre ist,
wurde verzichtet.)

== Installation

Um die Tabellen zu erstellen und mit Daten zu füllen, können Sie die
link:{dwscripts-relative-path}[SQL-Scripts aus Verzeichnis `Uebungen/DWScripts`]
(auch
{datana-pages}/zips/DWScripts.zip[als Zip-Archiv verfügbar])
verwenden:

* Entpacken Sie das Zip-File auf einen lokalen Ordner

* Führen Sie `0_runAllScripts.sql` mit `psql` aus:
+
[source,bash]
----
psql -U postgres -v ON_ERROR_STOP=on -f 0_runAllScripts.sql
----
+
(Analog zu
{angproj-gitlab}#import-der-datenbank-und-der-beispieldaten[AngProj]
in Dbs1)

* Zuerst wird ein neuer Benutzer `videodbuser` mit Passwort `dbuser`
und eine Datenbank `videodb` angelegt, dann werden die Tabellen erzeugt
(ggf. in separate Schemata `video_dw` und `video_oltp`;
vgl. auch der Tipp zu `SET SEARCH_PATH` unten)
und Daten eingefüllt.

Falls Sie die Datenbank neu erstellen möchten,
achten Sie darauf, dass keine Verbindungen zur `videodb`-Datenbank bestehen,
und führen Sie das Skript erneut aus.


== Aufgabe 1. Star Schema

Für unser Data Warehouse muss
aus dem relationalen Modell ein Star Schema entworfen werden.
Bei einem Star Schema wird bewusst Redundanz eingefügt, so dass
die Abfragen einfacher und die Antwortzeit besser werden.
Das Star Schema besteht aus einer oder mehreren Fakten-Tabellen,
welche die primären Informationen beinhalten,
und mehreren Dimensions-Tabellen,
welche dann genauere Informationen zu den Fakten speichern.


=== Lernziele

* Sie können einfache Star-Schemata entwerfen
* Sie kennen die Grundbegriffe des Dimensional Modelings

=== Aufgabe

Entwerfen Sie das Star-Schema, welches
für unser Data Warehouse verwendet werden kann:

* Folgende Auswertungen sollen möglich sein:
Abfragen der Verkaufszahlen (Anzahl, Preis) gruppiert nach
Movie, Movie-Genre, Subgenre, Kunde, Datum, Monat, Halbjahr, Jahr

* Bestimmen Sie die Fakten-Tabellen. - Enthalten
alle für das Business relevanten Daten.

* Bestimmen Sie die Dimension Table(s). - Enthalten
Zusatzinformationen zu den Daten in der/den Fakten-Tabelle(n).

* Zeichnen Sie das Stern-Schema.

* Was ist die Granularität der Fakten-Tabelle?

* Klassifizieren Sie die Fakten-Tabelle!


== Aufgabe 2: Erweiterung des DW

Unsere Firma wächst und betreibt ein Filialnetz.
Die Filialen beziehen ihre Movies aus einem der regionalen Lager.
Die Lagerdaten sollen nun in unserem DW gespeichert werden.
Das soll u.A. folgende Abfragen ermöglichen:

* Bestand eines Movies an einem Lagerort um 24h

* durchschnittlicher Bestand pro Woche eines Movies an allen Lagerorten

Nachts finden in unserer Firma weder Movie-Bezüge durch Filialen
noch Anlieferungen an die Lager statt.
Somit können die Daten aus den Standorten der regionalen Lager
dann bezogen werden, ohne dass sie sich gleichzeitig ändern.
Dazu werden jede Nacht um 23 Uhr
die aktuellen Daten der verschiedenen Lager via Internet geliefert
und im DW aktualisiert (ETL-Prozess).
Zwischen 23h und 24h ist das DW für Abfragen nicht verfügbar.
Ab 24h ist der Lagerbestand aktualisiert.

Folgende Daten werden geliefert:

* Bezug von Movies, für jedes Lager:
LagerId, FilialId, MovieId, Anzahl, Datum

* Anlieferung von Movies ins Lager, für jedes Lager:
LagerId, LieferantenId, MovieId, Anzahl, Datum, Lieferpreis pro Stück

Erweitern Sie das DW um einen zusätzlichen "Lager-Stern"!
Erweitern Sie dazu das Modell um die Dimension
Lager (LagerId, Bezeichnung)
und um eine geeignete Fakten-Tabelle.
Diese darf auch Verweise auf bereits bestehende Dimensions-Tabellen haben.


== Aufgabe 3: Implementation MovieDW

In der vorherigen Aufgabe haben Sie
das Star Schema für das Data Warehouse entworfen.
Um die Abfragen der folgenden Aufgaben einheitlich zu halten,
arbeiten Sie mit dem bereits in der Einführung installierten Schema,
welches der Musterlösung von Aufgabe 1 entspricht, weiter.


=== Lernziele

* Sie können einfache ETL-Prozesse nachvollziehen
* Sie kennen das Prinzip von Slowly Changing Dimensions (SCD)
* Sie können SCD mit Historisierung (SCD2) auf
Attribute von Dimensionstabellen anwenden


=== Aufgabe

Studieren Sie das Skript von Aufgabe 1 und
vergleichen Sie dieses mit Ihrem Star-Schema.
Analysieren Sie den SQL-Code aus der Einführung.
Beachten Sie speziell die Dateien, welche
sich auf das Data Warehouse beziehen.

Beachten Sie, dass sich die OLTP-Datenbank und das Data Warehouse
in derselben Datenbank `VideoDB` befinden:
Die OLTP-Datenbank im Schema `video_oltp`,
das Data Warehouse im Schema `video_dw`.


=== Hinweise

* Die Tabelle `dim_movie` erhält das Attribut `genre`,
welches durch das Subgenre bestimmt wird.

* Genre wird auf `'Action'` gesetzt,
wenn das Subgenre Action, Science-Fiction oder Thriller ist.
+
Die restlichen MovieGenres werden auf `'Non-Action'` gesetzt.

* Das Geburtsdatum des Kunden wird in
das Jahrzehnt und in Vierteljahrhunderte eingeteilt.
Dazu existieren die Attribute `decade` und `quarter_century`
in der Tabelle `customer`.

* Kunden, die im Jahr 1900 bis 1910 geboren wurden, erhalten `decade` = `0`,
1910 bis 1920 erhalten `decade` = `1`, usw.
+
Dasselbe gilt für `quarter_century`.
Kunden, die zwischen 1900 und 1925 geboren wurden, erhalten den Wert `0`, usw.

* Es gibt eine Tabelle `dim_time`:
+
Diese wird
abhängig vom Attribut Verkaufsdatum aus der Tabelle `sale` gefüllt.

* Das Attribut Season erhält den Wert
`'Spring'` für die Monate 3-5,
`'Summer'` für die Monate 6-8,
`'Fall'` für die Monate 9-11 und
`'Winter'` für die Monate 12-2.

* Mit der Funktion `to_char(sale_date, 'YYYY')` kann
aus einem Datum das Jahr herausgelesen werden.

* Mit der Funktion `to_date('1900', 'YYYY')` kann
aus einem String (z.B. Jahresangabe) ein Datum (`date`) erstellt werden.


=== Erweiterung der Tabelle `dim_customer`

Die Tabelle `dim_customer` enthält das Attribut `city`.
Natürlich kann sich im Laufe der Zeit der Wohnort eines Kunden ändern.

[TIP]
.Tipp zu `psql`/pgAdmin:
====
Setzen Sie im SQL-Query-Fenster den Suchpfad auf das Schema `video_dw`:

[source,sql]
----
SET SEARCH_PATH=video_dw;
----
(Sonst müssen Sie die Tabellen mit `<SchemaId>.<TableId>` angeben,
z.B. `video_dw.dim_customer`.)
====

Auftrag:

* Historisieren Sie das Attribut `city` mit dem SCD2-Ansatz.

* Ändern Sie die Daten von `dim_customer` wie folgt:
Der Kunde `'Marxer, Markus'` wechselt per 1.2.2013
seinen Wohnsitz von Rapperswil nach Zürich

* Fügen Sie die folgenden Neuzugänge in der Faktentabelle ein:
** `'Star Wars I'` am 2.2.2013, gekauft durch Kunde `'Marxer, Markus'`
** `'Star Wars II'`, gekauft am 1.3.2013 durch Kunde `'Marxer, Markus'`

* Testen Sie ihre Implementation:
** Ausgabe des Totals von
`fact_sales.sales_amount` des Kunden `'Marxer, Markus'`
** Ausgabe des Totals von
`fact_sales.sales_amount` des Kunden `'Marxer, Markus'` in `'Zuerich'`


---

= Übung VoWo 02: Data Warehouse und OLAP ff.: Modul Data Analytics (M_DatAna), Bachelor Informatik
Prof. Stefan Keller; Raphael Das Gupta
FS 2022

.Zeitbudget
- `CUBE`- und `ROLLUP`-Operator: 45 min.
- Analytische Funktionen: 45 min.

.Tipps
* Setzen Sie im SQL-Query Fenster der Search Pfad auf das Schema `video_dw`:
+
[source,sql]
----
SET SEARCH_PATH=video_dw;
----

== Aufgabe 1. `CUBE`- und `ROLLUP`-Operatoren

Mit SQL Operatoren `CUBE` und `ROLLUP` lassen sich einfach Übersichten und Zusammenfassungen erzeugen.

.Lernziele
- Sie können Anfragen mit `CUBE`- und `ROLLUP`-Operatoren formulieren.

.Aufgabe
Erstellen Sie folgenden Übersichten, in dem Sie den `CUBE`- und `ROLLUP`-Operator verwenden:

* Gesucht ist die Anzahl verkaufter Filme,
gegliedert nach Monat und das Total über das ganze Jahr.
Ausgabe:
Monat, Anzahl Verkäufe.
+
Verwenden Sie den `ROLLUP`-Operator.

* Gesucht ist die Anzahl verkaufter Filme,
gegliedert nach Jahr, Jahreszeit (Season) und Monat.
Zusätzlich soll das Total für jede Jahreszeit und über das ganze Jahr ausgegeben werden.
Ausgabe:
Jahr, Jahreszeit, Monat, Anzahl Verkäufe
+
Verwenden Sie den `ROLLUP`-Operator.
+
Versuchen Sie ausgehend von den Resultaten folgende Fragen zu beantworten:

** Zu welcher Jahreszeit werden die meisten Filme verkauft?

** Mitte August 2015 wurde eine Werbekampagne gestartet. Brachte diese den gewünschten Erfolg?

** Wie sieht es mit dem Weihnachtsgeschäft aus? Ab wann muss mit vermehrten Einkäufen für Weihnachten gerechnet werden?

* Als nächstes interessiert uns, welche Filmsparte (Subgenre) von welchem Geschlecht bevorzugt wird.
Erstellen Sie dazu eine Übersicht mit den Filmsparten, Geschlecht und den verkauften Filmen.
Zusätzlich sollen das Total pro Filmsparte, das Total pro Geschlecht und das Total über alles ausgegeben werden.
+
Verwenden Sie den `CUBE`-Operator.

* Die vorherige Abfrage war zu genau.
Jetzt sind wir nur noch daran interessiert, welches Geschlecht mehr Action- und welches mehr Non-Action-Filme kauft.
+
Verwenden Sie den `CUBE`-Operator.

* Was für eine Filmsparte (Action, Non-Action) kaufen sich ältere Menschen,
und was für eine Sparte kaufen vorwiegend jüngere Menschen?
Untersuchen Sie diese Fragestellung mit Hilfe einer Abfrage,
welche die Verkäufe pro Sparte und Alter (QuarterCentury) auflistet.
+
Verwenden Sie den `CUBE`-Operator.
* Unterschied `ROLLUP`- und `CUBE`-Operator:
Vergewissern Sie sich den Unterschied zwischen dem `ROLLUP`- und dem `CUBE`-Operator.
Nehmen Sie dazu die Abfrage des obigen Beispiels und führen Sie diese mit dem `CUBE`- und dem `ROLLUP`-Operator aus.
Bilden Sie die Differenz der Resultate der beiden Abfragen.

.Tipps

* Hinweis: Das Attribut `sales_amount` in der Tabelle `fact_sales` stellt bereits den Gesamtpreis (Film-Preis ∙ Anzahl) dar.

* Hinweis: Die Genres sind bereits direkt in der Tabelle `dim_movie` abgelegt, dies erleichtert die Abfragen um einen weiteren Join.


== Aufgabe 2: Analytische Funktionen

Moderne DBMS bieten eine Reihe von analytischen Funktionen, um die Daten im Data Warehouse genauer zu untersuchen.
Dazu gehören unter anderem das Erstellen von Ranglisten, lineare Regression, Verteilung und hypothetische Ranglisten.

.Vorbereitung, Vertiefung
Zu finden im DatAna-Kurs auf Moodle:

* Die Unterstützung von SQL/OLAP im SQL-Standard und in relationalen Datenbanksystemen
** Teil 1: SQL_OLAP_dbs-22-44.pdf
** Teil 2: SQL_OLAP_dbs-23-29.pdf

.Lernziele
Sie können analytische Abfragen formulieren

.Aufgaben

* Erstellen Sie eine Rangliste der Filmsparten (subgenre) nach Umsatz.
Ausgabe:
Umsatz-Rang (mit tiefere Rang-Nr. = höherer Umsatz), Sparte, Anzahl Verkäufe, Umsatz;
sortiert nach Umsatz bzw. Rang (höchster Umsatz zuoberst)
+
Verwenden Sie für diese Abfrage die `RANK()`-Funktion.

* Erstellen Sie eine Rangliste der Geschlechter nach Anzahl verkaufter Filme.
Ausgabe:
Rang (mit tiefere Rang-Nr. = höhere Anzahl), Geschlecht, Anzahl Verkäufe;
sortiert nach Anzahl bzw. Rang (höchste Anzahl zuoberst)

* Mit der `RANK()`-Funktion lassen sich auch Ranglisten innerhalb von Gruppen erstellen.
+
--
**  Erstellen Sie dazu zuerst eine Übersicht über die Umsätze pro Filmsparten (Subgenre) und Geschlecht mit dem `CUBE`-Operator.
**  Fügen Sie noch den Rang innerhalb der einzelnen Gruppen hinzu.
**  Jetzt sollte es
*** eine Rangliste innerhalb der Verkäufe pro Sparte und Geschlecht,
*** eine Rangliste innerhalb der Verkäufe pro Sparte
und
*** eine Rangliste innerhalb der Verkäufe pro Geschlecht
geben.
--
Hinweis:
Verwenden Sie `PARTITION BY GROUPING(...)` um nach der Gruppe zu partitionieren

* Als nächstes interessieren uns die Anzahl verkaufter Filme pro Monat.
Es soll eine Zusammenfassung erstellt werden,
die das Jahr, den Monat, die Anzahl verkaufter Filme
und zusätzlich die kumulierte Anzahl verkaufter Filme innerhalb des Kalenderjahres (YTD=year to date) darstellt,
also die Anzahl Filme
die in vorangehenden Monaten des selben Jahres und im jeweiligen Monat selbst insgesamt verkauft wurden.

* Windowing:
Modifizieren Sie die obige Anfrage so,
dass statt der YTD-Anzahl der Durchschnitt über die letzten 3 Monate erscheint (sog. Moving Average).
Ignorieren sie dabei die beiden Einzelnen Verkäufe in 2013.

* Erstellen Sie eine Anfrage, die die aktuellen Verkaufszahlen, sowie die Verkaufszahlen des Vormonats ausgeben.
Hinweis:
Verwenden Sie die `LAG`-Funktion.


---

= Übung VoWo 02: Data Warehouse und OLAP: Modul Data Analytics (M_DatAna), Bachelor Informatik
Prof. Stefan Keller; Raphael Das Gupta
FS 2022
:lang: de
:dwscripts-relative-path: ../DWScripts

== Teil 1
include::_parts/DW_01.adoc[leveloffset=+1,lines=6..-1]

== Teil 2
include::_parts/DW_02.adoc[leveloffset=+1,lines=5..-1]
