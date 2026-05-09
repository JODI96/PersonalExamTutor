# Week 9 — Exercises

> Quelle: DATANA 08 EX Introduction and Preprocessing.pdf, Introduction and Preprocessing(1) Exercises(2).pptx, DATANA 08 EX SOL Introduction and Preprocessing.pdf

---

 
 
Wirtschaftsingenieurwesen 
Übungsunterlagen zu Data Analytics 
Prof. Dr. Daniel Politze 
 
Data Analytics – Theoretical Exercises 
FS 2026 
Seite 1 
 
Theoretical Exercises – Sheet 1 
 
 
1. How is Data Science different from Data Mining? How are they similar? 
 
2. How does Data Mining relate to Machine Learning? 
 
3. Go through the CRISP-DM model and describe in your own words what happens in each phase. 
 
4. Present an example where Data Mining is crucial to the success of a business. What data mining 
functionalities does this business need? Formulate corresponding business questions. 
 
5. Explain the difference between Association, Segmentation/Clustering, Classification and Regression. 
 
6. Have a look at the efforts in Data Science per phase. Why do you think is data preparation so much effort and 
why is evaluation not? 
 
7. Provide examples for bad data quality. 
 
8. Provide examples for each attribute type: nominal, ordinal, interval-scaled and ratio-scaled and decide 
whether it makes sense to calculate mean, median and/or mode. 
 
9. Suppose that the data for analysis includes the attribute age. The age values for the data tuples are  
13, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25, 30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70 
(in increasing order). 
 
a. What is the mean of the data? What is the median? 
 
b. What is the mode of the data? Comment on the data’s modality. 
 
c. Can you find (roughly, by hand) the first quartile 𝑄ଵand the third quartile 𝑄ଷof the data? 
 
d. Give the five-number summary of the data and show a boxplot. 
 
10. Suppose that a hospital tested the age and the body fat data for 18 randomly selected adults as follows: 
 
age
23 
23 
27 
27 
39 
41 
47 
49 
50 
%fat
9.5 
26.5 
7.8 
17.8 
31.4 
25.9 
27.4 
27.2 
31.2 
 
age
52 
54 
54 
56 
57 
58 
58 
60 
61 
%fat
34.6 
42.5 
28.8 
33.4 
30.2 
34.1 
32.9 
41.2 
35.7 
 
a. Calculate the mean, median and standard deviation of age and %fat. 
 
b. Draw a scatter plot based on these two attributes. 
 
 
 


---

--- Folie 1 ---
Introduction and Preprocessing(1) Exercises
Studiengang Informatik
Lecture in Data Analytics
Prof. Dr. Daniel P. Politze
24. April 2025

--- Folie 2 ---
CRISP-DM  
Overview- Association- Classification- Segmentation/Clustering- Regression
Agenda
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
2

--- Folie 3 ---
Business Understanding
Anwendungsfall diskutieren und verstehen. 
Domain in der man sich befindet verstehen. (Data Analyst weiss z.b nicht was die Daten von einer Maschine bedeuten)
Herausfinden auf welches Ziel das hingearbeitet wird. 
Was sind die Abnahmekriterien am Ende der Evaluation. Welche Ziele möchte man erreichen?
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
3

--- Folie 4 ---
Data understanding
Herausfinden wo sich die Daten befinden (mehrere Datenquellen?) 
Inhalt der Daten verstehen
Qualität der Daten beurteilen
Erste Gedanken im Bereich des Einsatzzwecks der Daten
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
4

--- Folie 5 ---
Data Preparation
Daten aufbereiten
Daten zusammenführen  Daten in einheitliches Format bringen
Daten säubern  Fehlende Daten Standardwert, Falsche Daten löschen…..
Feature Engineering  Normalisierung der Daten, wichtige Parameter bestimmen.
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
5

--- Folie 6 ---
Modeling
Anwendung von Algorithmen auf die vorbereiteten Daten
Herausfinden welcher Algorithmus am besten geeignet ist.
Training des Models  Aufteilung der Testdaten und Validierungsdaten
Bestes Model finden
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
6

--- Folie 7 ---
Evaluation
Besprechung der Ergebnisse
Gibt es Dinge die man übersehen hat? (Parameter, Qualität der Daten, richtiger Algorithmus?)
Ist das Model gut genug. Sind die Ergebnisse Aussagekräftig?
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
7

--- Folie 8 ---
Deployment
Präsentation der Resultate
Integration des Models
CRISP-DM
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
8

--- Folie 9 ---
Was fällt auf bei folgender Statistik?
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
9

--- Folie 10 ---
Zeitaufwand im Data Mining
Data preparation ist aufwändig. Daten in einheitliches Format zu bringen + in guter Qualität zu haben ist aufwändig
Data Modeling kann aufgrund der vielen Algorithmen und vielen möglichen Parameter ebenfalls Zeitaufwändig sein. Da man herausfinden muss welches Model am besten performt. 
Evaluation kein grosser Zeitaufwand da heutzutage moderne Frameworks uns alle Zahlen automatisch rausgeben im Bezug auf Genauigkeit und Performance des Modells.
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
10

--- Folie 11 ---
Wird oft in der Warenkorbanalyse verwendet
Wir versuchen herauszufinden welche Produkte “zusammengehören”.
	Wenn jemand Brot kauft, dann ist die Wahrscheinlichkeit 66,7%, dass er auch Butter kauft.
Overview
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
11
Association

--- Folie 12 ---
Overview
Classification
Zuteilung von Daten in Kategorien
Beispiel rechts: Wie hoch ist die Wahrscheinlichkeit dass die Person betrieben wird anhand seines Kontostandes
Kategorien für Betreibung in Ja und Nein. 
Logistische Regression dabei eine Möglichkeit für Klassifizierung. 
Viele verschiedene Klassifizierungsalgorithmen: Lineare Diskriminanzanalyse, K-Neares Neighbours(k-NN)…..
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
12

--- Folie 13 ---
Overview
Clustering
Gehört zu Unsupervised learning  Wir haben keine Trainingsdaten, keine Labels
Wir wollen Daten gruppieren  Ähnlichkeiten zwischen Gruppendaten finden
Interessant für Marketing
Beispiel zeig K-Means Clustering
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
13

--- Folie 14 ---
Overview
Regression
Regression wird gebraucht, um vorhersagen zu treffen
Vor allem für quantitative Variablen
Beispiel rechts: Wie viele Sales machen wir wenn wir Betrag X für Werbung im TV brauchen.
24 April 2025
Change title: menu 'Insert'>'Header and Footer'
14

--- Folie 15 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
15
Was für Fehler findet ihr in den Daten?

--- Folie 16 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
16
Was für Fehler findet ihr in den Daten?

--- Folie 17 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
17
Verschiedene Skalen

--- Folie 18 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
18
Median berechnen
Unser Datensatz: 37,14,2,68,5,(16)
1. Datensatz ordnen  2,5,14,(16),37,68
2. Bei ungerader Anzahl Samples  Median = Wert an mittlerer Stelle (Bei uns an dritter Stelle)
3. Bei gerader Anzahl Samples  Median = Bei de Werte an mittlerer Stelle nehmen (bei uns an dritter und vierter stelle) zusammenzählen und dann durch 2 dividieren. 
Lösung: 14 (bei n = 5), 15 (bei n = 6)

--- Folie 19 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
19
Durchschnitt Berechnen
Datensatz: 37,14,2,68,5
1. Alle Daten zusammenzählen 
2. Summe durch die Anzahl Samples dividieren
Lösung: 25.2

--- Folie 20 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
20
Modus
Datenset: Gut,Gut,Genügend,Ungenügend,Gut
1. Jede Kategorie zählen, wie oft das sie vorkommt
2. Kategorie, die am häufigsten vorkommt entspricht dem Modus.
Lösung: Gut

--- Folie 21 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
21
Quartile berechnen

--- Folie 22 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
22
Quartile berechnen
Lösung für erstes Quantil = 0.25 * (10+1) = 2.75  Interpolation durch 2. und 3. Wert ergibt:10 * 0.25 + 14 * 0.75 = 13

--- Folie 23 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
23
Five Number Summary
Five Number Summary besteht aus: Minimum, Q1, Median, Q3, Maximum

Wie lautet die Five Number Summary für gegebenen Datensatz?

Minimum: 9Q1: 12Median: 23Q3: 26Maximum: 29

--- Folie 24 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
24
Boxplot
Whiskers befinden sich vom 1./3 Quartil –+ 1.5 * Interquartilsabstand.
T Form befindet sich beim letzten Wert der innerhalb der Grenze stattfindet

--- Folie 25 ---
24. April 2025
Titel ändern: Menü 'Einfügen'>'Kopf- und Fusszeile'
25
Boxplot