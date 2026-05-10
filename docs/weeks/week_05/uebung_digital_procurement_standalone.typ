// ============================================================
// DigiBusI FS26 — Übung 7: Digital Procurement
// Standalone Abgabe
// ============================================================

#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm))
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em, spacing: 1.05em)
#set heading(numbering: none)

*DigiBusI FS26* #h(1fr) *Übung 7 — Digital Procurement*
#v(0.2em)
07.05.2026
#v(0.8em)
#line(length: 100%, stroke: 0.5pt)
#v(1.4em)

== Aufgabe 1: Sell-Side Digital Procurement bei Würth und Conrad

=== Ausgangslage

Beim Sell-Side Digital Procurement stellt der Lieferant die Integrationslösung bereit, damit seine Geschäftskunden elektronisch bestellen können. Je nach technischer Reife des Käufers gibt es unterschiedlich aufwändige Optionen. Würth und Conrad bieten beide eine solche Palette an, setzen aber unterschiedliche Schwerpunkte.

=== Angebot von Würth

Würth hat vier Integrationsstufen im Angebot.

*Elektronische Kataloge*

Würth stellt dem Kunden einen statischen Produktkatalog als Datei bereit, üblicherweise im BMEcat-Format oder als CSV. Der Kunde importiert diesen in sein eigenes System und bestellt dort. Kein technischer Anschluss nötig, aber Preise und Verfügbarkeiten sind nur so aktuell wie der letzte Import.

*Online-Schnittstelle*

Der Einkäufer bestellt direkt über den Würth-Webshop, ohne dass eine Systemintegration nötig ist. Für Unternehmen ohne eigenes ERP ist das oft die praktischste Lösung. Bestellbestätigung und Statusverfolgung laufen über das Portal.

*EDI (Electronic Data Interchange)*

Die ERP-Systeme von Käufer und Lieferant kommunizieren vollautomatisch miteinander. Bestellungen, Auftragsbestätigungen, Lieferscheine und Rechnungen werden als strukturierte Nachrichten ausgetauscht, z.B. per EDIFACT oder XML. Der Setup-Aufwand ist hoch, zahlt sich aber bei grossem Bestellvolumen aus, weil danach kein manueller Eingriff mehr nötig ist.

*E-Procurement Light*

Eine vereinfachte ERP-Anbindung, die Würth für Kunden hostet, die von mehr Automatisierung profitieren wollen, aber keine eigene EDI-Infrastruktur betreiben. Mehr Automatisierung als der reine Webshop, weniger Aufwand als vollständiges EDI.

=== Angebot von Conrad

Conrad bietet drei Integrationsmöglichkeiten an.

*CSP (Conrad Smart Procure)*

Browserbasierte Lösung für Geschäftskunden ohne ERP. Der Einkäufer sucht und bestellt direkt auf der Conrad-Plattform. CSP unterstützt Kostenstellen und Genehmigungsworkflows, erfordert aber keine technische Integration seitens des Käufers.

*OCI / PunchOut*

Über das standardisierte OCI-Protokoll (Open Catalog Interface) kann der Einkäufer aus seinem ERP heraus direkt in den Conrad-Katalog wechseln, Produkte auswählen und den befüllten Warenkorb automatisch zurück ins ERP übertragen lassen. Die Bestellung wird danach im ERP freigegeben und gebucht. Preise und Verfügbarkeiten sind dabei immer in Echtzeit aktuell, weil der Käufer direkt im Conrad-System sucht.

*eKatalog*

Statischer Katalog-Download im BMEcat-Format, vergleichbar mit Würths elektronischen Katalogen. Für grosse Unternehmen, die bereits ein eigenes Katalogsystem betreiben. Nachteil: keine Echtzeitdaten.

=== Vergleich

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 7pt,
    stroke: 0.5pt + luma(160),
    fill: (col, row) => if row == 0 { luma(225) } else if calc.odd(row) { luma(245) } else { white },
    align: (left, left, left),
    [*Integrationsstufe*], [*Würth*], [*Conrad*],
    [Kein technischer Anschluss], [Online-Schnittstelle (Webshop)], [CSP (Conrad Smart Procure)],
    [Statischer Katalog], [Elektronische Kataloge (BMEcat)], [eKatalog (BMEcat)],
    [ERP-Anbindung via OCI], [nicht explizit angeboten], [OCI / PunchOut],
    [Vollautomatisierung], [EDI], [nicht explizit angeboten],
    [Vereinfachte ERP-Anbindung], [E-Procurement Light], [eher über OCI abgedeckt],
  ),
  caption: [Sell-Side DP-Angebote im Vergleich: Würth und Conrad],
)

*Gemeinsamkeiten:* Beide Anbieter decken das Spektrum von einfach bis technisch tief integriert ab. Der browserbasierte Webshop und der statische Katalog sind bei beiden vorhanden.

*Unterschiede:* Würth bietet EDI an und adressiert damit Grosskunden mit eigenem IT-Betrieb. Conrad setzt stärker auf OCI/PunchOut, das technisch einfacher einzurichten ist als EDI und trotzdem Echtzeitdaten liefert. E-Procurement Light ist eine Würth-spezifische Nischenlösung, die Conrad nicht direkt anbietet.

=== Fazit

Beide Anbieter zeigen, wie ein Lieferant unterschiedliche Kundentypen mit abgestuften Integrationslösungen bedienen kann. Conrad ist mit OCI/PunchOut moderner aufgestellt, weil dieser Standard weniger Aufwand erfordert als EDI und sich gut in bestehende Procurement-Systeme wie SAP oder Ariba einfügt. Würths Stärke liegt in der Tiefe der Automatisierung über EDI und der E-Procurement-Light-Option für den Mittelstand.
