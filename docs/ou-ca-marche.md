# Où ça marche : Claude Code vs Claude Desktop

Tu mélanges les deux, c'est normal : ce sont deux applications différentes.

## Claude Code — c'est là que vit Claude Setup

Le terminal, l'app Code, l'extension VS Code / JetBrains, claude.ai/code. Ça tourne **dans un dossier de projet**. C'est là que marchent :

- tes commandes : `/brancher`, `/check`, `/revue`, `/sans-ia`, `/mcp`, `/aide` ;
- tes agents : `code-reviewer`, `security-auditor`, `test-writer` ;
- le `.mcp.json` par projet et le `CLAUDE.md`.

Pour bosser sur un projet, c'est ici.

## Claude Desktop — l'appli de chat

L'application Claude « classique ». Connecteurs MCP **globaux** (tout le compte), pas de notion de projet, et ni tes commandes ni tes agents. Bien pour discuter ou brainstormer, pas pour appliquer tes standards sur un repo.

## La règle simple

| Tu veux… | Va dans… |
|---|---|
| Coder, brancher, reviewer un projet | Claude Code |
| Un Supabase (ou autre MCP) par projet | Claude Code |
| Tes commandes `/…` et tes agents | Claude Code |
| Juste poser une question, réfléchir | Claude Desktop |

Test mental : si tu tapes `/brancher` et qu'il ne se passe rien, tu es probablement dans Desktop, pas dans Code.
