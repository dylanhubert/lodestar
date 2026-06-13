#!/usr/bin/env node
// Détecte les langages et l'archétype d'un projet à partir de signaux concrets.
// Cross-platform (Node) : aucun shell requis.
// Usage : node scripts/detect.js [chemin]   (défaut : répertoire courant)
"use strict";
const fs = require("fs");
const path = require("path");

const root = process.argv[2] || ".";
const has = (f) => fs.existsSync(path.join(root, f));
const isDir = (f) => { try { return fs.statSync(path.join(root, f)).isDirectory(); } catch { return false; } };
const read = (f) => { try { return fs.readFileSync(path.join(root, f), "utf8"); } catch { return ""; } };

const langs = new Set();
if (has("package.json")) langs.add("javascript/typescript");
if (has("pyproject.toml") || has("requirements.txt")) langs.add("python");
if (has("go.mod")) langs.add("go");
if (has("composer.json")) langs.add("php");
if (has("Cargo.toml")) langs.add("rust");
if (has("Gemfile")) langs.add("ruby");
if (has("pom.xml")) langs.add("java");
if (has("build.gradle")) langs.add("java/kotlin");

// Archétype : front -> web, serveur -> api.
const pkg = read("package.json");
const webRe = /"(@(vue|sveltejs|angular|nuxt)\/[a-z0-9-]+|(react|react-dom|preact|vue|svelte|next|nuxt|solid-js|astro)([-/"]))/i;
const apiRe = /"(@nestjs\/[a-z0-9-]+|(express|fastify|koa|hapi|restify)([-/"]))/i;

let archetype = "inconnu";
if (pkg && webRe.test(pkg)) archetype = "application web";
else if (pkg && apiRe.test(pkg)) archetype = "service / api";
else if (has("go.mod") && isDir("cmd")) archetype = "cli (go)";
else if (has("pyproject.toml") && /\[project\.scripts\]|console_scripts/.test(read("pyproject.toml"))) archetype = "cli / lib (python)";
else if (has("index.html") && !has("package.json")) archetype = "site statique";
else if (has("Dockerfile") && (has("package.json") || has("pyproject.toml") || has("go.mod") || has("composer.json"))) archetype = "service / api";

console.log("Langages détectés  : " + (langs.size ? [...langs].sort().join(" ") : "aucun"));
console.log("Archétype probable : " + archetype);
