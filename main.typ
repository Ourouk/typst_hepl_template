#import  "template.typ":  *

#show: project.with(
  course-title: "Typst",
  title: "Use a Template",
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ing. Ind. - G. Electrique Informatique",
    ),
  ),
  bibliography-file: "ref.bib"
)
= Utiliser dans visual Studio Code
#link("https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview")
Permet de prévisualiser facilement les fichiers .typ dans Visual Studio Code.
= Include
== Image
#image("figures/g2.svg")
== Bibliographie
= Remerciement
Merci à Guilain Ernotte de l'ULiège pour sa template original
- #cite(<azSpecificationsFonctionnellesExemples2023>)