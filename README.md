# Claude Setup

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

Clone le socle dans `~/dev/claude-setup` (chemin référencé par les commandes), puis :

```sh
cp config.example.sh config.local.sh   # renseigne ton nom et ton email git
./install.sh
```

Installe les commandes, les agents et les règles globales dans `~/.claude` (la liste exacte s'affiche à la fin). `config.local.sh` (ignoré par Git) garde ton identité, pour que tes commits soient toujours à ton nom. Dépendances, toutes optionnelles : `gh` (GitHub), `lefthook` (hooks Git), `gitleaks` (scan de secrets) — l'install réussit sans elles, elles ne servent qu'à certaines commandes.

## Démarrage rapide

Dans n'importe quel projet, après avoir rechargé Claude Code :

1. `/aide` — la liste des commandes et où ça marche.
2. `/check` — l'état du projet (lecture seule).
3. `/brancher` — le met aux normes.

## Utiliser

Dans n'importe quel projet :

- `/brancher` — audite et met aux normes : structure, qualité, Git, gestion de projet GitHub.
- `/check` — diagnostique une dérive, sans rien modifier.
- `/revue` — comprend le code en profondeur, puis review, corrige, optimise, restructure.
- `/sans-ia` — retire les marques d'IA (commits, fichiers, contenu) d'un projet existant.
- `/mcp` — branche un service externe (Supabase, GitHub, Postgres…) sur le projet, par projet, sans fuiter de secret.
- `/aide` — rappelle les commandes, les agents, et où ça marche (Claude Code vs Desktop).

Et des agents spécialisés, que `/revue` peut mobiliser ou que tu invoques directement : `code-reviewer`, `security-auditor`, `test-writer`, `release-manager`.

## Nouvelle machine

Le repo poussé sur GitHub est la sauvegarde. Sur une machine neuve, tout se rejoue :

```sh
git clone <url-github> ~/dev/claude-setup
cd ~/dev/claude-setup && cp config.example.sh config.local.sh   # renseigne ton identité
./install.sh
```

`install.sh` recrée les symlinks et applique ton identité git. Rien n'est perdu d'une machine à l'autre, sauf `config.local.sh` (local par nature — recrée-le depuis l'exemple). Garde le clone à `~/dev/claude-setup` (chemin référencé par les commandes).

## Mettre à jour

Quand le socle évolue, sur une machine déjà installée :

```sh
~/dev/claude-setup/update.sh
```

Il récupère la dernière version (`git pull --ff-only`) puis relance l'install.

## L'utiliser (toi, ou quelqu'un d'autre)

Le socle est sous licence MIT, donc réutilisable. Pour l'adapter :

- **Identité** : `config.local.sh` (ton nom, ton email git), jamais committé.
- **Chemin** : clone-le dans `~/dev/claude-setup` — les commandes y font référence en absolu. C'est le seul chemin imposé.
- **Conventions** : `docs/` et `claude/CLAUDE.md` portent les règles ; édite-les pour les tiennes.
- La langue est le français et les standards reflètent une façon de travailler : un fork est fait pour être personnalisé.

## Structure

- `docs/` — règles d'or, voix humaine, conventions Git, MCP par projet, Code vs Desktop, ADR. Sommaire : `docs/README.md`.
- `profiles/` — un dossier par archétype (`api`, `web`, `cli`, `lib`, `static`).
- `templates/` — les fichiers que `/brancher` copie dans tes projets (configs lint, CI, issues, labels, MCP).
- `scripts/` — détection des langages, audit Git, scan des marques d'IA.
- `claude/` — commandes, agents et règles globales Claude Code.
- `CHANGELOG.md`, `VERSION` — l'historique et la version du socle, inscrite dans le `.standards.yml` de chaque projet branché.
- `install.sh`, `update.sh`, `config.example.sh` — installer, mettre à jour, configurer.
