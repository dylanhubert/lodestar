# Où ça marche : Claude Code vs Claude Desktop

Lodestar est un plugin **Claude Code**. La vraie question, c'est de savoir où tourne Claude Code.

## Claude Code — c'est là que vit Lodestar

Le terminal, l'app Code, les extensions VS Code / JetBrains, claude.ai/code, **et les modes Code et Cowork de l'app Claude Desktop** (qui sont du Claude Code). Ça tourne dans un dossier de projet. C'est là que marchent :

- tes commandes : `/brancher`, `/check`, `/revue`, `/sans-ia`, `/mcp`, `/aide`, `/setup` ;
- tes agents : `code-reviewer`, `security-auditor`, `test-writer`, `release-manager` ;
- le `.mcp.json` par projet.

## Le mode Chat de Claude Desktop — non

Le **Chat** classique de l'app Desktop ne fait pas tourner de plugins : pas de commandes, pas d'agents, pas de notion de projet. Bien pour discuter ou brainstormer, pas pour appliquer tes standards sur un repo.

## La règle simple

| Tu veux… | Où |
|---|---|
| Coder, brancher, reviewer un projet | Claude Code, ou Desktop en mode Code/Cowork |
| Tes commandes `/…` et tes agents | idem |
| Juste poser une question, réfléchir | Chat (Desktop ou web) |

Test mental : si tu tapes `/brancher` et qu'il ne se passe rien, tu es probablement en mode Chat, pas en Code/Cowork.
