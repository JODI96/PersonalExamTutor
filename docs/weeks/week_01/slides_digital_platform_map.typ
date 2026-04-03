// ============================================================
// Präsentation: Übungsaufgabe zur Digital Platform Map
// DigiBusI FS26 — Woche 1
// Build: typst compile docs/weeks/week_01/slides_digital_platform_map.typ output/slides_digital_platform_map.pdf
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
    title: [Digital Platform Map],
    subtitle: [Übungsaufgabe — Digitale Plattformen & Ökosysteme],
    author: [DigiBusI FS26],
    date: datetime.today(),
    institution: [FHS-OST],
  ),
)

#title-slide()

// ── 1. Was ist eine Digitale Plattform? ──────────────────────
== Was ist eine Digitale Plattform?

#v(0.5em)

#block(
  fill: rgb("#eaf4fb"),
  stroke: 2pt + rgb("#3498db"),
  radius: 6pt,
  inset: 14pt,
  width: 100%,
)[
  _"[...] organizations that get two or more sides on board and enable direct interactions between them"_
  #h(1fr) #text(fill: gray, size: 0.8em)[Obermaier & Mosch, 2019]
]

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    - *Intermediär:* verbindet Anbieter & Nachfrager
    - *Many-to-many:* viele Anbieter — viele Kunden
    - Stellt Infrastruktur & Regeln bereit
    - Produziert keinen eigenen Wert — *ermöglicht* ihn
  ],
  [
    *Akteure*
    - Anbieter
    - Nachfrager / Kunden
    - Plattformbetreiber
    - Plattform-Enabler _(z. B. Zahlungsdienste)_
  ],
)

// ── 2. Die 6 Typen ───────────────────────────────────────────
== Die Digital Platform Map — 6 Typen

#v(0.4em)

#table(
  columns: (auto, 1fr, 1.8fr),
  inset: 9pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[\#]],
  [#text(fill: white, weight: "bold")[Typ]],
  [#text(fill: white, weight: "bold")[Kernfunktion & Beispiele]],
  [1], [*Marktplatz (Marketplace)*],        [Güteraustausch zwischen Käufer & Verkäufer — _Amazon, eBay, Zalando_],
  [2], [*Suchplattform (Search Platform)*], [Vermittlung von Informationsangebot & -nachfrage — _Google, Booking.com_],
  [3], [*Repository*],                      [Virtuelles Archiv: Inhalte speichern & abrufen — _YouTube, GitHub, Spotify_],
  [4], [*Kommunikationsplattform*],          [Nachrichtenaustausch in Echtzeit — _WhatsApp, Slack, Teams_],
  [5], [*Community-Plattform*],             [Langfristige Vernetzung von Teilnehmern — _LinkedIn, Instagram, Reddit_],
  [6], [*Zahlungsplattform (Payment)*],     [Abwicklung von Zahlungstransaktionen — _PayPal, Twint, Stripe_],
)

#v(0.5em)
Unterschied zwischen den Typen: die *Art des Austauschs*, der über die Plattform ermöglicht wird.

// ── 3. Marktplatz ────────────────────────────────────────────
== Typ 1: Marktplatz — Beispiel Amazon

#v(0.3em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Charakteristika*
    - Zweiseitiger Markt: Käufer ↔ Plattform ↔ Verkäufer
    - Plattform als *Gatekeeper* _(Zugang, Sichtbarkeit, Bewertungen)_
    - *Netzwerkeffekte:* indirekt — mehr Verkäufer → mehr Käufer
    - *Einnahmen:* Provision, Listing-Gebühren, Fulfillment
    - Kein eigenes Inventar → hohe Skalierbarkeit
  ],
  [
    *Amazon Marketplace*
    - >50 % der Produkte von Drittanbietern
    - *Seller Central:* Verwaltungsportal für Händler
    - *FBA (Fulfillment by Amazon):* Amazon übernimmt Lager, Versand, Retouren
    - *Amazon Ads:* Sichtbarkeits-Werbung für Händler
    - Starker *Lock-in:* Bewertungshistorie & FBA-Integration binden Händler
  ],
)

// ── 4. Community-Plattform ───────────────────────────────────
== Typ 5: Community-Plattform — Beispiel LinkedIn

#v(0.3em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Charakteristika*
    - Fokus: *langfristige Vernetzung* — kein direkter Güteraustausch
    - Wert entsteht durch *Beziehungen, Wissen & Reputation*
    - *Netzwerkeffekte:* direkt — mehr Mitglieder → grösserer Nutzen für alle
    - *Einnahmen:* Werbung, Premium-Abos, B2B-Services
    - *Lock-in:* soziales Kapital ist nicht portierbar
  ],
  [
    *LinkedIn*
    - >1 Milliarde Mitglieder weltweit
    - *Für Mitglieder:* Kontakte, Jobs, Wissen
    - *Für Unternehmen:* Recruiting, Employer Branding
    - *LinkedIn Premium / Recruiter:* kostenpflichtige Abos
    - *LinkedIn Ads:* B2B-Targeting nach Beruf, Branche, Seniority
    - Winner-takes-all: Profil ohne Kontakte hat kaum Wert
  ],
)

// ── 5. Vergleich ─────────────────────────────────────────────
== Vergleich: Marktplatz vs. Community-Plattform

#v(0.5em)

#table(
  columns: (1fr, 1fr, 1fr),
  inset: 10pt,
  stroke: 0.5pt + luma(180),
  fill: (col, row) => if row == 0 { rgb("#2c3e50") } else if calc.odd(row) { luma(248) } else { white },
  [#text(fill: white, weight: "bold")[Kriterium]],
  [#text(fill: white, weight: "bold")[Marktplatz (Amazon)]],
  [#text(fill: white, weight: "bold")[Community (LinkedIn)]],
  [*Austauschtyp*],    [Transaktional — Güter],        [Relational — Beziehungen],
  [*Netzwerkeffekte*], [Indirekt (Cross-Side)],         [Direkt (Same-Side)],
  [*Einnahmen*],       [Provision, Fulfillment, Ads],  [Abo, Recruiting, Ads],
  [*Lock-in*],         [Bewertungen, FBA-Integration], [Soziales Kapital, Reputation],
  [*Skalierbarkeit*],  [Sehr hoch — kein Inventar],    [Sehr hoch — keine Produktionskosten],
)
