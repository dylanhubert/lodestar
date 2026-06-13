---
description: Branche un serveur MCP (Supabase…) sur le projet courant, par projet, sans fuiter de secret.
argument-hint: "[service, ex. supabase]"
allowed-tools: Bash, Read, Write, Edit, Grep, Glob
---

Tu branches un serveur MCP sur le projet courant, en portée **projet**, en gardant le secret hors de Git. Référence : `~/dev/claude-setup/docs/mcp.md`.

## 1. Cibler le service

Service demandé : $ARGUMENTS. Si vide, demande-moi lequel — ça dépend du projet, ce n'est pas forcément Supabase. Consulte `~/dev/claude-setup/templates/mcp/catalog.md` : si un modèle prêt existe (ex. `supabase.mcp.json`), pars de lui ; sinon construis l'entrée avec le bon patron (HTTP ou stdio, voir `_http.example.mcp.json` / `_stdio.example.mcp.json`), en vérifiant le nom de package, l'URL et les options sur le repo ou la doc **officielle** du serveur (ça bouge vite).

## 2. Écrire le `.mcp.json` (committé, SANS secret)

À la racine du projet. Le serveur référence des variables (`${SUPABASE_ACCESS_TOKEN}`, `${SUPABASE_PROJECT_REF}`), jamais le token en clair. Si un `.mcp.json` existe déjà, fusionne sans écraser les serveurs déjà présents.

Modèle Supabase (vérifié) : `type: http`, url `https://mcp.supabase.com/mcp?project_ref=${SUPABASE_PROJECT_REF}&read_only=true`, header `Authorization: Bearer ${SUPABASE_ACCESS_TOKEN}`.

## 3. Préparer le secret local (JAMAIS committé)

- Crée `.claude/settings.local.json` avec un bloc `env` contenant les clés attendues, en placeholders (copie depuis `templates/mcp/settings.local.example.json`).
- Ajoute `.claude/settings.local.json` au `.gitignore` **avant** que je colle quoi que ce soit.
- Vérifie qu'il n'est pas déjà suivi par git (`git ls-files | grep settings.local.json`) ; s'il l'est, `git rm --cached` et préviens-moi.

## 4. Me guider

Indique-moi : où récupérer les identifiants (Supabase : Dashboard → Account → Access Tokens pour le token, Settings → General pour le `project_ref`), de les coller dans `.claude/settings.local.json`, et qu'à la prochaine ouverture du projet Claude Code demandera d'approuver le serveur (normal, sécurité).

Ne me propose jamais de mettre un secret dans le `.mcp.json`. Ne commite jamais de token.
