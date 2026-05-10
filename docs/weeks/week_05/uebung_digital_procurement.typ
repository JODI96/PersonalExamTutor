// ============================================================
// Übungsaufgabe: Digital Procurement Integration
// DigiBusI FS26 — Woche 5
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Aufgabe 1: Digital Procurement — Würth vs. Conrad

// ── 1. Kontext ───────────────────────────────────────────────
=== Kontext: Sell-Side Digital Procurement

Beim *Sell-Side Digital Procurement* geht es darum, wie ein Lieferant seinen Kunden den elektronischen Einkauf ermöglicht. Der Lieferant stellt also die Schnittstelle bereit — nicht der Käufer. Das ist der Unterschied zur Buy-Side, wo das einkaufende Unternehmen sein eigenes System aufbaut.

Beide Anbieter — Würth und Conrad — sind typische Beispiele für Lieferanten, die mehrere Integrationsstufen anbieten. Je nach technischer Reife des Kunden gibt es unterschiedlich aufwändige Lösungen: von der einfachen statischen Datei bis hin zur voll automatisierten ERP-Anbindung.

// ── 2. Angebot Würth ─────────────────────────────────────────
=== Angebot Würth

Würth bietet vier verschiedene DP-Lösungen an, die sich in Integrationstiefe und technischem Aufwand unterscheiden.

// ── 2a. Elektronische Kataloge ───────────────────────────────
==== Elektronische Kataloge

Das ist die einfachste Variante. Würth stellt dem Kunden einen Katalog als Datei zur Verfügung — typischerweise im BMEcat-Format (XML-basiert) oder als Excel/CSV. Der Kunde importiert diesen Katalog in sein eigenes System und bestellt dort. Würth hat danach keinen Einfluss mehr auf den Prozess.

- *Aufwand Lieferant:* gering — Katalog einmalig erstellen und aktualisieren
- *Aufwand Käufer:* Katalog muss ins eigene System eingespielt werden
- *Nachteil:* Preise und Verfügbarkeiten werden nicht in Echtzeit aktualisiert

// ── 2b. Online-Schnittstelle ─────────────────────────────────
==== Online-Schnittstelle

Hier bestellt der Kunde direkt über den Würth-Webshop. Es gibt keine technische Systemintegration — der Einkäufer loggt sich ein, sucht Produkte und gibt die Bestellung manuell auf. Für Unternehmen ohne eigenes ERP oft die praktischste Lösung.

Die Bestellbestätigung kommt per E-Mail oder über das Portal. Statusverfolgung ist ebenfalls im Webshop möglich.

// ── 2c. EDI ──────────────────────────────────────────────────
==== EDI — Electronic Data Interchange

EDI ist die technisch anspruchsvollste Lösung. Hier kommunizieren die ERP-Systeme von Käufer und Lieferant direkt miteinander — ohne menschlichen Eingriff. Bestellungen, Auftragsbestätigungen, Lieferscheine und Rechnungen werden automatisch als strukturierte Nachrichten ausgetauscht (z. B. EDIFACT oder XML).

#formula-box[
  *EDI (Electronic Data Interchange)*

  Standardisierter, automatischer Datenaustausch zwischen zwei ERP-Systemen. Beide Seiten müssen dasselbe Format unterstützen und einmalig eine Verbindung einrichten. Danach läuft der gesamte Bestellprozess ohne manuellen Aufwand.
]

Voraussetzung ist, dass beide Seiten den gleichen Standard unterstützen und die technische Anbindung aufgesetzt wurde. Das ist aufwändig, zahlt sich aber bei hohem Bestellvolumen aus.

// ── 2d. E-Procurement Light ──────────────────────────────────
==== E-Procurement Light

Das ist Würths Lösung für Unternehmen, die von EDI profitieren wollen, aber nicht die IT-Ressourcen dafür haben. Würth hostet ein vereinfachtes Beschaffungsportal, das mit dem ERP des Kunden kommuniziert — ohne dass der Kunde eine vollständige EDI-Infrastruktur aufbauen muss.

Also eine Art Mittelweg: mehr Automatisierung als der reine Webshop, weniger Aufwand als vollständiges EDI.

// ── 3. Angebot Conrad ────────────────────────────────────────
=== Angebot Conrad

Conrad bietet drei Integrationsformen an, die ähnliche Ziele verfolgen wie Würth, aber anders strukturiert sind.

// ── 3a. CSP ──────────────────────────────────────────────────
==== CSP — Conrad Smart Procure

CSP ist die browserbasierte Variante von Conrad. Der Einkäufer sucht Produkte direkt auf der Conrad-Plattform, legt sie in den Warenkorb und schliesst die Bestellung im Browser ab. Keine Systemanbindung nötig.

Der Vorteil gegenüber einem normalen Webshop: CSP ist speziell für Geschäftskunden optimiert — mit Kostenstellen, Genehmigungsworkflows und Rechnungsadresse. Technisch braucht der Käufer aber gar nichts einzurichten.

// ── 3b. OCI / PunchOut ───────────────────────────────────────
==== OCI / PunchOut

OCI (Open Catalog Interface) ist ein standardisiertes Protokoll, das es dem Einkäufer erlaubt, *aus seinem eigenen ERP heraus* in den Conrad-Katalog zu wechseln, dort Produkte auszuwählen und den gefüllten Warenkorb automatisch zurück ins ERP zu übertragen.

#formula-box[
  *OCI / PunchOut — Ablauf*

  + Einkäufer startet den Prozess im ERP-System (z. B. SAP)
  + ERP öffnet automatisch den Conrad-Webshop (PunchOut)
  + Einkäufer sucht und wählt Produkte im Conrad-Shop aus
  + Warenkorb wird automatisch zurück ins ERP übertragen
  + Bestellung wird im ERP weiterverarbeitet (Freigabe, Buchung etc.)
]

Das Ergebnis: Der Einkäufer arbeitet im gewohnten ERP-Umfeld, hat aber Zugriff auf den aktuellen Conrad-Katalog mit Echtzeit-Preisen und Verfügbarkeiten. Für den Lieferanten bedeutet das: kein statischer Katalog, immer aktuelle Daten.

#warn-box[
  *Prüfungsfalle:* OCI und EDI sind nicht dasselbe. Bei OCI initiiert der *Mensch* den Prozess im ERP und surft dann im Webshop des Lieferanten. Bei EDI kommunizieren die Systeme vollautomatisch ohne Benutzerinteraktion. OCI ist also kein vollständig automatisierter Datenaustausch.
]

// ── 3c. eKatalog ─────────────────────────────────────────────
==== eKatalog

Der Conrad eKatalog entspricht konzeptionell den elektronischen Katalogen von Würth: Conrad stellt dem Kunden eine Katalogdatei zur Verfügung (z. B. im BMEcat-Format), die ins Kundensystem importiert wird. Gedacht ist das vor allem für grössere Unternehmen, die bereits ein eigenes Katalogsystem betreiben.

Nachteil gegenüber OCI: Preise und Verfügbarkeiten sind nur so aktuell wie der letzte Import.

// ── 4. Vergleich ─────────────────────────────────────────────
=== Vergleich: Gemeinsamkeiten und Unterschiede

Beide Anbieter decken das gesamte Spektrum von einfach bis komplex ab. Die folgende Tabelle stellt die Angebote gegenüber:

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    align: (left, left, left),
    [*Merkmal*], [*Würth*], [*Conrad*],
    [Statischer Katalog], [Elektronische Kataloge (BMEcat, CSV)], [eKatalog (BMEcat)],
    [Webshop / Browser], [Online-Schnittstelle], [CSP (Conrad Smart Procure)],
    [ERP-Integration via OCI], [— (nicht explizit angeboten)], [OCI / PunchOut],
    [Vollautomatisierung], [EDI], [— (kein direktes EDI-Angebot)],
    [Leichte ERP-Anbindung], [E-Procurement Light], [— (eher OCI statt eigene Light-Lösung)],
  ),
  caption: [Sell-Side DP-Angebote im Vergleich: Würth vs. Conrad]
)

*Gemeinsamkeiten:*

Beide Anbieter setzen auf eine Abstufung: günstig-einfach für kleine Kunden ohne IT, technisch tief integriert für grosse Unternehmen mit ERP. Der statische Katalog und der browserbasierte Webshop sind bei beiden vorhanden — das ist quasi der Mindeststandard im B2B-Bereich.

*Unterschiede:*

Würth hat EDI im Angebot und adressiert damit grosse Kunden mit eigenem IT-Department. Conrad setzt stärker auf OCI/PunchOut — das ist technisch einfacher einzurichten als EDI, bietet aber trotzdem Echtzeitdaten. E-Procurement Light ist eine Würth-spezifische Nischenlösung für den Mittelstand.

#tip-box[
  *Lernhinweis:* OCI/PunchOut ist der Trend. Immer mehr Lieferanten und Beschaffungsplattformen unterstützen diesen Standard, weil er weniger Aufwand als EDI erfordert und trotzdem Echtzeit-Katalogdaten liefert. Bei Würth fehlt diese Lösung explizit — das könnte sich mit der Zeit ändern.
]

// ── 5. Fazit ─────────────────────────────────────────────────
=== Fazit

Sowohl Würth als auch Conrad zeigen, wie ein Lieferant unterschiedliche Kundentypen mit einer Palette von Integrationslösungen bedienen kann. Kleine Unternehmen steigen mit dem Webshop ein, mittelgrosse Firmen nutzen eKataloge oder OCI, und grosse Konzerne mit hohem Bestellvolumen profitieren von EDI.

Die Stärke von Conrad liegt im OCI/PunchOut-Angebot, das sich gut in bestehende Procurement-Systeme (SAP, Ariba etc.) einfügt. Würths Stärke ist EDI und die E-Procurement-Light-Option, die auch weniger IT-affinen Kunden Automatisierung ermöglicht.

#cheat-box[
  *Was ist Sell-Side DP?*
  Lieferant stellt die Integrationslösung bereit, damit Kunden elektronisch bestellen können.

  #v(0.4em)

  *Würth — 4 Angebote:*
  + *Elektronische Kataloge* — statische Datei (BMEcat), Kunde importiert selbst
  + *Online-Schnittstelle* — Bestellung über Würth-Webshop, kein ERP nötig
  + *EDI* — vollautomatischer Systemdatenaustausch (EDIFACT/XML), hoher Aufwand
  + *E-Procurement Light* — vereinfachte ERP-Anbindung, gehostet von Würth

  #v(0.4em)

  *Conrad — 3 Angebote:*
  + *CSP (Conrad Smart Procure)* — browserbasiert, für Käufer ohne ERP
  + *OCI / PunchOut* — ERP öffnet Conrad-Shop, Warenkorb fliesst zurück ins ERP
  + *eKatalog* — statischer Katalog-Download (wie Würth Elektronische Kataloge)

  #v(0.4em)

  *Merke:*
  - EDI = vollautomatisch, kein Mensch involviert, hoher Setup-Aufwand
  - OCI = Mensch startet, surft im Lieferanten-Shop, ERP übernimmt Warenkorb
  - Statischer Katalog = günstig, aber Preise/Verfügbarkeit veralten
]
