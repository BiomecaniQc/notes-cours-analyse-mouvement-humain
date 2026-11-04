# Notes de cours — Analyse du mouvement humain par la biomécanique

Notes de cours rédigées en [Typst](https://typst.app).
Chaque enseignant peut compiler sa propre version (ordre des chapitres, chapitres retirés) sans modifier les fichiers partagés.

## Structure

```
main.typ                 Point d'entrée du document
chapters/<nom>/main.typ  Un dossier par chapitre ou annexe
chapters/<nom>/media/    Images et autres médias du chapitre
configs/default.toml     Ordre des chapitres par défaut (partagé)
configs/<nom>.toml       Configurations personnelles (voir plus bas)
common/                  Gabarit du livre et variables communes
.vscode/                 Réglages VS Code par défaut
```

## Première installation

1. Installer [Typst](https://github.com/typst/typst#installation).
2. Dans VS Code, installer l'extension **Tinymist Typst** (aperçu, formatage).
3. Copier les réglages VS Code par défaut :

   ```bash
   cp .vscode/settings.json.default .vscode/settings.json
   ```

   `.vscode/settings.json` est ignoré par Git : vous pouvez le modifier librement sans affecter vos collègues.
4. Créer votre configuration personnelle (étape suivante), puis dans `.vscode/settings.json`, remplacer `<name>` par votre nom dans la ligne :

   ```json
   "tinymist.typstExtraArgs": ["--input", "config=configs/<name>.local.toml"]
   ```

   Si vous utilisez simplement l'ordre par défaut, supprimez plutôt cette ligne.
   **Attention :** si le fichier indiqué n'existe pas, l'aperçu échouera.
5. **Redémarrer Tinymist** après toute modification de `settings.json` (`Ctrl+Shift+P` → « Typst: Restart Server », ou « Developer: Reload Window »).
   Sans redémarrage, la configuration choisie peut être ignorée.
   De même, après avoir changé le fichier TOML visé par `typstExtraArgs`, fermer puis rouvrir l'aperçu : un aperçu déjà ouvert conserve l'ancienne configuration.

   Ne pas définir `tinymist.rootPath` : la valeur `"-"` est refusée par Tinymist et bloque l'application de **tous** les réglages.
   Les imports étant relatifs (voir « Ajouter un chapitre »), la racine par défaut convient.

## Choisir l'ordre et les chapitres

L'ordre du document est défini dans un fichier TOML :

```toml
chapters = [
  "preliminary-informations",
]

annexes = [
  "interesting-web-pages",
]
```

Chaque nom correspond à un dossier de `chapters/`.
L'ordre de la liste est l'ordre dans le document ; retirer un nom exclut le chapitre.

Pour créer votre version, copiez `configs/default.toml` :

| Fichier                    | Versionné par Git ? | Usage                                     |
|----------------------------|---------------------|-------------------------------------------|
| `configs/default.toml`     | oui                 | Ordre officiel, modifié avec concertation |
| `configs/<nom>.toml`       | oui                 | Votre version, visible par les collègues  |
| `configs/<nom>.local.toml` | non                 | Votre version privée                      |

Chacun ne modifie que son propre fichier : il n'y a donc jamais de conflit Git entre les configurations.

## Compiler

```bash
# Ordre par défaut
typst compile main.typ

# Votre configuration
typst compile main.typ --input config=configs/<nom>.local.toml
```

Le PDF est produit à côté de `main.typ` (les PDF sont ignorés par Git).

Toujours compiler `main.typ` : les chapitres se référencent entre eux et ne peuvent pas être compilés seuls.
Dans VS Code, épingler `main.typ` comme fichier principal (`Ctrl+Shift+P` → « Typst: Pin the Main file to the currently opened document » depuis `main.typ`) pour que l'aperçu reste sur le document complet pendant l'édition d'un chapitre.

## Ajouter un chapitre

1. Créer `chapters/<nouveau-chapitre>/main.typ`, en commençant par des imports **relatifs** (jamais `"/common/..."`, qui dépend de la racine choisie) :

   ```typst
   #import "../../common/lib.typ": *
   ```
2. Placer tous les médias du chapitre (images, figures, vidéos, etc.) dans `chapters/<nouveau-chapitre>/media/`, et les référencer avec un chemin relatif :

   ```typst
   #image("media/ma-figure.png")
   ```

   Un chapitre reste ainsi autonome : il peut être déplacé, retiré d'une configuration ou partagé sans briser les liens vers ses médias.
3. L'ajouter à `configs/default.toml`.
4. Prévenir les collègues : un chapitre absent de leur propre configuration n'apparaîtra pas dans leur version (sans message d'erreur).

Un nom de chapitre mal orthographié dans une configuration provoque une erreur de compilation indiquant le fichier introuvable.

Retirer un chapitre d'une configuration casse les références (`@...`) qui pointent vers lui depuis les autres chapitres : la compilation échoue en indiquant l'étiquette introuvable.
Il faut alors aussi retirer ou adapter ces références.