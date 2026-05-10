// ============================================================
// DigiBusI FS26 — Übung 8: Digital Contracting
// Standalone Abgabe
// ============================================================

#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm))
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em, spacing: 1.05em)
#set heading(numbering: none)

*DigiBusI FS26* #h(1fr) *Übung 8 — Digital Contracting*
#v(0.2em)
07.05.2026
#v(0.8em)
#line(length: 100%, stroke: 0.5pt)
#v(1.4em)

== Aufgabe 1: Case Study from the Retail Industry

=== Ausgangslage

Das Unternehmen R ist ein grosser europäischer Detailhändler mit rund 80'000 Mitarbeitenden und einem Jahresumsatz von etwa 11 Milliarden Euro (Stand 2004). Das Unternehmen betreibt über 500 Filialen und ist dezentral organisiert. Die Beschaffung wird von einer zentralen Shared-Services-Einheit ("RS") verantwortet, die Category Management und Einkauf für alle Filialen übernimmt.

Im Einkauf unterhält RS rund 15'000 aktive Lieferantenverträge mit etwa 1'800 Lieferanten in Europa und Asien. Trotz dieser Grösse lief das gesamte Vertragsmanagement bis zur Einführung von Digital Contracting papierbasiert ab. Das führte zu fünf konkreten Problemen:

- *Aufwändige Vertragserstellung:* Das Erstellen eines neuen Vertrags erforderte manuelle Dateneingabe und den physischen Transfer von Stammdaten zwischen Abteilungen. Der Prozess war fehleranfällig und personalintensiv.

- *Lange Durchlaufzeiten:* Die Freigabe eines Vertrags dauerte zwei bis vier Wochen, weil Dokumente per Post oder intern weitergeleitet und manuell geprüft werden mussten.

- *Kein proaktives Monitoring:* Es gab kein System, das ablaufende Verträge automatisch erkannte und die Zuständigen informierte. Das führte dazu, dass Bestellungen auf Basis abgelaufener Verträge ausgelöst wurden.

- *Divergenz zwischen Papier und System:* 20 bis 30 Prozent aller Verträge wurden im Laufe der Zeit geändert. Diese Änderungen wurden oft im ERP-System nachgeführt, aber nicht oder zu spät im Papierdokument — oder umgekehrt. Die beiden Versionen wichen regelmässig voneinander ab.

- *Portokosten:* Allein für den Postversand von Vertragsunterlagen an Lieferanten fielen jährlich rund 100'000 Euro an.

=== Digital Contracting im Einsatz

Digital Contracting bezeichnet die durchgängige IT-Unterstützung des gesamten Vertragslebenszyklus — von der ersten Verhandlung bis zur Kündigung. Das Ziel von Unternehmen R war es, Papierverträge durch rechtsgültige elektronische Repräsentationen zu ersetzen und den Prozess so weit wie möglich zu automatisieren.

Der Vertragslebenszyklus wurde in sieben Phasen gegliedert: Information, Angebotsverwaltung, Verhandlung, Vertragserstellung, Monitoring, Änderungsmanagement und Kündigung. Für jede Phase sollte eine IT-Lösung vorhanden sein, die die manuelle Arbeit reduziert und Medienbrüche vermeidet.

Für die Umsetzung traf RS vier grundlegende Designentscheidungen:

- *Vertragsdarstellung:* Verträge werden in einem strukturierten, proprietären Format des bestehenden ERP-Systems abgelegt — nicht als PDF oder Word-Dokument. Das ermöglicht eine maschinelle Weiterverarbeitung und automatisches Monitoring.

- *Externe Integration:* Die Anbindung der Lieferanten erfolgt über ein webbasiertes Portal. Gegenüber EDI hat das den Vorteil, dass auch kleinere Lieferanten ohne eigene IT-Infrastruktur teilnehmen können. Der Lieferant braucht nur einen Internetzugang und einen Browser.

- *Signatur:* Für die rechtsgültige Unterzeichnung wird eine digitale Signatur auf Basis von Public-Key-Kryptographie eingesetzt. Damit sind elektronische Verträge juristisch gleichwertig zu handschriftlich unterzeichneten Papierdokumenten.

- *IS-Wahl:* Als informationstechnische Grundlage kommen entweder das bestehende ERP-System oder ein spezialisiertes Business Networking System (BNS) in Frage. Diese Entscheidung ist für alle drei evaluierten Szenarien relevant.

=== IT-Systemunterstützung

RS evaluierte drei konkrete IT-Szenarien, die sich in der Wahl des Kernsystems und der Art der Lieferantenanbindung unterscheiden. Allen drei Szenarien gemeinsam ist die Nutzung des strukturierten proprietären Vertragsformats und der digitalen beziehungsweise elektronischen Signatur.

*Szenario 1 — Business Networking System mit Portal*

Ein spezialisiertes Business Networking System übernimmt die zentrale Vertragsverwaltung. Die Lieferanten sind über ein webbasiertes Portal angebunden. Das BNS bietet umfangreiche Funktionen für Contract Lifecycle Management und ist nicht an das bestehende ERP gebunden. Nachteil: höhere Integrationskosten, weil das BNS mit dem ERP von RS verbunden werden muss.

*Szenario 2 — ERP-System mit Portal*

Das bestehende ERP-System von RS übernimmt die Vertragsverwaltung, Lieferanten sind ebenfalls über ein Portal angebunden. Vorteil: Die Stammdaten liegen bereits im ERP, kein zusätzliches System nötig. Nachteil: ERP-Systeme sind nicht primär für Contract Management optimiert; umfangreiche Anpassungen können nötig sein.

*Szenario 3 — ERP-System mit E-Mail-Integration*

Wie Szenario 2, aber statt eines Portals kommuniziert das System mit den Lieferanten per E-Mail. Das senkt die technische Hürde auf Lieferantenseite noch weiter, da keine Portalregistrierung nötig ist. Dafür ist der Prozess weniger strukturiert und die Automatisierung eingeschränkter.

#figure(
  table(
    columns: (1.4fr, 1fr, 1fr, 1fr),
    inset: 7pt,
    stroke: 0.5pt + luma(160),
    fill: (col, row) => if row == 0 { luma(225) } else if calc.odd(row) { luma(245) } else { white },
    align: (left, left, left, left),
    [*Merkmal*], [*Szenario 1*], [*Szenario 2*], [*Szenario 3*],
    [Kernsystem], [BNS], [ERP], [ERP],
    [Lieferantenanbindung], [Portal], [Portal], [E-Mail],
    [Vertragsformat], [proprietär/strukturiert], [proprietär/strukturiert], [proprietär/strukturiert],
    [Signatur], [digital (PKI)], [digital (PKI)], [elektronisch],
    [Integrationsaufwand], [hoch (BNS–ERP)], [mittel], [gering],
    [Automatisierungsgrad], [hoch], [hoch], [mittel],
  ),
  caption: [Vergleich der drei IT-Szenarien für Digital Contracting bei Unternehmen R],
)

Die Wahl zwischen den Szenarien hängt davon ab, wie stark das bestehende ERP ausgebaut werden kann und welchen Standardisierungsgrad die Lieferanten mitbringen. Szenario 1 bietet die meiste Funktionalität, erfordert aber die grösste Investition. Szenario 3 ist am schnellsten einzuführen, schränkt aber die Automatisierung ein.

=== Fazit

Der Fall Unternehmen R zeigt, wie Digital Contracting konkrete Ineffizienzen aus dem papierbasierten Vertragsmanagement beseitigt. Die fünf identifizierten Schwachstellen — lange Durchlaufzeiten, fehlende Überwachung, Medienbrüche, Divergenz und Portokosten — lassen sich durch eine strukturierte elektronische Vertragsverwaltung direkt adressieren.

Die drei evaluierten IT-Szenarien unterscheiden sich vor allem im Kernsystem (BNS oder ERP) und in der Art der Lieferantenanbindung (Portal oder E-Mail). Entscheidend für die Wahl ist die Balance zwischen Funktionsumfang, Integrationsaufwand und der technischen Reife der Lieferanten. Unabhängig vom Szenario sind das strukturierte Vertragsformat und die digitale Signatur die Grundlage für Rechtsverbindlichkeit und Automatisierung.
