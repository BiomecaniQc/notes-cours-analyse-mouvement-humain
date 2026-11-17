#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  let axis(from, to, shade, label, label-anchor) = {
    line(
      from,
      to,
      stroke: (paint: shade.line, thickness: 1.6pt, cap: "round"),
      mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.4),
      name: "axis",
    )
    content("axis.end", anchor: label-anchor, padding: 0.15, text(
      size: 12pt,
      fill: shade.text,
      label,
    ))
  }

  // Repère (x, y en perspective cavalière, z vers le haut)
  axis((-0.6, 0), (7, 0), palette.red, $x$, "north-east")
  axis((-0.25, -0.25), (2.4, 2.4), palette.green, $y$, "south-west")
  axis((0, -0.5), (0, 5.5), palette.blue, $z$, "south-east")

  // Objet : cube vu en perspective cavalière
  let (x0, y0) = (4, 3.6) // coin inférieur gauche de la face avant
  let side = 1.2
  let (dx, dy) = (0.45, 0.4) // décalage de profondeur
  let edge = 1pt + palette.dark.line

  rect((x0, y0), (x0 + side, y0 + side), fill: rgb("#455a64"), stroke: edge)
  line(
    (x0, y0 + side),
    (x0 + side, y0 + side),
    (x0 + side + dx, y0 + side + dy),
    (x0 + dx, y0 + side + dy),
    close: true,
    fill: rgb("#78909c"),
    stroke: edge,
  )
  line(
    (x0 + side, y0),
    (x0 + side + dx, y0 + dy),
    (x0 + side + dx, y0 + side + dy),
    (x0 + side, y0 + side),
    close: true,
    fill: rgb("#263238"),
    stroke: edge,
  )

  // Poids : appliqué au centre de gravité, vertical vers le bas
  let g = (x0 + side / 2, y0 + side / 2)
  line(
    g,
    (g.at(0), 1.4),
    stroke: (paint: black, thickness: 2.4pt),
    mark: (end: "stealth", fill: black, stroke: black, scale: 1.6),
    name: "poids",
  )
  circle(g, radius: 0.09, fill: white, stroke: 1pt + black)
  content(
    ("poids.start", 60%, "poids.end"),
    anchor: "west",
    padding: 0.2,
    text(size: 12pt, $arrow(P)$),
  )
})
