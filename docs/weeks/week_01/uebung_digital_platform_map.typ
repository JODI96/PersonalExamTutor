// ============================================================
// Übungsaufgabe: Digital Platform Map
// DigiBusI FS26 — Woche 1
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Übungsaufgabe: Digital Platform Map

// ── 1. Was ist eine Digitale Plattform? ──────────────────────
=== Was ist eine Digitale Plattform?

Digitale Plattformen sind *Technologien oder Infrastrukturen*, die die Interaktion zwischen verschiedenen Nutzergruppen ermöglichen. Sie bieten eine zentrale Schnittstelle, über die verschiedene Akteure — typischerweise Anbieter und Nachfrager — miteinander in Kontakt treten können.

#formula-box[
  *Kerndefinition* (Obermaier & Mosch, 2019)

  Plattformen sind Organisationen, die _"two or more sides on board get and enable direct interactions between them"_. Sie fungieren als *Intermediäre*, stellen die erforderliche Infrastruktur bereit und ermöglichen unter vorgegebenen Regeln wertschaffende Interaktionen zwischen mindestens zwei Akteuren.
]

*Grundprinzip der Digital Platform Map:*

- *Viele-zu-Viele* (Many-to-many): Mehrere Anbieter treffen auf mehrere Nachfrager
- *Kernfunktion:* Schaffung einer Infrastruktur, die Angebots- und Nachfrageseite verbindet
- *Bedeutung:* Plattformen sind eine *neue Form der Vermittlung* (Re-Intermediation) — kein Wegfall von Vermittlern, sondern deren digitale Transformation

*Wichtige Akteure einer Plattform:*

- *Anbieter* — liefern Produkte, Dienste oder Inhalte
- *Kunden / Nachfrager* — konsumieren das Angebot
- *Plattformbetreiber* — stellt die Infrastruktur und Governance bereit
- *Plattform-Enabler* — unterstützen den Betrieb (z. B. Zahlungsdienstleister)

*Kernbestandteile einer digitalen Plattform:*

- *Funktionsebene:* Vermittlung, Pooling oder Profiling
- *Schnittstellen:* Kundenseitiger Zugang (App, Website) und anbieterseitiger Zugang (ERP, API)
- *Ökonomische Vorteile:* Netzwerkeffekte, Skaleneffekte, Long-Tail-Märkte, Lock-in-Effekte
- *Einnahmenmodell:* Gebühren, Provisionen, Werbung, Datenverwertung, Premium-Modelle

#tip-box[
  *Merke:* Der entscheidende Unterschied zum Pipeline-Business ist, dass eine Plattform keinen eigenen Wert *produziert*, sondern Wert durch *Verbindung* von Akteuren *ermöglicht*.
]

// ── 2. Die Digital Platform Map — 6 Typen ───────────────────
=== Die Digital Platform Map — Die 6 Typen

Die *Digital Platform Map* (Quelle: tias.edu) unterscheidet sechs Arten digitaler Plattformen basierend auf der Art des Austauschs:

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    inset: 8pt,
    stroke: 0.5pt + luma(180),
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    align: (left, left, left),
    [*\#*], [*Typ*], [*Kernfunktion*],
    [1], [*Marktplatz (Marketplace)*], [Verbindet Käufer und Verkäufer für den Austausch physischer oder digitaler Güter],
    [2], [*Suchplattform (Search Platform)*], [Vermittelt Angebot und Nachfrage von Informationen],
    [3], [*Repository*], [Virtuelles Archiv: Inhalte werden gespeichert und später abgerufen],
    [4], [*Kommunikationsplattform*], [Fokus auf den Austausch von Nachrichten und Kommunikation in Echtzeit],
    [5], [*Community-Plattform*], [Langfristige Vernetzung und Beziehungspflege von Teilnehmern],
    [6], [*Zahlungsplattform (Payment Platform)*], [Abwicklung von Abrechnungen und Zahlungstransaktionen],
  ),
  caption: [Die 6 Plattformtypen der Digital Platform Map]
)

// ── 3. Ausgewählte Plattformtypen ────────────────────────────
=== Ausgewählte Plattformtypen im Detail

// ── 3a. Marktplatz ───────────────────────────────────────────
==== Typ 1: Marktplatz (Marketplace)

*Definition & Charakteristika:*

Ein digitaler Marktplatz bringt Käufer und Verkäufer auf einer gemeinsamen Plattform zusammen. Er ermöglicht den Austausch von physischen oder digitalen Gütern und Dienstleistungen und übernimmt dabei die Rolle des Intermediärs.

- *Marktstruktur:* Zweiseitiger Markt (Käufer ↔ Plattform ↔ Verkäufer)
- *Kernwert:* Zugang zu einer grossen, zentralen Kundenbasis und einem breiten Angebot
- *Netzwerkeffekte:* Indirekt — mehr Verkäufer zieht mehr Käufer an und umgekehrt
- *Einnahmemodell:* Provisionen pro Transaktion, Listing-Gebühren, Fulfillment-Services
- *Gatekeeper-Funktion:* Plattform kontrolliert Zugang, Sichtbarkeit und Vertrauenssignale (Bewertungen, Versiegelungen)
- *Skalierbarkeit:* Sehr hoch — kein eigenes Lager oder Inventar nötig

*Beispiel: Amazon Marketplace*

Amazon ist der weltweit grösste digitale Marktplatz. Mehr als die Hälfte der auf Amazon verkauften physischen Produkte stammt von externen Drittanbietern.

- *Seller Central:* Verwaltungsportal für externe Verkäufer (Produkte einstellen, Preise, Bestand)
- *Fulfillment by Amazon (FBA):* Amazon übernimmt Lagerung, Versand, Retouren — vollständige Outsourcing-Option für Händler
- *Ökosystem von Services:* Amazon Ads, Brand Registry, Kindle Direct Publishing
- *Reichweite:* Zugang zu Millionen aktiver Käufer global — für einzelne Händler kaum replizierbar

#warn-box[
  *Prüfungsfalle:* Amazon ist gleichzeitig Marktplatzbetreiber *und* Händler (Eigenmarken). Das schafft einen Interessenskonflikt — Amazon kennt die Verkaufsdaten aller Händler und kann eigene Konkurrenzprodukte platzieren.
]

// ── 3b. Community-Plattform ──────────────────────────────────
==== Typ 5: Community-Plattform

*Definition & Charakteristika:*

Eine Community-Plattform fokussiert sich auf die *langfristige Vernetzung* von Teilnehmern mit gemeinsamen Interessen, beruflichen Zielen oder sozialen Verbindungen. Im Vordergrund steht nicht der direkte Güteraustausch, sondern Beziehungsaufbau und Wissensteilung.

- *Marktstruktur:* Oft einseitiges Netzwerk (alle Teilnehmer in gleicher Rolle) oder zweiseitig (Nutzer + Werbetreibende)
- *Kernwert:* Netzwerkzugehörigkeit, Sichtbarkeit, Wissensaustausch, soziales Kapital
- *Netzwerkeffekte:* Direkt — je mehr Mitglieder, desto grösser der Nutzen für jeden einzelnen
- *Einnahmemodell:* Werbung (datenbasiertes Targeting), Premium-Mitgliedschaften, Recruiting-Services
- *Bindungseffekt (Lock-in):* Hohes soziales Kapital (Kontakte, Inhalte, Geschichte) macht Wechsel kostspielig
- *Datenzentriertheit:* Verhaltensdaten ermöglichen hochpräzises Targeting

*Beispiel: LinkedIn*

LinkedIn ist die weltweit grösste Community-Plattform für berufliche Vernetzung mit über 1 Milliarde Mitgliedern.

- *Kernnutzen für Mitglieder:* Berufliche Kontakte pflegen, Stellenangebote finden, Wissen teilen
- *Kernnutzen für Unternehmen:* Recruiting, Employer Branding, B2B-Marketing
- *Einnahmenquellen:* LinkedIn Premium (Abo), LinkedIn Recruiter (HR-Tool), LinkedIn Ads
- *Netzwerkeffekte in Aktion:* Ein Profil ohne Kontakte hat kaum Wert; mit 500+ Kontakten steigt die Sichtbarkeit exponentiell
- *Lock-in:* Aufgebautes Netzwerk, Empfehlungen und Reputation können nicht exportiert werden

#tip-box[
  *Vergleich Marktplatz vs. Community:* Beim Marktplatz ist der Austausch *transaktional* (einmalig, Güter). Bei der Community-Plattform ist er *relational* (dauerhaft, Beziehungen). Beide nutzen Netzwerkeffekte, aber auf unterschiedliche Weise.
]

// ── 4. Zusammenfassung ───────────────────────────────────────
=== Zusammenfassung & Cheat Sheet

#cheat-box[
  *DIGITAL PLATFORM MAP — CHEAT SHEET*

  #v(0.3em)

  *Was ist eine digitale Plattform?*
  - Infrastruktur für Interaktionen zwischen Nutzergruppen (Many-to-many)
  - Intermediär: verbindet Angebot und Nachfrage, produziert keinen eigenen Wert
  - Akteure: Anbieter, Kunden, Betreiber, Enabler

  #v(0.5em)

  *6 Typen der Digital Platform Map:*
  + Marktplatz — Güteraustausch (Amazon, eBay, Zalando)
  + Suchplattform — Informationsvermittlung (Google, booking.com)
  + Repository — Inhaltsspeicher (YouTube, GitHub, Spotify)
  + Kommunikationsplattform — Nachrichtenaustausch (WhatsApp, Slack)
  + Community-Plattform — Vernetzung (LinkedIn, Instagram, Reddit)
  + Zahlungsplattform — Transaktionsabwicklung (PayPal, Twint, Stripe)

  #v(0.5em)

  *Marktplatz (Amazon):* Transaktional · Indirekte NWE · Provisionsmodell · FBA als Differenzierung

  *Community (LinkedIn):* Relational · Direkte NWE · Werbung + Premium · Starker Lock-in durch soziales Kapital

  #v(0.5em)

  *Merke:* Netzwerkeffekte = der Wert steigt mit der Nutzerzahl → Winner-takes-all-Dynamik
]
