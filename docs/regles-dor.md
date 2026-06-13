# Les règles d'or

Les invariants. Ils s'appliquent à **tous** les projets, quel que soit le langage ou la structure. Ce qui n'est pas listé ici peut varier d'un projet à l'autre.

1. **Tout projet a un remote GitHub** et y est poussé. Le local seul ne compte pas.
2. **Le working tree est propre** avant de passer à autre chose : rien en suspens, rien d'oublié.
3. **Commits conventionnels** (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`…), écrits en voix humaine.
4. **Aucun secret dans le dépôt.** `.env`, clés, tokens : ignorés et jamais commités.
5. **Un `.gitignore` adapté** au(x) langage(s) du projet.
6. **Un README** qui dit quoi, pourquoi, et comment lancer.
7. **Formatage et lint automatiques** via les hooks (lefthook), avec les outils du langage détecté.
8. **Les décisions d'archi sont tracées** en ADR (`docs/adr/`).
9. **Voix humaine partout** (voir `voix.md`).
10. **Chaque projet déclare son profil** dans `.dev-standards.yml`.
