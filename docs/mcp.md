# MCP par projet

Le problème : sur Claude Desktop, les connecteurs (MCP) sont liés au compte, donc globaux. Si deux projets utilisent deux comptes Supabase différents, ça coince.

La solution en Claude Code : déclarer les serveurs MCP **par projet**, dans un `.mcp.json` à la racine du repo. Chaque projet a les siens, committés avec lui. Le secret, lui, reste local et hors Git.

## Les trois portées

| Portée | Fichier | Pour qui |
|---|---|---|
| `project` | `.mcp.json` à la racine du repo | committé, voyage avec le projet |
| `local` | `~/.claude.json` (section du projet) | toi seul, ce projet |
| `user` | `~/.claude.json` (niveau global) | toi, tous les projets |

Pour « un Supabase différent par projet », c'est `project`.

## La règle de sécurité

Le `.mcp.json` est **committé**, donc il ne contient **jamais** le token en clair. Il référence des variables (`${SUPABASE_ACCESS_TOKEN}`), et le token réel vit dans un fichier **local, ignoré par Git** : `.claude/settings.local.json`.

`.mcp.json` (committé) :

```json
{
  "mcpServers": {
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp?project_ref=${SUPABASE_PROJECT_REF}&read_only=true",
      "headers": {
        "Authorization": "Bearer ${SUPABASE_ACCESS_TOKEN}"
      }
    }
  }
}
```

`.claude/settings.local.json` (jamais committé) :

```json
{
  "env": {
    "SUPABASE_PROJECT_REF": "ref-du-projet",
    "SUPABASE_ACCESS_TOKEN": "sbp_xxx"
  }
}
```

`.gitignore` :

```
.claude/settings.local.json
```

Claude Code lit l'environnement (settings.local.json + shell), puis remplace les `${...}` dans `.mcp.json` au lancement du serveur. Filet bulletproof si l'expansion ne prend pas : `export SUPABASE_ACCESS_TOKEN=… && claude`.

## Mise en place

`/mcp` fait tout : il écrit le `.mcp.json`, prépare `.claude/settings.local.json` avec les bonnes clés, et s'assure qu'il est bien ignoré par Git. Tu n'as qu'à coller ton token.

À la première ouverture du projet, Claude Code demande d'approuver les serveurs MCP du `.mcp.json` (sécurité : un clone non fiable ne lance rien sans ton accord). Tu approuves une fois.

## Supabase : obtenir les identifiants

- Token : Dashboard Supabase → Account → Access Tokens → génère un token (commence par `sbp_`).
- `project_ref` : l'identifiant du projet, visible dans l'URL du dashboard ou dans Settings → General.
- `&read_only=true` garde l'accès en lecture seule ; retire-le seulement si tu as besoin d'écrire.
