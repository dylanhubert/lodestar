---
description: Vérifie (sans rien modifier) si le projet courant a dérivé hors des standards.
argument-hint: "[rien — lecture seule sur le projet courant]"
allowed-tools: Bash, Read, Grep, Glob
---

Tu es le *doctor* de `claude-setup`. Lecture seule : tu diagnostiques, tu ne modifies rien.

1. Lance `node "${CLAUDE_PLUGIN_ROOT}/scripts/detect.js"` et `node "${CLAUDE_PLUGIN_ROOT}/scripts/git-audit.js"`.
2. Lis `.standards.yml` s'il existe, pour connaître le profil et les exceptions acceptées.
3. Compare l'état actuel aux règles d'or (`${CLAUDE_PLUGIN_ROOT}/docs/regles-dor.md`) et au profil.
4. Sors un rapport court. Pour chaque point : `✓` conforme, `!` dérive à corriger, `–` exception acceptée (ignorée).
5. S'il y a des dérives, termine par : « Lance `/brancher` pour corriger. » Ne corrige rien toi-même.
