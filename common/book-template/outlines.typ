
/// Show the outlines
/// show-main (bool): Whether to show the main outline
/// show-figures (bool): Whether to show the figures outline
/// show-tables (bool): Whether to show the tables outline
/// show-videos (bool): Whether to show the videos outlinepage
/// -> content
#let outlines(
  show-main: true,
  show-figures: true,
  show-tables: true,
  show-videos: true,
) = [
  #if show-main {
    outline()
  }

  #if show-figures {
    outline(title: "Table des figures", target: figure.where(kind: image))
  }

  #if show-tables {
    outline(title: "Table des tableaux", target: figure.where(kind: table))
  }

  #if show-videos {
    outline(title: "Table des vidéos", target: figure.where(kind: "video"))
  }
]
