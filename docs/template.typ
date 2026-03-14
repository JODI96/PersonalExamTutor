// ============================================================
// Exam Tutor — Document Template
// ============================================================
// Reusable template for any module. Configure via show rule.

#let template(
  title: "Module Summary",
  module: "Module Name",
  author: "Student",
  doc,
) = {
  set document(title: title, author: author)

  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(9pt, fill: gray)
        #title #h(1fr) #module
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

  set text(font: "New Computer Modern", size: 11pt)
  set par(justify: true, leading: 0.7em, spacing: 1.2em)
  set heading(numbering: "1.1.")

  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1em)
    block[
      #set text(18pt, weight: "bold")
      #it.body
      #v(0.3em)
      #line(length: 100%, stroke: 1.5pt)
    ]
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.8em)
    block[
      #set text(13pt, weight: "bold")
      #it.body
    ]
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    v(0.5em)
    block[
      #set text(11pt, weight: "bold", style: "italic")
      #it.body
    ]
    v(0.1em)
  }

  // Code blocks
  show raw.where(block: true): it => {
    block(
      fill: luma(245),
      stroke: 0.5pt + luma(200),
      radius: 4pt,
      inset: 10pt,
      width: 100%,
      it,
    )
  }

  // Callout box helper (use as: #box-tip[...])
  // Title page
  align(center)[
    #v(4cm)
    #text(32pt, weight: "bold")[#title]
    #v(0.6em)
    #text(18pt, fill: gray)[#module]
    #v(1.5cm)
    #text(12pt)[#author]
    #v(0.4em)
    #text(10pt, fill: gray)[Last updated: #datetime.today().display("[day]. [month repr:long] [year]")]
    #v(4cm)
    #line(length: 70%, stroke: 1pt + gray)
  ]

  pagebreak()

  outline(
    title: [Table of Contents],
    indent: auto,
    depth: 2,
  )

  pagebreak()

  doc
}

// ── Callout boxes ──────────────────────────────────────────

#let tip-box(body) = block(
  fill: rgb("#e8f4e8"),
  stroke: 1pt + rgb("#4caf50"),
  radius: 4pt,
  inset: 10pt,
  width: 100%,
)[*Tip:* #body]

#let warn-box(body) = block(
  fill: rgb("#fff3e0"),
  stroke: 1pt + rgb("#ff9800"),
  radius: 4pt,
  inset: 10pt,
  width: 100%,
)[*Exam Trap:* #body]

#let formula-box(body) = block(
  fill: rgb("#e3f2fd"),
  stroke: 1pt + rgb("#2196f3"),
  radius: 4pt,
  inset: 10pt,
  width: 100%,
)[#body]

#let cheat-box(body) = block(
  fill: rgb("#f3e5f5"),
  stroke: 1.5pt + rgb("#9c27b0"),
  radius: 4pt,
  inset: 12pt,
  width: 100%,
)[#body]
