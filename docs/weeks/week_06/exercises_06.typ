// Echte Kursübungen — Woche 6 (konvertiert am 2026-05-09)
// Quelle: README.adoc

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

```typst
== Übungen

=== Aufgabe 1 — Hitzeinseln in bewohnten Gebieten

Ziel dieser Aufgabe ist es, lokale Hitze- und Kälteinseln in bewohnten oder bebauten Gebieten zu visualisieren. Eine Hitze- oder Kälteinsel ist ein Ort, der wärmer bzw. kälter als seine Umgebung ist. Das können z.B. stark bebaute Plätze sein, die sich stark aufheizen, oder Parks, die von der Vegetation gekühlt werden.

*Umgebung:* Browser, Online-Entwicklungsumgebung von Google Earth Engine (https://code.earthengine.google.com/)

**(a) Datenquelle**

Als erstes brauchen wir eine geeignete Datenquelle. Diese muss Temperatur-Messungen in genügend hoher räumlicher Auflösung enthalten, um Unterschiede im innerstädtischen Bereich (z.B. zwischen Quartieren) ermitteln zu können. Die Auflösung sollte also deutlich feiner als Kilometer sein. Daten mit einer Auflösung von einigen 100 Metern können funktionieren.

Suchen Sie im Katalog nach geeigneten Datenquellen und wählen Sie eine. Falls Sie selbst keine finden oder die Musterlösung exakt nachvollziehen wollen, sehen Sie sich den Datensatz NASA/ASTER GED AG100 003 an.

Lesen Sie die Beschreibung der Datenquelle und machen Sie sich mit den Bändern der Datenquelle vertraut. Ermitteln Sie ein Band, das Land-Oberflächen-Temperatur-Angaben enthält.

**(b) Datenquelle in Entwicklungsumgebung laden**

Mit dem Knopf "Open in Code Editor" können Sie den darüber angezeigten Code in die Online-Entwicklungsumgebung übernehmen. Mit "Run" können Sie den Code ausführen, um das Ergebnis in der Karte darunter zu sehen. Passen Sie den Code so an, dass das von Ihnen ermittelte Band mit Temperaturen angezeigt wird. Benennen Sie auch die Variablen passend um.

Die Darstellung sieht nun seltsam aus, da die Visualisierung nicht auf den Wertebereich der Daten angepasst ist. Finden Sie einen passenden Wertebereich. Als Farbpalette können Sie folgende verwenden:

```javascript
  palette: [ // color palette for displaying, ranging from blue to red
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
` `` `

**(c) Kartenausschnitt anpassen**

Passen Sie den Code so an, dass die Stadt Zürich angezeigt wird. Falls der eingefügte Code-Ausschnitt bereits `Map.setCenter` verwendet, ändern Sie einfach den entsprechenden Aufruf ab. Falls noch nicht, fügen Sie einen solchen hinzu.

Verwenden Sie Zoomlevel `13`. Die Koordinaten können Sie auf Wikipedia nachschlagen. Beachten Sie, dass es verschiedene Koordinaten-Referenzsysteme gibt, und dass selbst beim von Google verwendeten WGS84 verschiedene Reihenfolgen der Komponenten üblich sind.

Machen Sie den Datenlayer halbtransparent, um die Basiskarte unter den Daten zu sehen. Zwar kann man das interaktiv über den Schieberegler in der Karten-Legende machen, muss es dann aber nach jeder Ausführung des Codes wiederholen. Um das zu vermeiden, kann die `opacity`-Angabe direkt beim Code, der den Layer zur Karte hinzufügt, mitgegeben werden.

**(d) Skalieren der Messgrössen**

Je nach Datenquelle liegen die Daten nicht in gewohnten Einheiten vor. Die in der Musterlösung gewählte Datenquelle verwendet z.B. hundertstel Kelvin.

Anstatt dies erst bei der Visualisierung zu kompensieren, kann man die Daten schon von Anfang an so skalieren, dass sie in vertrauten Einheiten (z.B. Kelvin mit Nachkommastellen) vorliegen. Das macht die Analyse intuitiver.

Verwenden Sie geeignete `Image`-Methoden wie `divide` oder `multiply`, um die Skalierung anzupassen:

```javascript
var temperature = dataset.select('temperature').divide(100);
` `` `

_Hinweis:_ `divide`, `multiply` usw. können anstatt eines weiteren `Image`s wie hier auch einfach eine Zahl als Argument mitgegeben werden.

**(e) Ermitteln der Umgebungstemperatur eines Orts**

Um die Temperatur in der Umgebung eines Orts zu ermitteln, müssen wir die Temperaturen an nahen Orten (eben jener Umgebung) zu einem Mittelwert verrechnen. Das ist mit der Methode `reduceNeighborhood` möglich. Suchen Sie diese im "Docs"-Tab und finden Sie heraus, wie sie aufzurufen ist, damit die Berechnung möglichst performant abläuft. Als Kernel können Sie ein Quadrat mit "Radius" von etwa 2 km verwenden.

Visualisieren Sie das Resultat auf der Karte. Die Temperatur-Verläufe sollten "weicher" (verschwommener) als in den Ursprungsdaten aussehen.

**(f) Ermitteln der Hitze- und Kälteinseln**

Da Hitze- und Kälteinseln Orte sind, deren Temperatur von ihrer Umgebung abweicht, bilden wir die Differenz der Temperatur aus den Ursprungsdaten (= Temperatur genau an jenem Ort) und den zuvor ermittelten Umgebungstemperaturen (= Temperatur um jenen Ort herum).

Finden und verwenden Sie eine passende Methode und visualisieren Sie das Ergebnis auf der Karte. Wählen Sie einen passenden Wertebereich für die Visualisierung. Dieser wird für die Temperatur-Differenzen anders sein als für die absoluten Temperaturen.

=== Aufgabe 2 — Einschränkung auf besiedeltes Gebiet _(Zusatzaufgabe)_

Wenn Sie aus der Ergebnis-Visualisierung heraus-zoomen, werden Sie feststellen, dass auch Berge zu lokalen Temperatur-Unterschieden führen, die in der Visualisierung als Kälteinseln sichtbar werden. Da wir uns für Unterschiede im urbanen Bereich interessieren, wollen wir das Ergebnis auf bebaute oder bewohnte Gebiete einschränken. Diese emittieren nachts typischerweise mehr Licht als unbesiedelte Gegenden.

Suchen Sie eine Nacht-Licht-Datenquelle, mit der Sie die Temperatur-Differenz-Daten verrechnen können. Wahrscheinlich werden Sie auch diese Datenquelle vorverarbeiten müssen, um sinnvolle Ergebnisse zu erzielen.

Visualisieren Sie das Endergebnis. Es sollte ähnlich wie das vorherige Ergebnis aussehen, ausser dass keine Kälte- und Wärmeinseln in unbewohnten oder schwach besiedelten Gebieten wie dem Alpenhauptkamm mehr angezeigt werden.
```

== Lösungen

=== Aufgabe — Hitzeinseln in bewohnten Gebieten (Google Earth Engine)

==== Schritt 1 — Datenquelle wählen und in den Code Editor laden

*Schritt 1 —* Wir wählen den NASA ASTER Global Emissivity Dataset (AG100), da dieser Land-Oberflächen-Temperaturen (Land Surface Temperature, LST) mit einer räumlichen Auflösung von 100 m enthält — fein genug für innerstädtische Analysen. Im GEE Data Catalog findet man das Dataset unter `NASA/ASTER_GED/AG100_003`. Das relevante Band heisst `temperature` und enthält Werte in hundertstel Kelvin.

*Schritt 2 —* Über den Knopf "Open in Code Editor" wird der Beispiel-Code übernommen. Wir passen die Variablennamen und das ausgewählte Band an:

```javascript
// Rasterdaten-Dataset laden (Image, kein ImageCollection!)
var dataset = ee.Image('NASA/ASTER_GED/AG100_003');

// Band 'temperature' (Landoberflächentemperatur) auswählen
var temperature = dataset.select('temperature');
```

*Ergebnis:* Die Variable `temperature` enthält das Raster-Band mit Temperaturdaten in hundertstel Kelvin als `ee.Image`.

---

==== Schritt 2 — Skalierung der Messgrössen (hundertstel Kelvin → Kelvin)

*Schritt 1 —* Wie in der Vorlesung zu Rasterdaten erläutert, liegen Satellitenbild-Daten häufig in skalierten Ganzzahlwerten vor, um Speicher zu sparen. Das ASTER-Dataset speichert Temperaturen in hundertstel Kelvin. Wir dividieren durch 100, um gewöhnliche Kelvin-Werte zu erhalten:

```javascript
// Skalierung: hundertstel Kelvin → Kelvin (Division durch 100)
var temperature = dataset.select('temperature').divide(100);
```

*Schritt 2 —* Damit liegen die Werte z.B. als ~270–320 K vor, was anschaulicher ist und spätere Differenzberechnungen vereinfacht.

*Ergebnis:* Das Band `temperature` enthält nun Werte in Kelvin (z.B. 273 K ≈ 0 °C).

---

==== Schritt 3 — Visualisierung mit passendem Wertebereich und Farbpalette

*Schritt 1 —* Um die Temperatur-Rasterdaten korrekt darzustellen, definieren wir Visualisierungsparameter. Der typische Wertebereich für Landoberflächentemperaturen liegt zwischen ca. 250 K (kalte Berggebiete) und 320 K (heisse Stadtflächen im Sommer). Diese Farbpalette reicht von Blau (kalt) zu Rot (heiss):

```javascript
// Visualisierungsparameter: Wertebereich 250-320 K, Farbpalette blau→rot
var vizParams = {
  min: 250,
  max: 320,
  palette: [
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};
```

*Schritt 2 —* Wir fügen den Layer halbtransparent zur Karte hinzu, damit die Basiskarte (Google Maps Mashup, wie in der Vorlesung zu GEE erwähnt) darunter sichtbar bleibt. Die `opacity`-Angabe direkt im Code vermeidet, den Schieberegler nach jedem Run neu einstellen zu müssen:

```javascript
// Layer mit Deckkraft 0.7 zur Karte hinzufügen
Map.addLayer(temperature, vizParams, 'Landoberflächentemperatur', true, 0.7);
```

*Ergebnis:* Das Temperatur-Raster wird farbig und halbtransparent auf der Karte dargestellt.

---

==== Schritt 4 — Kartenausschnitt auf Zürich setzen

*Schritt 1 —* Gemäss Vorlesungsunterlagen zu GEE bietet die Plattform Geo-Visualisierungs­möglichkeiten ("Google Maps Mashups"). Wir zentrieren die Karte auf Zürich. Die WGS84-Koordinaten von Zürich lauten: Längengrad (Longitude) 8.5417°, Breitengrad (Latitude) 47.3769°. In GEE ist die Reihenfolge `setCenter(longitude, latitude, zoom)`:

```javascript
// Karte auf Zürich zentrieren (WGS84: lon=8.5417, lat=47.3769), Zoomlevel 13
Map.setCenter(8.5417, 47.3769, 13);
```

*Ergebnis:* Die Karte zeigt beim Start den Raum Zürich auf Zoomlevel 13.

---

==== Schritt 5 — Ermitteln der Umgebungstemperatur mit `reduceNeighborhood`

*Schritt 1 —* Eine Hitzeinsel ist laut Aufgabenstellung ein Ort, dessen Temperatur von seiner Umgebung abweicht. Um die Umgebungstemperatur zu ermitteln, mitteln wir die Temperaturwerte in der Nachbarschaft jedes Pixels. Wir verwenden `reduceNeighborhood` mit einem quadratischen Kernel von ~2 km Radius. Ein quadratischer Kernel ist recheneffizienter als ein runder:

```javascript
// Quadratischer Kernel mit Radius 2 km für die Nachbarschaftsanalyse
var kernel = ee.Kernel.square({
  radius: 2000,   // 2000 Meter = 2 km
  units: 'meters'
});
```

*Schritt 2 —* Wir wenden `reduceNeighborhood` mit dem Mittelwert-Reducer an. Dieser berechnet für jedes Pixel den Mittelwert aller Pixel innerhalb des Kernels — also die lokale Umgebungstemperatur:

```javascript
// Umgebungstemperatur: Mittelwert im 2-km-Quadrat um jeden Pixel
var temperatureNeighborhood = temperature.reduceNeighborhood({
  reducer: ee.Reducer.mean(),
  kernel: kernel
});
```

*Schritt 3 —* Wir visualisieren das Ergebnis (gleicher Wertebereich wie die Originaldaten), um zu prüfen, dass die Temperaturverläufe "weicher" (verschwommener) wirken — ein Zeichen korrekt berechneter räumlicher Mittelwerte:

```javascript
// Umgebungstemperatur visualisieren (sollte weicher/verschwommener aussehen)
Map.addLayer(temperatureNeighborhood, vizParams, 'Umgebungstemperatur', true, 0.7);
```

*Ergebnis:* Die Variable `temperatureNeighborhood` enthält für jeden Pixel die mittlere Temperatur seiner 2-km-Umgebung — die Darstellung ist deutlich weicher als das Original-Raster.

---

==== Schritt 6 — Differenzberechnung: Hitze- und Kälteinseln ermitteln

*Schritt 1 —* Eine Hitzeinsel entsteht dort, wo die lokale Temperatur höher ist als die Umgebungstemperatur. Wir berechnen die Differenz: Originaltemperatur minus Umgebungstemperatur. Ein positiver Wert zeigt eine Hitzeinsel, ein negativer Wert eine Kälteinsel:

```javascript
// Differenz: lokale Temperatur minus Umgebungstemperatur
// positiv = Hitzeinsel, negativ = Kälteinsel
var heatIsland = temperature.subtract(temperatureNeighborhood);
```

*Schritt 2 —* Für die Visualisierung der Differenzen wählen wir einen symmetrischen Wertebereich um 0, da sowohl Wärme- als auch Kälteinseln sichtbar sein sollen. Typische Differenzen liegen im Bereich von -10 bis +10 Kelvin:

```javascript
// Visualisierungsparameter für Temperatur-Differenzen (-10 bis +10 K)
var heatIslandViz = {
  min: -10,
  max: 10,
  palette: [
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};

// Hitze-/Kälteinsel-Layer zur Karte hinzufügen
Map.addLayer(heatIsland, heatIslandViz, 'Hitze- und Kälteinseln', true, 0.7);
```

*Ergebnis:* Rote Bereiche zeigen Hitzeinseln (z.B. stark versiegelte Stadtflächen), blaue Bereiche zeigen Kälteinseln (z.B. Parks, Gewässer) — analog zum Anwendungsbeispiel "Urbane Hitzeinseln" aus der Vorlesung.

---

==== Vollständiger Code (Zusammenfassung)

*Schritt 1 —* Der vollständige, lauffähige Code für die Hauptaufgabe:

```javascript
// === 1. Rasterdaten laden: NASA ASTER GED AG100 (100m Auflösung) ===
var dataset = ee.Image('NASA/ASTER_GED/AG100_003');

// === 2. Band auswählen und skalieren (hundertstel Kelvin → Kelvin) ===
var temperature = dataset.select('temperature').divide(100);

// === 3. Karte auf Zürich zentrieren (WGS84: lon, lat, zoom) ===
Map.setCenter(8.5417, 47.3769, 13);

// === 4. Visualisierungsparameter für absolute Temperatur ===
var vizParams = {
  min: 250,
  max: 320,
  palette: [
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};

// Temperatur-Layer halbtransparent hinzufügen (opacity=0.7)
Map.addLayer(temperature, vizParams, 'Landoberflächentemperatur', true, 0.7);

// === 5. Umgebungstemperatur: Mittelwert im 2-km-Quadrat (reduceNeighborhood) ===
var kernel = ee.Kernel.square({
  radius: 2000,
  units: 'meters'
});

var temperatureNeighborhood = temperature.reduceNeighborhood({
  reducer: ee.Reducer.mean(),
  kernel: kernel
});

// Umgebungstemperatur visualisieren
Map.addLayer(temperatureNeighborhood, vizParams, 'Umgebungstemperatur', true, 0.7);

// === 6. Differenz: lokale Temp. minus Umgebungstemp. = Hitze-/Kälteinsel ===
var heatIsland = temperature.subtract(temperatureNeighborhood);

// Visualisierungsparameter für Differenzen (symmetrisch um 0)
var heatIslandViz = {
  min: -10,
  max: 10,
  palette: [
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};

// Hitze-/Kälteinsel-Layer zur Karte hinzufügen
Map.addLayer(heatIsland, heatIslandViz, 'Hitze- und Kälteinseln', true, 0.7);
```

---

==== Zusatzaufgabe — Einschränkung auf besiedeltes Gebiet (Nachtlicht-Maskierung)

*Schritt 1 —* Wie in der Aufgabenstellung beschrieben, zeigen beim Herauszoomen auch Bergregionen starke Temperaturunterschiede, die als Kälteinseln erscheinen — obwohl sie für die urbane Hitzeinseln-Analyse irrelevant sind. Besiedelte Gebiete emittieren nachts typischerweise mehr Licht (Strassenbeleuchtung, Gebäude). Wir suchen im GEE Data Catalog nach einem Nachtlicht-Dataset, z.B. `NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG` (VIIRS Nighttime Day/Night Band). Das Band `avg_rad` enthält die mittlere Strahlungsintensität in der Nacht:

```javascript
// Nachtlicht-Datenquelle laden (VIIRS, monatlich, Band avg_rad)
var nightlights = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
  .filterDate('2020-01-01', '2020-12-31')
  .select('avg_rad')
  .mean();
```

*Schritt 2 —* Wir definieren einen Schwellwert für "besiedelt": Pixel mit einem Nachtlicht-Wert über einem Mindestwert (z.B. 1 nW/cm²/sr) gelten als bebaut oder bewohnt. Wir erstellen eine binäre Maske:

```javascript
// Maske: Pixel mit Nachtlicht-Wert > 1 gelten als besiedelt (Wert 1), sonst 0
var settledMask = nightlights.gt(1);
```

*Schritt 3 —* Wir maskieren das Hitzeinseln-Ergebnis mit dieser Maske: Nicht-besiedelte Pixel werden ausgeblendet. Die Methode `updateMask` setzt alle Pixel mit Maskenwert 0 auf "kein Daten" (transparent):

```javascript
// Hitzeinsel-Raster auf besiedelte Gebiete einschränken
var heatIslandSettled = heatIsland.updateMask(settledMask);
```

*Schritt 4 —* Wir visualisieren das maskierte Ergebnis mit denselben Visualisierungsparametern wie zuvor:

```javascript
// Maskiertes Ergebnis: Hitze-/Kälteinseln nur in besiedelten Gebieten
Map.addLayer(
  heatIslandSettled,
  heatIslandViz,
  'Hitze-/Kälteinseln (nur Siedlungen)',
  true,
  0.7
);
```

*Schritt 5 —* Vollständiger Zusatz-Code (ergänzend zum Hauptcode):

```javascript
// === ZUSATZAUFGABE: Einschränkung auf besiedelte Gebiete via Nachtlicht ===

// Nachtlicht-ImageCollection laden, auf 2020 filtern, Mittelwert bilden
var nightlights = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
  .filterDate('2020-01-01', '2020-12-31')
  .select('avg_rad')
  .mean();

// Binäre Maske: Nachtlicht > 1 nW/cm²/sr → besiedelt
var settledMask = nightlights.gt(1);

// Hitzeinsel-Raster mit Siedlungsmaske verschneiden (updateMask)
var heatIslandSettled = heatIsland.updateMask(settledMask);

// Ergebnis visualisieren (gleiche Farbpalette, nur noch Siedlungspixel sichtbar)
Map.addLayer(
  heatIslandSettled,
  heatIslandViz,
  'Hitze-/Kälteinseln (nur Siedlungen)',
  true,
  0.7
);
```

*Ergebnis:* Das finale Raster zeigt Hitze- und Kälteinseln ausschliesslich in besiedelten oder bebauten Gebieten. Unbewohnte Regionen wie der Alpenhauptkamm erscheinen transparent — die Analyse entspricht damit dem Anwendungsbeispiel "Urbane Hitzeinseln" aus der Vorlesung, bei dem Google Earth Engine als PaaS-Dienst mit aufbereiteten Satellitendaten (Petabyte-Massstab) für die Rasteranalyse genutzt wird.