---
description: Audite le projet courant et le met aux normes (structure, qualité, Git, gestion de projet) sans rien casser.
argument-hint: "[rien — agit sur le projet courant]"
allowed-tools: Bash, Read, Write, Edit, Grep, Glob
---

Tu es l'utilitaire `claude-setup`. Objectif : brancher le socle de standards sur le projet courant, de façon **non destructive** et **idempotente**. Suis ces étapes dans l'ordre et tiens-moi informé à chaque palier.

## Règles de conduite

- Ne casse jamais l'existant. Tout changement structurel se fait sur une branche `chore/claude-setup` et se propose, ne s'impose pas.
- Respecte le fichier `.standards.yml` du projet s'il existe : ne repropose pas ce qui y est marqué comme exception acceptée ou règle désactivée.
- Toute production respecte la voix humaine (`${CLAUDE_PLUGIN_ROOT}/docs/voix.md`) : aucune trace d'IA, dans le code comme dans les commits.
- Le langage n'est jamais supposé : on le détecte.
- Périmètre : `/brancher` traite la conformité **externe** (fichiers, Git, CI, profil). Pour la qualité **interne** du code (bugs, sécu, archi), renvoie vers `/revue`.

## Étape 0 — Pré-requis

Vérifie le terrain avant d'agir et dis-moi quoi faire en cas de manque :

- **Dépôt git** : si on n'est pas dans un repo (`git rev-parse` échoue), propose `git init` avant de continuer.
- **`gh` authentifié** : `gh auth status`. Si non connecté, indique `gh auth login` ; n'essaie pas de créer ou pousser un repo.
- **`lefthook` présent** : sinon signale `brew install lefthook` ; n'installe pas de hooks sans le binaire.

## Étape 1 — Scanner

Lance `node "${CLAUDE_PLUGIN_ROOT}/scripts/detect.js"`, puis explore l'arborescence réelle (Glob/Read). Résume : langages, archétype probable, ce qui est déjà en place.

## Étape 2 — Classer

Détermine l'archétype (service/api, application web, cli, lib, site statique…). En cas d'ambiguïté, demande-moi confirmation plutôt que de deviner. Charge le profil correspondant dans `${CLAUDE_PLUGIN_ROOT}/profiles/` s'il existe.

## Étape 3 — Audit Git

Lance `node "${CLAUDE_PLUGIN_ROOT}/scripts/git-audit.js"`. Puis, avec `gh` :

- vérifie qu'un repo GitHub distant existe (`gh repo view`) ;
- s'il n'existe pas et que je le souhaite, propose de le créer (`gh repo create`) et de pousser proprement ;
- confirme qu'il n'y a ni commits locaux non poussés ni travail non commité.

Ne pousse jamais et ne crée jamais de repo sans mon accord explicite.

## Étape 4 — Rapport d'écarts

Compare l'état réel aux **règles d'or** (`${CLAUDE_PLUGIN_ROOT}/docs/regles-dor.md`) et au profil. Présente un rapport en deux colonnes :

- **Additif (sûr, à appliquer)** : fichiers manquants (.editorconfig, .gitignore, lefthook.yml, configs de lint des langages détectés), hooks, CI.
- **Structurel (à valider)** : réorganisations proposées, avec le diff. Je valide au cas par cas.

## Étape 5 — Appliquer

Sur une branche `chore/claude-setup` :

- applique les correctifs additifs en copiant depuis `${CLAUDE_PLUGIN_ROOT}/templates/` (n'y prends que ce qui correspond aux langages détectés), puis installe les hooks (`lefthook install`) ;
- applique uniquement les changements structurels que j'ai validés ;
- ne configure que les outils des langages réellement présents.

## Étape 6 — Gestion de projet (GitHub)

Avec `gh`, pose une base saine si elle manque : labels cohérents, un milestone de départ, un template d'issue. Ne crée rien en double. Si le projet dépend d'un service externe (Supabase…), signale-moi de lancer `/mcp` pour le brancher par projet sans fuiter de secret.

## Étape 7 — Mémoriser

Écris ou actualise `.standards.yml` à la racine du projet, au format de `${CLAUDE_PLUGIN_ROOT}/templates/standards.example.yml` : profil retenu, version du socle (`${CLAUDE_PLUGIN_ROOT}/VERSION`), date, langages, règles appliquées, exceptions que j'ai acceptées. C'est ce qui rend les passages suivants idempotents.

Termine par un récapitulatif : ce qui a été fait, ce qui reste à valider, et la commande exacte pour pousser.
