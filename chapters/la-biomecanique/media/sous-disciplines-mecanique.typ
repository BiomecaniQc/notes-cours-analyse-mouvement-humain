#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  import cetz.decorations: brace

  let radius = 0.25

  let node(a, b, shade, name, body) = {
    // Ombre portée légère
    rect(
      (a.at(0) + 0.08, a.at(1) - 0.08),
      (b.at(0) + 0.08, b.at(1) - 0.08),
      radius: radius,
      fill: palette.shadow,
      stroke: none,
    )
    rect(
      a,
      b,
      radius: radius,
      fill: shade.fill,
      stroke: 1.2pt + shade.line,
      name: name,
    )
    content(name, align(center, text(
      size: 11pt,
      fill: shade.text,
      weight: "semibold",
      body,
    )))
  }

  let brace-stroke = 1.4pt + palette.neutral.line

  // Cinématique + géométrie des masses = cinétique
  node((0, 6), (3.4, 7.6), palette.gold, "cinematique")[Cinématique]
  node((3.8, 6), (7.2, 7.6), palette.neutral, "geometrie")[Géométrie \ des masses]
  brace((7.2, 5.75), (0, 5.75), amplitude: 0.5, stroke: brace-stroke)

  // Cinétique + forces = dynamique
  node((1.8, 3.4), (5.4, 4.8), palette.green, "cinetique")[Cinétique]
  node((8.2, 3.4), (11.6, 4.8), palette.red, "force")[Force]
  brace((11.6, 3.15), (1.4, 3.15), amplitude: 0.5, stroke: brace-stroke)

  node((4.8, 0.8), (8.2, 2.2), palette.dark, "dynamique")[Dynamique]
})
