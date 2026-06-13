# Profil : site statique

Pour un site sans backend (HTML/CSS/JS, ou via un générateur de site statique).

## Structure attendue

- une racine claire avec le point d'entrée (`index.html`) ou la config du générateur.
- assets (images, polices) regroupés, séparés du contenu.
- contenu et présentation distincts quand c'est possible.

## Fichiers requis en plus des règles d'or

- build reproductible si générateur, avec la commande documentée dans le README.
- aucune clé ni secret dans le code livré au navigateur.

## Règles en plus

- liens et assets en chemins cohérents (relatifs ou absolus, pas un mélange).
- performances : images optimisées, pas de dépendances lourdes inutiles.
- accessibilité de base : balises sémantiques, alternatives textuelles, contraste.
