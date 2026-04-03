// ============================================================
// Sprechernotizen: Digital Platform Map
// DigiBusI FS26 — Woche 1
// Build: typst compile docs/weeks/week_01/slides_digital_platform_map_script.typ output/slides_digital_platform_map_script.pdf
// ============================================================

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(9pt, fill: gray)
      Sprechernotizen — Digital Platform Map #h(1fr) DigiBusI FS26
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
  #text(14pt, fill: gray)[Digital Platform Map — Übungsaufgabe DigiBusI FS26]
  #v(0.3em)
  #text(10pt, fill: gray)[~5 Minuten · 6 Folien · ca. 50 Sekunden pro Folie]
  #v(1cm)
  #line(length: 60%, stroke: 1pt + gray)
]

#v(1.5cm)

// ── Folie 1 ───────────────────────────────────────────────────
#slide-box(1, "Titelfolie")[
  Guten Tag. Wir präsentieren heute unsere Übungsaufgabe zur *Digital Platform Map* aus der Vorlesung Digitale Plattformen und Ökosysteme.

  Wir schauen uns an, was eine digitale Plattform überhaupt ist, welche sechs Typen die Digital Platform Map unterscheidet — und gehen dann zwei dieser Typen im Detail durch: den Marktplatz am Beispiel Amazon und die Community-Plattform am Beispiel LinkedIn.
]

// ── Folie 2 ───────────────────────────────────────────────────
#slide-box(2, "Was ist eine Digitale Plattform?")[
  Bevor wir uns die Typen anschauen, kurz die Grundlage: Was ist eine digitale Plattform überhaupt?

  Die einfachste Definition lautet: Eine Plattform bringt zwei oder mehr Seiten zusammen und ermöglicht direkte Interaktionen zwischen ihnen. Das heisst, eine Plattform produziert selbst keinen Wert — sie *ermöglicht* ihn, indem sie Anbieter und Nachfrager verbindet.

  Das Grundprinzip ist das sogenannte *Many-to-many*: viele Anbieter treffen auf viele Kunden — über eine zentrale Infrastruktur.

  Neben Anbietern und Kunden gibt es noch den *Plattformbetreiber*, der die Regeln und die Infrastruktur stellt, sowie sogenannte *Plattform-Enabler* — zum Beispiel Zahlungsdienstleister, die den Betrieb erst möglich machen.
]

// ── Folie 3 ───────────────────────────────────────────────────
#slide-box(3, "Die Digital Platform Map — 6 Typen")[
  Die *Digital Platform Map* — entwickelt von der TIAS Business School — unterscheidet sechs Typen digitaler Plattformen. Der entscheidende Unterschied zwischen den Typen ist immer die *Art des Austauschs*, der über die Plattform stattfindet.

  Erstens der *Marktplatz*, bei dem Güter zwischen Käufern und Verkäufern ausgetauscht werden — Amazon, eBay, Zalando.

  Zweitens die *Suchplattform*, die Informationsangebot und -nachfrage vermittelt — zum Beispiel Google oder Booking.com.

  Drittens das *Repository*, ein virtuelles Archiv, in dem Inhalte gespeichert und später abgerufen werden — YouTube, GitHub oder Spotify.

  Viertens die *Kommunikationsplattform*, bei der der Austausch von Nachrichten im Vordergrund steht — WhatsApp, Slack oder Teams.

  Fünftens die *Community-Plattform*, die auf langfristige Vernetzung von Teilnehmern setzt — LinkedIn, Instagram oder Reddit.

  Und sechstens die *Zahlungsplattform*, die rein die Abwicklung von Transaktionen übernimmt — PayPal, Twint oder Stripe.
]

// ── Folie 4 ───────────────────────────────────────────────────
#slide-box(4, "Typ 1: Marktplatz — Beispiel Amazon")[
  Den ersten Typ, den Marktplatz, schauen wir uns am Beispiel von Amazon an.

  Ein Marktplatz funktioniert als *zweiseitiger Markt*: auf der einen Seite die Käufer, auf der anderen die Verkäufer — verbunden durch die Plattform. Die Plattform übernimmt dabei die Rolle des *Gatekeepers*: Sie kontrolliert, wer sichtbar ist, wie Vertrauen aufgebaut wird — zum Beispiel durch Bewertungen — und welche Regeln gelten.

  Das Besondere am Marktplatz ist, dass er kein eigenes Inventar braucht. Amazon lagert nicht alle Produkte selbst — das macht ihn extrem skalierbar.

  Die Netzwerkeffekte sind hier *indirekt*: mehr Verkäufer ziehen mehr Käufer an, die wiederum mehr Verkäufer anziehen.

  Bei Amazon konkret: Über die Hälfte der verkauften Produkte kommen von externen Drittanbietern. Diese nutzen *Seller Central* zur Verwaltung und optional *Fulfillment by Amazon* — kurz FBA — bei dem Amazon Lager, Versand und Retouren komplett übernimmt. Das schafft einen starken Lock-in: Wer einmal in FBA integriert ist, wechselt kaum mehr.
]

// ── Folie 5 ───────────────────────────────────────────────────
#slide-box(5, "Typ 5: Community-Plattform — Beispiel LinkedIn")[
  Als zweiten Typ betrachten wir die Community-Plattform — am Beispiel LinkedIn.

  Der zentrale Unterschied zum Marktplatz: Hier findet kein Güteraustausch statt. Der Fokus liegt auf *langfristiger Vernetzung*. Der Wert entsteht durch Beziehungen, geteiltes Wissen und aufgebaute Reputation — also durch soziales Kapital.

  Die Netzwerkeffekte sind hier *direkt*: je mehr Mitglieder mitmachen, desto grösser ist der Nutzen für jeden einzelnen. Ein Profil ohne Kontakte hat kaum Wert — mit einem grossen Netzwerk steigt die eigene Sichtbarkeit enorm.

  Das führt zu einer klassischen *Winner-takes-all-Dynamik*: Am Ende dominiert eine Plattform pro Nische.

  LinkedIn hat heute über eine Milliarde Mitglieder und verdient hauptsächlich über drei Kanäle: *LinkedIn Premium* — also Abo-Modelle für Jobsuchende und Verkäufer — *LinkedIn Recruiter* als spezialisiertes HR-Tool und *LinkedIn Ads*, die extrem präzises B2B-Targeting erlauben, weil LinkedIn Beruf, Branche und Seniority der Nutzer kennt.

  Der Lock-in ist stark: Wer sein Netzwerk, seine Empfehlungen und seine Beiträge aufgebaut hat, wechselt die Plattform nicht mehr.
]

// ── Folie 6 ───────────────────────────────────────────────────
#slide-box(6, "Vergleich: Marktplatz vs. Community-Plattform")[
  Abschliessend der direkte Vergleich der beiden Typen.

  Der grundlegendste Unterschied: Der Marktplatz ermöglicht einen *transaktionalen* Austausch — also einmalige Gütertransaktionen. Die Community-Plattform dagegen einen *relationalen* Austausch — dauerhafte Beziehungen.

  Die Netzwerkeffekte wirken unterschiedlich: beim Marktplatz *indirekt* zwischen den zwei Seiten, bei der Community *direkt* innerhalb derselben Nutzergruppe.

  Beide erzielen Einnahmen über Werbung, aber mit unterschiedlichen Schwerpunkten: Amazon über Provisionen und Fulfillment, LinkedIn über Abonnements und Recruiting-Tools.

  Und beide haben einen starken Lock-in — Amazon durch die Bewertungshistorie und FBA-Integration der Händler, LinkedIn durch das soziale Kapital der Nutzer.

  Das war unsere Präsentation zur Digital Platform Map. Vielen Dank.
]
