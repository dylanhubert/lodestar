# dev-standards

Mon socle commun pour tous mes projets, quel que soit le langage. Il garantit la cohérence sur ce qui doit l'être (qualité, Git, conventions, voix) sans imposer une structure unique aux projets, qui restent libres sur leur archi métier.

## Idée

Un seul endroit fait référence. Chaque projet en hérite :

- les **nouveaux** projets démarrent déjà aux normes ;
- les projets **existants** s'y branchent avec `/brancher`, sans rien casser.

La cohérence repose sur trois niveaux de règles :

- **universel** (partout) : `docs/regles-dor.md` ;
- **par langage** : configs de lint/format, détectées et jamais supposées ;
- **par archétype** : `profiles/` (api, web, cli, lib…).

## Comment c'est fait

- **Moteur déterministe** (`scripts/`) pour ce qui se vérifie : état Git, fichiers requis, secrets.
- **Couche de jugement** (commandes Claude Code) pour ce qui demande de réfléchir : classer un projet, réorganiser une structure, rédiger.

L'outil sait quoi vérifier mécaniquement et quoi confier au raisonnement. C'est ce qui le rend fiable plutôt que bavard.

## Installer

```sh
./install.sh
```

Installe les commandes `/brancher` et `/check` et les règles globales dans `~/.claude`. Dépendances : `gh` (GitHub), `lefthook` (hooks Git).

## Utiliser

Dans n'importe quel projet :

- `/brancher` — audite et met aux normes : structure, qualité, Git, gestion de projet GitHub.
- `/check` — diagnostique une dérive, sans rien modifier.

## Structure

- `docs/` — règles d'or, voix humaine, conventions Git, modèle d'ADR.
- `profiles/` — un dossier par archétype de projet.
- `scripts/` — détection des langages et audit Git.
- `claude/` — commandes et règles globales Claude Code.
