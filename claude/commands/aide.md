---
description: Rappelle les commandes, les agents et où ça marche (Claude Code vs Desktop).
allowed-tools: Read
---

Affiche un mémo court et clair, sans blabla :

**Commandes** (toutes dans Claude Code, sur le projet courant) :
- `/brancher` — met le projet aux normes (structure, Git, CI, profil).
- `/check` — diagnostic de dérive, lecture seule.
- `/revue` — review du code en profondeur (bugs, sécu, optimisation).
- `/sans-ia` — retire les marques d'IA (contenu, fichiers, historique).
- `/mcp` — branche un service externe (Supabase, GitHub…) par projet.
- `/aide` — ce mémo.

**Agents** : `code-reviewer`, `security-auditor`, `test-writer`.

**Rappel** : tout ça marche dans **Claude Code**, pas dans Claude Desktop. Si `/brancher` ne fait rien, tu es sûrement dans Desktop. Détail : `~/dev/claude-setup/docs/ou-ca-marche.md`.

Garde-le bref : un mémo, pas un cours.
