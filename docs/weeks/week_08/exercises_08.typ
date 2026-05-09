// Echte Kursübungen — Woche 8 (konvertiert am 2026-05-09)
// Quelle: README.adoc

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

```typst
== Übungen

=== Vorbereitung

Installieren Sie zuerst Apache Hop auf Ihrem Rechner. Die Software ist in Java geschrieben und bietet neben einigen Kommandozeilen-Tools auch ein GUI, um Pipelines und Workflows zu bearbeiten und auszuführen.

+ Laden Sie von #link("https://hop.apache.org/download") die „Binaries"-Zip-Datei herunter.
+ Entpacken Sie die Datei in einem Verzeichnis Ihrer Wahl.

  *Wichtig:* Das Verzeichnis muss für das Betriebssystem-Benutzerkonto, mit dem Sie Apache Hop verwenden werden, schreibbar sein. Daher empfehlen wir, ein Unterverzeichnis des persönlichen Ordners zu verwenden.

+ Die Datei `hop-gui.bat` resp. `hop-gui.sh` im Unterverzeichnis `hop` startet die Software.
+ Nach dem Start (dauert einige Sekunden) wird das Hauptfenster angezeigt.

_Hinweis:_ Apache Hop erfordert, dass Java 17 auf dem Rechner installiert ist. Die Software dürfte aber auch mit einer aktuelleren Version von Java arbeiten.

*Hinweise:*
- Die CSV-Dateien mit den Beispieldaten sind im Verzeichnis `sample_data` zu finden.
- Die Projekte der Aufgaben sind unter `Musterloesungen` abgelegt.
- Wählen Sie _Help_ bei den Einstellungen eines Blocks, um dessen Beschreibung aufzurufen.

---

=== Aufgabe 1 — Erste Schritte mit Apache Hop

*Ziel:* Erste Schritte mit Apache Hop.

Erstellen Sie wie folgt ein neues Projekt `Tutorial`:

+ Klicken Sie in der unteren linken Ecke des Fensters auf das Projekt-Icon und wählen Sie aus dem dadurch erscheinenden Menü _Add project…_. Das öffnet den Dialog _Project Properties_.
+ Geben Sie im Dialog _Project Properties_ beim Feld _Name_ den Namen des neu zu erstellenden Projekts (hier: `Tutorial`) an.
+ Klicken Sie im Dialog _Project Properties_ rechts des Felds „Home folder" auf den Button _Browse_, um einen Verzeichnis-Auswahl-Dialog zu öffnen.
+ Erstellen Sie über diesen Verzeichnis-Auswahl-Dialog ein neues Verzeichnis. Benennen Sie dieses gleich wie das Projekt (hier: `Tutorial`) und wählen Sie es an, bevor Sie die Auswahl bestätigen.
+ Im Feld _Home folder_ des Dialogs _Project Properties_ sollte nun der Pfad des neu erstellten Verzeichnisses sein.
+ Die anderen Einstellungen können Sie übernehmen.
+ Den Dialog _Create project lifecycle environment?_ können Sie mit _No_ schliessen.

Spielen Sie das Tutorial unter #link("https://hop.apache.org/manual/latest/getting-started/hop-gui-pipelines.html") durch, um eine einfache Pipeline zusammenzustellen und sich mit dem GUI von Apache Hop vertraut zu machen.

---

=== Aufgabe 2 — CSV-Dateien einlesen

*Ziel:* CSV-Dateien einlesen.

Erstellen Sie ein neues Projekt `Sales` und kopieren Sie die Datei `sales.csv` in das Projektverzeichnis. Erstellen Sie eine neue Pipeline mit einem Block _CSV file input_.

Die Einstellungen bei _CSV file input_ sind wie folgt:

- Transform name: `Read sales`
- Filename: `${PROJECT_HOME}/sales.csv`
- Delimiter: `,`
- Enclosure: `"`
- Häkchen bei _Lazy conversion?_ entfernen

Klicken Sie anschliessend auf den Button _Get Fields_. Damit werden neben der Kopfzeile die gegebene Anzahl Datensätze eingelesen, um die Felder und deren Datentypen zu bestimmen. Im Dialog werden diese anschliessend tabellarisch aufgelistet.

*Wichtig:* Setzen Sie bei den Feldern `CITY` und `STATE` den _Trim type_ auf `both`. Damit werden Leerzeichen zu Beginn und am Ende entfernt. (Ohne diese Einstellung funktioniert Aufgabe 4 nicht.)

Der Button _Preview_ liefert eine tabellarische Vorschau der Datensätze.

Prüfen Sie, ob die Datensätze vollständig und plausibel sind.

---

=== Aufgabe 3 — Datensätze aufteilen

*Ziel:* Datensätze aufteilen.

Mit dem Block _Read zips_ wird die Datei `zipssorted.csv` eingelesen. Beachten Sie, dass hierfür der Typ von `POSTALCODE` auf `String` gesetzt werden muss. Davon abgesehen können Sie gleich wie bei Aufgabe 2 vorgehen.

Die beiden _Dummy_-Blöcke sind hilfreich, um die Pipeline zu testen. Der grüne Hop liefert die Datensätze, bei denen die Kriterien erfüllt sind. Der orange Hop liefert die Datensätze, bei denen die Postleitzahl nicht gesetzt ist.

Die Einstellungen bei _Filter rows_ filtern auf Datensätze, bei denen die Postleitzahl nicht gesetzt ist.

Führen Sie die Pipeline aus.

*Bei wie vielen Einträgen ist die Postleitzahl nicht gesetzt?*

---

=== Aufgabe 4 — Vervollständigen von Datensätzen mit Lookup

*Ziel:* Vervollständigen von Datensätzen mit Lookup.

Um die fehlenden Postleitzahlen zu ergänzen, verwenden wir die Datei `zipssorted.csv`. In der Datei sind Staaten, Städtenamen und die dazugehörigen Postleitzahlen abgelegt. Kopieren Sie die Datei in das Projektverzeichnis.

Hierzu sind neben einem zusätzlichen Block _CSV file input_ einige weitere Blöcke erforderlich.

Mit dem Block _Read zips_ wird die Datei `zipssorted.csv` eingelesen. Beachten Sie dort, dass der Typ von `POSTALCODE` auf `String` gesetzt ist. Ansonsten können Sie gleich wie bei Aufgabe 2 vorgehen.

Mit dem Block _Stream lookup_ wird der Lookup ausgeführt. Dabei wird die Postleitzahl aufgrund von `CITY` und `STATE` gesucht. Der Block fügt hierzu bei den Datensätzen ein zusätzliches Feld `ZIP_RESOLVED` hinzu, in dem die gefundene Postleitzahl abgelegt wird.

Der Block _Select values_ sorgt dafür, dass die Werte von `ZIP_RESOLVED` in der Spalte `POSTALCODE` eingetragen werden. Hierzu wird die originale Spalte `POSTALCODE` durch `ZIP_RESOLVED` ersetzt und anschliessend `ZIP_RESOLVED` in `POSTALCODE` umbenannt.

Mit _Get Fields to select_ werden alle Felder im Dialog eingetragen. Verschieben Sie den untersten Eintrag `ZIP_RESOLVED` an die Stelle von `POSTALCODE` und entfernen Sie anschliessend den Eintrag von `POSTALCODE` aus der Liste. Zusätzlich ist ein Eintrag beim Reiter _Meta-data_ erforderlich, um das Feld umzubenennen.

Der Block _Append streams_ fügt die beiden Streams zusammen. Wählen Sie die Einstellungen so, dass die Datensätze von _Select values_ am Ende hinzugefügt werden.

Führen Sie die Pipeline aus. Da die Datensätze bei der Vorschau in umgekehrter Reihenfolge ausgegeben werden, sollten bei _Dummy_ die Datensätze mit der eingefügten Postleitzahl zuoberst aufgelistet werden.

---

=== Aufgabe 5 — Bereinigen und Ergänzen von Feldern

*Ziel:* Bereinigen und Ergänzen von Feldern.

Bei dieser Aufgabe ergänzen wir die Pipeline mit den Blöcken _Value mapper_ und _Number range_.

Vielleicht haben Sie bemerkt, dass beim Feld `COUNTRY` teilweise `United States` anstelle von `USA` eingetragen ist. Mit dem Block _Value mapper_ können wir dies bereinigen: der Wert `United States` soll durch `USA` ersetzt werden.

Mit _Number range_ wird ein neues Feld eingefügt, dessen Wert aufgrund eines Wertebereiches eines anderen Feldes gesetzt wird. Wir nutzen diesen Block, um den Umfang einer Bestellung zu kategorisieren.

Führen Sie die Pipeline aus und prüfen Sie, ob die Datensätze bereinigt und ergänzt werden.

---

=== Aufgabe 6 — Schreiben von Datensätzen in eine Datenbank

*Ziel:* Schreiben von Datensätzen in eine Datenbank.

Apache Hop ist in der Lage, zu diversen Datenbanken eine Verbindung aufzubauen, um Daten abzulegen oder auszulesen. Apache Hop kann aber selber keine neue Datenbank erstellen — diese muss mit dem entsprechenden DBMS zuerst eingerichtet werden.

Falls Sie mit PostgreSQL arbeiten, können Sie hierzu in `psql` den folgenden Befehl absetzen:

```sql
CREATE DATABASE sampledata;
```

Bei der Pipeline können Sie einfach den Block _Dummy_ am Ende durch einen Block _Table output_ ersetzen. Öffnen Sie die Einstellungen von _Table output_ und klicken Sie auf das Datenbank-Icon, um die Verbindung zur Datenbank einzurichten.

_Hinweis:_ Beachten Sie, dass unter Username und Password der Benutzername und das Passwort des zu verwendenden Benutzerkontos im Datenbank-Managementsystem (z.B. Ihrer lokalen PostgreSQL-Instanz) gefordert sind.

Mit _Test_ können Sie prüfen, ob eine Verbindung zur Datenbank aufgebaut werden kann.

Legen Sie in den Einstellungen unter _Target Table_ mit `SALES_DATA` den Namen der Tabelle fest, in der die Daten abgelegt werden sollen. Klicken Sie anschliessend den Button _SQL_. Falls die Tabelle noch nicht existiert (was der Fall sein sollte), wird der `CREATE TABLE`-Befehl aufgelistet, mit dem die Tabelle erstellt werden kann.

Wählen Sie den Button _Execute_, um die Tabelle zu erstellen. Führen Sie anschliessend die Pipeline aus und prüfen Sie, ob die Daten in der Datenbank abgelegt wurden.

---

=== Aufgabe 7 — Zusammenführen von ungleichen Datensätzen

*Ziel:* Zusammenführen von ungleichen Datensätzen.

Erstellen Sie ein neues Projekt `Mitarbeiter` und kopieren Sie die beiden Dateien `mitarbeiter_abt_1.csv` und `mitarbeiter_abt_2.csv` in das Projektverzeichnis.

Entwickeln Sie eine Pipeline, mit der die Datensätze zusammengefügt und als CSV- sowie als JSON-Datei gespeichert werden. Wenn Sie den Inhalt der Dateien untersuchen, werden Sie feststellen, dass es einige Unterschiede gibt.

Damit die Datensätze „kompatibel" werden, sind einige zusätzliche Blöcke erforderlich, bevor die Datensätze mit dem Block _Append stream_ zusammengefügt werden können. Dabei sollen die Daten wie folgt angeglichen werden:

Bei `mitarbeiter_abt_1`:
- Das fehlende Feld `ranking` mit einem Default-Wert `0.0` ergänzen
- Wenn das Alter nicht bekannt ist, soll der Wert `0` und nicht `NULL` verwendet werden

Bei `mitarbeiter_abt_2`:
- Das Feld `name` in `nachname` umbenennen

---

=== Aufgabe 8 — Berechnungen mit dem Block _Formula_

*Ziel:* Berechnungen mit dem Block _Formula_ durchführen.

Erstellen Sie ein neues Projekt `Temperature` und kopieren Sie die Datei `tempreratures.csv` in das Projektverzeichnis. Die Datei enthält eine Liste mit Materialien und deren Schmelz- und Siedetemperaturen in Kelvin.

Entwickeln Sie eine Pipeline, welche die Temperaturen nach °C und °F umrechnet und die Datensätze mit entsprechenden Feldern ergänzt. Beachten Sie, dass nicht alle Materialien einen Schmelz- oder Siedepunkt aufweisen.

_Hinweis:_ Benennen Sie zuerst die Felder so um, dass sie keine Klammern `( )` im Namen aufweisen.
```

== Lösungen

=== Aufgabe 1 — Erste Schritte mit Apache Hop

==== Projekt „Tutorial" erstellen

*Schritt 1 —* Apache Hop starten, indem die Datei `hop-gui.sh` (Linux/macOS) bzw. `hop-gui.bat` (Windows) im Unterverzeichnis `hop` ausgeführt wird; Apache Hop ist ein hybrides ETL/ELT-Tool (vgl. Vorlesung: „Hybrid Dataprocessing und Datenflussmanagement"), das grafische Pipeline-Entwicklung mit Datenflussmanagement kombiniert.

*Schritt 2 —* In der unteren linken Ecke auf das Projekt-Icon klicken und im erscheinenden Menü _Add project..._ auswählen, um den Dialog _Project Properties_ zu öffnen.

*Schritt 3 —* Im Feld _Name_ den Projektnamen `Tutorial` eingeben; der Name identifiziert das Projekt eindeutig innerhalb von Apache Hop.

*Schritt 4 —* Rechts des Felds _Home folder_ auf btn:[Browse] klicken, im Verzeichnis-Auswahl-Dialog ein neues Verzeichnis `Tutorial` erstellen und dieses auswählen, da Apache Hop ein dediziertes Verzeichnis als Arbeitsbereich (Home folder) benötigt.

*Schritt 5 —* Sicherstellen, dass das Verzeichnis für das Betriebssystem-Benutzerkonto schreibbar ist (wichtig: Apache Hop speichert Pipeline-Definitionen als XML-Dateien im Projektverzeichnis).

*Schritt 6 —* Den Dialog _Create project lifecycle environment?_ mit _No_ schliessen, da für dieses Tutorial keine separaten Laufzeitumgebungen benötigt werden.

==== Tutorial-Pipeline nachbauen

*Schritt 7 —* Das Tutorial unter `https://hop.apache.org/manual/latest/getting-started/hop-gui-pipelines.html` durchspielen; dabei wird eine einfache Pipeline aus Input-Transform-Output-Blöcken zusammengestellt, was dem ETL-Grundprinzip (Extract → Transform → Load) aus der Vorlesung entspricht.

*Schritt 8 —* Im Hauptfenster eine neue Pipeline erstellen (File → New → Pipeline) und die Blöcke gemäss Tutorial-Anleitung per Drag-and-Drop in den Canvas ziehen und mit Hops (Pfeilen) verbinden.

*Ergebnis:* Eine lauffähige Tutorial-Pipeline gemäss folgendem Schema:

```
[Generate rows] ---> [Add sequence] ---> [Write to log]
```

=== Aufgabe 2 — CSV-Dateien einlesen

==== Projekt „Sales" und Pipeline erstellen

*Schritt 1 —* Analog zu Aufgabe 1 ein neues Projekt `Sales` erstellen und die Datei `sales.csv` in das Projektverzeichnis kopieren; die Datei dient als Quelldaten (Extract-Phase im ETL-Prozess).

*Schritt 2 —* Eine neue Pipeline erstellen (File → New → Pipeline) und einen Block _CSV file input_ aus der Transform-Palette in den Canvas ziehen; dieser Block übernimmt die Extract-Rolle im ETL-Prozess.

*Schritt 3 —* Den Block _CSV file input_ doppelklicken, um seine Einstellungen zu öffnen, und folgende Parameter setzen, da sie das Dateiformat der `sales.csv` beschreiben:

```
Transform name : Read sales
Filename       : ${PROJECT_HOME}/sales.csv
Delimiter      : ,
Enclosure      : "
Lazy conversion: (Häkchen entfernen)
```

*Schritt 4 —* Auf den Button _Get Fields_ klicken, damit Apache Hop die Kopfzeile und eine Stichprobe der Datensätze einliest und die Felder mit ihren Datentypen automatisch erkennt; dies entspricht dem Schema-Mapping in der Datenintegration.

*Schritt 5 —* Bei den Feldern `CITY` und `STATE` den _Trim type_ auf `both` setzen, um führende und nachfolgende Leerzeichen zu entfernen — dies ist ein typischer Schritt der Datenbereinigung (Data Cleaning), da Leerzeichen beim späteren Lookup (Aufgabe 4) zu fehlgeschlagenen Matches führen würden.

*Schritt 6 —* Einen _Dummy_-Block erstellen, ihn mit _Read sales_ per Hop verbinden und mit dem Button _Preview_ die eingelesenen Datensätze tabellarisch prüfen, um die Vollständigkeit und Plausibilität der Daten zu beurteilen (Validierung).

*Ergebnis:* Die Pipeline liest die `sales.csv` korrekt ein:

```
[Read sales (CSV file input)] ---> [Dummy]
```

Die Felder werden mit ihren erkannten Datentypen (z. B. `ORDERNUMBER: Integer`, `SALES: Number`, `CITY: String`, `STATE: String`) angezeigt.

=== Aufgabe 3 — Datensätze aufteilen

==== Pipeline mit Filter erweitern

*Schritt 1 —* Die Pipeline aus Aufgabe 2 öffnen und einen zweiten _CSV file input_-Block für `zipssorted.csv` hinzufügen; diese Datei enthält Referenzdaten (Postleitzahlen), die später für die Datenanreicherung (Data Enrichment) benötigt werden.

*Schritt 2 —* Bei _Read zips_ den Datentyp von `POSTALCODE` auf `String` setzen, da Postleitzahlen führende Nullen enthalten können, die bei einem numerischen Typ verloren gingen — dies ist ein typischer Datenfehler (Konvertierungsfehler), den die Datenbereinigung beheben muss.

*Schritt 3 —* Einen Block _Filter rows_ in den Canvas ziehen und zwischen _Read sales_ und den zwei _Dummy_-Blöcken einsetzen; der Filter trennt vollständige Datensätze (POSTALCODE gesetzt) von unvollständigen (POSTALCODE ist NULL oder leer).

*Schritt 4 —* Den Block _Filter rows_ doppelklicken und die Bedingung wie folgt konfigurieren, um Datensätze mit fehlender Postleitzahl zu identifizieren (fehlende Werte sind ein klassischer Datenfehler gemäss Vorlesung):

```
Condition: POSTALCODE IS NOT NULL
```

*Schritt 5 —* Den grünen Hop (Bedingung erfüllt = POSTALCODE vorhanden) zum ersten _Dummy_-Block und den orangen Hop (Bedingung nicht erfüllt = POSTALCODE fehlt) zum zweiten _Dummy_-Block verbinden.

*Schritt 6 —* Die Pipeline ausführen (Run) und die Zähler an den Hops ablesen; die Anzahl der Datensätze am orangen Hop gibt die Anzahl der Einträge ohne Postleitzahl an.

*Ergebnis:* Die Pipeline hat folgende Struktur:

```
[Read sales] ---> [Filter rows] --green--> [Dummy: mit PLZ]
                               --orange--> [Dummy: ohne PLZ]
[Read zips]  (noch nicht verbunden)
```

*Beobachtung:* Beim orangen Hop (fehlende Postleitzahl) werden Datensätze gezählt — die genaue Anzahl ist durch Ausführen der Pipeline ablesbar (typischerweise einige Dutzend Einträge in `sales.csv`).

=== Aufgabe 4 — Vervollständigen von Datensätzen mit Lookup

==== Stream Lookup konfigurieren

*Schritt 1 —* Den Block _Read zips_ (CSV file input für `zipssorted.csv`) mit einem neuen Block _Stream lookup_ verbinden; der Stream Lookup übernimmt die Rolle der Datenanreicherung (Data Enrichment) aus der Vorlesung — fehlende Felder werden durch Abgleich mit einer Referenzdatei ergänzt.

*Schritt 2 —* Den Block _Stream lookup_ doppelklicken und als Lookup-Stream den Ausgang von _Read zips_ auswählen; der Lookup-Stream stellt die Referenzdaten bereit.

*Schritt 3 —* Die Lookup-Schlüssel konfigurieren (Join-Bedingung), da `CITY` und `STATE` die gemeinsamen Verknüpfungsattribute zwischen `sales.csv` und `zipssorted.csv` sind:

```
Stream field  : CITY    --> Lookup field: CITY
Stream field  : STATE   --> Lookup field: STATE
```

*Schritt 4 —* Als Ergebnisfeld `POSTALCODE` aus dem Lookup-Stream hinzufügen und es als `ZIP_RESOLVED` benennen, damit das ursprüngliche Feld `POSTALCODE` nicht sofort überschrieben wird und eine saubere Transformation möglich ist:

```
Field in stream: POSTALCODE  --> New name: ZIP_RESOLVED
```

*Schritt 5 —* Den orange Hop (fehlende POSTALCODE) vom _Filter rows_ zum _Stream lookup_ führen; nur die Datensätze ohne Postleitzahl durchlaufen den Lookup-Schritt.

==== Select values konfigurieren

*Schritt 6 —* Einen Block _Select values_ nach dem _Stream lookup_ einfügen; dieser Block übernimmt die Transformation: das aufgelöste Feld `ZIP_RESOLVED` ersetzt das ursprünglich leere `POSTALCODE`.

*Schritt 7 —* Im Reiter _Select & Alter_ auf _Get Fields to select_ klicken, alle Felder eintragen lassen, dann den Eintrag `ZIP_RESOLVED` an die Position von `POSTALCODE` verschieben und den ursprünglichen Eintrag `POSTALCODE` löschen:

```
Felder (Reihenfolge): ORDERNUMBER, QUANTITYORDERED, ..., ZIP_RESOLVED, COUNTRY, ...
(POSTALCODE-Eintrag entfernt)
```

*Schritt 8 —* Im Reiter _Meta-data_ folgenden Eintrag hinzufügen, um `ZIP_RESOLVED` in `POSTALCODE` umzubenennen, sodass das Zielschema konsistent bleibt:

```
Fieldname  : ZIP_RESOLVED
Rename to  : POSTALCODE
```

==== Append streams konfigurieren

*Schritt 9 —* Einen Block _Append streams_ einfügen und so verbinden, dass der grüne Hop (Datensätze mit original POSTALCODE) als Head-Stream und der Ausgang von _Select values_ (angereicherte Datensätze) als Tail-Stream eingestellt wird; der Append-Block führt die zwei Teilströme wieder zusammen (analog zu UNION in SQL).

*Schritt 10 —* Den Ausgang von _Append streams_ mit einem _Dummy_-Block verbinden und die Pipeline ausführen; in der Vorschau erscheinen die angereicherten Datensätze (mit zuvor fehlender PLZ) zuoberst.

*Ergebnis:* Die vollständige Pipeline:

```
[Read sales] --> [Filter rows] --green--> [Append streams] --> [Dummy]
                               --orange--> [Stream lookup] --> [Select values] --> [Append streams]
[Read zips]  --> [Stream lookup]
```

Alle Datensätze haben nun einen Wert im Feld `POSTALCODE` — fehlende Postleitzahlen wurden durch Abgleich mit `zipssorted.csv` ergänzt (Datenanreicherung durch gemeinsame Verknüpfungsattribute `CITY` und `STATE`).

=== Aufgabe 5 — Bereinigen und Ergänzen von Feldern

==== Value Mapper konfigurieren

*Schritt 1 —* Einen Block _Value mapper_ nach dem _Append streams_-Block einfügen; dieser Block übernimmt die regelbasierte Bereinigung (Rule-based Cleaning) aus der Vorlesung — inkonsistente Feldwerte werden durch korrekte Werte ersetzt.

*Schritt 2 —* Den Block _Value mapper_ doppelklicken und folgende Einstellungen vornehmen, um die inkonsistente Schreibweise von `COUNTRY` zu bereinigen (typischer Datenfehler: dieselbe Entität mit unterschiedlichen Bezeichnungen):

```
Fieldname to use : COUNTRY
Target field name: COUNTRY
Non match default: (leer lassen)

Source value    --> Target value
United States   --> USA
```

==== Number Range konfigurieren

*Schritt 3 —* Einen Block _Number range_ nach dem _Value mapper_-Block einfügen; dieser Block ergänzt die Daten um ein neues kategoriales Feld, was der Datenanreicherung (Data Enrichment) und Feature-Engineering entspricht.

*Schritt 4 —* Den Block _Number range_ doppelklicken und folgende Einstellungen vornehmen, um den Bestellumfang anhand des Felds `SALES` zu kategorisieren:

```
Input field : SALES
Output field: ORDER_SIZE

Lower bound --> Upper bound --> Value
0           --> 1000        --> Small
1000        --> 5000        --> Medium
5000        --> 99999       --> Large
```

*Schritt 5 —* Einen _Dummy_-Block am Ende anhängen, die Pipeline ausführen und in der Vorschau prüfen:
- Feld `COUNTRY`: Alle Einträge zeigen nun `USA` (kein `United States` mehr)
- Feld `ORDER_SIZE`: Jeder Datensatz hat eine Kategorie (`Small`, `Medium` oder `Large`)

*Ergebnis:* Die erweiterte Pipeline:

```
... --> [Append streams] --> [Value mapper] --> [Number range] --> [Dummy]
```

Die Daten sind bereinigt (einheitliches `COUNTRY`) und um das Kategorisierungsfeld `ORDER_SIZE` angereichert.

=== Aufgabe 6 — Schreiben von Datensätzen in eine Datenbank

==== Datenbank vorbereiten

*Schritt 1 —* In `psql` (PostgreSQL) die Zieldatenbank erstellen, da Apache Hop selbst keine Datenbanken anlegen kann (es ist ein ETL/ELT-Tool, kein DBMS):

```sql
CREATE DATABASE sampledata;
```

==== Table output konfigurieren

*Schritt 2 —* In der Pipeline den _Dummy_-Block am Ende durch einen Block _Table output_ ersetzen; dieser Block übernimmt die Load-Phase im ETL-Prozess — die transformierten Daten werden in die Datenbank geschrieben.

*Schritt 3 —* Den Block _Table output_ doppelklicken und auf das Datenbank-Icon klicken, um eine neue Datenbankverbindung zu konfigurieren:

```
Connection type : PostgreSQL
Host name       : localhost
Database name   : sampledata
Port number     : 5432
Username        : <DB-Benutzername>
Password        : <DB-Passwort>
```

*Schritt 4 —* Mit dem Button _Test_ prüfen, ob die Verbindung erfolgreich aufgebaut werden kann; eine erfolgreiche Verbindung ist Voraussetzung für den Load-Schritt.

*Schritt 5 —* Im Feld _Target Table_ den Tabellennamen `SALES_DATA` eintragen, der die Ziel-Tabelle im Data Warehouse (hier: PostgreSQL-Datenbank) definiert.

*Schritt 6 —* Auf den Button _SQL_ klicken; Apache Hop generiert automatisch den `CREATE TABLE`-Befehl basierend auf dem aktuellen Feldschema der Pipeline:

```sql
CREATE TABLE SALES_DATA (
  ORDERNUMBER    BIGINT,
  QUANTITYORDERED BIGINT,
  SALES          DOUBLE PRECISION,
  POSTALCODE     VARCHAR(255),
  CITY           VARCHAR(255),
  STATE          VARCHAR(255),
  COUNTRY        VARCHAR(255),
  ORDER_SIZE     VARCHAR(255),
  ...
);
```

*Schritt 7 —* Den Button _Execute_ klicken, um die Tabelle zu erstellen, und anschliessend die Pipeline ausführen.

*Schritt 8 —* In `psql` die erfolgreiche Datenablage prüfen:

```sql
SELECT COUNT(*) FROM SALES_DATA;
SELECT * FROM SALES_DATA LIMIT 5;
```

*Ergebnis:* Die vollständige ETL-Pipeline:

```
[Read sales] --> [Filter rows] --> ... --> [Value mapper] --> [Number range] --> [Table output: SALES_DATA]
```

Alle bereinigten und angereicherten Datensätze sind in der Tabelle `SALES_DATA` der PostgreSQL-Datenbank `sampledata` abgelegt.

=== Aufgabe 7 — Zusammenführen von ungleichen Datensätzen

==== Projekt und Dateien vorbereiten

*Schritt 1 —* Ein neues Projekt `Mitarbeiter` erstellen und die Dateien `mitarbeiter_abt_1.csv` sowie `mitarbeiter_abt_2.csv` in das Projektverzeichnis kopieren; die zwei Dateien repräsentieren heterogene Datenquellen, deren Schemata angeglichen werden müssen — ein klassisches Datenintegrationsproblem (Schema-Heterogenität).

*Schritt 2 —* Beide CSV-Dateien in einem Texteditor oder mit DuckDB untersuchen, um die Unterschiede zu identifizieren (vgl. Vorlesung: „Data preparation — browsing"):

```
mitarbeiter_abt_1.csv: Felder: id, vorname, nachname, alter, abteilung
  → kein Feld "ranking"; Alter kann NULL sein

mitarbeiter_abt_2.csv: Felder: id, vorname, name, alter, abteilung, ranking
  → Feld heisst "name" statt "nachname"
```

==== Branch für mitarbeiter_abt_1

*Schritt 3 —* Einen _CSV file input_-Block für `mitarbeiter_abt_1.csv` erstellen (Transform name: `Read Abt1`); dieser liest die erste Datenquelle ein (Extract-Phase).

*Schritt 4 —* Einen Block _Add constants_ (oder _Add values_) nach _Read Abt1_ einfügen und das fehlende Feld `ranking` mit dem Default-Wert `0.0` (Typ: `Number`) ergänzen; fehlende Felder mit Default-Werten zu füllen ist eine Technik der Datenbereinigung (Data Cleaning), um Schema-Kompatibilität herzustellen:

```
Name   : ranking
Type   : Number
Value  : 0.0
```

*Schritt 5 —* Einen Block _If field value is null_ (oder _Replace in string_ / _Coalesce_ via _Calculator_) nach dem vorigen Block einfügen, um NULL-Werte im Feld `alter` durch `0` zu ersetzen; fehlende numerische Werte sind ein typischer einfacher Datenfehler (durch Betrachtung eines Tupels erkennbar):

```
Field        : alter
Replace by   : 0
```

==== Branch für mitarbeiter_abt_2

*Schritt 6 —* Einen _CSV file input_-Block für `mitarbeiter_abt_2.csv` erstellen (Transform name: `Read Abt2`); dieser liest die zweite Datenquelle ein.

*Schritt 7 —* Einen Block _Select values_ nach _Read Abt2_ einfügen und im Reiter _Meta-data_ das Feld `name` in `nachname` umbenennen, damit beide Streams ein einheitliches Zielschema aufweisen (Schema-Angleichung als Teil der Datenintegration):

```
Fieldname : name
Rename to : nachname
```

==== Streams zusammenführen und speichern

*Schritt 8 —* Einen Block _Append streams_ einfügen und so konfigurieren, dass _Read Abt1_ (nach den Transformationsblöcken) als Head-Stream und _Read Abt2_ (nach _Select values_) als Tail-Stream dienen; der Append-Block vereint beide Streams zu einem einheitlichen Datenstrom.

*Schritt 9 —* Einen Block _Text file output_ (für CSV) nach _Append streams_ einfügen und konfigurieren:

```
Filename  : ${PROJECT_HOME}/mitarbeiter_gesamt
Extension : csv
Separator : ,
Enclosure : "
```

*Schritt 10 —* Einen zweiten Output-Block _Json output_ parallel zum CSV-Block einfügen (oder in Serie nach dem CSV-Block), um die Daten auch als JSON zu speichern:

```
Filename  : ${PROJECT_HOME}/mitarbeiter_gesamt
Extension : json
```

*Ergebnis:* Die vollständige Pipeline:

```
[Read Abt1] --> [Add constants: ranking=0.0] --> [If null: alter=0] --> [Append streams] --> [Text file output: .csv]
[Read Abt2] --> [Select values: name→nachname]                     --> [Append streams] --> [Json output: .json]
```

Beide Abteilungs-Datensätze sind mit einheitlichem Schema zusammengeführt und in CSV- sowie JSON-Format gespeichert.

=== Aufgabe 8 — Berechnungen mit dem Block Formula

==== Projekt und Datei vorbereiten

*Schritt 1 —* Ein neues Projekt `Temperature` erstellen und die Datei `temperatures.csv` in das Projektverzeichnis kopieren; die Datei enthält Schmelz- und Siedetemperaturen in Kelvin als Quelldaten.

*Schritt 2 —* Die Datei untersuchen, um die Feldnamen zu identifizieren (z. B. `Material`, `Melting point (K)`, `Boiling point (K)`); Felder mit Klammern im Namen können in Apache Hop zu Problemen führen und müssen umbenannt werden.

==== Felder umbenennen

*Schritt 3 —* Einen _CSV file input_-Block erstellen (Transform name: `Read Temperatures`, Filename: `${PROJECT_HOME}/temperatures.csv`) und mit _Get Fields_ die Felder einlesen.

*Schritt 4 —* Einen Block _Select values_ nach dem CSV-Input einfügen und im Reiter _Meta-data_ die Felder mit Klammern umbenennen, da Apache Hop-Formeln keine Klammern in Feldnamen verarbeiten können:

```
Fieldname         --> Rename to
Melting point (K) --> melting_K
Boiling point (K) --> boiling_K
```

==== Temperaturumrechnung mit Formula-Blöcken

*Schritt 5 —* Einen Block _Formula_ nach _Select values_ einfügen, um die Schmelztemperatur von Kelvin nach °C und °F umzurechnen; die Umrechnungsformeln lauten:

$ T_"°C" = T_"K" - 273.15 $
$ T_"°F" = T_"K" times 1.8 - 459.67 $

*Schritt 6 —* Im Block _Formula_ folgende neue Felder definieren; dabei wird `IF(ISBLANK(...))` verwendet, um fehlende Werte (nicht alle Materialien haben einen Schmelzpunkt) korrekt zu behandeln — fehlende Werte sind ein klassischer Datenfehler:

```
New field      : melting_C
Formula        : IF(ISBLANK([melting_K]); NA(); [melting_K] - 273.15)
Value type     : Number

New field      : melting_F
Formula        : IF(ISBLANK([melting_K]); NA(); [melting_K] * 1.8 - 459.67)
Value type     : Number

New field      : boiling_C
Formula        : IF(ISBLANK([boiling_K]); NA(); [boiling_K] - 273.15)
Value type     : Number

New field      : boiling_F
Formula        : IF(ISBLANK([boiling_K]); NA(); [boiling_K] * 1.8 - 459.67)
Value type     : Number
```

*Schritt 7 —* Einen _Dummy_-Block am Ende der Pipeline anhängen, die Pipeline ausführen und die Vorschau prüfen; für Materialien ohne Schmelz- oder Siedepunkt (NULL/leer) sollen die umgerechneten Felder ebenfalls leer/NULL bleiben.

*Ergebnis:* Die vollständige Pipeline:

```
[Read Temperatures] --> [Select values: umbenennen] --> [Formula: Umrechnung] --> [Dummy]
```

Beispielrechnung für Wasser (Schmelzpunkt 273.15 K, Siedepunkt 373.15 K):

$ T_"Schmelz,°C" = 273.15 - 273.15 = 0 "°C" $

$ T_"Schmelz,°F" = 273.15 times 1.8 - 459.67 = 491.67 - 459.67 = 32 "°F" $

$ T_"Siede,°C" = 373.15 - 273.15 = 100 "°C" $

$ T_"Siede,°F" = 373.15 times 1.8 - 459.67 = 671.67 - 459.67 = 212 "°F" $

Jeder Datensatz in der Pipeline enthält nun die Felder `melting_K`, `melting_C`, `melting_F`, `boiling_K`, `boiling_C` und `boiling_F`, wobei fehlende Originalwerte zu fehlenden umgerechneten Werten führen.