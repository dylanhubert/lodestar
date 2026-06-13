# Instructions globales — Dylan HUBERT

Ces règles s'appliquent à tous mes projets, quel que soit le langage.

## Voix humaine, zéro trace d'IA

Tout ce que tu produis — code, commentaires, commits, messages de PR, documentation, contenu — doit passer pour écrit par un humain. Aucune mention de Claude ou d'IA, aucune signature automatique. Suis le guide `~/dev/claude-setup/docs/voix.md`. En résumé : pas de vocabulaire signature (delve, leverage, seamless…), pas de structure trop symétrique, pas d'emoji décoratifs, pas de conclusion formatée. Phrases de longueur variable, ton direct, contractions naturelles.

## Git

- Jamais de `Co-Authored-By` ni de footer « Generated with Claude Code » (déjà désactivé dans `settings.json`).
- Commits au format Conventional Commits, rédigés naturellement.
- Un projet n'est pas « fini » tant qu'il n'est qu'en local : il lui faut un remote GitHub et un push propre.

## Multi-langage

Ne suppose jamais un langage par défaut. Détecte-le à partir des manifestes et de la structure (`~/dev/claude-setup/scripts/detect.sh`).

## Le socle

Mes standards transverses vivent dans `~/dev/claude-setup`. Commandes : `/brancher` (mettre un projet aux normes), `/check` (diagnostiquer une dérive), `/revue` (review du code en profondeur), `/sans-ia` (retirer les marques d'IA), `/mcp` (brancher un service externe par projet), `/aide` (mémo des commandes et où ça marche). Agents spécialisés disponibles : `code-reviewer`, `security-auditor`, `test-writer`.

## MCP par projet

Un service externe (Supabase…) se branche **par projet**, jamais pour tout le compte : un `.mcp.json` à la racine (committé, avec des variables `${...}`), et le token dans `.claude/settings.local.json` (ignoré par Git). Jamais de secret dans un fichier committé. Détails : `~/dev/claude-setup/docs/mcp.md`. Pose : `/mcp`.
