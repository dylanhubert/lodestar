#!/usr/bin/env node
// Installe Lodestar dans ~/.claude (commandes + agents), pour Claude Desktop ou tout
// environnement qui lit ~/.claude mais n'a pas la commande /plugin.
// Cross-platform (Node). Usage : node install.js   (depuis le dépôt cloné)
"use strict";
const fs = require("fs");
const path = require("path");
const os = require("os");

const pluginRoot = path.join(__dirname, "lodestar");
const claudeDir = path.join(os.homedir(), ".claude");
const cmdDir = path.join(claudeDir, "commands");
const agentDir = path.join(claudeDir, "agents");

if (!fs.existsSync(path.join(pluginRoot, "skills"))) {
  console.error("Erreur : dossier lodestar/skills introuvable. Lance ce script depuis la racine du dépôt cloné.");
  process.exit(1);
}

fs.mkdirSync(cmdDir, { recursive: true });
fs.mkdirSync(agentDir, { recursive: true });

// Les fichiers utilisent ${CLAUDE_PLUGIN_ROOT} (contexte plugin) ; hors plugin on le
// remplace par le chemin absolu du dossier cloné.
const resolve = (txt) => txt.split("${CLAUDE_PLUGIN_ROOT}").join(pluginRoot);

let nCmd = 0;
const skillsDir = path.join(pluginRoot, "skills");
for (const name of fs.readdirSync(skillsDir)) {
  const skill = path.join(skillsDir, name, "SKILL.md");
  if (fs.existsSync(skill)) {
    fs.writeFileSync(path.join(cmdDir, name + ".md"), resolve(fs.readFileSync(skill, "utf8")));
    nCmd++;
  }
}

let nAgent = 0;
const agentsSrc = path.join(pluginRoot, "agents");
for (const f of fs.readdirSync(agentsSrc)) {
  if (f.endsWith(".md")) {
    fs.writeFileSync(path.join(agentDir, f), resolve(fs.readFileSync(path.join(agentsSrc, f), "utf8")));
    nAgent++;
  }
}

console.log(`Lodestar installé : ${nCmd} commandes, ${nAgent} agents dans ${claudeDir}`);
console.log("Redémarre Claude, puis lance /setup, puis /brancher dans un projet.");
