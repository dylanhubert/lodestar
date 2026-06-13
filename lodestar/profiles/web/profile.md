# Profil : application web

Pour un front (react, vue, svelte, next, nuxt…).

## Structure attendue

- découpage par fonctionnalité plutôt que par type de fichier.
- composants réutilisables isolés ; état applicatif séparé de la présentation.
- `public/` ou équivalent pour les assets statiques.

## Fichiers requis en plus des règles d'or

- config de build et de lint/format du framework.
- variables d'environnement publiques préfixées et documentées (`.env.example`).

## Règles en plus

- aucune clé secrète embarquée dans le bundle client.
- accessibilité de base respectée (labels, contraste, navigation clavier).
- budget de performance surveillé (taille du bundle).
