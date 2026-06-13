---
description: Détecte et retire les marques d'IA d'un projet (commits, fichiers, contenu) pour qu'il passe pour 100 % humain.
argument-hint: "[rien — agit sur le projet courant]"
allowed-tools: Bash, Read, Write, Edit, Grep, Glob
---

Tu nettoies le projet courant de toute trace d'IA. Objectif : qu'il passe pour entièrement écrit par moi. Deux temps : constater, puis nettoyer avec mon accord. Rien d'irréversible sans confirmation.

## 1. Scanner

Lance `~/dev/claude-setup/scripts/scan-ia.sh`. Présente un rapport classé par nature :

- **Fichiers** : `CLAUDE.md`, `.claude/`, `.cursor*`, configs d'outils IA versionnées.
- **Contenu** : commentaires/docs mentionnant une IA (candidats à vérifier — un vrai prénom « Claude » est un faux positif).
- **Historique git** : commits avec trailer `Co-authored-by: Claude`, « Generated with… », auteur/committer Anthropic.

Rappelle qu'au passage le futur est déjà couvert : `includeCoAuthoredBy:false` et la voix humaine évitent les nouvelles marques.

## 2. Contenu et fichiers (sûr)

Avec mon accord :

- retire ou déversionne les fichiers d'outils IA qui n'ont rien à faire dans le repo (et ajoute-les au `.gitignore` si besoin) ;
- réécris en voix humaine (`~/dev/claude-setup/docs/voix.md`) les commentaires et docs qui sonnent IA, sans changer le comportement du code.

## 3. Historique git (sensible — confirmation explicite)

C'est l'étape qui réécrit le passé. Explique-moi clairement AVANT d'agir :

- réécrire l'historique change tous les hash de commits et impose un `git push --force` ;
- sûr pour un repo solo ou non partagé ; risqué si d'autres ont déjà cloné (ça casse leurs copies).

Demande-moi si le repo est partagé. Si je confirme :

- fais d'abord une sauvegarde : `git branch backup-avant-nettoyage`.
- privilégie `git filter-repo` (`brew install git-filter-repo`) pour retirer les trailers `Co-authored-by: Claude` et réécrire l'auteur/committer Anthropic vers `Dylan HUBERT <contact@dylan-hubert.fr>` (via `--mailmap` ou `--commit-callback`) ;
- à défaut, propose un rebase interactif pour les commits récents seulement.
- termine en me donnant la commande exacte de force-push à lancer.

## 4. Vérifier

Relance `scan-ia.sh` et confirme qu'il ne reste rien.
