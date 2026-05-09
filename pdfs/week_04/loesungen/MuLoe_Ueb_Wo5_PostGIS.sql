------------------------------------------------------------------------------
-- Vorlesung Data Analytics, FS 2021
-- 
-- MuLoe_Ueb_Wo5_PostGIS
--
------------------------------------------------------------------------------



------------
-- Aufgabe 5: Eigene räumliche Queries erstellen
------------

-- Aufgabe 5.1: Distanzberechnung
-- Berechnen Sie die spheroidische Distanz zwischen Bern und Zürich
-- => Im Lokalkoordinatensystem
SELECT ST_distance(
  (SELECT geom FROM orte WHERE "name" = 'Bern' AND type = 'Medium City'),
  (SELECT geom FROM orte WHERE "name" = 'Zürich'AND type = 'Medium City'));
-- => basierend auf einer Kugel
SELECT ST_distanceSphere(
  (SELECT ST_Transform(geom,4326) FROM orte WHERE "name" = 'Bern' AND type = 'Medium City'),
  (SELECT ST_Transform(geom,4326) FROM orte WHERE "name" = 'Zürich'AND type = 'Medium City')
  );
-- => basierend auf einem Bessel 1841 Ellipsoid.
SELECT ST_distanceSpheroid(
  (SELECT ST_Transform(geom,4326) FROM orte WHERE "name" = 'Bern' AND type = 'Medium City'),
  (SELECT ST_Transform(geom,4326) FROM orte WHERE "name" = 'Zürich'AND type = 'Medium City'),
  'SPHEROID["Bessel 1841",6377397.155,299.1528128]');


-- Aufgabe 5.2: Objektselektion mit angrenzenden Flächen
-- Selektieren Sie alle Gemeinden, die an die Gemeinde Rapperswil-Jona grenzen.
SELECT * FROM gemeinden
WHERE ST_Touches(
  geom, 
  (SELECT geom FROM gemeinden WHERE name = 'Rapperswil-Jona')
) 
ORDER BY name ASC;


-- Aufgabe 5.3: Objektselektion als Umkreissuche
-- Selektieren Sie alle Orte im Umkreis von 10 km um die HSR (CH1903: 704472/231216)
SELECT name, geom 
FROM orte
WHERE ST_DWithin(geom, ST_GeomFromText('POINT(704472 231216)', 21781),10000)
ORDER BY name ASC;


-- Aufgabe 5.4: Pufferzone
-- Selektieren Sie alle Orte, die in einer Pufferzone von 2km um den Fluss Emme liegen.
SELECT name 
FROM orte
WHERE ST_Within(
 geom,
 (SELECT ST_Buffer(geom, 2000) FROM fluesse WHERE name = 'Emme')
)
ORDER BY name ASC;


-- Aufgabe 5.5. 
-- Schreiben Sie eine Query, die alle Gemeinden selektiert, durch die der Fluss Emme fliesst. 
SELECT g.name 
FROM gemeinden g
WHERE ST_Intersects(geom, (SELECT geom FROM fluesse WHERE name = 'Emme'))
ORDER BY 1;
-- oder 
SELECT g.name 
FROM gemeinden g
JOIN fluesse f ON ST_Intersects(f.geom, g.geom)
WHERE f.name = 'Emme' 
ORDER BY 1;


------------
-- Aufgabe 6: Flächenverschnitt (Spatial Analysis)
------------

-- SQL-Query, welche die Geometrien der Tabelle flugschneise mit 2 km puffert 
-- und mit den Geometrien der Tabelle gemeinden verschneidet.
SELECT ST_Intersection(g.geom, f.geom) 
FROM gemeinden g
JOIN (SELECT ST_Buffer(geom, 2000) AS geom FROM flugschneise) f ON ST_Intersects(g.geom, f.geom);

