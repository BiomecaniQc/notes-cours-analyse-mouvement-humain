// Palette de couleurs commune aux figures du livre.
//
// Chaque teinte propose trois nuances :
//   - fill : fond pastel (intérieur des boîtes)
//   - line : teinte soutenue (contours, flèches)
//   - text : teinte foncée (texte posé sur le fond pastel)
//
// Utilisation : `palette.green.line`, `palette.red.fill`, etc.

#let _shade(fill, line) = (fill: rgb(fill), line: rgb(line), text: rgb(line).darken(30%))

#let palette = (
  green: _shade("#e3f4e1", "#2e7d32"),
  red: _shade("#fde4e1", "#c62828"),
  gold: _shade("#fff4c9", "#c49000"),
  blue: _shade("#e3e8fa", "#2f3fa0"),
  neutral: _shade("#f4f4f4", "#616161"),
  dark: (fill: rgb("#263238"), line: rgb("#000000"), text: white),
  shadow: black.transparentize(88%),
)
