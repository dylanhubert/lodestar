#!/usr/bin/env bash
# Installe les commandes, les agents et les règles globales de claude-setup dans ~/.claude.
# Idempotent : relançable sans risque.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CANONICAL="$HOME/dev/claude-setup"

if [ "$REPO" != "$CANONICAL" ]; then
  echo "! Ce repo est à $REPO, pas à $CANONICAL."
  echo "  Les commandes référencent le chemin canonique. Clone-le à $CANONICAL pour éviter des liens cassés."
  echo "  Et ne déplace pas le repo après l'install : si tu le bouges, relance install.sh."
fi

mkdir -p "$CLAUDE_DIR/commands" "$CLAUDE_DIR/agents"

# Pose un symlink sans jamais écraser un vrai fichier existant.
# Retourne 0 si le lien est posé, 1 s'il a été refusé.
link() {  # link <source> <destination> <label>
  local src="$1" dest="$2" label="$3"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "! $dest existe déjà (vrai fichier) — non remplacé."
    return 1
  fi
  ln -sf "$src" "$dest"
  echo "✓ $label"
}

commands=""

# Commandes
for cmd in "$REPO"/claude/commands/*.md; do
  [ -e "$cmd" ] || continue
  base="$(basename "$cmd" .md)"
  if link "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")" "commande : /$base"; then
    commands="$commands /$base"
  fi
done

# Agents
for ag in "$REPO"/claude/agents/*.md; do
  [ -e "$ag" ] || continue
  link "$ag" "$CLAUDE_DIR/agents/$(basename "$ag")" "agent : $(basename "$ag" .md)" || true
done

# Règles globales
link "$REPO/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md" "règles globales : ~/.claude/CLAUDE.md" || true

# Réglage Claude Code : pas de signature IA dans les commits. Réappliqué sur chaque machine.
if command -v python3 >/dev/null; then
  python3 - "$CLAUDE_DIR/settings.json" <<'PY'
import json, os, sys, tempfile
p = sys.argv[1]
if os.path.exists(p):
    try:
        with open(p) as fh:
            data = json.load(fh)
    except Exception:
        print("! settings.json existe mais est illisible (JSON invalide) — je n'y touche pas.")
        print('  Ajoute "includeCoAuthoredBy": false toi-même, ou corrige le fichier puis relance.')
        sys.exit(0)
    if not isinstance(data, dict):
        print("! settings.json n'est pas un objet JSON — je n'y touche pas.")
        sys.exit(0)
else:
    data = {}
if data.get("includeCoAuthoredBy") is not False:
    data["includeCoAuthoredBy"] = False
    d = os.path.dirname(p) or "."
    fd, tmp = tempfile.mkstemp(dir=d, suffix=".tmp")
    with os.fdopen(fd, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")
    os.replace(tmp, p)
    print("✓ settings.json : includeCoAuthoredBy = false")
else:
    print("✓ settings.json : déjà sans signature IA")
PY
else
  echo "! python3 absent — settings.json NON configuré."
  echo '  Ajoute "includeCoAuthoredBy": false dans ~/.claude/settings.json à la main,'
  echo "  sinon les commits peuvent porter une signature IA."
fi

# Identité git : les commits doivent toujours être à mon nom, quel que soit l'environnement.
want_name="Dylan HUBERT"
want_email="contact@dylan-hubert.fr"
cur_name="$(git config --global user.name || true)"
cur_email="$(git config --global user.email || true)"
if [ "$cur_name" != "$want_name" ] || [ "$cur_email" != "$want_email" ]; then
  git config --global user.name "$want_name"
  git config --global user.email "$want_email"
  echo "✓ identité git imposée : $want_name <$want_email> (était : ${cur_name:-vide} <${cur_email:-vide}>)"
else
  echo "✓ identité git : $want_name <$want_email>"
fi

# Dépendances
command -v gh >/dev/null       || echo "! gh absent (brew install gh) — requis pour GitHub"
command -v lefthook >/dev/null || echo "! lefthook absent (brew install lefthook) — requis pour les hooks"
command -v gitleaks >/dev/null || echo "! gitleaks absent (brew install gitleaks) — scan de secrets plus poussé (optionnel)"

echo
echo "Terminé. Commandes :${commands}."
echo "Recharge Claude Code pour les voir, ainsi que les agents."
