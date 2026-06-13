#!/usr/bin/env bash
# Crée un jeu de labels cohérent sur le repo GitHub courant.
# Requiert gh authentifié. Idempotent : --force met à jour si le label existe déjà.
set -euo pipefail

label() { gh label create "$1" --color "$2" --description "$3" --force; }

label "type:bug"      "d73a4a" "Quelque chose ne marche pas"
label "type:feat"     "0e8a16" "Nouvelle fonctionnalité"
label "type:refactor" "5319e7" "Refactoring, sans changement de comportement"
label "type:docs"     "0075ca" "Documentation"
label "type:chore"    "cfd3d7" "Tâche technique, maintenance"
label "prio:haute"    "b60205" "À traiter en priorité"
label "prio:basse"    "fbca04" "Peut attendre"

echo "Labels à jour."
