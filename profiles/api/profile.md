# Profil : service / api

Pour un backend qui expose une API (HTTP, gRPC…).

## Structure attendue

- `src/` (ou équivalent du langage) : code applicatif découpé par domaine, pas par type technique.
- une séparation claire entre couche transport (routes/handlers), logique métier, et accès aux données.
- `tests/` : au moins les chemins critiques et les cas d'erreur.

## Fichiers requis en plus des règles d'or

- `Dockerfile` ou équivalent de déploiement reproductible.
- variables d'environnement documentées (`.env.example`), jamais de secret commité.
- un health-check ou endpoint de statut.

## Règles en plus

- toute entrée externe est validée avant traitement.
- les erreurs ne fuitent pas de détails internes (stack, requêtes SQL) dans les réponses.
- logs structurés, sans données sensibles.
