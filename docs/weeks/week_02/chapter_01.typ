// ============================================================
// Week 2 — Chapter 1: Start-Up Szene Schweiz
// Topics: Akteure, Finanzierungsphasen, Ökosystem, Zahlen & Fakten
// PDF: pdfs/week_02/DigiBusI_5_Unternehmesgründung_2026.pdf
// ============================================================

#import "../../template.typ": tip-box, warn-box, formula-box, cheat-box

== Chapter 1: Start-Up Szene Schweiz

// ── 1. Core Idea ─────────────────────────────────────────────
=== Core Idea

Ein *Startup-Ökosystem* ist das Zusammenspiel aus Gründerinnen, Investoren und unterstützenden Organisationen, die gemeinsam neue Unternehmen von der Idee zur Marktreife begleiten. Die Schweiz verfügt über eines der stärksten Startup-Ökosysteme Europas — getragen von Weltklasse-Forschung, politischer Stabilität und einem professionellen Investorennetzwerk.

#formula-box[
  *Drei-Akteure-Modell der Unternehmensgründung*

  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Akteur*], [*Rolle*], [*Beitrag*],
    [Gründerinnen & Gründer], [Träger der Idee], [Innovation, Technologie, Risikobereitschaft],
    [Investorinnen & Investoren], [Kapitalgeber], [Business Angels (Frühphase), VC (Wachstumsphase)],
    [Unterstützendes Ökosystem], [Enabler], [Gründerzentren, Förderprogramme, Beratung, Netzwerke],
  )
]

// ── 2. Intuition ─────────────────────────────────────────────
=== Intuition

*Warum braucht es ein Startup-Ökosystem?*

Eine gute Idee allein reicht nicht aus. Startups scheitern häufig nicht an der Technologie, sondern an drei strukturellen Lücken:

- *Kapitallücke:* Banken finanzieren keine unerprobten Geschäftsmodelle → externe Eigenkapitalgeber nötig
- *Wissenslücke:* Gründende brauchen Coaching zu Gesellschaftsrecht, Pitching, Pricing, Internationalisierung
- *Netzwerklücke:* Zugang zu Erstkunden, Pilotkunden und internationalen Märkten ist entscheidend für die Skalierung

*Wann ist das relevant?*

- Bei der Entscheidung zur Gründung (Welche Unterstützung steht zur Verfügung?)
- Während des Aufbaus (Wo beantrage ich Fördergelder? Wer coacht mich?)
- Bei der Suche nach Wachstumskapital (Wer investiert in meine Phase?)

// ── 3. Practical Example ─────────────────────────────────────
=== Practical Example: Die Schweizer Start-Up Szene 2024

Die Schweiz zählt zu den führenden Startup-Nationen Europas. Die aktuellen Zahlen (2024) zeigen:

#figure(
  table(
    columns: (1fr, auto),
    stroke: 0.5pt + luma(180),
    inset: 9pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Kennzahl*], [*Wert*],
    [Investiertes Kapital (2024)], [CHF 2.369 Milliarden],
    [Finanzierungsrunden (2024)], [357],
    [Registrierte Startups], [3'714],
    [Neugründungen (lfd. Jahr)], [96],
  ),
  caption: [Schweizer Startup-Szene in Zahlen, 2024]
)

*Sektorale Verteilung:*
- Biotech: 31 % — international führend (ETH-Spin-offs, Pharma-Nähe)
- ICT / Fintech: 22 %
- Cleantech: 20 % — wachsender Bereich durch ESG-Druck
- Medtech: 12 %
- Weitere: 15 %

*Geografische Konzentration (nach investiertem Kapital):*
- Zürich: CHF 631 Mio. (27 %)
- Waadt: CHF 506 Mio. (21 %) — EPFL-Cluster
- Genf: CHF 265 Mio. (11 %)
- Basel-Land: CHF 249 Mio. (11 %)
- Zug: CHF 246 Mio. (10 %) — Crypto Valley
- Bern: CHF 118 Mio. (5 %)

// ── 4. Key Rules / Formulas / Definitions ────────────────────
=== Key Rules, Formulas & Definitions

*Die drei Finanzierungsphasen:*

#formula-box[
  #table(
    columns: (auto, 1fr, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Phase*], [*Teilphasen*], [*Fokus*], [*Kapitalquellen*],
    [*Early Stage*], [Pre-Seed, Seed, Startup], [Idee, Prototyp, MVP], [Eigenmittel, Förderung, Business Angels],
    [*Expansion Stage*], [2nd Round, 3rd Round], [Wachstum, Markterschliessung], [Venture Capital (VC)],
    [*Later Stage*], [Bridge, IPO, MBO/MBI], [Skalierung, Exit], [VC, Börse (SIX Swiss Exchange)],
  )
]

*Wichtige Schweizer Förderorganisationen:*

#formula-box[
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 8pt,
    fill: (col, row) => if row == 0 { luma(230) } else if calc.odd(row) { luma(248) } else { white },
    [*Organisation*], [*Fokus & Leistung*], [*Bekannte Portfolios / Fakten*],
    [*Startfeld* (Rapperswil)], [OST/HSG/Empa-Partnerschaft; Coaching, Infrastruktur, Netzwerk; Seed-Kapital bis CHF 300'000], [Direkte Brücke OST → Markt; Ostschweizer Ankerpunkt],
    [*b2venture* (St. Gallen)], [Early-stage VC + Angel-Netzwerk; Fokus Pre-Seed & Seed], [Portfolio: *DeepL*, *SumUp*],
    [*Venturelab* (national)], [1'000+ Startups begleitet; TOP 100 Award; Innosuisse Startup Training], [*Venture Kick*: max. CHF 150'000 in drei Phasen],
  )
]

// ── 5. Exam Traps ────────────────────────────────────────────
=== Exam Traps

#warn-box[
  *Häufige Prüfungsfehler:*

  1. *"VCs finanzieren alle Phasen gleichermassen"* → Falsch. VCs spezialisieren sich auf Phasen. Business Angels = Early Stage; VC = Expansion Stage; Börse/MBO = Later Stage.

  2. *"Schweizer Startups haben keinen Standortnachteil"* → Falsch. Hohe Lebens- und Lohnkosten bedeuten hohen Kapitalbedarf. Der kleine Heimmarkt zwingt zur frühen Internationalisierung.

  3. *"FH-Absolvierende gründen gleich viel wie ETH/EPFL-Absolvierende"* → Falsch. ETH/EPFL dominieren das Gründungsgeschehen. FH-Gründungen sind systematisch unterrepräsentiert — das wird aktiv als Schwäche des Ökosystems benannt.

  4. *"Startfield und b2venture machen dasselbe"* → Falsch. Startfeld = regionales Inkubator-Zentrum mit Coaching und Seed-Kapital. b2venture = VC-Fonds, der in Early-Stage-Unternehmen investiert und Eigenkapital nimmt.
]

// ── 6. 3-Minute Summary ──────────────────────────────────────
=== 3-Minute Summary

#tip-box[
  *Kurzfassung: Schweizer Start-Up Szene*

  - *Grösse:* CHF 2.4 Mrd. investiert / 357 Runden / 3'714 Startups (2024)
  - *Sektoren:* Biotech (31 %) und Deep-Tech dominieren; Cleantech wächst
  - *Geografie:* Konzentriert auf Zürich, Waadt, Genf — Ostschweiz mit Startfeld aufstrebend
  - *Drei Akteure:* Gründerinnen (Idee) · Investoren (Kapital) · Ökosystem (Enabler)
  - *Drei Phasen:* Early → Expansion → Later — jeweils mit anderen Kapitalquellen
  - *Stärken:* ETH/EPFL, Stabilität, internationales VC-Netzwerk
  - *Schwächen:* Hohe Kosten, kleiner Heimmarkt, FH-Gründungen unterrepräsentiert
]

// ── 7. Cheat Sheet ───────────────────────────────────────────
=== Cheat Sheet

#cheat-box[
  *SCHWEIZER START-UP SZENE — CHEAT SHEET*

  #v(0.4em)

  *Zahlen 2024:* CHF 2.4 Mrd. · 357 Runden · 3'714 Startups · 96 Neugründungen

  *Sektoren:* Biotech 31 % · ICT/Fintech 22 % · Cleantech 20 % · Medtech 12 %

  *Geografie (Top 3):* Zürich 27 % · Waadt 21 % · Genf 11 %

  #v(0.4em)

  *Drei Akteure:*
  - Gründer: Idee, Tech, Risiko
  - Investoren: Angels (Early) → VC (Expansion) → Börse (Later)
  - Ökosystem: Zentren, Förderung, Beratung, Netzwerke

  *Drei Phasen:*
  1. Early Stage — Eigenmittel, Förderung, Business Angels
  2. Expansion Stage — Venture Capital
  3. Later Stage — VC, Börse, Exit

  *Wichtige Organisationen:*
  - Startfeld (Rapperswil): bis CHF 300'000 Seed, OST/HSG/Empa
  - b2venture (St. Gallen): Early-stage VC — DeepL, SumUp
  - Venturelab (national): Venture Kick bis CHF 150'000, TOP 100

  #v(0.3em)

  *Merke:* Startups scheitern an Kapital-, Wissens- und Netzwerklücken — nicht (nur) an der Idee.
]
