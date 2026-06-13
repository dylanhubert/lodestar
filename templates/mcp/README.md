# Templates MCP

Pour brancher un service externe (Supabase…) sur un projet, par projet, sans fuiter de secret.

- `supabase.mcp.json` → à copier en `.mcp.json` à la racine du projet. **Committé**, sans secret : il référence des variables `${...}`.
- `settings.local.example.json` → à copier en `.claude/settings.local.json`. **Jamais committé** : c'est là qu'on colle le token.

Détails et règle de sécurité : `docs/mcp.md`. La commande `/mcp` automatise la pose.
