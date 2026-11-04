#import "common/lib.typ": *

// Configuration choisie avec `--input config=configs/<nom>.toml` (voir configs/default.toml)
#let config = toml(sys.inputs.at("config", default: "configs/default.toml"))

#show: biomecaniqc-book.with(
  title: config.title,
  lang: "fr",
  show-page-numbering: true,
  authors: (
    Author("Mickaël Begon", affiliations: "Université de Montréal"),
    Author("Benjamin Michaud", affiliations: "Université de Sherbrooke"),
  ),
  date: datetime(year: 2026, month: 11, day: 3),
  watermark-text: config.watermark,
  chapter-on-same-page: config.chapter-on-same-page,
)

#todo[Change '’' for ''']

#outlines()

#for chapter in config.at("chapters", default: ()) {
  include "chapters/" + chapter + "/main.typ"
}


#let annex-list = config.at("annexes", default: ())
#if annex-list.len() > 0 [
  #show: annexes
  #for chapter in annex-list {
    include "chapters/" + chapter + "/main.typ"
  }
]

