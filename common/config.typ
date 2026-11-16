// Configuration de compilation, accessible depuis n'importe quel fichier
// (main.typ et chapitres) via `#import "../../common/lib.typ": *`.
//
// Choisie avec `--input config=configs/<nom>.toml` (voir configs/default.toml).
// Le chemin donné est relatif au dossier notes-de-cours/. Comme ce fichier-ci
// est dans common/, on remonte d'un niveau : le chemin fonctionne quel que
// soit le fichier qui importe la configuration et quelle que soit la racine
// du projet choisie par l'éditeur ou la ligne de commande.

#let _config-path = sys.inputs.at("config", default: "configs/default.toml")
#let config = toml("../" + _config-path)
