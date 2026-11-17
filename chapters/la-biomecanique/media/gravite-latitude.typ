#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Intensité de la gravité au niveau de la mer selon la latitude
// (formule internationale de la gravité, GRS 80) :
// g(φ) = 9.780327 (1 + 0.0053024 sin²φ − 0.0000058 sin²2φ)
#let gravity(lat) = {
  let s = calc.sin(lat * 1deg)
  let s2 = calc.sin(2 * lat * 1deg)
  9.780327 * (1 + 0.0053024 * s * s - 0.0000058 * s2 * s2)
}

#let places = (
  (0, [Singapour]),
  (15, [Dakar \ (Sénégal)]),
  (30, [Le Caire \ (Égypte)]),
  (45, [Bordeaux \ (France)]),
  (60, [Oslo \ (Norvège)]),
  (75, []),
  (90, [Village du \ Père Noël]),
)
#let gravity-value = 9.81

// Affiche un nombre avec un nombre fixe de décimales (9.8 -> "9.80")
#let fixed(value, digits) = {
  let scaled = str(int(calc.round(value * calc.pow(10, digits))))
  scaled.slice(0, -digits) + "." + scaled.slice(-digits)
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Échelles
  let (g-min, g-max, g-step) = (9.77, 9.84, 0.01)
  let (width, height) = (11, 5.5)
  let px(lat) = lat / 90 * width
  let py(g) = (g - g-min) / (g-max - g-min) * height

  let ink = palette.neutral.text
  let grid-stroke = 0.4pt + palette.neutral.line.transparentize(70%)
  let series = palette.blue

  // Grille horizontale et graduations en y
  let n = int(calc.round((g-max - g-min) / g-step))
  for i in range(n + 1) {
    let g = g-min + i * g-step
    line((0, py(g)), (width, py(g)), stroke: grid-stroke)
    content((-0.15, py(g)), anchor: "east", text(size: 8pt, fill: ink, fixed(
      g,
      2,
    )))
  }

  // Axe x : latitudes et lieux
  line((0, 0), (width, 0), stroke: 0.8pt + ink)
  for (lat, place) in places {
    line((px(lat), 0), (px(lat), -0.12), stroke: 0.8pt + ink)
    content((px(lat), -0.2), anchor: "north", align(center, {
      text(size: 9pt, fill: ink, weight: "semibold")[#lat°]
      if place != [] {
        linebreak()
        text(size: 7.5pt, fill: ink, place)
      }
    }))
  }

  // Titres des axes
  content(
    (-1.25, height / 2),
    angle: 90deg,
    text(size: 9pt, fill: ink)[Gravité (m/s#super[2])],
  )
  content((width / 2, -1.75), text(size: 9pt, fill: ink)[Latitude])

  // Valeur de référence utilisée dans les calculs
  let ref = palette.red
  line(
    (0, py(gravity-value)),
    (width, py(gravity-value)),
    stroke: (paint: ref.line, thickness: 1.2pt, dash: "dashed"),
  )
  content(
    (px(52), py(gravity-value) - 0.15),
    anchor: "north-west",
    text(
      size: 13pt,
      fill: ref.text,
      weight: "bold",
    )[$g approx #qty[#gravity-value][m/s^2]$],
  )

  // Courbe et points de mesure
  let points = places.map(((lat, _)) => (px(lat), py(gravity(lat))))
  line(..points, stroke: (paint: series.line, thickness: 2pt, join: "round"))
  for p in points {
    circle(p, radius: 0.11, fill: series.line, stroke: 1.5pt + white)
  }

  // Étiquettes directes aux extrémités seulement
  let label(lat, anchor) = content(
    (px(lat), py(gravity(lat))),
    anchor: anchor,
    padding: 0.2,
    text(size: 8.5pt, fill: series.text, fixed(gravity(lat), 3)),
  )
  label(0, "south-west")
  label(90, "south")
})
