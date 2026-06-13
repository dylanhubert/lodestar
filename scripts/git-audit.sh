#!/usr/bin/env bash
# Audit de l'état Git d'un projet : remote, push, propreté, secrets.
# Rapport lisible. Code retour 0 si tout est vert, 1 sinon.
# Usage : scripts/git-audit.sh [chemin]   (défaut : répertoire courant)
set -uo pipefail

root="${1:-.}"
cd "$root" || exit 1

fail=0
ok()   { printf "  \033[32m✓\033[0m %s\n" "$1"; }
warn() { printf "  \033[33m!\033[0m %s\n" "$1"; fail=1; }

echo "Audit Git — $(pwd)"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  warn "Pas un dépôt git (git init manquant)"
  exit 1
fi

# Remote configuré ?
if git remote get-url origin >/dev/null 2>&1; then
  ok "Remote 'origin' : $(git remote get-url origin)"
else
  warn "Aucun remote 'origin' — le projet n'existe qu'en local"
fi

# Travail non commité ?
if [ -n "$(git status --porcelain)" ]; then
  warn "Modifications non commitées dans le working tree"
else
  ok "Working tree propre"
fi

# Commits locaux non poussés ?
upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"
if [ -n "$upstream" ]; then
  ahead="$(git rev-list --count '@{u}'..HEAD 2>/dev/null || echo 0)"
  if [ "$ahead" -gt 0 ]; then
    warn "$ahead commit(s) local(aux) non poussé(s) vers $upstream"
  else
    ok "Branche à jour avec $upstream"
  fi
else
  warn "Branche courante non suivie (pas d'upstream défini)"
fi

# .gitignore présent ?
if [ -f .gitignore ]; then ok ".gitignore présent"; else warn ".gitignore manquant"; fi

# Secrets potentiels suivis par git ?
if git ls-files 2>/dev/null | grep -qiE '(^|/)\.env($|\.)|id_rsa|\.pem$|\.p12$|\.key$'; then
  warn "Fichiers sensibles suivis par git (.env, clés…) — à retirer du suivi"
else
  ok "Aucun fichier sensible évident suivi par git"
fi

echo
if [ "$fail" -eq 0 ]; then
  echo "Résultat : tout est vert."
else
  echo "Résultat : des points à corriger (voir les ! ci-dessus)."
fi
exit "$fail"
