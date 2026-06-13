# Profil : bibliothèque

Pour du code destiné à être réutilisé par d'autres projets.

## Structure attendue

- une surface publique (API) explicite et minimale ; le reste est interne.
- `tests/` qui couvrent l'API publique, pas les détails d'implémentation.
- exemples d'utilisation.

## Fichiers requis en plus des règles d'or

- documentation de l'API publique.
- versionnement semver respecté, changelog tenu.

## Règles en plus

- pas de rupture de compatibilité sans bump majeur.
- dépendances minimales ; pas d'effet de bord à l'import.
- ce qui n'est pas documenté comme public peut changer à tout moment.
