# Changelog

Les évolutions notables du socle. Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/), versionnage [semver](https://semver.org/lang/fr/).

## [1.2.0] — 2026-06-14

### Ajouts

- `update.sh` : met à jour le socle sur une machine déjà installée (`git pull --ff-only` puis réinstall).
- Démarrage rapide et section de personnalisation dans le README.
- `/aide` indique par où commencer et distingue `/check` (conformité) de `/revue` (code).

### Changements

- Identité git sortie dans `config.local.sh` (ignoré par Git) au lieu d'être codée en dur : le socle est réutilisable par d'autres, chacun avec sa propre identité.
- Licence MIT (au lieu de propriétaire).

### Corrections

- `docs/ou-ca-marche.md` listait 3 agents au lieu de 4 (ajout de `release-manager`).
- `templates/standards.example.yml` affichait une version périmée.

## [1.1.0] — 2026-06-14

### Ajouts

- `install.sh` impose l'identité git (`Dylan HUBERT <contact@dylan-hubert.fr>`) sur chaque environnement, pour que les commits soient toujours à mon nom, quel que soit l'outil utilisé.
- `git-audit.sh` (donc `/check` et `/brancher`) alerte si l'identité git est absente ou est un placeholder (`t@t.t`…).

## [1.0.0] — 2026-06-14

Première version stable.

### Ajouts

- Commandes : `/brancher`, `/check`, `/revue`, `/sans-ia`, `/mcp`, `/aide`.
- Agents : `code-reviewer`, `security-auditor`, `test-writer`, `release-manager`.
- Règles d'or, guide de voix humaine, conventions Git, modèle d'ADR.
- Profils par archétype : `api`, `web`, `cli`, `lib`, `static`.
- Templates copiés dans les projets : lint (biome, ruff), commitlint, `.gitignore` par langage, CI, issues, labels.
- MCP par projet (`.mcp.json` + secret local), avec catalogue de serveurs.
- Détection de langage et d'archétype, audit Git, scan des marques d'IA.
- Installation portable par symlinks (`install.sh`), réglage anti-signature.
