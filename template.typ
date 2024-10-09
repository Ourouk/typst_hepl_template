// In file top level sit the global variables that need to be exported
// (they need to be used outside the template settings),
// as well as the main template setting function, named `project`.

// Save font families.
#let main-font = "STIX Two Text"
#let sans-font = "Source Sans Pro"
#let mono-font = "Inconsolata"

//Based on color scheme of the official https://hepl.be/themes/custom/hepl/css/module.css?s8sgmk
#let HEPLColors = (
  beige-super-pale:   rgb("#e8e8e3"),
  rouge-prv:          rgb("#CC0033"),
  jaune-prv:          rgb("#F6A800"),
  jaune-fonce-hepl:   rgb("#be7f00"),
  bleu-hepl:          rgb("#0080a0"),
  bleu-clair-hepl:    rgb("#8abcc8"),
  bleu-clair-darker-hepl:    rgb("#294e57"),
  bleu-fonce-hepl:    rgb("#002b4f"),
)

// Uliège colors (from official graphic chart).
#let Uliege = (
  TealDark:  rgb(000, 112, 127),
  TealLight: rgb(095, 164, 176),
  // Beige gray scale.
  BeigeLight: rgb(232, 226, 222),
  BeigePale:  rgb(230, 230, 225),
  BeigeDark:  rgb(198, 192, 180),
  // Faculty colors.
  Yellow:        rgb(255, 208, 000),
  OrangeLight:   rgb(248, 170, 000),
  OrangeDark:    rgb(240, 127, 060),
  Red:           rgb(230, 045, 049),
  GreenPale:     rgb(185, 205, 118),
  GreenLight:    rgb(125, 185, 040),
  Green:         rgb(040, 155, 056),
  GreenDark:     rgb(000, 132, 059),
  BlueLight:     rgb(031, 186, 219),
  BlueDark:      rgb(000, 092, 169),
  LavenderDark:  rgb(091, 087, 162),
  LavenderLight: rgb(141, 166, 214),
  PurpleLight:   rgb(168, 088, 158),
  PurpleDark:    rgb(091, 037, 125),
  GrayDark:      rgb(140, 139, 130),
  GrayLight:     rgb(181, 180, 169),
)

// The project function defines how your document looks.
// It takes your content and some metadata and formats rest.
#let project(
  title: "Title of the document",
  course-title: none,
  abstract: none,
  authors: (),
  date: datetime.today(),
  paper-size: "a4",
  twocols: false,  // TODO: implement this.
  bibliography-file: none,
  body,
) = {
  
  // Document's basic properties.
  set document(author: authors.map(author => author.first-name + author.last-name), title: title)


  // Paper and margins
  let headsize = 0.95em  // TODO: get true head height.
  set page(
    paper: paper-size,
    margin:
      if twocols == true {
        (x: 1.5cm, top: 2cm+headsize, bottom: 1.5cm)
      } else {
        (x: 3cm, top: 2cm+headsize, bottom: 2cm)
      },
    header-ascent: 35%,
  )

  // Font families.
  let font-size = 11pt
  if twocols == true {font-size = 10pt}
  set text(
    font: main-font,
    size: font-size,
    lang: "en",
    number-type: "old-style",
    number-width: "proportional")
  show raw: set text(font: mono-font, size: font-size)
  set raw(tab-size: 4)

  // Math settings.
  show math.equation: set text(font: "STIX Two Math")
  set math.equation(numbering: "(1.1)")

  // Header.
  set page(
  header: locate(loc => {
    set text(font: sans-font, size: headsize, fill: Uliege.GrayDark)

    // Right header: page numbering
    let thisPage = counter(page).display()
    let totalPages = [#counter(page).final(loc).at(0)]
    let pageNumbering = thisPage + " \u{2022} " + totalPages

    // Left header: section number and title
    let elems = query(
      selector(heading.where(level: 1)).before(loc),
      loc,
    )
    let sectionNum = none
    let sectionTitle = none
    let sectionHeader = none
    if elems != () {
      sectionTitle = elems.last().body
      if elems.last().numbering == none {
        sectionHeader = sectionTitle
      } else {
        sectionNum = counter(heading.where(level: 1)).display()
        sectionHeader = sectionNum + " \u{2022} " + sectionTitle
      }
    }

    // Build the complete header.
    sectionHeader + h(1fr) + pageNumbering
  }),
  )



  // Paragraphs.
  set par(
    leading: 0.8em,
    first-line-indent: 1.8em,
    justify: true,
    linebreaks: "optimized",
  )
  show par: set block(spacing: 0.8em)

  // Headings.
  set heading(numbering: "1.1")
  show heading: set text(font: sans-font, fill: Uliege.TealDark)
  show heading: rest => {
    if rest.level == 1 {
      text(size:1.10em, weight: "semibold")[#rest]
    } else if rest.level == 2 {
      text(size:1.05em, weight: "semibold")[#rest]
    } else if rest.level == 3 {
      text(size:1.03em, weight: "regular")[#rest]
    } else if rest.level > 3 {  // Set run-in subheadings, starting at level 4.
      parbreak()
      text(font: sans-font, fill: Uliege.TealDark, weight: "semibold")[#rest.body ---]
    } else {
      rest
    }
  }


// TODO: Size ajustement if more authors
place(top + center, dy: -2.4cm ,
  rect(
    fill: HEPLColors.beige-super-pale,
    width: 140%,
    height: 5.5cm + 0.3cm * calc.min(3, authors.len())
  )
)

// Teal top right triangle.
place(top + right, dx: 6cm, dy: -5.5cm,
  rotate(30deg,
    polygon.regular(
      fill:HEPLColors.rouge-prv,
      size: 9cm,
      vertices: 5,
    )
  )
)

// Faculty logo.
place(top + left, dy: -1cm)[
    #image("figures/g2.svg", height: 1.25cm)
  ]
v(1.5cm)
// Title and course. + academic year
box(width: 100%,columns(2, gutter: 11pt)[
              #align(left)[
              // Determine the academic year.
              #v(0.25cm, weak: true)
              #let this_year = date.year()
              #if date.month() < 9 [Année Académique #{this_year - 1} -- #this_year] else [Année Académique #this_year -- #(this_year+ 1)]
              \
                // Report course
                #text(size: 1.4em, fill: HEPLColors.bleu-fonce-hepl, weight: "semibold")[
                  #course-title :
              ] \
              #text(size: 1.8em, fill:  HEPLColors.bleu-clair-darker-hepl, weight: "semibold")[
                #title
              ]
        ]

      #colbreak()

      #set par(justify: false)
      #grid(
        rows: (0.25cm) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(
            center,
            [
              #author.first-name #smallcaps(author.last-name)  \
              #author.cursus
            ]
          ) + v(0.5cm),
        )
      )
  ]
)


  // Abstract.
  if abstract != none {
    block(
      width: 100%,
      fill: Uliege.TealDark.lighten(90%),
      inset: 2em,
      below: 2em,
      par(first-line-indent: 0em)[
        #text(font: sans-font, fill: Uliege.TealDark, weight: "semibold")[Abstract]
        #linebreak()
        #abstract
      ]
    )
  }

  // Rest of document in two columns, if desired.
  show: rest => {
    if twocols == true {
      show: columns.with(2, gutter: 2em)
      rest
    } else {
      rest
    }
  }
  outline(indent: auto,title: "Table des matières")
  pagebreak()
  // Document main body.
  body
  // Print the bibliography.
  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(0.9em)
    bibliography(bibliography-file, full: false, style: "ieee",title: "Bibliographie")
  }
}
