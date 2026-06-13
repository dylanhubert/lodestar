#!/usr/bin/env bash
# Détecte les langages et devine l'archétype d'un projet à partir de signaux concrets.
# Le langage n'est jamais supposé : on le lit dans les manifestes et la structure.
# Usage : scripts/detect.sh [chemin]   (défaut : répertoire courant)
set -uo pipefail

root="${1:-.}"
cd "$root" || exit 1

langs=()
have() { [ -e "$1" ]; }

have package.json     && langs+=("javascript/typescript")
have pyproject.toml   && langs+=("python")
have requirements.txt && langs+=("python")
have go.mod           && langs+=("go")
have composer.json    && langs+=("php")
have Cargo.toml       && langs+=("rust")
have Gemfile          && langs+=("ruby")
have pom.xml          && langs+=("java")
have build.gradle     && langs+=("java/kotlin")

# Dédoublonnage (globbing désactivé le temps de l'expansion : valeurs contrôlées, mais on se protège).
if [ "${#langs[@]}" -gt 0 ]; then
  set -f
  langs=($(printf "%s\n" "${langs[@]}" | sort -u))
  set +f
fi

# Archétype, par signaux structurels.
# Front (react/vue/svelte/next/nuxt…) -> web ; serveur (express/fastify/nest…) -> api.
web_re='"(@(vue|sveltejs|angular|nuxt)/[a-z0-9-]+|(react|react-dom|preact|vue|svelte|next|nuxt|solid-js|astro)([-/"]|$))'
api_re='"(@nestjs/[a-z0-9-]+|(express|fastify|koa|hapi|restify)([-/"]|$))'

archetype="inconnu"
if [ -f package.json ] && grep -qiE "$web_re" package.json 2>/dev/null; then
  archetype="application web"
elif [ -f package.json ] && grep -qiE "$api_re" package.json 2>/dev/null; then
  archetype="service / api"
elif have go.mod && [ -d cmd ]; then
  archetype="cli (go)"
elif have pyproject.toml && grep -qiE '\[project\.scripts\]|console_scripts' pyproject.toml 2>/dev/null; then
  archetype="cli / lib (python)"
elif [ -f index.html ] && ! have package.json; then
  archetype="site statique"
elif have Dockerfile && { have package.json || have pyproject.toml || have go.mod || have composer.json; }; then
  archetype="service / api"
fi

echo "Langages détectés  : ${langs[*]:-aucun}"
echo "Archétype probable : $archetype"
