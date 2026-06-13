# Profils

Un profil décrit la structure attendue et les règles supplémentaires d'un **archétype** de projet : service/api, application web, cli, lib, site statique…

L'idée tient en une phrase : la cohérence ne veut pas dire une structure unique. Chaque projet choisit le profil qui lui correspond, et le profil n'ajoute des contraintes que là où ça a du sens pour ce type de projet.

## Ajouter un profil

Crée un dossier `profiles/<archetype>/` avec un `profile.md` qui précise :

- la structure de dossiers attendue ;
- les fichiers requis spécifiques à cet archétype ;
- les outils et règles en plus des règles d'or.

`/brancher` charge automatiquement le profil correspondant à l'archétype détecté. Tant qu'un profil n'existe pas, seules les règles d'or universelles s'appliquent. C'est volontaire : on n'ajoute un profil que quand un vrai besoin apparaît, pas par anticipation.
