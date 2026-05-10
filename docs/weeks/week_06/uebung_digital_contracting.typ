// ============================================================
// Übungsaufgabe: Digital Contracting — Case Study Retail Industry
// DigiBusI FS26 — Woche 6
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Aufgabe 1: Digital Contracting — Case Study from the Retail Industry

=== Kontext: Was ist Digital Contracting?

*Digital Contracting* bezeichnet die durchgängige IT-Unterstützung des gesamten Vertragslebenszyklus — von der Verhandlung über die Erstellung und Unterzeichnung bis hin zum Monitoring und zur Kündigung. Ziel ist es, Medienbrüche zu vermeiden, Durchlaufzeiten zu verkürzen und Verträge maschinell auswertbar zu machen.

=== Ausgangslage: Unternehmen R

Unternehmen R ist ein grosser europäischer Detailhändler mit rund 80'000 Mitarbeitenden und einem Jahresumsatz von etwa 11 Milliarden Euro (Stand 2004). Das Unternehmen betreibt über 500 Filialen und ist dezentral organisiert. Die zentrale Shared-Services-Einheit "RS" verantwortet Category Management und Einkauf für alle Filialen.

RS unterhält rund 15'000 aktive Lieferantenverträge mit etwa 1'800 Lieferanten in Europa und Asien — alles papierbasiert. Das führt zu fünf konkreten Problemen:

- *Aufwändige Vertragserstellung:* Manuelle Dateneingabe, keine automatische Stammdatenübernahme aus dem ERP.
- *Lange Durchlaufzeiten:* Freigabe dauert zwei bis vier Wochen durch postalische Weiterleitung und manuelle Prüfung.
- *Kein proaktives Monitoring:* Keine Warnung bei ablaufenden Verträgen → Bestellungen auf Basis abgelaufener Verträge.
- *Divergenz Papier/System:* 20–30 % der Verträge werden geändert; Papier und ERP laufen auseinander.
- *Portokosten:* Rund EUR 100'000 jährlich für den Postversand von Vertragsunterlagen.

=== Digital Contracting im Einsatz

RS verfolgte das Ziel, Papierverträge durch rechtsgültige elektronische Repräsentationen zu ersetzen und den Prozess durchgehend IT-gestützt abzuwickeln.

#formula-box[
  *Vertragslebenszyklus bei Unternehmen R*

  Information → Angebotsverwaltung → Verhandlung → Vertragserstellung → Monitoring → Änderungsmanagement → Kündigung

  Für jede Phase sollte eine IT-Lösung vorhanden sein, die manuelle Arbeit und Medienbrüche reduziert.
]

RS traf vier grundlegende Designentscheidungen:

- *Vertragsdarstellung:* Strukturiertes proprietäres Format des bestehenden ERP-Systems — keine PDFs oder Word-Dokumente. Ermöglicht maschinelle Weiterverarbeitung und automatisches Monitoring.
- *Externe Integration:* Portalbasiert statt EDI, damit auch kleinere Lieferanten ohne eigene IT-Infrastruktur teilnehmen können.
- *Signatur:* Digitale Signatur auf Basis von Public-Key-Kryptographie für rechtsgültige elektronische Unterzeichnung.
- *IS-Wahl:* Entweder bestehendes ERP oder spezialisiertes Business Networking System (BNS) als Kernsystem.

=== IT-Systemunterstützung

RS evaluierte drei IT-Szenarien. Allen gemeinsam: strukturiertes proprietäres Vertragsformat und digitale Signatur.

#figure(
  table(
    columns: (1.4fr, 1fr, 1fr, 1fr),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    align: (left, left, left, left),
    [*Merkmal*], [*Szenario 1*], [*Szenario 2*], [*Szenario 3*],
    [Kernsystem], [BNS], [ERP], [ERP],
    [Lieferantenanbindung], [Portal], [Portal], [E-Mail],
    [Integrationsaufwand], [hoch (BNS–ERP)], [mittel], [gering],
    [Automatisierungsgrad], [hoch], [hoch], [mittel],
  ),
  caption: [Vergleich der drei IT-Szenarien für Digital Contracting bei Unternehmen R]
)

#warn-box[
  Szenario 1 bietet die meiste Funktionalität (BNS ist speziell für Contract Lifecycle Management ausgelegt), erfordert aber die grösste Investition, weil das BNS zusätzlich mit dem ERP integriert werden muss.
]

=== Fazit

#tip-box[
  *Was Digital Contracting löst:* Lange Durchlaufzeiten werden durch digitale Freigabeworkflows verkürzt. Kein proaktives Monitoring wird durch automatische Alerting-Funktionen ersetzt. Papier/System-Divergenz wird durch eine einzige, strukturierte elektronische Vertragsrepräsentation eliminiert.
]

#cheat-box[
  *Was ist Digital Contracting?*
  IT-gestützte Abwicklung des gesamten Vertragslebenszyklus — von Verhandlung bis Kündigung.

  #v(0.4em)

  *Ausgangslage Unternehmen R:*
  - 15'000 Verträge, 1'800 Lieferanten, papierbasiert
  - 5 Pain Points: Erstellungsaufwand, Durchlaufzeit, kein Monitoring, Divergenz, Portkosten

  #v(0.4em)

  *Design-Entscheidungen:*
  - Strukturiertes ERP-Format (nicht PDF/Word)
  - Portal statt EDI (auch kleine Lieferanten)
  - Digitale Signatur (PKI)
  - BNS oder ERP als Kernsystem

  #v(0.4em)

  *Drei IT-Szenarien:*
  + BNS + Portal — viel Funktion, hoher Aufwand
  + ERP + Portal — gute Balance
  + ERP + E-Mail — einfach, weniger Automatisierung
]
