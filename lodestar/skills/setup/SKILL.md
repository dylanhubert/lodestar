---
description: Configure Lodestar — détecte l'OS, vérifie les outils, règle l'identité git, installe les règles globales. À lancer une fois après l'installation du plugin.
---

Tu fais la configuration interactive de Lodestar. Sois bref, concret, et ne change rien de sensible sans accord.

## 1. Environnement

Détecte l'OS (macOS / Windows / Linux). Vérifie la présence de : `git`, `node` (requis), puis `gh`, `lefthook`, `gitleaks` (optionnels, selon les commandes). Pour chaque outil manquant, donne la commande d'installation adaptée à l'OS :
- macOS : `brew install …`
- Windows : `winget install …` (ou `scoop install …`)
- Linux : le gestionnaire de la distrib.

## 2. Identité git

Lis `git config --global user.name` et `git config --global user.email`. Si l'un est vide, ou si l'email est un placeholder (`t@t.t`, `you@example.com`…), demande-moi mon nom et mon email puis applique :

```
git config --global user.name "<nom>"
git config --global user.email "<email>"
```

Rappelle que c'est l'**email** qui détermine l'attribution des commits sur GitHub : il doit être un email vérifié sur mon compte, sinon mes commits ne me seront pas rattachés.

## 3. Pas de signature IA

Vérifie `~/.claude/settings.json` : `includeCoAuthoredBy` doit valoir `false` (pas de trailer « Co-Authored-By: Claude » ni de footer « Generated with… »). S'il est absent ou à `true`, propose de l'ajouter **sans écraser** le reste du fichier (lis, modifie la seule clé, réécris).

## 4. Règles globales (optionnel)

Propose d'ajouter mes règles transverses à `~/.claude/CLAUDE.md` : voix humaine, hygiène Git, multi-langage. Sources : `${CLAUDE_PLUGIN_ROOT}/docs/regles-dor.md`, `${CLAUDE_PLUGIN_ROOT}/docs/voix.md`, `${CLAUDE_PLUGIN_ROOT}/docs/git.md`. Demande avant d'écrire ; n'écrase jamais un `CLAUDE.md` existant, ajoute à la suite.

## 5. Récap

Termine par : ce qui est prêt, ce qui manque encore (avec la commande exacte pour l'installer), et « tape `/aide` pour voir les commandes ».
