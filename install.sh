#!/usr/bin/env bash
# Installe les commandes et les règles globales de dev-standards dans ~/.claude.
# Idempotent : relançable sans risque.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR/commands"

# Commandes : symlink vers le repo, qui reste la source versionnée.
for cmd in "$REPO"/claude/commands/*.md; do
  name="$(basename "$cmd")"
  ln -sf "$cmd" "$CLAUDE_DIR/commands/$name"
  echo "✓ commande installée : /$(basename "$name" .md)"
done

# Règles globales.
if [ -e "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
  echo "! ~/.claude/CLAUDE.md existe déjà (vrai fichier). Je ne l'écrase pas."
  echo "  Reporte le contenu de claude/CLAUDE.md à la main, ou supprime le fichier puis relance."
else
  ln -sf "$REPO/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "✓ règles globales installées : ~/.claude/CLAUDE.md"
fi

# Dépendances.
command -v gh >/dev/null       || echo "! gh absent (brew install gh) — requis pour GitHub"
command -v lefthook >/dev/null || echo "! lefthook absent (brew install lefthook) — requis pour les hooks"

echo
echo "Terminé. Recharge Claude Code pour voir /brancher et /check."
