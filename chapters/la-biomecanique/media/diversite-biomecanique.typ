#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let blue = palette.blue
  let neutral = palette.neutral
  let link-stroke = 1pt + neutral.line

  // Nœud mis en avant (chemin vers la biomécanique sportive) : boîte pastel
  let node(pos, name, body) = {
    content(
      pos,
      text(size: 11pt, fill: blue.text, weight: "semibold", body),
      padding: (x: 0.2, y: 0.12),
      name: name,
    )
    on-layer(-1, {
      rect(
        (rel: (0.06, -0.06), to: name + ".south-west"),
        (rel: (0.06, -0.06), to: name + ".north-east"),
        radius: 0.15,
        fill: palette.shadow,
        stroke: none,
      )
      rect(
        name + ".south-west",
        name + ".north-east",
        radius: 0.15,
        fill: blue.fill,
        stroke: 1.2pt + blue.line,
      )
    })
  }

  // Nœud secondaire : simple texte
  let leaf(pos, name, body) = {
    content(
      pos,
      text(size: 11pt, fill: neutral.text, body),
      padding: (x: 0.2, y: 0.12),
      name: name,
    )
  }

  // Liaison orthogonale d'un parent vers ses enfants
  let branch(parent, children, mid-y) = {
    let (px, _) = parent
    line(parent, (px, mid-y), stroke: link-stroke)
    let xs = children.map(c => c.at(0))
    line((calc.min(..xs), mid-y), (calc.max(..xs), mid-y), stroke: link-stroke)
    for c in children { line((c.at(0), mid-y), c, stroke: link-stroke) }
  }

  // Positions
  let y0 = 0
  let y1 = -1.3
  let y2 = -2.6
  let y3 = -3.9
  let y4 = -5.2
  let y5 = -6.5

  node((5.2, y0), "bio")[biomécanique]
  node((2.8, y1), "animale")[animale]
  leaf((7.4, y1), "vegetale")[végétale]
  leaf((0.4, y2), "autre")[autre]
  node((4.0, y2), "homme")[homme]
  node((8.4, y3), "sport")[sport]
  node((5.6, y4), "blessures")[blessures]
  node((8.4, y4), "performance")[performance]
  node((11.2, y4), "equipements")[équipements]
  node((6.9, y5), "theorique")[théorique]
  node((10.2, y5), "experimentale")[expérimentale]

  branch((5.2, y0 - 0.32), ((2.8, y1 + 0.32), (7.4, y1 + 0.3)), (y0 + y1) / 2)
  branch((2.8, y1 - 0.32), ((0.4, y2 + 0.3), (4.0, y2 + 0.32)), (y1 + y2) / 2)
  branch((4.0, y2 - 0.32), ((0.9, (y2 + y3) / 2), (8.4, y3 + 0.32)), (y2 + y3) / 2)
  branch(
    (8.4, y3 - 0.32),
    ((5.6, y4 + 0.32), (8.4, y4 + 0.32), (11.2, y4 + 0.32)),
    (y3 + y4) / 2,
  )
  // La performance se décline en approches théorique et expérimentale
  line((8.4, y4 - 0.32), (6.9, y5 + 0.32), stroke: link-stroke)
  line((8.4, y4 - 0.32), (10.2, y5 + 0.32), stroke: link-stroke)

  // Autres applications de la biomécanique humaine (liste)
  let items = ([réadaptation], [bio-ingénierie], [ergonomie], [etc.])
  let list-y = (y3, y3 - 0.85, y3 - 1.7, y3 - 2.55)
  line((0.9, (y2 + y3) / 2), (0.9, list-y.last()), stroke: link-stroke)
  for (i, body) in items.enumerate() {
    line((0.9, list-y.at(i)), (1.2, list-y.at(i)), stroke: link-stroke)
    content((1.3, list-y.at(i)), anchor: "west", text(
      size: 11pt,
      fill: neutral.text,
      body,
    ))
  }
})
