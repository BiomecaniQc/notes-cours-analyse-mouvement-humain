/// Defines a TODO section that can be optionally hidden or displayed in a compact form.
/// - body (content): The content of the TODO note.
/// - hide (bool): Whether to hide the TODO note. Defaults to false. Hide almost works as a comment, but may still leave some visual artifacts.
/// - compact (bool): Whether to display the TODO note in a compact form. Defaults to false.
/// -> content
#let todo(body, header: "TODO", hide: false, color: orange, compact: false) = {
  if hide { return [] }

  let theme = (fill: color, stroke: black)

  if compact {
    box(..theme, inset: 3pt, radius: 4pt)[
      #if header != none { [*#header ---*] } #body
    ]
  } else {
    rect(..theme, inset: 10pt, radius: 12pt, align(left, [
      *#header*
      #if body != [] {
        line(length: 10%, stroke: 0.3pt)
        body
      }
    ]))
  }
}

/// Defines a section that is targetted to be revised, or has been revised
/// - body (content): The content of the note.
/// - revise (bool): Whether the section has been revised
/// -> content
#let revise(body, done: false) = todo(
  header: if done { none } else { "To confirm" },
  color: if done { green } else { yellow },
  compact: true,
)[#body]

/// Highlight a place where a reference needs to be found in the document.
/// - example (array|none): An optional example to display alongside the highlight.
/// -> content
#let ref-to-find(example: none) = {
  set text(fill: red)
  highlight()[
    (REF#if example != none {
      if type(example) != array { example = (example,) }
      [, e.g. #example.join(", ")]
    })
  ]
}
