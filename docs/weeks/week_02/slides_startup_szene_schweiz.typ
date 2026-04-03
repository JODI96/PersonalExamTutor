// ============================================================
// Präsentation: Start-Up Szene Schweiz
// DigiBusI FS26 — Woche 2
// Build: typst compile docs/weeks/week_02/slides_startup_szene_schweiz.typ output/slides_startup_szene_schweiz.pdf
// ============================================================

#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: rgb("#2c3e50"),
    secondary: rgb("#3498db"),
  ),
  config-info(
    title: [Start-Up Szene Schweiz],
    subtitle: [Übungsaufgabe — Unternehmensgründung in der digitalen Wirtschaft],
    author: [DigiBusI FS26],
    date: datetime.today(),
    institution: [FHS-OST],
  ),
)

#title-slide()

// ── 1. Zahlen & Fakten ───────────────────────────────────────
== Die Schweizer Start-Up Szene in Zahlen

#v(1em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 1em,
  align(center)[
    #text(size: 2.2em, weight: "bold", fill: rgb("#3498db"))[CHF 2.4 Mrd.]
    #v(0.2em)
    #text(size: 0.85em)[investiertes Kapital\ _(2024)_]
  ],
  align(center)[
    #text(size: 2.2em, weight: "bold", fill: rgb("#3498db"))[357]
    #v(0.2em)
    #text(size: 0.85em)[Finanzierungs-\ runden _(2024)_]
  ],
  align(center)[
    #text(size: 2.2em, weight: "bold", fill: rgb("#3498db"))[3'714]
    #v(0.2em)
    #text(size: 0.85em)[registrierte\ Startups]
  ],
  align(center)[
    #text(size: 2.2em, weight: "bold", fill: rgb("#3498db"))[96]
    #v(0.2em)
    #text(size: 0.85em)[Neugründungen\ _(lfd. Jahr)_]
  ],
)

#v(1.5em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  gutter: 0.8em,
  align(center, block(fill: luma(240), radius: 4pt, inset: 8pt, width: 100%)[
    *Biotech*\ #text(fill: rgb("#3498db"))[31 %]
  ]),
  align(center, block(fill: luma(240), radius: 4pt, inset: 8pt, width: 100%)[
    *Cleantech*\ #text(fill: rgb("#3498db"))[20 %]
  ]),
  align(center, block(fill: luma(240), radius: 4pt, inset: 8pt, width: 100%)[
    *ICT/Fintech*\ #text(fill: rgb("#3498db"))[22 %]
  ]),
  align(center, block(fill: luma(240), radius: 4pt, inset: 8pt, width: 100%)[
    *Medtech*\ #text(fill: rgb("#3498db"))[12 %]
  ]),
  align(center, block(fill: luma(240), radius: 4pt, inset: 8pt, width: 100%)[
    *Weitere*\ #text(fill: rgb("#3498db"))[15 %]
  ]),
)

// ── 2. Regionen & Stärken ────────────────────────────────────
== Regionen & Standorte

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    #table(
      columns: (1fr, auto, auto),
      inset: 9pt,
      stroke: 0.4pt + luma(200),
      fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
      [#text(fill: white, weight: "bold")[Kanton]],
      [#text(fill: white, weight: "bold")[CHF Mio.]],
      [#text(fill: white, weight: "bold")[Anteil]],
      [Zürich (ZH)],  [631], [27 %],
      [Waadt (VD)],   [506], [21 %],
      [Genf (GE)],    [265], [11 %],
      [Basel-Land],   [249], [11 %],
      [Zug (ZG)],     [246], [10 %],
      [Bern (BE)],    [118], [5 %],
    )
  ],
  [
    *Was macht die Schweiz stark?*
    - Weltklasse-Hochschulen: ETH, EPFL, OST, HSG
    - Politische Stabilität & Rechtssicherheit
    - Professionelles internationales Investoren-Netzwerk

    #v(0.8em)
    *Ostschweiz*
    - *Startfeld* — Switzerland Innovation Park Ost, Rapperswil
    - Direkte Brücke OST → Markt
  ],
)

// ── 3. Akteure der Gründung ──────────────────────────────────
== Akteure der Gründung

#v(1em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.5em,
  block(
    fill: luma(246), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #text(weight: "bold", size: 1.05em)[Gründerinnen &\ Gründer]
    #v(0.5em)
    - Idee, Innovation, Technologie
    - Digital-Know-how & Führungsstärke
    - Vom Gründer zum Manager
  ],
  block(
    fill: luma(246), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #text(weight: "bold", size: 1.05em)[Investorinnen &\ Investoren]
    #v(0.5em)
    - Business Angels: Frühphase
    - Venture Capital: Wachstumsphase
    - Minderheitsbeteiligung → Exit
  ],
  block(
    fill: luma(246), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #text(weight: "bold", size: 1.05em)[Unterstützendes\ Ökosystem]
    #v(0.5em)
    - Gründerzentren & Förderprogramme
    - Steuer-, Rechts- & Strategieberatung
    - Netzwerke & Events
  ],
)

// ── 4. Phasen & Finanzierung ─────────────────────────────────
== Phasen & Finanzierung

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.2em,
  block(
    stroke: 2pt + rgb("#3498db"), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #align(center, text(weight: "bold", size: 1.1em, fill: rgb("#3498db"))[Early Stage])
    #v(0.4em)
    *Phasen:* Pre-Seed, Seed, Startup\
    *Fokus:* Idee, Prototyp, MVP\
    *Kapital:* Eigenmittel, Förderung\
    *Beispiel:* Venture Kick, Innosuisse
  ],
  block(
    stroke: 2pt + rgb("#2c3e50"), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #align(center, text(weight: "bold", size: 1.1em, fill: rgb("#2c3e50"))[Expansion Stage])
    #v(0.4em)
    *Phasen:* 2nd Round, 3rd Round\
    *Fokus:* Wachstum, Markterschliessung\
    *Kapital:* Venture Capital\
    *Beispiel:* b2venture
  ],
  block(
    stroke: 2pt + luma(160), radius: 6pt, inset: 16pt, width: 100%,
  )[
    #align(center, text(weight: "bold", size: 1.1em, fill: luma(80))[Later Stage])
    #v(0.4em)
    *Phasen:* Bridge, IPO, MBO/MBI\
    *Fokus:* Skalierung, Exit\
    *Kapital:* VC, Börse\
    *Beispiel:* SIX Swiss Exchange
  ],
)

// ── 5. Ökosystem & Support ───────────────────────────────────
== Ökosystem & Support

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.5em,
  block(fill: rgb("#eaf4fb"), stroke: 1.5pt + rgb("#3498db"), radius: 6pt, inset: 16pt, width: 100%)[
    #text(weight: "bold", size: 1.05em)[Startfeld]
    #text(size: 0.8em, fill: gray)[ — Rapperswil]
    #v(0.5em)
    - Partner: OST, HSG, Empa
    - Coaching, Infrastruktur, Netzwerk
    - Seed-Kapital bis CHF 300'000
  ],
  block(fill: rgb("#eaf4fb"), stroke: 1.5pt + rgb("#3498db"), radius: 6pt, inset: 16pt, width: 100%)[
    #text(weight: "bold", size: 1.05em)[b2venture]
    #text(size: 0.8em, fill: gray)[ — St. Gallen]
    #v(0.5em)
    - Early-stage VC + Angel-Netzwerk
    - Fokus: Pre-Seed & Seed
    - Portfolio: *DeepL*, *SumUp*
  ],
  block(fill: rgb("#eaf4fb"), stroke: 1.5pt + rgb("#3498db"), radius: 6pt, inset: 16pt, width: 100%)[
    #text(weight: "bold", size: 1.05em)[Venturelab]
    #text(size: 0.8em, fill: gray)[ — national]
    #v(0.5em)
    - 1'000+ Startups begleitet
    - Venture Kick, TOP 100 Award
    - Innosuisse Startup Training
  ],
)

// ── 6. Fazit & Beurteilung ───────────────────────────────────
== Fazit: Beurteilung der Schweizer Start-Up Szene

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    *Stärken*
    - Weltklasse-Forschung: ETH, EPFL, OST
    - Stabiles Umfeld & starkes VC-Netzwerk
    - Biotech & DeepTech international führend
    - Gut vernetztes regionales Ökosystem

    #v(0.5em)
    *Herausforderungen*
    - Hohe Kosten → hoher Kapitalbedarf
    - Kleiner Heimmarkt: frühe Internationalisierung nötig
    - FH-Gründungen noch unterrepräsentiert
  ],
  block(
    fill: rgb("#eaf4fb"),
    stroke: 2pt + rgb("#3498db"),
    radius: 6pt,
    inset: 18pt,
    width: 100%,
  )[
    *Unser Fazit*
    #v(0.5em)
    Die Schweizer Start-Up Szene ist im globalen Vergleich *überdurchschnittlich stark* — getragen von exzellenter Forschung, stabilen Rahmenbedingungen und einem professionellen VC-Ökosystem.

    #v(0.5em)
    Grösstes Potenzial: *FH-Absolvierende* stärker einbinden — Startfeld und OST bauen hier gezielt Brücken.
  ],
)
