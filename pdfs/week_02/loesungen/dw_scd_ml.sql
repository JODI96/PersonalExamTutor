-- Alle Teilaufgaben von Aufg. 3 beziehen sich auf's DW:
SET search_path TO video_dw;


/*
 * Historisieren Sie das Attribut 'city' mit dem SCD2-Ansatz.
 */

/*
SCD gemäss Variante 2:
Wir machen aus allen Kunden-Tupel Kunden-Versions-Tupel.
Dazu werden ein Business-Key und Gültigkeits-Grenzen eingeführt.
Der PK cust_id identifiziert ab jetzt die Kunden-Version
und der BK cust_id_bk versionsübergreifend den Kunden.
*/
ALTER TABLE dim_customer
  ADD COLUMN cust_id_bk INTEGER, -- business key
  ADD COLUMN scd_valid_from DATE DEFAULT current_date,
  ADD COLUMN scd_valid_to DATE DEFAULT 'infinity'::DATE;

/*
Da der BK fortan dem PK der OLTP-Tabelle entspricht,
müssen wir ihn entsprechend befüllen. Dafür nutzen wir,
dass cust_id derzeit noch genau diese Daten enthält:
*/
UPDATE dim_customer
SET cust_id_bk = cust_id;

/*
scd_valid_from wurde von ADD COLUMN mit dem angegebenen DEFAULT-Wert befüllt,
also mit dem aktuellen Datum zum Ausführungszeitpunkt. Für die bestehenden
Tupel soll die Gültigkeit aber in der Vergangenheit beginnen!
Ändern wir sie also entsprechend:
*/
UPDATE dim_customer
SET scd_valid_from = '-infinity'::DATE;

/*
 * ÄndernSie die Daten von dim_customer wie folgt:
 * Der Kunde 'Marxer, Markus' wechselt per 1.2.2013 seinen Wohnsitz
 * von Rapperswil nach Zürich.
 */

-- Wir fügen eine neu Version des Kunden 1001 ein:
INSERT INTO dim_customer
  SELECT
    cust_id + 100000, -- PK der neuen Version
    name, first_name, -- Daten von bisheriger Version übernehemen
    'Zuerich', -- neuer Wohnort
    birthday, gender, decade, quarter_century, cust_id_bk,-- Daten von bish. Version übern.
    to_date('1.2.2013', 'dd.mm.yyyy'), -- Gültigkeits-Beginn der neuen Version
    'infinity'::DATE -- (kein) Gültigkeits-Ende der neuen Version
  FROM dim_customer
  WHERE cust_id = 1001; -- Markus Marxer, bisher einzige Version.

-- ... und begrenzen die Gültigkeit der bisherigen Version:
UPDATE dim_customer
SET scd_valid_to = to_date('1.2.2013', 'dd.mm.yyyy')
WHERE cust_id = 1001; -- Markus Marxer, vorherige Version

/*
Fügen Sie die folgenden Neuzugänge in der Faktentabelle ein:
 - 'Star Wars I', am 2.2.2013 gekauft durch Kunde 'Marxer, Markus'
 - 'Star Wars II', am 1.3.2013 gekauft durch Kunde 'Marxer, Markus'
*/

-- 'Star Wars I', am 2.2.2013 gekauft durch Kunde 'Marxer, Markus'
--füge dim_time-Wert ein
INSERT INTO dim_time
VALUES (
  nextval('s_dim_time'), to_date('2.2.2013','dd.mm.yyyy'), 2, 'Winter', 2013
);
--Füge fact_sales-Eintrag ein
INSERT INTO fact_sales (sale_id, sale_detail_id, movie_id, cust_id, time_id, quantity, sales_amount)
VALUES ( 1067, 1067, 10, 101001, currval('s_dim_time'), 1, 26.6);

-- 'Star Wars II', am 1.3.2013 gekauft durch Kunde 'Marxer, Markus'
--Füge zweiten dim_time-Wert ein
INSERT INTO dim_time
VALUES (
  nextval('s_dim_time'), to_date('1.3.2013','dd.mm.yyyy'), 3, 'Spring', 2013
);
--Füge wieder einen fact_sales-Eintrag ein
INSERT INTO fact_sales (sale_id, sale_detail_id, movie_id, cust_id, time_id, quantity, sales_amount)
VALUES ( 1067, 1067, 11, 101001, currval('s_dim_time'), 1, 29.6);

/*
 * Testen Sie ihre Implementation
 */

--Ausgabe der des Totals von fact_sales.sales_amount des Kunden 'Marxer, Markus'.
SELECT sum(sales_amount), c.cust_id_bk
FROM fact_sales f
INNER JOIN dim_customer c on f.cust_id=c.cust_id
GROUP BY c.cust_id_bk
HAVING c.cust_id_bk = 1001;
/*
  sum  | cust_id_bk
-------+------------
 183.9 |       1001
(1 row)
*/

-- Ausgabe der des Totals von fact_sales.sales_amount des Kunden 'Marxer, Markus' in 'Zuerich'
SELECT sum(sales_amount), c.cust_id_bk
FROM fact_sales f
INNER JOIN dim_customer c on f.cust_id=c.cust_id
WHERE city='Zuerich'
GROUP BY c.cust_id_bk
HAVING c.cust_id_bk=1001;
/*
 sum  | cust_id_bk
------+------------
 56.2 |       1001
(1 row)
*/
