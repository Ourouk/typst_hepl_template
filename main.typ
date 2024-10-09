#import "template.typ": *

#show: project.with(
  course-title: "IOT",
  title: "Vélos connectés",
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ing. Ind. - Informatique",
    ),
    (
      first-name: "Martin",
      last-name: "Van den Bosh",
      cursus: "M. Ing. Civ. - Informatique",
    ),
  ),
  bibliography-file: "ref.bib"
)

= Introduction
== Problématique
Lors de nos diverses balades en ville, nous pouvons, désormais, constater l'apparition de plus en plus fréquente de vélos en libre-service.
C'est ainsi que l'idée de gérer une flotte de vélos Universitaire, disponible pour les étudiants et le personnel sur un campus nous est venue en tête #cite(<ruggieroSecurityFlawGoogle2018>).
Des problématiques apparaissent directement avec cette idée. Comme l'exemple du campus de Google de Montain Valley où une succession de vols des vélos mis à disposition sur le site a eu lieu. Avec près de 250 disparitions par semaines.

On ne sait aussi aucunement qui utilise les vélos, si les règles d'utilisation sont réspectées ou si les vélos sont en bon état.

Il semble donc nécessaire de mettre en place un système de gestion de ces vélos pour éviter ce genre de désagrément. Cet ajout est aussi l'occasion de rajouter une série de fonctionnalités qui pourraient être utiles pour les utilisateurs.
== Objectif
L'objectif de ce projet est de réaliser un systême de gestion permettant de suivre l'activité de vélo en libre-service à l'intérieur d'un campus.

Ce système devra permettre de gérer les vélos, les stations, les utilisateurs et les trajets.
Nous ajouterons aussi quelques fonctionnalités intelligentes pour améliorer le confort de l'utilisateur.
== Proposition

Le projet consiste à réaliser trois objets connectés avec des capteurs différents. Ces objets sont les suivants :
- Un vélo connecté avec un esp32 compatible LORA
- Une station de sécurité/Charge connectée avec un esp32 compatible WIFI
- Une Antenne connectée avec un edge processing basé sur une RPI qui se connecte aux deux autres objets.

Le serveur de gestion sera réalisé en python avec une base de MongoDB.
Un serveur sera présent coté client de notre produit et un second sera géré de notre coté pour gérer la distribution de mise à jour le troubleshooting et la télémétrie.

Les deux serveurs seraient basés sur Rocky Linux en utilisant une architecture containérisée avec Docker.

== Diagramme de 