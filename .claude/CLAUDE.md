# CLAUDE.md — www.thebiggerguy.com

Personal site for **Guy Taylor** (aka TheBiggerGuy) — a software engineer in
Edinburgh. Portfolio, projects, photography, and contributions.

## What this site is

- Static site built with **Hugo** (no JS framework, no npm build pipeline)
- Deployed to **AWS S3 + CloudFront** in **eu-west-1**
- Infrastructure defined in **CloudFormation** (`cloudformation.yaml`)
- Content sections: about, projects, photography, contributions

## Current tech stack

| Component | Current version | Notes |
|---|---|---|
| Hugo | 0.123.7 | Extended edition, SHA256-pinned in `.ci/versions.sh`. |
| Bootstrap | 4.2.1 | Via Hugo module `github.com/twbs/bootstrap`. |
| CI/CD | GitHub Actions | `.github/workflows/` + `.ci/` scripts. |
| Go | 1.15 (go.mod) / 1.21 (devcontainer) / ^1.11.13 (workflows) | For Hugo module resolution. |
| AWS CLI | 2.15.28 via pip-from-git | OpenSSL-workaround install. |
| IaC | CloudFormation | S3 data bucket, logging bucket, CloudFront, budget. Deployed in deploy.sh. |
| AWS region | eu-west-1 | Owner is UK-based. |
| Analytics | Google Analytics (UA-126221439-1) | Universal Analytics (sunset July 2023). |
| Language | en-gb | |

## Project layout

```
/
├── .ci/                 # CI scripts (versions.sh, install_*.sh, test.sh, deploy.sh, lint_cf.sh, spell_check.sh, archive.sh)
├── .github/workflows/   # GitHub Actions (test.yaml, deploy.yaml)
├── .devcontainer/       # Dev container (Go, Node, cfn-lint)
├── cloudformation.yaml  # AWS infra: budget, S3 data + logging buckets, CloudFront
├── site/
│   ├── config.toml      # Hugo config
│   ├── go.mod           # Hugo module deps (Bootstrap)
│   ├── assets/          # SCSS / JS
│   ├── content/         # Markdown (about, projects, photography, contributions)
│   ├── layouts/         # Hugo HTML templates (no external theme)
│   ├── static/          # favicon, etc.
│   └── data/
└── local-hugo           # Dev wrapper — installs pinned Hugo, then runs it
```

## Running locally

```bash
./local-hugo server
```

Installs the pinned Hugo version (via `.ci/install_hugo.sh`) and serves on 1313.

## GitHub Actions security policy

Goal: maximum supply-chain security. When writing/updating workflows:
- **SHA-pin every action** — `owner/action@<full-sha> # vX.Y.Z`. No floating tags.
- **Prefer first-party actions** (`actions/*`, `aws-actions/*`). Justify third-party.
- **Minimise external actions** — prefer a `.ci/*.sh` script over a new action.
- **OIDC only** for AWS — no long-lived credentials.
- **Least-privilege `permissions:`** per job; default `contents: read`.
- **Pinned runner** — explicit Ubuntu version, not `ubuntu-latest`.

## Spell checking

`.ci/test.sh` builds the site, then `.ci/spell_check.sh` runs **cspell** over
`site/public/**/*.html`. The script invokes it with `npm exec` (not `npx` —
deprecated), pulling `cspell` + `@cspell/dict-en-gb` at versions pinned in
`.ci/versions.sh` (`CSPELL_VERSION`, `CSPELL_DICT_EN_GB_VERSION`); version-only,
no SHA (npm verifies registry integrity). The npm download cache (`~/.npm`) is
cached in CI alongside `~/.local`. Config is `.cspell.json` (`language: en-GB`).

Non-obvious cspell behaviour (learned the hard way):
- **`cspell --config <file>` MERGES with the auto-discovered `.cspell.json`, it
  does not replace it.** Tests run with `--config` while a populated `cspell.json`
  exists are contaminated — the repo words stay active. Test against the real
  `cspell.json` (or a clean dir).
- **Case-boundary splitting** (`allowCompoundWords` off by default): `FontAwesome`
  → `Font`+`Awesome`, `GnuCash` → `Gnu`+`Cash` — accepted if every part is known,
  so such compounds need no custom word. It will NOT accept arbitrary
  concatenations (`helloworld`). A typo slips only if it splits into all-real
  words (`InThe`); single-token misspellings are caught.
- Custom words live in `project-words.txt` (a cspell text dictionary wired in via
  `dictionaryDefinitions`/`dictionaries` in `.cspell.json`), grouped with `#`
  comments — including transliterations for the Thai phrases (cspell DOES flag
  non-Latin scripts). Inline `# comment` after a word works. It holds only what's
  genuinely unknown: proper nouns (NZ/Danish/Thai place names), product names,
  acronyms. Generic tech terms are covered by cspell's default bundled
  dictionaries — no extra dict packages needed.
- `ignoreRegExpList: ["CommitHash"]` skips the footer git SHA (`footer.html`
  `.GitInfo.Hash`), replacing the old `git log >> .hunspell_default` hack. The
  `integrity="…"` regex skips SRI base64 hashes (Hugo `resources.Fingerprint`),
  which otherwise yield false positives like `Grcq`/`pqir`.
