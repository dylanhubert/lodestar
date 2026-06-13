#!/usr/bin/env node
// Audit de l'état Git d'un projet : remote, push, identité, propreté, secrets.
// Cross-platform (Node + git). Code retour 0 si tout est vert, 1 sinon.
// Usage : node scripts/git-audit.js [chemin]   (défaut : répertoire courant)
"use strict";
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const root = process.argv[2] || ".";
let fail = 0;
const G = "\x1b[32m", Y = "\x1b[33m", R = "\x1b[0m";
const ok = (m) => console.log(`  ${G}✓${R} ${m}`);
const warn = (m) => { console.log(`  ${Y}!${R} ${m}`); fail = 1; };
const info = (m) => console.log(`  · ${m}`);
const git = (args) => {
  try { return execFileSync("git", args, { cwd: root, encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] }).trim(); }
  catch { return null; }
};
const have = (cmd) => { try { execFileSync(cmd, ["--version"], { stdio: "ignore" }); return true; } catch { return false; } };

console.log("Audit Git — " + path.resolve(root));

if (git(["rev-parse", "--is-inside-work-tree"]) !== "true") { warn("Pas un dépôt git (git init manquant)"); process.exit(1); }

const origin = git(["remote", "get-url", "origin"]);
origin ? ok(`Remote 'origin' : ${origin}`) : warn("Aucun remote 'origin' — le projet n'existe qu'en local");

git(["status", "--porcelain"]) ? warn("Modifications non commitées dans le working tree") : ok("Working tree propre");

const upstream = git(["rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}"]);
if (upstream) {
  const ahead = parseInt(git(["rev-list", "--count", "@{u}..HEAD"]) || "0", 10);
  ahead > 0 ? warn(`${ahead} commit(s) local(aux) non poussé(s) vers ${upstream}`) : ok(`Branche à jour avec ${upstream}`);
} else warn("Branche courante non suivie (pas d'upstream défini)");

// Identité git : tes commits seront-ils bien à toi ?
const idName = git(["config", "user.name"]) || "";
const idEmail = git(["config", "user.email"]) || "";
if (!idName || !idEmail) warn(`Identité git incomplète (name='${idName}' email='${idEmail}') — tes commits seront mal attribués`);
else if (/^(t@t\.t|test@|you@example|user@example|root@|.*@(localhost|example\.com))$/i.test(idEmail)) warn(`Identité git suspecte : ${idName} <${idEmail}> (placeholder) — corrige-la avant de commiter`);
else ok(`Identité git : ${idName} <${idEmail}>`);

fs.existsSync(path.join(root, ".gitignore")) ? ok(".gitignore présent") : warn(".gitignore manquant");

// Fichiers sensibles suivis par git (on ignore .example/.sample et les clés .pub).
const files = (git(["ls-files"]) || "").split("\n").filter(Boolean);
const suspects = files.filter((f) =>
  !/\.(example|sample|dist|template)$|\.pub$/i.test(f) &&
  /(^|\/)\.env($|\.)|(^|\/)id_rsa$|\.pem$|\.p12$|\.key$|(^|\/)credentials$|(^|\/)settings\.local\.json$/i.test(f)
);
if (suspects.length) { warn("Fichiers sensibles suivis par git (à retirer du suivi) :"); suspects.forEach((s) => console.log("      " + s)); }
else ok("Aucun fichier sensible évident suivi par git");

// Scan de contenu si gitleaks est présent.
if (have("gitleaks")) {
  try { execFileSync("gitleaks", ["detect", "--no-banner"], { cwd: root, stdio: "ignore" }); ok("gitleaks : aucun secret détecté"); }
  catch { warn("gitleaks a détecté des secrets potentiels — lance 'gitleaks detect --no-banner' pour le détail"); }
} else info("gitleaks absent : seuls les noms de fichiers sont vérifiés (brew install gitleaks)");

console.log("");
console.log(fail === 0 ? "Résultat : tout est vert." : "Résultat : des points à corriger (voir les ! ci-dessus).");
process.exit(fail);
