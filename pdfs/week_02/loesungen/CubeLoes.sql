SET SEARCH_PATH=video_dw;
-- Abfragen mit Rollup

-- Verkäufe pro Monat und Total übers Jahr
SELECT
	month,
	sum(quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id = t.time_id
GROUP BY ROLLUP (month);


-- Verkäufe pro Jahr, Jahreszeit und Monat
SELECT
	t.year,
	t.season,
	t.month,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id = t.time_id
GROUP BY ROLLUP (t.year, t.season, t.month);

-- oder mit partiellem Rollup (Das Gesamttotal über alle Jahre ist nicht im Ergebnis enthalten)
SELECT
	t.year,
	t.season,
	t.month,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id = t.time_id
GROUP BY t.year, ROLLUP (t.season, t.month);

--Lösungsansatz mit Windowing
--Die Frage nach dem Verkaufsverlauf kann auch mit der LAG-Funktion beantwortet werden, indem die Differenz zu den Verkäufen des Vormonats berechnet wird.
SELECT
	t.year,
	t.month,
	sum(s.quantity)-lag(sum(s.quantity),1) OVER (ORDER BY t.year,t.month) as difference
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id=t.time_id
GROUP BY t.year,t.month
ORDER BY t.year,t.month;
--Die Werbekampagne im August 2015 sorgte für einen starken Anstieg von 10, der allerdings nur kurz anwirkte. Im nächsten Monat war die Differenz wieder -9.
--Die Weihnachtsverkäufe starteten ab dem Oktober, bis Dezember wurden jeden Monat mehr Videos verkauft.


-- Abfragen mit Cube

-- Verkäufe pro Sparte und Geschlecht
SELECT
	m.subgenre,
	c.gender,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY CUBE(m.subgenre, c.gender);

-- Verkäufe pro Sparte (grob) und Geschlecht (nicht überraschend werden Action-Filme von männlichen und Non-Action-Filme von weiblichen Kunden bevorzugt)
SELECT
	m.genre, 
	c.gender, 
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY CUBE(m.genre, c.gender);



-- oder etwas schöner mit der Grouping-Funktion, welche im Resultat schön erkennen lässt, ob ein Wert null war oder ob es sich um eine Gruppierung handelt.
SELECT 
	CASE WHEN grouping(m.genre) = 1 THEN 'All Genres' ELSE m.genre END AS genre,
	CASE WHEN grouping(c.gender) = 1 THEN 'All Genders' ELSE c.gender END AS gender,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY CUBE(m.genre, c.gender);

--Eine weitere Variante: Gruppiert wird nach 'Action' und 'Non-Action'. 
--Frauen kaufen nur zu einem drittel Actionfilme, bei Männern ist es die Hälfte:
SELECT
	c.gender, 
	CASE WHEN m.subgenre = 'Action' THEN 1 ELSE 0 END AS is_action,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_movie m ON m.movie_id = s.movie_id
	JOIN dim_customer c ON c.cust_id = s.cust_id
GROUP BY CUBE(CASE WHEN m.subgenre = 'Action' THEN 1 ELSE 0 END , c.gender)
ORDER BY c.gender;

-- Verkäufe pro Sparte und Alter
SELECT
	m.genre,
	c.quarter_century,
	sum(s.quantity) AS quantity
FROM
	fact_sales s
	JOIN dim_movie m ON m.movie_id = s.movie_id
	JOIN dim_customer c ON c.cust_id = s.cust_id
GROUP BY CUBE(c.quarter_century, m.genre);
