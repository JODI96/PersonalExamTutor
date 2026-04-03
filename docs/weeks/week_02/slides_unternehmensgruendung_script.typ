// ============================================================
// Sprechernotizen: Unternehmensgründung & Geschäftsmodelle
// DigiBusI FS26 — Woche 2
// Build: typst compile docs/weeks/week_02/slides_unternehmensgruendung_script.typ output/slides_unternehmensgruendung_script.pdf
// ============================================================

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(9pt, fill: gray)
      Sprechernotizen — Unternehmensgründung & Geschäftsmodelle #h(1fr) DigiBusI FS26
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
  #text(14pt, fill: gray)[Unternehmensgründung & Geschäftsmodelle — Übungsaufgabe DigiBusI FS26]
  #v(0.3em)
  #text(10pt, fill: gray)[~7 Minuten · 6 Folien · ca. 60–70 Sekunden pro Folie]
  #v(1cm)
  #line(length: 60%, stroke: 1pt + gray)
]

#v(1.5cm)

// ── Folie 1 ───────────────────────────────────────────────────
#slide-box(1, "Titelfolie")[
  Guten Tag. Wir präsentieren heute unsere Übungsaufgabe zu *Unternehmensgründung und Geschäftsmodellen* aus der Vorlesung Digitale Plattformen und Ökosysteme.

  Im Zentrum stehen zwei Analysetools, die wir in der Vorlesung kennengelernt haben: die *PESTL-Analyse* zur systematischen Umfeldbetrachtung — und der *Business Model Stress Test*, mit dem wir prüfen, ob ein Geschäftsmodell gegenüber konkreten Entwicklungen stabil ist.

  Als Fallbeispiel nutzen wir *Spotify*, da es ein gut verstandenes, digitales Geschäftsmodell mit klarer Plattformlogik ist.
]

// ── Folie 2 ───────────────────────────────────────────────────
#slide-box(2, "Resilienz von Geschäftsmodellen")[
  Bevor wir zu den Analysetools kommen, kurz die Ausgangsfrage: Warum müssen wir Geschäftsmodelle überhaupt auf Resilienz prüfen?

  Die Antwort lautet: Weil jedes Geschäftsmodell in einem bestimmten Umfeld entstanden ist — und dieses Umfeld sich verändert. Was heute funktioniert, kann morgen durch Regulierung, Technologiewandel oder gesellschaftliche Verschiebungen fundamental erschüttert werden.

  Kollmann formuliert es klar: Ein Geschäftsmodell beschreibt, wie ein Unternehmen Wert schafft, liefert und erfasst. Aber das reicht nicht — es muss auch zeigen, wie es auf Veränderungen *reagiert*.

  Für diese Prüfung nutzen wir zwei komplementäre Tools: die *PESTL-Analyse* für den breiten Umfeldscan, und den *Business Model Stress Test* für gezielte Szenarioanalysen.
]

// ── Folie 3 ───────────────────────────────────────────────────
#slide-box(3, "PESTL-Analyse — 6 Dimensionen")[
  Die PESTL-Analyse ist ein klassisches Strategiewerkzeug, das externe Einflussfaktoren systematisch in sechs Dimensionen gliedert.

  *P* steht für Politisch: Welche staatlichen Eingriffe, Regulierungen oder Steuerpolitiken betreffen das Unternehmen? Beispiel: der Digital Markets Act der EU.

  *E* steht für Ökonomisch: Wie wirken Konjunktur, Zinsen und Kaufkraft? Für Startups besonders relevant ist das VC-Finanzierungsklima.

  *S* steht für Sozial: Werte, Demografie und Nutzerverhalten — zum Beispiel der Trend zu Remote Work oder der Creator Economy.

  *T* steht für Technologisch: Innovationen und Disruption — KI, Cloud oder 5G als aktuelle Treiber.

  *L* steht für Rechtlich: Urheberrecht, Datenschutz, Haftungsfragen — besonders relevant im Streaming-Bereich.

  Und das zweite *E* steht für Ökologisch: Klimaziele, Nachhaltigkeit und ESG-Berichtspflichten.

  Entscheidend: Die PESTL-Analyse liefert keine Handlungsempfehlungen — sie systematisiert zuerst, was *existiert*.
]

// ── Folie 4 ───────────────────────────────────────────────────
#slide-box(4, "PESTL-Analyse — Beispiel Spotify")[
  Wenden wir die PESTL-Analyse auf Spotify an.

  *Politisch und rechtlich*: Spotify operiert in einem hochregulierten Lizenzumfeld. Die EU-Urheberrechtsreform von 2021 hat die Lizenzkosten erhöht. Gleichzeitig verpflichtet die DSGVO zu striktem Datenschutz — bei einem Dienst, der Hörverhalten, Standorte und Stimmungen auswertet, ist das besonders relevant.

  *Ökonomisch*: Spotify verdient primär über Abonnements. In wirtschaftlich schwierigen Zeiten kündigen Nutzer Abos — das macht das Modell konjunkturabhängig. Zusätzlich entstehen rund 70 Prozent der Kosten durch Musiklizenzgebühren, die in US-Dollar abgerechnet werden — ein erhebliches Währungsrisiko für einen schwedischen Anbieter.

  *Sozial und technologisch*: Der Trend zu Podcasts und Hörbüchern spielt Spotify in die Hände — der Dienst hat sein Portfolio gezielt erweitert. KI-Empfehlungsalgorithmen sind ein zentrales Differenzierungsmerkmal.

  *Ökologisch*: Streaming verbraucht erheblich Energie. ESG-Druck und Nachhaltigkeitsberichtspflichten werden für Spotify relevanter — der Dienst hat sich Ziele für erneuerbare Energie bis 2030 gesetzt.

  Das Fazit der PESTL-Analyse: Spotify ist in einem dynamischen Regulierungs- und Technologieumfeld — mit klaren Chancen, aber auch strukturellen Risiken.
]

// ── Folie 5 ───────────────────────────────────────────────────
#slide-box(5, "Business Model Stress Test — Konzept")[
  Der Business Model Stress Test geht einen Schritt weiter als die PESTL-Analyse: Er prüft nicht nur, *was* im Umfeld existiert, sondern *wie robust* das Geschäftsmodell gegenüber konkreten Entwicklungen ist.

  Die Methodik ist dreigliedrig: Erstens definiert man drei plausible — also nicht extreme, sondern realistisch mögliche — Entwicklungen im Umfeld. Zweitens analysiert man, wie jede dieser Entwicklungen das Geschäftsmodell konkret trifft. Und drittens bewertet man die Resilienz: Ist das Modell in diesem Szenario stabil, anpassungsfähig — oder gefährdet?

  Die Analogie zum Bankwesen hilft: Genau wie die Aufsichtsbehörden Bankbilanzen auf Extremszenarien testen, um systemische Risiken zu erkennen, testen wir Geschäftsmodelle auf externe Schocks.

  Der grosse Vorteil: Der Stress Test zwingt zu konkreten, spezifischen Aussagen — statt vager Risikobeschreibungen.
]

// ── Folie 6 ───────────────────────────────────────────────────
#slide-box(6, "Business Model Stress Test — Beispiel Spotify")[
  Wir testen Spotify mit drei konkreten Entwicklungen.

  *Erste Entwicklung: KI generiert Musik ohne Labels.* Wenn Künstliche Intelligenz qualitativ hochwertige Musik erzeugt, könnten Majors umgangen werden — Lizenzkosten würden sinken. Das klingt positiv für Spotify, birgt aber ein Reputationsrisiko: Künstlerboykotte und Nutzerproteste gegen KI-Musik sind realistisch. *Bewertung: ambivalent.*

  *Zweite Entwicklung: Apple und Google erzwingen eine 30-Prozent-App-Store-Gebühr.* Das ist das kritischste Szenario. Spotify ist auf iOS und Android angewiesen — ein erzwungener 30-Prozent-Aufschlag auf Abo-Einnahmen würde die Marge auf Mobilgeräten halbieren. Spotify hat bereits rechtlich gegen Apple gekämpft, aber die strukturelle Plattformabhängigkeit bleibt bestehen. *Bewertung: kritisch.*

  *Dritte Entwicklung: EU-Gesetz verpflichtet zu fairer Künstlervergütung.* Steigende Lizenzkosten zwingen Spotify zu Preiserhöhungen oder zur Einschränkung des Free-Tiers. Angesichts der Marktmacht — Spotify hat über 600 Millionen Nutzer — hat der Dienst jedoch Spielraum für Preisanpassungen. *Bewertung: moderat.*

  Das war unser Business Model Stress Test für Spotify. Der zentrale Befund: Die App-Store-Abhängigkeit ist das strukturell grösste Risiko — und liegt ausserhalb der PESTL-Analyse, die Regulierungen eher allgemein erfasst. Genau hier zeigt sich der Mehrwert des kombinierten Einsatzes beider Tools. Vielen Dank.
]
