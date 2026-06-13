#!/usr/bin/env bash
# Met à jour le socle : récupère la dernière version puis réinstalle.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
echo "Mise à jour de Claude Setup…"
git pull --ff-only
./install.sh
