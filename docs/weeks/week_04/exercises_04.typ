// Echte Kursübungen — Woche 4 (konvertiert am 2026-05-09)
// Quelle: README.adoc

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Übungen

=== Aufgabe 1 — Schweiz-Daten in QGIS anzeigen

Bei gestartetem QGIS …

*Schritt 1:*
Die Datei `Schweiz.gpkg` (im Übungsverzeichnis) einfach mit Drag & Drop in den „Layers Panel" ziehen (Alternative: Menu „Layer" > „Layer hinzufügen" > „Vektorlayer hinzufügen").

*Schritt 2:*
Die Layers so sortieren wie nachfolgend angezeigt, d.h. Flächen zuunterst, dann Linien, dann Punkte (und allfällige weitere — wie z.B. Labels — ganz „oben").

*Schritt 3:*
Die Layer untersuchen: Was haben Sie für CRS (siehe Layer-Properties mit Rechts-Klick)? Was für Attribute (siehe in Icon Bar „Open Attribute Table")?

---

=== Aufgabe 2 — PostGIS-Datenbank `gisdb` erstellen

In diesem Abschnitt sind nur die *fett* gedruckten Befehle einzugeben. Der Rest sind Ausgaben des Computers.

*1. Eine leere PostGIS-Datenbank `gisdb` erstellen*

Variante SQL:
```sql
postgres=# CREATE DATABASE gisdb;
CREATE DATABASE
```

Variante GUI im pgAdmin: Rechts-Klick und „Create Database"; dann die Extension „postgis" mit „New Object > New Extension…" installieren.

Variante Command Shell:
```
shell> createdb -U postgres gisdb
```

*2. PostGIS-Extension aktivieren*

Zur Datenbank `gisdb` verbinden (`psql`):
```
postgres=# \c gisdb
You are now connected to database "gisdb" as user "postgres".
gisdb=#
```
(In pgAdmin stattdessen per Kontext-Menü ein SQL-Eingabefenster für die DB `gisdb` öffnen.)

PostGIS für `gisdb` aktivieren (in `psql` oder pgAdmin):
```sql
gisdb=# CREATE EXTENSION postgis;
CREATE EXTENSION
```

Variante Command Shell:
```
shell> psql -U postgres -d gisdb --command="CREATE EXTENSION postgis;"
CREATE EXTENSION
```

*3. Installation überprüfen*

Die leere Datenbank `gisdb` sollte nun bereit sein. Das kann folgendermassen überprüft werden (sollte eine Row liefern):

```
shell> psql --username postgres --dbname gisdb --command="SELECT postgis_full_version();"
```

oder (etwas kürzer):

```
shell> psql -U postgres -d gisdb -c"SELECT postgis_full_version();"
```

oder: `psql` starten (z.B. als User `postgres`) und die Query dort eingeben:

```sql
gisdb=# SELECT postgis_full_version();
```

---

=== Aufgabe 3 — Daten der Schweiz mittels QGIS in PostGIS importieren

*Voraussetzungen:*
- QGIS ist gestartet
- mit den Layern „Schweiz gemeinden", „Schweiz fluesse" und „Schweiz orte", die vom GeoPackage kommen
- und mit der leeren DB `gisdb` in der PostGIS-Datenbank

*Schritt 1:*
Im QGIS im Panel «Browser» aus dem Kontext-Menü des «PostGIS»-Eintrags (Blaues Elefant-Icon) den Eintrag «neue Verbindung» wählen und dann die PostgreSQL-Verbindung zur Datenbank `gisdb` einrichten.

*Schritt 2:*
Im QGIS die „DB-Verwaltung" (auch „DB Manager" genannt) öffnen: Menu „Datenbank" > „DB-Verwaltung". Dort sollte bei „PostGIS" ein Eintrag „gisdb" stehen.

*Schritt 3:*
Im „DB Manager" bei „PostGIS" den Eintrag „gisdb" sowie DB-Schema „public" wählen; dann „Import" (Vector Layer). Die zurzeit im QGIS „Layers Panel" geöffneten Layer „Schweiz gemeinden", „Schweiz fluesse" und „Schweiz orte" können nun einzeln hintereinander als Tabellen `gemeinden`, `fluesse`, `orte` importiert werden. Dabei muss die Option „primärschlüssel" auf «fid» gesetzt werden.

*Schritt 4:*
Mit pgAdmin kontrollieren, ob die Tabellen erscheinen und mit Daten gefüllt sind.

_Hinweis:_ Falls der „DB Manager" im QGIS nicht funktioniert oder falls die Datenmenge riesig ist, empfiehlt sich das Kommandozeilen-Tool `ogr2ogr`. Importieren Sie das GeoPackage in die Datenbank mit folgendem Befehl:

```
ogr2ogr -f PostgreSQL PG:"dbname='gisdb' user='postgres' password='postgres'" -overwrite Schweiz.gpkg
```

---

=== Aufgabe 4 — Räumliche Query lesen

Schauen Sie diese Query an:

```sql
WITH mylocation AS ( -- Nelson Pub Rapperswil
  SELECT st_transform(st_geomfromtext('POINT(8.81642 47.22541)', 4326), 21781) AS geom
)
SELECT
  "name",
  st_astext(orte.geom,0) AS geom,
  st_distance(orte.geom,mylocation.geom)::int AS distance_in_m
FROM orte
JOIN mylocation ON st_dwithin(orte.geom, mylocation.geom, 10000)
ORDER BY distance_in_m;
```

Was machen die verschiedenen `ST_`-Funktionen? Sehen Sie in der PostGIS-Dokumentation nach.

- `ST_GeomFromText`
- `ST_Transform`
- `ST_AsText`
- `ST_Distance`
- `ST_DWithin`

Was für eine Frage ermittelt obige Query? Welches Ergebnis erwarten Sie? Dokumentieren Sie Ihre Annahme, bevor Sie die Query ausprobieren.

Sehen Sie sich zusätzlich diese Funktion an:

- `ST_Buffer`

---

=== Aufgabe 5 — Eigene räumliche Queries erstellen

Schreiben Sie folgende Queries in SQL. Wenn Sie wollen, können Sie das Resultat auch in QGIS anschauen (ausserdem hat QGIS viele Funktionen auch im Menu).

**(1)** Was ist die Distanz zwischen Bern und Zürich?

**(2)** Schreiben Sie eine Query, die alle Gemeinden selektiert, die an die Gemeinde Rapperswil-Jona angrenzen. Beachten Sie, dass Sie dazu eine Attribut- und eine räumliche Abfrage kombinieren müssen. Ausgabe der Gemeinde-Namen.

**(3)** Schreiben Sie eine Query, die alle Orte (Namen) im Umkreis von 10 km um die HSR (Landeskoordinaten (CH1903): 704472/231216) selektiert.

**(4)** Schreiben Sie eine Query, die alle Orte (Namen) selektiert, die in einer Pufferzone von 2 km um den Fluss Emme liegen.

**(5)** Schreiben Sie eine Query, die alle Gemeinden selektiert, durch die der Fluss Emme fliesst. Ausgabe der Gemeinde-Namen.

---

=== Aufgabe 6 — Flächenverschnitt (Spatial Analysis)

Erfassen Sie eine Flugschneise mit https://geojson.io, schreiben Sie dann eine Query in SQL und visualisieren Sie schliesslich das Resultat mit QGIS Desktop und wieder mit geojson.io im Webbrowser.

**(1)** Mit geojson.io eine Linie mit zwei Punkten erfassen, die von Zürich-Kloten (CH) bis Bernau im Schwarzwald (D) geht und die `id=1` hat.

**(2)** Linie im GeoJSON-Format exportieren in die Datei `flugschneise.json`.

**(3)** Datei `flugschneise.json` in QGIS importieren (z.B. Drag & Drop), dort darstellen und in Layer „flugschneise (GeoJSON)" umbenennen.

**(4)** Mit QGIS und dort mit dem DB-Manager den Layer „flugschneise" in PostGIS importieren und als gleichnamige Tabelle speichern.

_Wichtig:_ Kreuzen Sie „Ziel-SRID" an und wählen Sie dort `EPSG:21781`, damit die Daten der Flugschneise im selben Bezugssystem vorliegen wie die restlichen Daten.

**(5)** Mit pgAdmin SQL-Fenster (oder Texteditor und `psql`) eine SQL-Query schreiben, welche die Geometrien der Tabelle `flugschneise` mit 2 km puffert und mit den Geometrien der Tabelle `gemeinden` verschneidet.

_Tipp:_ Verwenden Sie die PostGIS-Funktion `st_intersection`:

```sql
select st_intersection(g1.geom, g2.geom) from g1,g2 where st_intersects(g1,g2) …;
```

_Tipp:_ Attribute, die Schlüsselwörter sein könnten, in Anführungszeichen setzen, z.B. `"name"` oder `"date"`.

== Lösungen

=== Aufgabe 1 — Schweiz-Daten in QGIS anzeigen

==== Schritt 1 — GeoPackage laden
*Schritt 1 —* Die Datei `Schweiz.gpkg` wird per Drag & Drop in das „Layers Panel" von QGIS gezogen, um die enthaltenen Vektorlayer zu laden.

*Schritt 2 —* Die Layer werden nach dem Ebenenprinzip (wie in der Vorlesung beschrieben) sortiert: Flächen (Polygone) zuunterst, darüber Linien (LineStrings), dann Punkte — damit höhere Layer nicht von unteren verdeckt werden.

*Schritt 3 —* Jeder Layer wird per Rechts-Klick > „Properties" untersucht:

*Ergebnis:*

- `Schweiz_gemeinden` — Typ: *Polygon*, CRS: `EPSG:21781` (CH1903/LV03), Attribute: z.B. `fid`, `name`, `kanton`
- `Schweiz_fluesse` — Typ: *LineString*, CRS: `EPSG:21781`, Attribute: z.B. `fid`, `name`
- `Schweiz_orte` — Typ: *Point*, CRS: `EPSG:21781`, Attribute: z.B. `fid`, `name`, `einwohner`

Das CRS `EPSG:21781` entspricht dem schweizerischen Landeskoordinatensystem CH1903/LV03 (planares CRS, Einheit: Meter).

---

=== Aufgabe 2 — PostGIS-Datenbank `gisdb` erstellen

==== Schritt 1 — Leere Datenbank erstellen
*Schritt 1 —* Eine neue, leere Datenbank wird angelegt, weil PostGIS eine eigene Datenbank benötigt, in der die Erweiterung aktiviert wird.

```sql
CREATE DATABASE gisdb;
```

Oder via Shell:
```
createdb -U postgres gisdb
```

==== Schritt 2 — Mit der Datenbank verbinden
*Schritt 2 —* Es wird zur neu erstellten Datenbank gewechselt, damit die nachfolgende Extension im richtigen Datenbankkontext installiert wird.

```
\c gisdb
```

==== Schritt 3 — PostGIS-Extension aktivieren
*Schritt 3 —* Die PostGIS-Erweiterung wird aktiviert, um die Geodatentypen (`GEOMETRY`, `GEOGRAPHY`), die PostGIS-Funktionen (z.B. `ST_Buffer`, `ST_Distance`) sowie den räumlichen GIST-Index (R-Baum) verfügbar zu machen.

```sql
CREATE EXTENSION postgis;
```

==== Schritt 4 — Installation prüfen
*Schritt 4 —* Die Installation wird verifiziert; die Funktion `postgis_full_version()` gibt die installierte PostGIS-Version zurück.

```sql
SELECT postgis_full_version();
```

*Ergebnis:* Eine Zeile mit der PostGIS-Versionsinformation wird ausgegeben, z.B.:
```
POSTGIS="3.2.0" [EXTENSION] PGSQL="140" GEOS="3.10.2" PROJ="8.2.1" ...
```

---

=== Aufgabe 3 — Schweiz-Daten via QGIS in PostGIS importieren

==== Schritt 1 — PostGIS-Verbindung in QGIS einrichten
*Schritt 1 —* Im QGIS-Browser wird unter dem PostGIS-Eintrag (blauer Elefant) eine neue Verbindung zur Datenbank `gisdb` konfiguriert, damit QGIS mit der PostGIS-Datenbank kommunizieren kann.

Verbindungsparameter:
- Name: `gisdb`
- Host: `localhost`
- Port: `5432`
- Datenbank: `gisdb`
- Benutzer: `postgres`

==== Schritt 2 — DB-Manager öffnen
*Schritt 2 —* Der DB-Manager wird über Menu „Datenbank" > „DB-Verwaltung" geöffnet, um den Import der Vektorlayer in PostGIS durchzuführen.

==== Schritt 3 — Layer importieren
*Schritt 3 —* Jeder der drei Layer wird einzeln über „Import (Vector Layer)" in die Datenbank `gisdb`, Schema `public`, importiert — dabei wird der Primärschlüssel auf `fid` gesetzt, damit jede Zeile eindeutig identifizierbar ist.

Import-Einstellungen für jeden Layer:

- `Schweiz_gemeinden` → Tabellenname: `gemeinden`, Primärschlüssel: `fid`
- `Schweiz_fluesse` → Tabellenname: `fluesse`, Primärschlüssel: `fid`
- `Schweiz_orte` → Tabellenname: `orte`, Primärschlüssel: `fid`

Alternative via `ogr2ogr` (Command Line):
```
ogr2ogr -f PostgreSQL PG:"dbname='gisdb' user='postgres' password='postgres'" \
  -overwrite Schweiz.gpkg
```

==== Schritt 4 — Import kontrollieren
*Schritt 4 —* In pgAdmin wird überprüft, ob die drei Tabellen mit Daten befüllt sind.

```sql
SELECT count(*) FROM gemeinden;
SELECT count(*) FROM fluesse;
SELECT count(*) FROM orte;
```

*Ergebnis:* Die drei Tabellen `gemeinden`, `fluesse`, `orte` existieren in der Datenbank `gisdb` und enthalten jeweils Zeilen mit einem `geom`-Attribut vom Typ `GEOMETRY`.

---

=== Aufgabe 4 — Räumliche Query lesen

==== Erklärung der ST_-Funktionen

*Schritt 1 —* Die verwendeten PostGIS-Funktionen werden gemäss Vorlesungsklassifikation (Keller 2011) eingeordnet und erklärt:

*`ST_GeomFromText`* — _Constructor Function_: Erzeugt ein Geometrie-Objekt aus einem WKT-String (Well Known Text) mit optionaler SRID. In der Query wird der Standort des Nelson Pub als `POINT(8.81642 47.22541)` im CRS `EPSG:4326` (WGS84/GPS, geografische Koordinaten lon/lat) konstruiert.

```sql
ST_GeomFromText('POINT(8.81642 47.22541)', 4326)
-- Erzeugt: POINT mit lon=8.81642, lat=47.22541 in EPSG:4326
```

*`ST_Transform`* — _Output/Conversion Function_: Transformiert eine Geometrie von einem Koordinatenreferenzsystem (CRS) in ein anderes. Hier wird von `EPSG:4326` (geocentrisch, Grad) nach `EPSG:21781` (CH1903/LV03, planar, Meter) transformiert, damit metrische Distanzberechnungen korrekt sind.

```sql
ST_Transform(geom, 21781)
-- Wandelt WGS84-Koordinaten in Schweizer Landeskoordinaten um
```

*`ST_AsText`* — _Output Function_: Gibt eine Geometrie als lesbaren WKT-String zurück. Der zweite Parameter `0` rundet die Koordinaten auf 0 Dezimalstellen.

```sql
ST_AsText(orte.geom, 0)
-- z.B. "POINT(700000 231000)"
```

*`ST_Distance`* — _Measurement Function_: Berechnet die (euklidische) Distanz zwischen zwei Geometrien in den Einheiten des CRS. Da das CRS hier `EPSG:21781` (Meter) ist, liefert die Funktion die Distanz in Metern.

```sql
ST_Distance(orte.geom, mylocation.geom)::int
-- Distanz in Metern (ganzzahlig)
```

*`ST_DWithin`* — _Relationship Function_ (gibt Boolean zurück): Gibt `true` zurück, wenn zwei Geometrien innerhalb einer angegebenen Distanz (in CRS-Einheiten, hier Meter) liegen. Wird als Filter im `JOIN` verwendet und nutzt den räumlichen GIST-Index (R-Baum) effizient.

```sql
ST_DWithin(orte.geom, mylocation.geom, 10000)
-- true, wenn Ort innerhalb 10000 m (= 10 km) vom Nelson Pub liegt
```

*`ST_Buffer`* — _Processing Function_: Erzeugt eine Pufferzone (Polygon) um eine Geometrie mit dem angegebenen Radius. Beispiel:

```sql
ST_Buffer(geom, 2000)
-- Erzeugt ein Polygon mit 2000 m Puffer um die Geometrie
```

==== Bedeutung der gesamten Query

*Schritt 2 —* Die Query wird als Ganzes analysiert:

```sql
WITH mylocation AS ( -- Nelson Pub Rapperswil
  SELECT st_transform(st_geomfromtext('POINT(8.81642 47.22541)', 4326), 21781) AS geom
)
SELECT
  "name",
  st_astext(orte.geom, 0) AS geom,
  st_distance(orte.geom, mylocation.geom)::int AS distance_in_m
FROM orte
JOIN mylocation ON st_dwithin(orte.geom, mylocation.geom, 10000)
ORDER BY distance_in_m;
```

*Ergebnis:* Die Query beantwortet die Frage: _„Welche Orte (aus der Tabelle `orte`) liegen im Umkreis von 10 km um den Nelson Pub in Rapperswil, und wie weit sind sie entfernt — sortiert nach Distanz?"_

Erwartetes Ergebnis: Orte in der Region Rapperswil-Jona und unmittelbaren Umgebung (z.B. Rapperswil, Jona, Kempraten, Eschenbach, Uznach) werden ausgegeben, sortiert vom nächstgelegenen zum am weitesten entfernten Ort innerhalb von 10 km.

---

=== Aufgabe 5 — Eigene räumliche Queries

==== (a) Distanz zwischen Bern und Zürich

*Schritt 1 —* Aus der Tabelle `orte` werden die Geometrien der beiden Städte Bern und Zürich per Subquery selektiert, um dann die Distanz zu berechnen.

*Schritt 2 —* Da `EPSG:21781` ein planares CRS in Metern ist, liefert `ST_Distance` direkt die metrische Distanz. Division durch 1000 ergibt Kilometer.

```sql
SELECT
  round(
    ST_Distance(
      (SELECT geom FROM orte WHERE name = 'Bern'),
      (SELECT geom FROM orte WHERE name = 'Zürich')
    ) / 1000.0
  ) AS distanz_km;
```

*Ergebnis:* Die Luftlinie zwischen Bern und Zürich beträgt ca. *$ 95 "km" $* (Euklidische Distanz im planaren CRS `EPSG:21781`).

---

==== (b) Gemeinden angrenzend an Rapperswil-Jona

*Schritt 1 —* Zuerst wird Rapperswil-Jona über ein Attribut-Filter (`WHERE name = 'Rapperswil-Jona'`) identifiziert — das ist die thematische Abfrage.

*Schritt 2 —* Dann wird die räumliche Beziehung „grenzt an" mit `ST_Touches` geprüft: Zwei Polygone berühren sich genau dann, wenn sie eine gemeinsame Grenzlinie haben, aber keine überlappenden Innen-Flächen besitzen. Alternativ kann `ST_Intersects` kombiniert mit einer Ungleichung auf den Namen verwendet werden.

```sql
SELECT g.name
FROM gemeinden g
JOIN gemeinden rj ON rj.name = 'Rapperswil-Jona'
WHERE ST_Touches(g.geom, rj.geom)
  AND g.name != 'Rapperswil-Jona'
ORDER BY g.name;
```

*Alternative mit `ST_Intersects`* (wie in der Vorlesung empfohlen, da meist bevorzugt):

```sql
SELECT g.name
FROM gemeinden g
JOIN gemeinden rj ON rj.name = 'Rapperswil-Jona'
WHERE ST_Intersects(g.geom, rj.geom)
  AND g.name != 'Rapperswil-Jona'
ORDER BY g.name;
```

*Ergebnis:* Ausgegeben werden alle Gemeinde-Namen, die an Rapperswil-Jona angrenzen, z.B. Eschenbach (SG), Uznach, Schmerikon, Wollerau, Freienbach, Dürnten, Hombrechtikon.

---

==== (c) Orte im Umkreis von 10 km um die HSR

*Schritt 1 —* Die HSR-Koordinaten `(704472, 231216)` liegen im CRS `EPSG:21781` (Landeskoordinaten CH1903/LV03) vor. Mit `ST_MakePoint` und `ST_SetSRID` wird daraus ein Geometrie-Punkt konstruiert.

*Schritt 2 —* Die Relationship Function `ST_DWithin` filtert alle Orte innerhalb von 10 000 Metern (= 10 km) und nutzt dabei den GIST-Index (R-Baum) effizient.

```sql
SELECT
  o.name,
  ST_Distance(
    o.geom,
    ST_SetSRID(ST_MakePoint(704472, 231216), 21781)
  )::int AS distanz_m
FROM orte o
WHERE ST_DWithin(
  o.geom,
  ST_SetSRID(ST_MakePoint(704472, 231216), 21781),
  10000
)
ORDER BY distanz_m;
```

*Ergebnis:* Alle Ortsnamen innerhalb von 10 km um die HSR Rapperswil werden ausgegeben, sortiert nach Distanz in Metern. Erwartet werden z.B. Rapperswil, Jona, Eschenbach (SG), Uznach, Schmerikon, Rüti (ZH).

---

==== (d) Orte in einer Pufferzone von 2 km um den Fluss Emme

*Schritt 1 —* Mit der Processing Function `ST_Buffer` wird um die Geometrie des Flusses Emme ein 2000-Meter-Puffer (ein Polygon) erzeugt.

*Schritt 2 —* Mit `ST_Intersects` wird geprüft, ob ein Ort (Point) innerhalb dieses Puffer-Polygons liegt — das ist ein Point-in-Polygon-Test, wie in der Vorlesung beschrieben.

```sql
SELECT DISTINCT o.name
FROM orte o
JOIN fluesse f ON f.name = 'Emme'
WHERE ST_Intersects(
  o.geom,
  ST_Buffer(f.geom, 2000)
)
ORDER BY o.name;
```

*Ergebnis:* Alle Ortsnamen, die innerhalb von 2 km beidseits der Emme liegen, werden ausgegeben — z.B. Burgdorf, Langnau im Emmental, Biberist, Solothurn (je nach Verlauf).

---

==== (e) Gemeinden, durch die der Fluss Emme fliesst

*Schritt 1 —* Die räumliche Beziehung „fliesst durch" entspricht einem Intersect zwischen dem LineString (Fluss) und dem Polygon (Gemeinde). Gemäss Vorlesung wird `ST_Intersects` bevorzugt (gegenüber `ST_Crosses` oder `ST_Within`).

*Schritt 2 —* Der `JOIN` mit dem Filter auf `f.name = 'Emme'` kombiniert die thematische Abfrage (Attribut-Filter) mit der räumlichen Abfrage (Spatial Relationship Function) — wie in der Vorlesung als typisches Muster beschrieben.

```sql
SELECT DISTINCT g.name
FROM gemeinden g
JOIN fluesse f ON f.name = 'Emme'
WHERE ST_Intersects(g.geom, f.geom)
ORDER BY g.name;
```

*Ergebnis:* Alle Gemeinde-Namen, durch die der Fluss Emme fliesst, werden ausgegeben — z.B. Burgdorf, Kirchberg (BE), Biberist, Luterbach, Derendingen.

---

=== Aufgabe 6 — Flächenverschnitt (Spatial Analysis)

==== (a) Linie in geojson.io erfassen

*Schritt 1 —* Auf https://geojson.io wird mit dem Linie-Werkzeug eine Linie mit genau zwei Punkten erfasst:
- Startpunkt: Zürich-Kloten (ca. lon/lat `8.5480 / 47.4508`)
- Endpunkt: Bernau im Schwarzwald (ca. lon/lat `7.9987 / 47.8082`)

*Schritt 2 —* In der JSON-Ansicht wird der Feature das Attribut `"id": 1` hinzugefügt.

*Ergebnis:* GeoJSON-Struktur der Flugschneise:

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": 1,
      "properties": { "id": 1 },
      "geometry": {
        "type": "LineString",
        "coordinates": [
          [8.5480, 47.4508],
          [7.9987, 47.8082]
        ]
      }
    }
  ]
}
```

---

==== (b) GeoJSON exportieren

*Schritt 3 —* Die Datei wird in geojson.io über „Save" > „GeoJSON" als `flugschneise.json` gespeichert. Das GeoJSON-Format ist gemäss Vorlesung ein W3C-Standard für Vektor-Geodaten.

---

==== (c) In QGIS importieren und umbenennen

*Schritt 4 —* Die Datei `flugschneise.json` wird per Drag & Drop in das QGIS-Layers Panel gezogen. Der Layer wird dann per Rechts-Klick > „Umbenennen" in `flugschneise (GeoJSON)` umbenannt.

---

==== (d) In PostGIS importieren mit Ziel-SRID 21781

*Schritt 5 —* Im QGIS DB-Manager wird der Layer `flugschneise` in PostGIS importiert. Dabei wird zwingend `EPSG:21781` als Ziel-SRID angegeben, damit die Flugschneise im selben planaren CRS vorliegt wie die Tabellen `gemeinden` und `fluesse` — nur so sind metrische Berechnungen (z.B. ST_Buffer in Metern) korrekt.

Alternative via `ogr2ogr`:
```
ogr2ogr -f PostgreSQL \
  PG:"dbname='gisdb' user='postgres' password='postgres'" \
  -t_srs EPSG:21781 \
  -nln flugschneise \
  flugschneise.json
```

---

==== (e) SQL-Query: Puffer + Verschnitt

*Schritt 1 —* Die Flugschneise wird mit `ST_Buffer(..., 2000)` um 2000 Meter gepuffert (Processing Function), das ergibt ein Polygon, das den Korridor rund um die Flugroute repräsentiert.

*Schritt 2 —* Mit `ST_Intersects` als Relationship Function wird geprüft, welche Gemeinden den gepufferten Korridor berühren oder überschneiden — das ist die Vorauswahl (Index-Nutzung via GIST R-Baum).

*Schritt 3 —* Mit `ST_Intersection` als Processing Function wird die tatsächliche geometrische Schnittfläche zwischen dem Gemeinde-Polygon und dem Puffer-Polygon berechnet und zurückgegeben — das ergibt die Teilflächen der Gemeinden, die im Flugschneisen-Korridor liegen.

```sql
SELECT
  g.name,
  ST_Intersection(
    g.geom,
    ST_Buffer(f.geom, 2000)
  ) AS geom_verschnitt
FROM gemeinden g
JOIN flugschneise f ON ST_Intersects(
  g.geom,
  ST_Buffer(f.geom, 2000)
)
ORDER BY g.name;
```

*Schritt 4 —* Das Ergebnis wird in QGIS visualisiert: Die zurückgegebenen Geometrien (Teilpolygone) werden als neuer Layer dargestellt und zeigen genau, welche Teile der Gemeinden unter der Flugschneise liegen.

*Schritt 5 —* Zur Visualisierung im Browser kann das Ergebnis mit `ST_AsGeoJSON` in GeoJSON umgewandelt und in geojson.io eingefügt werden:

```sql
SELECT
  g.name,
  ST_AsGeoJSON(
    ST_Intersection(
      g.geom,
      ST_Buffer(f.geom, 2000)
    )
  ) AS geojson
FROM gemeinden g
JOIN flugschneise f ON ST_Intersects(
  g.geom,
  ST_Buffer(f.geom, 2000)
)
ORDER BY g.name;
```

*Ergebnis:* Die Query liefert für jede Gemeinde, die im 2-km-Korridor der Flugschneise Zürich-Kloten → Bernau liegt, den Gemeinde-Namen und die Schnittgeometrie (Teilpolygon). Die Gemeinden liegen entlang der Linie durch den Kanton Zürich und den Schwarzwald, z.B. Kloten, Bülach, Eglisau sowie Gemeinden im Hochrhein-Gebiet.