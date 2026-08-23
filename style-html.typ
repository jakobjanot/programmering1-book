// HTML-specific book styling. Typst's HTML export does not support paged
// constructs (set page, pagebreak, page()), so this is a separate, simpler
// template used only for the website build. The PDF still uses style.typ.

#let book(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  body,
) = {
  set document(title: title, author: author)

  set text(lang: "da")

  set heading(numbering: "1.1")

  // Link to the external stylesheet (copied alongside index.html by `just html`)
  html.elem("link", attrs: (rel: "stylesheet", href: "style.css"))

  // Configure code blocks
  show raw.where(block: true): it => {
    html.elem("pre", attrs: (class: "code-block"), it)
  }

  // Configure inline code
  show raw.where(block: false): it => {
    html.elem("code", it)
  }

  // Title page
  align(center)[
    #v(2cm)
    #text(size: 2.2em, weight: "bold")[#title]
    #v(0.5cm)
    #if subtitle != none [
      #text(size: 1.3em)[#subtitle]
      #v(1cm)
    ]
    #text(size: 1.1em)[#author]
    #v(0.5cm)
    #if date != none [
      #text(size: 1em, style: "italic")[Bygget: #date.display("[day].[month].[year]")]
    ]
    #v(1cm)
  ]

  // Link to the PDF download
  align(center)[
    #link("programmering1-java.pdf")[Download som PDF]
  ]

  v(1cm)

  // Table of contents
  outline(depth: 2, indent: 1em)

  v(1cm)

  // Main content
  body
}

// Helper function for exercises
#let exercise(title: none, body) = {
  block(
    width: 100%,
    fill: rgb("#e8f4fd"),
    stroke: rgb("#1f77b4"),
    radius: 6pt,
    inset: 12pt,
  )[
    #if title != none [
      #text(weight: "bold", size: 12pt)[Øvelse: #title]
      #v(0.5em)
    ]
    #body
  ]
}

// Helper function for notes
#let note(body) = {
  block(
    width: 100%,
    fill: rgb("#fff3cd"),
    stroke: rgb("#ffc107"),
    radius: 6pt,
    inset: 12pt,
  )[
    #text(weight: "bold")[Note: ]
    #body
  ]
}
