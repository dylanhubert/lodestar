---
description: Rappelle les commandes, les agents et où ça marche (Claude Code vs Desktop).
allowed-tools: Read
---

Affiche un mémo court et clair, sans blabla :

**Par où commencer** : dans un projet, `/check` pour voir l'état, puis `/brancher` pour le mettre aux normes.

**Commandes** (toutes dans Claude Code, sur le projet courant) :
- `/check` — diagnostic, lecture seule : le projet est-il aux normes ? (conformité externe)
- `/brancher` — met le projet aux normes (structure, Git, CI, profil) ; applique ce que `/check` signale.
- `/revue` — review du **code** en profondeur (bugs, sécu, optimisation, structure interne).
- `/sans-ia` — retire les marques d'IA (contenu, fichiers, historique).
- `/mcp` — branche un service externe (Supabase, GitHub…) par projet.
- `/aide` — ce mémo.

**Agents** : `code-reviewer`, `security-auditor`, `test-writer`, `release-manager`.

**Rappel** : tout ça marche dans **Claude Code**, pas dans Claude Desktop. Si `/brancher` ne fait rien, tu es sûrement dans Desktop. Détail : `~/dev/claude-setup/docs/ou-ca-marche.md`.

Garde-le bref : un mémo, pas un cours.
