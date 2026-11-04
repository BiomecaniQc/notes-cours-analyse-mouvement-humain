/// Insère une figure vectorielle (fichier `.typ`, par ex. un dessin CeTZ)
/// comme on insérerait une image : on peut imposer sa largeur et/ou sa
/// hauteur, et tout le dessin (texte compris) est mis à l'échelle.
///
/// Le chemin doit être passé sous forme de `path(...)` et non de chaîne :
/// une chaîne serait résolue depuis ce fichier-ci (common/book-template/),
/// alors qu'un `path` reste relatif au fichier qui l'a créé (le chapitre).
///
/// Exemple :
/// ```typ
/// #figure(
///   image-like-include(path("media/choix-activites.typ"), width: 60%),
///   caption: [...],
/// )
/// ```
///
/// - source (path): fichier à inclure, créé avec `path("...")`.
/// - width (auto, length, ratio, relative): largeur voulue.
/// - height (auto, length, ratio, relative): hauteur voulue.
///   Si les deux sont fournis, le dessin tient dans la boîte en gardant ses
///   proportions (comme `fit: "contain"` pour une image).
#let scaled-include(source, width: auto, height: auto) = {
  if type(source) == str {
    panic(
      "image-like-include : passer le chemin avec path(\""
        + source
        + "\") "
        + "plutôt qu'une chaîne, sinon il est résolu depuis le gabarit.",
    )
  }

  let body = include source
  if width == auto and height == auto { return body }

  layout(size => {
    // Convertit une taille (absolue, relative ou en %) en longueur absolue
    let resolve(value, total) = {
      if value == auto { return auto }
      if type(value) == ratio { value = value + 0pt }
      if type(value) == length { value = 0% + value }
      (
        value.length.to-absolute()
          + if value.ratio == 0% { 0pt } else { value.ratio * total }
      )
    }

    let natural = measure(body)
    let w = resolve(width, size.width)
    let h = resolve(height, size.height)

    let factors = ()
    if w != auto { factors.push(w / natural.width) }
    if h != auto { factors.push(h / natural.height) }
    let factor = calc.min(..factors)

    scale(factor * 100%, reflow: true, body)
  })
}
