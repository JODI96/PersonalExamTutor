# Week 5 — Exercises

> Quelle: README.adoc, README_nb.adoc

---

= Übung VoWo 05: PySpark mit Spark SQL und Spark DataFrames: Modul Data Analytics (M_DatAna), Bachelor Informatik
Prof. Stefan Keller; Raphael Das Gupta
FS 2022
:lang: de
:figure-caption: Abbildung
:xrefstyle: short

Diese Übung basiert z.T. auf dem "`Code for San Francisco`"-Vortrag
"`Using Apache Spark 2.0 to Analyze the City of San Francisco's Open Data`"
(https://youtu.be/K14plpZgy_c[YouTube-video]) von Sameer Farooqui.


== Vorbereitung

=== Account-Erstellung und Login

Falls Sie noch keinen Databricks-Account haben,
gehen Sie auf https://login.databricks.com/?intent=CE_SIGN_UP
und melden Sie sich für die kostenlose "`Community Edition`" an.

Um einen bestehenden Databricks-Account zu verwenden,
loggen Sie sich auf https://community.cloud.databricks.com/login.html ein.


=== Notebook laden

==== Download Aufgaben- und Musterlösung-Notebook-Archiv

Laden Sie die Datei link:DatAna_PySpark.dbc[`DatAna_PySpark.dbc`] herunter.


==== Import in Databricks

1. Klicken Sie in der Databricks-Weboberfläche
im Menü links auf "`Workspace`".

2. Öffnen Sie das Kontextmenü
des Workspace-Eintrags "`Home`"
und wählen Sie daraus "`Import`".

3. Belassen Sie die Einstellung "`Import from:`" auf "`File`".

4. Ziehen Sie die Datei `DatAna_PySpark.dbc` in das vorgesehene Feld
oder wählen Sie sie über den "`browse`"-Link.

5. Schliessen Sie den Import durch den "`Import`"-Button ab.


==== Notebook Öffnen

Im Workspace-Eintrag "`Home`" haben Sie nun ein neues Verzeichnis `DatAna_PySpark`.
Durch Anklicken sehen Sie dessen Inhalt: 2 Databricks-Python-Notebooks.
Klicken Sie Notebook `Aufgaben: PySpark mit SQL und DataFrames` an, um es zu öffnen.


== Übung

Folgen Sie nun den Anweisungen im Notebook.

NOTE: Nicht alle Screenshots im Notebook
wurden auf die aktuelle Databricks-Version aktualisiert.
Daher kann es sein, dass
Darstellung,
Job-Anzahl,
Stage-Anzahl pro Job,
Task-Anzahl pro Stage
und
Laufzeiten
z.T. von den Bildern abweichen.

== Musterlösung

Siehe Notebook `Musterlösung: PySpark mit SQL und DataFrames`.


---

= Notebook images

This directory contains
those images referenced by the Notebooks in `DatAna_PySpark.dbc`
that we produced ourselves and host on GitLab pages.
