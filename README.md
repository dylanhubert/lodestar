# Lodestar

Un plugin Claude Code qui garde **tous tes projets cohérents** — qualité, Git, conventions, voix humaine — quel que soit le langage. Par Dylan HUBERT.

## Idée

Un seul socle de standards, branché sur n'importe quel projet :

- les **nouveaux** projets démarrent déjà aux normes ;
- les projets **existants** s'y branchent avec `/brancher`, sans rien casser.

Trois niveaux de règles : universel (`docs/regles-dor.md`), par langage (configs détectées), par archétype (`profiles/`).

## Installer

Dans Claude Code (terminal, IDE, ou les modes Code/Cowork de Claude Desktop), sur Windows ou Mac :

```
/plugin marketplace add dylanhubert/lodestar
/plugin install lodestar@lodestar
/setup
```

`/setup` est interactif : il détecte ton OS, vérifie tes outils (git, gh, node…), règle ton identité git et configure le reste. Aucun chemin à choisir, aucun script à lancer à la main.

> Les commandes et agents tournent dans **Claude Code** (terminal, IDE, et les modes **Code / Cowork** de Claude Desktop). Le mode **Chat** pur de Desktop ne fait pas tourner de plugins.

## Utiliser

Dans n'importe quel projet :

- `/check` — l'état du projet (lecture seule).
- `/brancher` — le met aux normes : structure, Git, CI, profil.
- `/revue` — review du code en profondeur (bugs, sécu, optimisation).
- `/sans-ia` — retire les marques d'IA (contenu, fichiers, historique).
- `/mcp` — branche un service externe (Supabase, GitHub…) par projet.
- `/aide` — mémo des commandes et des agents.
- `/setup` — (re)configure ton environnement.

Et des agents spécialisés, que `/revue` mobilise ou que tu invoques directement : `code-reviewer`, `security-auditor`, `test-writer`, `release-manager`.

## Mettre à jour

```
/plugin marketplace update lodestar
```

## Sous le capot

- **Moteur déterministe** : des scripts Node (`lodestar/scripts/`) pour ce qui se vérifie — langages, état Git, secrets, marques d'IA. Cross-platform, sans bash.
- **Couche de jugement** : skills et agents Claude Code pour ce qui demande de réfléchir.

## Structure du dépôt

- `.claude-plugin/marketplace.json` — le catalogue.
- `lodestar/` — le plugin : `.claude-plugin/plugin.json`, `skills/`, `agents/`, `scripts/`, `docs/`, `profiles/`, `templates/`.

## Licence

MIT — © 2026 Dylan HUBERT.
