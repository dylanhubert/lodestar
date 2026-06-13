# Templates

Les fichiers que `/brancher` copie dans un projet pour le mettre aux normes. À distinguer des configs à la racine du repo, qui régissent claude-setup lui-même : ceux-ci sont destinés à être déposés dans tes **autres** projets.

`/brancher` ne copie que ce qui correspond aux langages détectés :

- `.editorconfig`, `lefthook.yml` — tous les projets.
- `commitlint.config.js` — valide les messages de commit (Conventional Commits).
- `biome.json` — projets JS/TS. `ruff.toml` — projets Python.
- `gitignore/<langage>.gitignore` — base de `.gitignore` selon le langage.
- `github/workflows/qualite.yml` — CI. `github/ISSUE_TEMPLATE/` — templates d'issue. `labels.sh` — labels cohérents.
- `standards.example.yml` — le format du marqueur `.standards.yml` déposé à la racine du projet.
