// ============================================================
// Präsentation: Übungsaufgabe Unternehmensgründung & Geschäftsmodelle
// DigiBusI FS26 — Woche 2
// Build: typst compile docs/weeks/week_02/slides_unternehmensgruendung.typ output/slides_unternehmensgruendung.pdf
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
    title: [Unternehmensgründung & Geschäftsmodelle],
    subtitle: [Übungsaufgabe — PESTL-Analyse & Business Model Stress Test],
    author: [DigiBusI FS26],
    date: datetime.today(),
    institution: [FHS-OST],
  ),
)

#title-slide()

// ── 1. Resilienz von Geschäftsmodellen ───────────────────────
== Resilienz von Geschäftsmodellen

#v(0.5em)

#block(
  fill: rgb("#eaf4fb"),
  stroke: 2pt + rgb("#3498db"),
  radius: 6pt,
  inset: 14pt,
  width: 100%,
)[
  _„Ein Geschäftsmodell beschreibt, wie ein Unternehmen Wert schafft, liefert und erfasst — und wie es auf Veränderungen im Umfeld reagiert."_
  #h(1fr) #text(fill: gray, size: 0.8em)[Kollmann, 2022]
]

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Warum Resilienz prüfen?*
    - Geschäftsmodelle entstehen in einem Kontext
    - Umfeld verändert sich: politisch, wirtschaftlich, technologisch
    - Nicht resiliente Modelle scheitern bei Umfeldschocks
    - Frühzeitige Analyse schützt vor strategischer Blindheit
  ],
  [
    *Zwei Analysetools*
    - *PESTL-Analyse:* systematische Umfeldanalyse in 6 Dimensionen
    - *Business Model Stress Test:* gezielte Prüfung auf Robustheit gegenüber konkreten Entwicklungen
    - Zusammen: vollständige Resilienzbewertung
  ],
)

// ── 2. PESTL-Analyse — 6 Dimensionen ────────────────────────
== PESTL-Analyse — 6 Dimensionen

#v(0.4em)

#table(
  columns: (auto, 1fr, 1.8fr),
  inset: 9pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[Kürzel]],
  [#text(fill: white, weight: "bold")[Dimension]],
  [#text(fill: white, weight: "bold")[Kernfragen & Beispiele]],
  [*P*], [*Politisch*],       [Regulierungen, staatliche Eingriffe, Steuerpolitik — _DSGVO, Digital Markets Act_],
  [*E*], [*Ökonomisch*],      [Konjunktur, Zinsen, Kaufkraft, Inflation — _Rezession, VC-Finanzierungsklima_],
  [*S*], [*Sozial*],          [Werte, Demografie, Nutzerverhalten, Trends — _Remote Work, Creator Economy_],
  [*T*], [*Technologisch*],   [Innovationen, Disruption, Infrastruktur — _KI, Cloud, 5G_],
  [*L*], [*Rechtlich*],       [Gesetze, Urheberrecht, Datenschutz, Haftung — _Streaming-Lizenzen, GDPR_],
  [*E*], [*Ökologisch*],      [Klimaziele, Nachhaltigkeit, Ressourcen — _CO₂-Fussabdruck, ESG-Reporting_],
)

#v(0.5em)
Ziel: *externe Einflussfaktoren* systematisch erfassen, bevor das Geschäftsmodell bewertet wird.

// ── 3. PESTL — Beispiel Spotify ──────────────────────────────
== PESTL-Analyse — Beispiel Spotify

#v(0.3em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Politisch / Rechtlich*
    - EU Digital Single Market: vereinfachter Lizenzrahmen
    - DSGVO: strenge Anforderungen an Nutzerdaten
    - Urheberrechtsreform EU 2021: erhöhte Lizenzkosten

    *Ökonomisch*
    - Abo-Modell krisenanfällig bei Konsumrückgang
    - Währungsrisiken (globale Präsenz, USD-Lizenzkosten)
    - Hoher Kostendruck durch Musiklizenz-Gebühren (~70 % Umsatz)
  ],
  [
    *Sozial / Technologisch*
    - Trend zu Audio-Content: Podcasts, Hörbücher
    - KI-Empfehlungsalgorithmen als Differenzierungsmerkmal
    - Wachstum in Märkten des Globalen Südens (Lateinamerika, Indien)

    *Ökologisch*
    - Streaming: hoher Energie- und Serververbrauch
    - ESG-Druck: Nachhaltigkeitsberichte werden erwartet
    - Ziel: 100 % erneuerbare Energie für Rechenzentren bis 2030
  ],
)

// ── 4. Business Model Stress Test — Konzept ──────────────────
== Business Model Stress Test

#v(0.3em)

#block(
  fill: rgb("#eaf4fb"),
  stroke: 2pt + rgb("#3498db"),
  radius: 6pt,
  inset: 12pt,
  width: 100%,
)[
  *Methodik:* 3 plausible Entwicklungen im Umfeld definieren → Auswirkung auf das Geschäftsmodell bewerten → Resilienz einschätzen
]

#v(0.5em)

#table(
  columns: (auto, 1fr, 1fr),
  inset: 9pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[\#]],
  [#text(fill: white, weight: "bold")[Schritt]],
  [#text(fill: white, weight: "bold")[Frage]],
  [1], [Entwicklung identifizieren],  [Welche plausible Veränderung im Umfeld könnte eintreten?],
  [2], [Auswirkung analysieren],      [Wie trifft diese Entwicklung das Geschäftsmodell konkret?],
  [3], [Resilienz bewerten],          [Ist das Modell stabil, anpassungsfähig oder gefährdet?],
)

#v(0.4em)
Ursprung: Analog zum Bankensektor — dort testet man Bilanzen auf Extremszenarien (*Stresstests*).

// ── 5. Stress Test — Beispiel Spotify ────────────────────────
== Business Model Stress Test — Beispiel Spotify

#v(0.4em)

#table(
  columns: (1.4fr, 1fr, 1fr),
  inset: 9pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[Entwicklung]],
  [#text(fill: white, weight: "bold")[Auswirkung auf Spotify]],
  [#text(fill: white, weight: "bold")[Resilienz]],
  [*KI generiert Musik direkt* — Labels werden umgangen],
    [Lizenzkosten sinken; aber Qualitätsfrage & Künstlerboykott-Risiko],
    [Ambivalent — könnte Margen verbessern, aber Reputationsrisiko],
  [*Apple/Google sperren App-Store-Zugang* — 30 % Gebühr erzwungen],
    [Abo-Marge halbiert sich auf Mobilgeräten; Preiserhöhung nötig],
    [Kritisch — Plattformabhängigkeit als strukturelles Risiko],
  [*Regulierung verpflichtet zu fairer Künstlervergütung* (EU-Gesetz)],
    [Lizenzkosten steigen nochmals; Druck auf Free-Tier erhöht sich],
    [Moderat — Spotify hat Preissetzungsspielraum durch Marktmacht],
)

// ── 6. Fazit ─────────────────────────────────────────────────
== Fazit: PESTL-Analyse & Stress Test

#v(0.5em)

#table(
  columns: (1fr, 1fr, 1fr),
  inset: 10pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[Kriterium]],
  [#text(fill: white, weight: "bold")[PESTL-Analyse]],
  [#text(fill: white, weight: "bold")[Stress Test]],
  [*Zweck*],        [Umfeldscan: Was existiert?],      [Robustheit: Was hält stand?],
  [*Perspektive*],  [Breit — alle 6 Dimensionen],      [Fokussiert — 3 konkrete Szenarien],
  [*Output*],       [Chancen & Risiken im Umfeld],     [Bewertung: stabil / anpassbar / kritisch],
  [*Anwendung*],    [Vor Markteinritt, Strategierevision], [Laufendes Monitoring, Investitionsentscheid],
  [*Beispiel*],     [Spotify: KI, ESG, DSGVO erkannt], [App-Store-Abhängigkeit als kritisches Risiko],
)
