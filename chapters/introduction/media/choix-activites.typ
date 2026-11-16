#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  let green = palette.green
  let red = palette.red
  let gold = palette.gold
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

  node((0, 3), (3.2, 5.8), green, "banque")[banque \ d'exercices]
  node((4.6, 3), (7.8, 5.8), red, "analyse")[analyse du \ mouvement]
  node((2.4, -0.1), (5.4, 1.1), gold, "selection")[sélection]

  // Démarche par la banque d'exercices seule (pointillés) : effleure la sélection
  let dotted = (
    paint: green.line,
    thickness: 1.4pt,
    dash: "loosely-dotted",
    cap: "round",
  )
  bezier((1.4, 2.95), (3.9, 1.3), (1.8, 1.8), (3.0, 1.3), stroke: dotted)
  bezier(
    (3.9, 1.3),
    (6.4, 2.4),
    (4.9, 1.3),
    (5.8, 1.6),
    stroke: dotted,
    mark: (end: "stealth", fill: green.line, stroke: green.line, scale: 2.2),
  )

  // Démarche guidée par l'analyse du mouvement (trait plein) :
  // part de l'analyse, traverse la banque, aboutit à la sélection.
  let main-path = (
    (6.6, 5.4),
    (3.75, 1.3),
    (1.9, 5.7),
    (2.9, 2.6),
  )
  // Halo blanc pour détacher la flèche des boîtes qu'elle traverse
  bezier(..main-path, stroke: (paint: white, thickness: 5pt, cap: "round"))
  bezier(
    ..main-path,
    stroke: (paint: red.line, thickness: 2.4pt, cap: "round"),
    mark: (end: "stealth", fill: red.line, stroke: red.line, scale: 2.2),
  )
  circle((6.6, 5.4), radius: 0.09, fill: red.line, stroke: none)
})
