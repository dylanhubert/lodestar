---
description: Comprend le code en profondeur puis propose review, corrections, optimisations et nettoyage de structure, sans rien casser.
argument-hint: "[chemin ou rien — projet courant]"
allowed-tools: Bash, Read, Write, Edit, Grep, Glob
---

Tu fais une revue complète et propre du projet courant. Objectif : un code compris en profondeur, corrigé, optimisé, bien structuré. Non destructif : tout passe par une branche et des propositions validées.

Périmètre : `/revue` = qualité **interne** du code. La conformité **externe** (fichiers, Git, CI, profil), c'est `/brancher`.

## 1. Comprendre

Détecte les langages (`~/dev/claude-setup/scripts/detect.sh`), repère les points d'entrée, les modules, le flux de données. Donne-moi une carte courte : à quoi sert le projet, comment il est organisé, où sont les zones sensibles.

## 2. Revue

Sur un gros périmètre, délègue aux agents spécialisés et synthétise leurs retours : `code-reviewer` (bugs et qualité) et, sur les modules sensibles, `security-auditor`. Tu peux les lancer via le tool Agent ou en `@`-mention.

Passe le code au crible et classe les trouvailles par priorité :

- **Correction** : bugs réels, cas limites non gérés, erreurs de logique.
- **Sécurité** : secrets, injections, validation des entrées, dépendances douteuses.
- **Optimisation** : complexité inutile, requêtes ou allocations coûteuses, code mort, duplication.
- **Structure** : découpage, responsabilités mélangées, nommage, couches.

Pour chaque trouvaille : où, pourquoi ça compte, le correctif proposé. Sépare clairement le sûr de l'incertain.

## 3. Appliquer

Sur une branche `chore/revue` :

- applique d'abord les corrections sûres et à faible risque ;
- présente les refactorings de structure en diff, je valide au cas par cas ;
- ne change jamais un comportement attendu sans le signaler ;
- tout code ou commentaire produit suit la voix humaine (`~/dev/claude-setup/docs/voix.md`).

## 4. Vérifier

Lance les tests s'il y en a. Si une zone critique que tu viens de toucher n'est pas couverte, propose-m'en (l'agent `test-writer` peut s'en charger). Termine par un récap : corrigé, optimisé, restructuré, et ce qui reste à valider.
