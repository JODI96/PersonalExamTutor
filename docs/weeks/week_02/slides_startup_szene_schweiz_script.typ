// ============================================================
// Sprechernotizen: Start-Up Szene Schweiz
// DigiBusI FS26 — Woche 2
// Build: typst compile docs/weeks/week_02/slides_startup_szene_schweiz_script.typ output/slides_startup_szene_schweiz_script.pdf
// ============================================================

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(9pt, fill: gray)
      Sprechernotizen — Start-Up Szene Schweiz #h(1fr) DigiBusI FS26
      #line(length: 100%, stroke: 0.5pt + gray)
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #set text(9pt, fill: gray)
      #line(length: 100%, stroke: 0.5pt + gray)
      #h(1fr) #counter(page).display("1 / 1", both: true) #h(1fr)
    ]
  },
)

#set text(font: "New Computer Modern", size: 11.5pt)
#set par(justify: true, leading: 0.75em, spacing: 1.3em)

#let slide-box(number, title, body) = {
  v(1em)
  block(
    width: 100%,
    stroke: (left: 4pt + rgb("#3498db")),
    inset: (left: 14pt, top: 6pt, bottom: 6pt, right: 0pt),
  )[
    #text(weight: "bold", size: 10pt, fill: rgb("#3498db"))[FOLIE #number]
    #h(0.5em)
    #text(weight: "bold", size: 12pt)[#title]
  ]
  v(0.3em)
  body
  v(0.5em)
  line(length: 100%, stroke: 0.4pt + luma(210))
}

// ── Titelseite ────────────────────────────────────────────────
#align(center)[
  #v(1.5cm)
  #text(22pt, weight: "bold")[Sprechernotizen]
  #v(0.4em)
  #text(14pt, fill: gray)[Start-Up Szene Schweiz — Übungsaufgabe DigiBusI FS26]
  #v(0.3em)
  #text(10pt, fill: gray)[~8 Minuten · 7 Folien · ca. 60–70 Sekunden pro Folie]
  #v(1cm)
  #line(length: 60%, stroke: 1pt + gray)
]

#v(1.5cm)

// ── Folie 1 ───────────────────────────────────────────────────
#slide-box(1, "Titelfolie")[
  Guten Tag. Wir präsentieren heute unsere Übungsaufgabe zur *Start-Up Szene Schweiz* aus der Vorlesung Unternehmensgründung in der digitalen Wirtschaft.

  Wir geben einen datenbasierten Überblick über die Schweizer Startup-Landschaft: Wie viel Kapital fliesst? In welche Sektoren und Regionen? Wer sind die zentralen Akteure? Und wie beurteilen wir die Szene abschliessend — auch mit Blick auf die Ostschweiz und unsere eigene Hochschule, die OST?
]

// ── Folie 2 ───────────────────────────────────────────────────
#slide-box(2, "Die Schweizer Start-Up Szene in Zahlen — Zahlen & Fakten")[
  Beginnen wir mit den Fakten. Im Jahr 2024 wurden in Schweizer Startups *CHF 2'369 Millionen* investiert — verteilt auf 357 Finanzierungsrunden. Das ist ein Rückgang gegenüber dem Rekordjahr 2022 mit rund 4 Milliarden Franken, liegt aber noch immer deutlich über dem Niveau vor 2020.

  Auf der Plattform startup.ch sind aktuell über 3'700 Schweizer Startups registriert, 374 Finanzierungsrunden fanden in den letzten sechs Monaten statt, und 96 neue Unternehmen wurden im laufenden Jahr gegründet.

  Sektoral dominiert *Biotech* mit 31 Prozent des investierten Kapitals — rund 739 Millionen Franken. Dahinter folgen Cleantech, ICT und Fintech sowie Medtech. Die Schweiz ist also kein reines Software-Startup-Land, sondern stark in Deep-Tech und Lebenswissenschaften verankert — das unterscheidet sie von vielen anderen europäischen Ökosystemen.
]

// ── Folie 3 ───────────────────────────────────────────────────
#slide-box(3, "Regionen & Standorte")[
  Geografisch ist die Szene klar konzentriert: Der Kanton Zürich allein vereint 27 Prozent des gesamten Investitionsvolumens — rund 631 Millionen Franken. Dahinter folgen die Waadt mit dem EPFL-Cluster in Lausanne, Genf, Basel-Landschaft und Zug als Fintech-Hochburg.

  Was macht die Schweiz grundsätzlich attraktiv? Erstens die starke Hochschullandschaft — ETH Zürich, EPFL, die Universität St. Gallen, und auch Fachhochschulen wie die OST. Zweitens die politische Stabilität und Rechtssicherheit, die internationalen Investoren Vertrauen geben. Drittens die Lebensqualität, die Talente aus aller Welt anzieht.

  Für uns besonders relevant ist die *Ostschweiz*: Mit dem *Startfeld* am Switzerland Innovation Park Ost in Rapperswil hat die Region eine eigene Anlaufstelle für Gründerinnen und Gründer — direkt angebunden an die OST. Der Kanton St. Gallen bietet zudem einen eigenen Startup-Guide unter startupguide.sg.ch.
]

// ── Folie 4 ───────────────────────────────────────────────────
#slide-box(4, "Akteure der Gründung")[
  Das Schweizer Startup-Ökosystem trägt sich durch drei Gruppen von Akteuren.

  Die erste Gruppe sind die *Gründerinnen und Gründer* selbst. Sie bringen die Idee, das technologische Know-how und die Bereitschaft, Risiken einzugehen. Erfolgreich sind vor allem jene, die nicht nur Produkte entwickeln, sondern auch führen, kommunizieren und Netzwerke aufbauen können — die Entwicklung vom Gründer zum Manager ist eine der grössten Herausforderungen im Startup-Leben.

  Die zweite Gruppe sind die *Investorinnen und Investoren*. In der Frühphase sind das vor allem *Business Angels* — Einzelpersonen, die eigenes Kapital und persönliche Erfahrung einbringen. Später kommen *Venture-Capital-Gesellschaften* dazu, die aus Fonds investieren. Entscheidend: Investoren erhalten eine Minderheitsbeteiligung, und ihr Engagement ist zeitlich begrenzt — am Ende steht immer ein Exit.

  Die dritte Gruppe ist das *unterstützende Ökosystem*: Technologie- und Gründerzentren, Förderstellen, Anwaltskanzleien, Steuerberater, Berufsverbände und Startup-Netzwerke. Sie senken die Hürden für Neugründungen und vernetzten die Szene.
]

// ── Folie 5 ───────────────────────────────────────────────────
#slide-box(5, "Phasen & Finanzierung — Early / Expansion / Later Stage")[
  Die Finanzierung eines Startups verläuft in drei klar definierten Phasen.

  Im *Early Stage* steht die Idee im Vordergrund: Pre-Seed, Seed und die eigentliche Startphase. Das Kapital kommt meist aus eigenen Mitteln, öffentlichen Förderprogrammen und ersten Business-Angel-Investitionen. In der Schweiz sind Venturelab und Venture Kick zentrale Player dieser Phase — Venture Kick allein hat seit 2007 Hunderte von Projekten mit Seed-Kapital und Coaching begleitet.

  Im *Expansion Stage* geht es ums Wachstum: zweite und dritte Finanzierungsrunden, Markterschliessung, erste grosse VC-Investitionen. Hier treten Gesellschaften wie b2venture auf den Plan.

  Im *Later Stage* schliesslich geht es um Skalierung und Exit: Börsengang an der SIX Swiss Exchange, Übernahme durch strategische Käufer oder Management-Buy-outs. Das ist die Phase, in der aus Startups etablierte Unternehmen werden — oder in der Investoren ihre Beteiligung gewinnbringend verkaufen.
]

// ── Folie 6 ───────────────────────────────────────────────────
#slide-box(6, "Ökosystem & Support — Startfeld, b2venture, Venturelab")[
  Auf dieser Folie zeigen wir die drei wichtigsten Unterstützungsorganisationen für Schweizer Startups.

  *Startfeld* ist der Switzerland Innovation Park Ost in Rapperswil — direkt angebunden an die OST, die HSG und Empa. Startfeld bietet Coaching, Infrastruktur und Seed-Kapital bis CHF 300'000. Für uns als OST-Studierende ist das die nächstgelegene und relevanteste Anlaufstelle.

  *b2venture* ist eine Early-stage Venture-Capital-Gesellschaft aus St. Gallen mit einem Netzwerk aus Business Angels. Sie investieren ab Pre-Seed und begleiten Startups bis in spätere Runden. Bekannte Investments aus ihrem Portfolio: DeepL und SumUp.

  *Venturelab* ist die nationale Plattform für Startup-Förderung — gegründet 2004, heute voll privatisiert. Sie haben über 1'000 Startups begleitet und betreiben bekannte Programme wie Venture Kick, wo Startups bis zu CHF 150'000 Seed-Kapital gewinnen können, sowie den TOP 100 Swiss Startup Award.
]

// ── Folie 7 ───────────────────────────────────────────────────
#slide-box(7, "Fazit: Beurteilung der Schweizer Start-Up Szene")[
  Abschliessend unsere Beurteilung der Schweizer Startup-Szene.

  Die Stärken liegen klar auf der Hand: Weltklasse-Forschungseinrichtungen, politische Stabilität, ein professionelles VC-Ökosystem mit internationaler Ausstrahlung und eine Spezialisierung auf Deep-Tech-Sektoren, die hohe Eintrittsbarrieren — und damit nachhaltigen Wettbewerbsvorteil — bieten.

  Die Herausforderungen sind ebenfalls klar: Die hohen Lebenshaltungskosten erhöhen den Kapitalbedarf in der Frühphase. Der kleine Heimmarkt zwingt Schweizer Startups früh zur Internationalisierung. Und FH-Absolvierende sind als Gründerinnen und Gründer noch deutlich unterrepräsentiert gegenüber ETH- und EPFL-Abgängerinnen.

  Unser persönliches Fazit: Die Schweizer Startup-Szene ist im europäischen Vergleich überdurchschnittlich stark — mit dem grössten Wachstumspotenzial in der stärkeren Einbindung von Fachhochschul-Absolvierenden sowie in der Ostschweiz, wo die OST und Startfeld gezielt Brücken zwischen Forschung und Markt bauen. Vielen Dank.
]
