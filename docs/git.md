# Conventions Git

## Branches

- `main` : toujours déployable.
- `feat/<sujet>`, `fix/<sujet>`, `chore/<sujet>` pour le travail en cours.
- `chore/dev-standards` : réservée aux mises aux normes par `/brancher`.

## Commits

Conventional Commits : `type(scope): description`.
Types : `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `build`, `ci`.
Rédaction en voix humaine (voir `voix.md`). Aucune signature IA.

## Remote

Tout projet a un `origin` sur GitHub. Pas de travail qui dort uniquement en local.

## Releases

- Tags semver : `vMAJEUR.MINEUR.CORRECTIF`.
- Changelog généré depuis les commits conventionnels.

## Gestion de projet (GitHub)

- Labels cohérents d'un projet à l'autre (`type:bug`, `type:feat`, `prio:haute`…).
- Milestones pour les jalons.
- Un template d'issue pour cadrer les demandes entrantes.
