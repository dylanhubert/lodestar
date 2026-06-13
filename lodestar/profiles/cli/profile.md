# Profil : cli

Pour un outil en ligne de commande.

## Structure attendue

- un point d'entrée mince qui parse les arguments et délègue à la logique.
- logique métier testable, séparée de l'affichage terminal.
- `tests/` couvrant les commandes principales et les erreurs d'usage.

## Fichiers requis en plus des règles d'or

- un `--help` clair et à jour.
- exemples d'usage dans le README.

## Règles en plus

- codes de sortie cohérents (0 = succès, non-zéro = erreur identifiable).
- messages d'erreur lisibles sur stderr, résultats sur stdout.
- pas d'effet de bord destructeur sans confirmation ou option explicite.
