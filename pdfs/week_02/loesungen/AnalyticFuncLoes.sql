SET SEARCH_PATH=video_dw;


-- Rangliste Verkäufe pro Sparte
SELECT
	rank() OVER (ORDER BY sum(s.sales_amount) DESC) AS "sales volume rank",
	m.subgenre,
	sum(s.quantity) quantity,
	sum(s.sales_amount) AS "sales volume [USD]"
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
GROUP BY m.genre, m.subgenre
ORDER BY "sales volume rank";
-- oder:
-- ... ORDER BY "sales volume [USD]" DESC;

/*
 sales volume rank |     subgenre      | quantity | sales volume [USD] 
-------------------+-------------------+----------+--------------------
                 1 | Action            |       60 |             1671.6
                 2 | Drama             |       15 |              519.0
                 3 | Comedy            |       19 |              413.2
                 4 | Thriller          |       13 |              351.6
                 5 | Romance           |       12 |              261.0
                 6 | Science-Fiction   |        7 |              195.2
(6 rows)
*/


-- Rangliste: Verkäufe pro Geschlecht:
SELECT
	rank() OVER (ORDER BY sum(s.quantity) DESC) AS rank,
	c.gender,
	sum(s.quantity) quantity
FROM
	fact_sales s
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY c.gender
ORDER BY rank;
/*
 rank | gender | quantity 
------+--------+----------
    1 | f      |       67
    2 | m      |       59
(2 rows)
*/


/*
Cube Ranking: Innerhalb der Würfels Rangliste erstellen:

Der Vorteil dieser Darstellung ist, dass mit einer einzigen Abfrage
mehrere Ranglisten erstellt werden können.
*/
SELECT
	m.subgenre,
	c.gender,
	sum(s.sales_amount) AS "sales volume [USD]",
	dense_rank() OVER (
		PARTITION BY grouping(m.subgenre, c.gender)
		ORDER BY sum(s.sales_Amount) DESC
	) AS rank,
	CASE
		WHEN grouping(m.subgenre, c.gender) = 0 THEN 'subgenre + gender'
		WHEN grouping(m.subgenre, c.gender) = 1 THEN 'subgenre'
		WHEN grouping(m.subgenre, c.gender) = 2 THEN 'gender'
		WHEN grouping(m.subgenre, c.gender) = 3 THEN '(overall total)'
	END AS "ranking list"
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY CUBE(m.subgenre, c.gender)
ORDER BY grouping(m.subgenre, c.gender);
/*
     subgenre      | gender | sales volume [USD] | rank |   ranking list    
-------------------+--------+--------------------+------+-------------------
 Action            | f      |              927.6 |    1 | subgenre + gender
 Action            | m      |              744.0 |    2 | subgenre + gender
 Drama             | f      |              346.0 |    3 | subgenre + gender
 Comedy            | m      |              282.1 |    4 | subgenre + gender
 Romance           | f      |              241.1 |    5 | subgenre + gender
 Thriller          | m      |              231.4 |    6 | subgenre + gender
 Drama             | m      |              173.0 |    7 | subgenre + gender
 Science-Fiction   | m      |              139.0 |    8 | subgenre + gender
 Comedy            | f      |              131.1 |    9 | subgenre + gender
 Thriller          | f      |              120.2 |   10 | subgenre + gender
 Science-Fiction   | f      |               56.2 |   11 | subgenre + gender
 Romance           | m      |               19.9 |   12 | subgenre + gender
 Action            |        |             1671.6 |    1 | subgenre
 Drama             |        |              519.0 |    2 | subgenre
 Comedy            |        |              413.2 |    3 | subgenre
 Thriller          |        |              351.6 |    4 | subgenre
 Romance           |        |              261.0 |    5 | subgenre
 Science-Fiction   |        |              195.2 |    6 | subgenre
                   | f      |             1822.2 |    1 | gender
                   | m      |             1589.4 |    2 | gender
                   |        |             3411.6 |    1 | (overall total)
(21 rows)
*/

/*
Um die umsatzhöchsten Eingrag innerhalb jeder Rangliste zu ermitteln,
können wir Ranglisten-Übergreifend nach dem Rang sortieren:
*/
SELECT
	m.subgenre,
	c.gender,
	sum(s.sales_amount) AS "sales volume [USD]",
	dense_rank() OVER (
		PARTITION BY grouping(m.subgenre, c.gender)
		ORDER BY sum(s.sales_Amount) DESC
	) AS rank,
	CASE
		WHEN grouping(m.subgenre, c.gender) = 0 THEN 'subgenre + gender'
		WHEN grouping(m.subgenre, c.gender) = 1 THEN 'subgenre'
		WHEN grouping(m.subgenre, c.gender) = 2 THEN 'gender'
		WHEN grouping(m.subgenre, c.gender) = 3 THEN '(overall total)'
	END AS "ranking list"
FROM
	fact_sales s
	JOIN dim_movie m ON s.movie_id = m.movie_id
	JOIN dim_customer c ON s.cust_id = c.cust_id
GROUP BY CUBE(m.subgenre, c.gender)
ORDER BY rank;
/*
     subgenre      | gender | sales volume [USD] | rank |   ranking list    
-------------------+--------+--------------------+------+-------------------
 Action            | f      |              927.6 |    1 | subgenre + gender
 Action            |        |             1671.6 |    1 | subgenre
                   | f      |             1822.2 |    1 | gender
                   |        |             3411.6 |    1 | (overall total)
                   | m      |             1589.4 |    2 | gender
 Action            | m      |              744.0 |    2 | subgenre + gender
 Drama             |        |              519.0 |    2 | subgenre
 Drama             | f      |              346.0 |    3 | subgenre + gender
 Comedy            |        |              413.2 |    3 | subgenre
 Comedy            | m      |              282.1 |    4 | subgenre + gender
 Thriller          |        |              351.6 |    4 | subgenre
 Romance           | f      |              241.1 |    5 | subgenre + gender
 Romance           |        |              261.0 |    5 | subgenre
 Thriller          | m      |              231.4 |    6 | subgenre + gender
 Science-Fiction   |        |              195.2 |    6 | subgenre
 Drama             | m      |              173.0 |    7 | subgenre + gender
 Science-Fiction   | m      |              139.0 |    8 | subgenre + gender
 Comedy            | f      |              131.1 |    9 | subgenre + gender
 Thriller          | f      |              120.2 |   10 | subgenre + gender
 Science-Fiction   | f      |               56.2 |   11 | subgenre + gender
 Romance           | m      |               19.9 |   12 | subgenre + gender
(21 rows)
*/
/*
Am umsatzreichsten sind also:
- unter den Filmsparten+Geschlecht-Kombinationen: Action + f
- unter den Filmsparten (über beide Geschlechter): Action
- unter den Geschlechtern (über alle Filmsparten): f

(Das Gesamt-Total erscheint auch mit "Rang 1",
da es der einzige Eintrag einer eigenen vierten "Rangliste" ist.)
*/

--: Windowing: Verkäufe pro Monat kummuliert über ein Jahr                                  
SELECT
	t.year,
	t.month,
	sum(s.quantity) AS sales,
	sum(sum(s.quantity)) OVER (
		PARTITION BY t.year
		ORDER BY t.year, t.month ROWS UNBOUNDED PRECEDING
	) AS cum_sales
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id = t.time_id
GROUP BY t.year, t.month
ORDER BY t.year, t.month;
/*
 year | month | sales | cum_sales 
------+-------+-------+-----------
 2013 |     2 |     1 |         1
 2013 |     3 |     1 |         2
 2015 |     1 |     7 |         7
 2015 |     2 |     5 |        12
 2015 |     3 |     4 |        16
 2015 |     4 |     6 |        22
 2015 |     5 |     4 |        26
 2015 |     6 |     4 |        30
 2015 |     7 |     3 |        33
 2015 |     8 |    13 |        46
 2015 |     9 |     4 |        50
 2015 |    10 |     9 |        59
 2015 |    11 |    10 |        69
 2015 |    12 |    15 |        84
 2016 |     1 |    22 |        22
 2016 |     2 |    18 |        40
(16 rows)
*/

  
-- Windowing: Verkäufe pro Monat Durchschnitt mit einem Fenster von 2 vorherigen Monaten
SELECT
	t.year,
	t.month,
	sum(s.quantity) AS sales,
	avg(sum(s.quantity)) OVER (
		ORDER BY t.year, t.month ROWS 2 PRECEDING
	) AS moving_3_month_avg
FROM
	fact_sales s
	JOIN dim_time t ON s.time_id = t.time_id
WHERE t.year != 2013
GROUP BY t.year, t.month
ORDER BY t.year, t.month;
/*
year | month | sales | moving_3_month_avg  
------+-------+-------+---------------------
 2015 |     1 |     7 |  7.0000000000000000
 2015 |     2 |     5 |  6.0000000000000000
 2015 |     3 |     4 |  5.3333333333333333
 2015 |     4 |     6 |  5.0000000000000000
 2015 |     5 |     4 |  4.6666666666666667
 2015 |     6 |     4 |  4.6666666666666667
 2015 |     7 |     3 |  3.6666666666666667
 2015 |     8 |    13 |  6.6666666666666667
 2015 |     9 |     4 |  6.6666666666666667
 2015 |    10 |     9 |  8.6666666666666667
 2015 |    11 |    10 |  7.6666666666666667
 2015 |    12 |    15 | 11.3333333333333333
 2016 |     1 |    22 | 15.6666666666666667
 2016 |     2 |    18 | 18.3333333333333333
(14 rows)
*/

SELECT
	tmp.sales AS "sales",
	lag(tmp.sales) OVER (ORDER BY tmp.year, tmp.month) AS "sales prev. month"
FROM (
	SELECT
		t.year,
		t.month,
		sum(s.quantity) AS sales
	FROM
		fact_sales s
		JOIN dim_time t ON s.time_id = t.time_id
	WHERE t.year != 2013
	GROUP BY t.year, t.month
) AS tmp
ORDER BY tmp.year, tmp.month DESC
LIMIT 1;
