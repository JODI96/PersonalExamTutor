# Week 5 — Solutions (detailliert)

---

== Lösungen

=== Aufgabe 1 — PySpark mit Spark SQL und Spark DataFrames

Die Übung führt durch die wichtigsten Konzepte von Apache Spark, wie sie in der Vorlesung besprochen wurden: die *Lazy Evaluation*, die *DataFrame/Dataset-API*, *Spark SQL* sowie die verteilte Verarbeitung grosser Datenmengen. Die Lösung ist als vollständiges Notebook aufgebaut und folgt dem Ablauf der Übung.

---

==== (a) SparkSession erstellen

*Schritt 1 —* In Databricks ist eine `SparkSession` bereits vorkonfiguriert. Wir greifen auf die bestehende Session zu, da Databricks automatisch eine Instanz namens `spark` bereitstellt. Die `SparkSession` ist der zentrale Einstiegspunkt in Apache Spark (seit Spark 2.0) und vereint den früheren `SQLContext` und `HiveContext`.

```python
# In Databricks ist spark bereits verfügbar
print(spark)
# Ausgabe: <pyspark.sql.session.SparkSession object at 0x...>
```

*Schritt 2 —* Wir prüfen die Spark-Version, um sicherzustellen, dass wir mit einer modernen Version arbeiten, die die vereinheitlichte DataFrame/Dataset-API unterstützt (ab Spark 2.0).

```python
print(spark.version)
# Ausgabe z.B.: 3.x.x
```

*Ergebnis:* Die `SparkSession` steht bereit. Sie ist — gemäss Vorlesung — der *Driver-Prozess*, der die Aufgabenverteilung an die verteilten *Executoren (Worker-Nodes)* steuert.

---

==== (b) Daten laden — San Francisco Fire Department Calls

*Schritt 1 —* Wir laden die Rohdaten aus dem CSV-Format. Gemäss Vorlesung unterstützt Spark SQL verschiedene Datenquellen wie CSV, JSON, Parquet und weitere. Mit `inferSchema=True` lässt Spark das Schema automatisch ableiten (Inferenz), was bei explorativen Analysen praktisch ist.

```python
fire_df = spark.read \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .csv("/databricks-datasets/learning-spark-v2/sf-fire/sf-fire-calls.csv")
```

*Schritt 2 —* Wir zeigen die ersten Zeilen an. `show()` ist eine *Action* — gemäss Vorlesung löst eine Action die eigentliche Ausführung des *Lazy Evaluation*-Plans aus. Erst jetzt werden die vorherigen Transformationen tatsächlich berechnet.

```python
fire_df.show(5, truncate=False)
```

*Schritt 3 —* Wir prüfen das inferierte Schema mit `printSchema()`, um Spaltennamen und Datentypen zu verstehen. Das Schema entspricht dem Konzept aus der Vorlesung: DataFrames haben ein *explizites Schema (Spaltenname + Datentyp)*.

```python
fire_df.printSchema()
```

*Ausgabe (Auszug):*
```
root
 |-- CallNumber: integer (nullable = true)
 |-- UnitID: string (nullable = true)
 |-- IncidentNumber: integer (nullable = true)
 |-- CallType: string (nullable = true)
 |-- CallDate: string (nullable = true)
 |-- WatchDate: string (nullable = true)
 |-- CallFinalDisposition: string (nullable = true)
 |-- AvailableDtTm: string (nullable = true)
 |-- Address: string (nullable = true)
 |-- City: string (nullable = true)
 |-- Zipcode: integer (nullable = true)
 |-- Battalion: string (nullable = true)
 |-- StationArea: string (nullable = true)
 |-- Box: string (nullable = true)
 |-- OrigPriority: string (nullable = true)
 |-- Priority: string (nullable = true)
 |-- FinalPriority: integer (nullable = true)
 |-- ALSUnit: boolean (nullable = true)
 |-- CallTypeGroup: string (nullable = true)
 |-- NumAlarms: integer (nullable = true)
 |-- UnitType: string (nullable = true)
 |-- UnitSequenceInCallDispatch: integer (nullable = true)
 |-- FirePreventionDistrict: string (nullable = true)
 |-- SupervisorDistrict: string (nullable = true)
 |-- Neighborhood: string (nullable = true)
 |-- Location: string (nullable = true)
 |-- RowID: string (nullable = true)
 |-- Delay: double (nullable = true)
```

*Schritt 4 —* Wir zählen die Anzahl der Zeilen. `count()` ist ebenfalls eine *Action*, die den Ausführungsplan triggert.

```python
print(fire_df.count())
# Ausgabe: z.B. 175296
```

*Ergebnis:* Der DataFrame ist geladen, das Schema ist inferiert, und wir sehen, dass der Datensatz mehrere Hunderttausend Zeilen umfasst — ein typisches *Medium Data*-Szenario gemäss der Keller-Definition aus der Vorlesung (Daten passen auf Disk eines Servers, aber nicht zwingend in den RAM eines einzelnen Rechners).

---

==== (c) Daten filtern — nur "Medical Incident"-Einträge

*Schritt 1 —* Wir filtern mit der *DataFrame-API* (Transformationen sind *lazy* — es wird noch nichts berechnet). Wir suchen alle Einsätze vom Typ "Medical Incident". Das Ergebnis ist ein neuer, unveränderlicher DataFrame — gemäss Vorlesung sind DataFrames *immutable*: jede Transformation erzeugt einen neuen DataFrame.

```python
few_fire_df = fire_df \
    .select("IncidentNumber", "AvailableDtTm", "CallType") \
    .where(fire_df["CallType"] == "Medical Incident")
```

*Schritt 2 —* Wir lösen die Auswertung mit der Action `show()` aus und sehen die gefilterten Resultate.

```python
few_fire_df.show(5, truncate=False)
```

*Ausgabe (Auszug):*
```
+--------------+--------------------+----------------+
|IncidentNumber|       AvailableDtTm|        CallType|
+--------------+--------------------+----------------+
|       2003235|01/11/2002 01:51:...|Medical Incident|
|       2003241|01/11/2002 02:11:...|Medical Incident|
...
```

*Ergebnis:* Durch die Kombination von `.select()` (Projektion) und `.where()` (Selektion) wird — analog zu SQL — nur eine Teilmenge der Spalten und Zeilen zurückgegeben.

---

==== (d) Verschiedene Call-Typen zählen

*Schritt 1 —* Wir zählen, wie viele verschiedene `CallType`-Werte es gibt, mit der Methode `distinct()`. Dies entspricht einem `SELECT DISTINCT` in SQL. Die Methode `.count()` ist die auslösende Action.

```python
fire_df.select("CallType") \
    .where(fire_df["CallType"].isNotNull()) \
    .distinct() \
    .count()
# Ausgabe: z.B. 32
```

*Schritt 2 —* Wir zeigen alle unterschiedlichen Werte an, um einen Überblick über die Kategorien zu erhalten.

```python
fire_df.select("CallType") \
    .where(fire_df["CallType"].isNotNull()) \
    .distinct() \
    .show(40, truncate=False)
```

*Ergebnis:* Es gibt z.B. 32 verschiedene Call-Typen. Dies ist eine typische explorative Analyse, wie sie im Big Data Analytics-Kontext der Vorlesung beschrieben wird.

---

==== (e) Häufigste Call-Typen — groupBy und orderBy

*Schritt 1 —* Wir gruppieren nach `CallType`, zählen die Vorkommen und sortieren absteigend. Dies entspricht einer *Aggregation* — das Kernelement von MapReduce (Reduce-Phase) und auch von Spark SQL.

```python
fire_df.select("CallType") \
    .where(fire_df["CallType"].isNotNull()) \
    .groupBy("CallType") \
    .count() \
    .orderBy("count", ascending=False) \
    .show(10, truncate=False)
```

*Ausgabe (Auszug):*
```
+-------------------------------+------+
|CallType                       |count |
+-------------------------------+------+
|Medical Incident               |113794|
|Structure Fire                 |23319 |
|Alarms                         |19406 |
|Traffic Collision              |7013  |
|Citizen Assist / Service Call  |2524  |
...
```

*Ergebnis:* "Medical Incident" ist mit Abstand der häufigste Einsatztyp. Die Ausführung dieser Abfrage demonstriert den *Catalyst Optimizer* von Spark, der gemäss Vorlesung effiziente Abfragepläne erzeugt.

---

==== (f) Neue Spalten hinzufügen — withColumn und Datumsfunktionen

*Schritt 1 —* Die Datumsspalten sind als Strings eingelesen. Wir konvertieren `CallDate` in einen echten Datums-Typ mit `to_date()` und fügen eine neue Spalte `IncidentDate` hinzu. Gemäss Vorlesung erzeugt `withColumn()` einen neuen unveränderlichen DataFrame.

```python
from pyspark.sql.functions import to_date, year

fire_ts_df = fire_df \
    .withColumn("IncidentDate", to_date(fire_df["CallDate"], "MM/dd/yyyy")) \
    .drop("CallDate")
```

*Schritt 2 —* Wir fügen analog eine Spalte für das Jahr hinzu, um zeitbasierte Analysen zu ermöglichen.

```python
fire_ts_df = fire_ts_df \
    .withColumn("IncidentYear", year(fire_ts_df["IncidentDate"]))
```

*Schritt 3 —* Wir prüfen das neue Schema, das nun korrekte Datums- und Integer-Typen für die Zeitangaben enthält.

```python
fire_ts_df.select("IncidentDate", "IncidentYear").show(5)
```

*Ausgabe:*
```
+------------+------------+
|IncidentDate|IncidentYear|
+------------+------------+
|  2002-01-11|        2002|
|  2002-01-11|        2002|
|  2002-01-11|        2002|
...
```

*Ergebnis:* Die Datumsspalten sind nun korrekt typisiert, was korrekte zeitbasierte Filter und Aggregationen ermöglicht.

---

==== (g) Spark SQL — Temporäre View registrieren und SQL-Abfragen

*Schritt 1 —* Wir registrieren den DataFrame als temporäre SQL-View. Dies ermöglicht es, *Spark SQL*-Abfragen direkt auf dem DataFrame auszuführen — gemäss Vorlesung ist Spark SQL *funktional gleichwertig* zur DataFrame/Dataset-API.

```python
fire_ts_df.createOrReplaceTempView("fire_service_calls_view")
```

*Schritt 2 —* Wir führen eine SQL-Abfrage aus, um die Anzahl Einsätze pro Jahr zu ermitteln. Der `spark.sql()`-Aufruf gibt einen DataFrame zurück — die Verarbeitung ist wiederum *lazy* bis zur nächsten Action.

```python
spark.sql("""
    SELECT IncidentYear, COUNT(*) AS AnzahlEinsaetze
    FROM fire_service_calls_view
    GROUP BY IncidentYear
    ORDER BY IncidentYear
""").show()
```

*Ausgabe (Auszug):*
```
+------------+---------------+
|IncidentYear|AnzahlEinsaetze|
+------------+---------------+
|        2000|           1843|
|        2001|          10704|
|        2002|          17536|
...
|        2018|          16399|
+------------+---------------+
```

*Schritt 3 —* Die gleiche Abfrage lässt sich äquivalent mit der DataFrame-API formulieren, was die *funktionale Gleichwertigkeit* beider Ansätze gemäss Vorlesung zeigt.

```python
fire_ts_df \
    .groupBy("IncidentYear") \
    .count() \
    .orderBy("IncidentYear") \
    .show()
```

*Ergebnis:* Beide Ansätze (Spark SQL und DataFrame-API) liefern identische Ergebnisse. Spark SQL nutzt dabei den *Catalyst Optimizer*, um den Ausführungsplan zu optimieren.

---

==== (h) Analyse der Reaktionszeiten — Delay-Spalte

*Schritt 1 —* Wir analysieren die Reaktionszeiten (Spalte `Delay` = Verzögerung in Minuten) für "Medical Incident"-Einsätze. Dazu filtern wir zunächst, dann berechnen wir statistische Kennzahlen.

```python
medical_df = fire_ts_df.where(fire_ts_df["CallType"] == "Medical Incident")
```

*Schritt 2 —* Mit `describe()` erhalten wir deskriptive Statistiken (Minimum, Maximum, Mittelwert, Standardabweichung) für die Verzögerungsspalte. Dies ist eine Action, die die Berechnung auslöst.

```python
medical_df.select("Delay").describe().show()
```

*Ausgabe:*
```
+-------+------------------+
|summary|             Delay|
+-------+------------------+
|  count|            113794|
|   mean| 3.892364...       |
| stddev| 9.378...          |
|    min|              0.016|
|    max|           1440.133|
+-------+------------------+
```

*Schritt 3 —* Wir filtern nach besonders langen Verzögerungen (über 5 Minuten), um problematische Einsätze zu identifizieren.

```python
medical_df.select("IncidentNumber", "Delay", "Neighborhood") \
    .where(medical_df["Delay"] > 5) \
    .orderBy("Delay", ascending=False) \
    .show(10, truncate=False)
```

*Ergebnis:* Die Analyse der Reaktionszeiten zeigt, dass die meisten Einsätze schnell bearbeitet werden, es aber Ausreisser mit sehr langen Verzögerungen gibt. Dies ist ein typisches Beispiel für *Big Data Analytics* — explorative Analyse grosser Datensätze auf Mustern und Anomalien.

---

==== (i) Ergebnisse als Parquet speichern

*Schritt 1 —* Wir speichern den aufbereiteten DataFrame im *Parquet-Format*. Parquet ist gemäss Vorlesung ein *spaltenorientiertes Dateiformat* ("column-based"), das optimal für OLAP-Abfragen und besonders gut mit Column Stores kompatibel ist.

```python
fire_ts_df.write \
    .format("parquet") \
    .mode("overwrite") \
    .save("/tmp/fire_ts_df.parquet")
```

*Schritt 2 —* Wir lesen die gespeicherten Daten wieder ein, um die Persistenz zu prüfen. Da Parquet das Schema einbettet, ist kein `inferSchema` mehr nötig.

```python
parquet_df = spark.read.parquet("/tmp/fire_ts_df.parquet")
parquet_df.printSchema()
```

*Ergebnis:* Die Daten sind im spaltenorientierten Parquet-Format gespeichert. Dieses Format ermöglicht — gemäss der Vorlesung über Column Stores — deutlich schnellere OLAP-Lesezugriffe, da nur die für eine Abfrage relevanten Spalten gelesen werden müssen. Parquet ist auch das Standardformat in modernen Data Lakehouse-Architekturen (z.B. Delta Lake, Apache Iceberg), die in der Vorlesung erwähnt wurden.

---

==== (j) Zusammenfassung der wichtigsten Konzepte

*Schritt 1 —* Die folgende Tabelle fasst die in der Übung demonstrierten Spark-Kernkonzepte gemäss Vorlesungsterminologie zusammen:

#table(
  columns: (auto, auto, auto),
  [*Konzept*], [*Beschreibung (Vorlesung)*], [*Beispiel in der Übung*],
  [Lazy Evaluation], [Transformationen werden erst bei einer Action ausgeführt], [`filter()`, `select()`, `groupBy()` sind lazy; `show()`, `count()` sind Actions],
  [Immutabilität], [Jede Transformation erzeugt einen neuen DataFrame], [`withColumn()` erstellt neuen DF, Original bleibt unverändert],
  [Spark SQL], [Funktional gleichwertig zur DataFrame-API, nutzt SQL-Syntax], [`spark.sql("SELECT ...")`],
  [DataFrame-API], [Strukturierte Daten mit explizitem Schema, verteilt auf Partitionen], [`fire_df.groupBy("CallType").count()`],
  [Column Store (Parquet)], [Spaltenorientiertes Format für schnelle OLAP-Lesezugriffe], [`write.format("parquet")`],
  [Catalyst Optimizer], [Erzeugt effiziente Abfragepläne automatisch], [Wirkt intern bei jeder Spark-Abfrage],
)

*Ergebnis:* Die Übung demonstriert vollständig das Apache Spark-Ökosystem im Sinne der Vorlesung: die *verteilte, In-Memory-basierte Verarbeitung* grosser Datenmengen, die *vereinheitlichte DataFrame/Dataset-API*, *Spark SQL* als deklarative Schnittstelle sowie das Speichern in spaltenorientierten Formaten. Databricks dient dabei als kommerzielle Cloud-Plattform auf Spark-Basis — ein Beispiel für die in der Vorlesung besprochenen *Cloud Platforms und Data Warehouses*.