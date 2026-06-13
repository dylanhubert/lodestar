# Catalogue MCP

Le MCP n'est pas que Supabase. Chaque projet branche les serveurs dont il a besoin, dans son `.mcp.json` — un projet peut avoir Supabase, un autre GitHub + Postgres, un autre rien. Deux patrons selon le serveur.

## Patron HTTP (service hébergé)

Un service distant expose un endpoint MCP. Auth dans `headers`.

```json
{
  "mcpServers": {
    "mon-service": {
      "type": "http",
      "url": "https://exemple.com/mcp",
      "headers": { "Authorization": "Bearer ${MON_SERVICE_TOKEN}" }
    }
  }
}
```

## Patron stdio (process local)

Un programme lancé localement (souvent via `npx`). Secrets dans `env`.

```json
{
  "mcpServers": {
    "mon-service": {
      "command": "npx",
      "args": ["-y", "@vendor/mcp-server@latest", "--une-option"],
      "env": { "MON_SERVICE_TOKEN": "${MON_SERVICE_TOKEN}" }
    }
  }
}
```

## Quelques serveurs courants

| Service | Type | Où trouver la config exacte |
|---|---|---|
| Supabase | http | `templates/mcp/supabase.mcp.json` (prêt, vérifié) |
| GitHub | http / stdio | repo officiel `github/github-mcp-server` |
| Stripe | stdio | package `@stripe/mcp` |
| Postgres | stdio | `@modelcontextprotocol/server-postgres` |
| Filesystem | stdio | `@modelcontextprotocol/server-filesystem` |
| Playwright | stdio | `@playwright/mcp` |

Vérifie toujours le nom de package, l'URL et les options sur le repo ou la doc **officielle** du serveur : ça bouge vite. Ne copie pas ces noms les yeux fermés.

## Plusieurs serveurs

Un projet peut en avoir plusieurs : ils cohabitent sous `mcpServers`. `/mcp` fusionne dans le `.mcp.json` existant, il n'écrase pas les serveurs déjà là.

## Règle constante

Quel que soit le serveur, le secret va **toujours** en `${VAR}` dans le `.mcp.json` (committé) et la vraie valeur dans `.claude/settings.local.json` (ignoré par Git). Jamais de token en clair dans un fichier versionné.
