# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on **[Keep a Changelog](https://keepachangelog.com/en/1.1.0/)**
and this project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**.

---

## [Unreleased]

### Planned

- Review the Persistence classification contract (`pattern`, `persist`, `IsPrs`, and `WellFormed`) for semantic consistency and independently justified interpretation.
- Test the distinction between identity-breaking transformations, generated identity, and independently supplied distinct-commitments.
- Extend SS-002 to compare geometric attractor persistence and weighted-system persistence using separate referent carriers and justified identity criteria.
- Examine the relationship between Persistence dynamics and Neutral Substrate persistence accounts, including eligible stages and settings.
- Record whether the experiments establish substantive results, reveal underdetermination, or demonstrate a need for upstream theory changes.

---

## [0.1.0] - 2026-10-20

### Added

- Initial Lean 4 formal verification testbed for Structural Explainability using mathematical self-similarity cases.
- **SS-001: Address Collision** - distinct symbolic addresses, shared point representations, and coding uniqueness.
- **SS-002: Reweighting** - equal geometric attractors with different first-symbol probability distributions.
- Formal bridges to canonical SE Individuation, Coreference, and Persistence theories.
- Concrete individuation settings, co-reference commitment comparisons, and persistence classification tests.
- Lean verification library, tests, and lint driver.
- Case registry with mathematical results, interpretation limits, prospective predictions, and unresolved scientific obligations.
- Upstream provenance registry documenting mathematical sources and SE theory dependencies.
- Zensical documentation tooling.

### Research Status

- Mathematical results and formal bridges are separated from their scientific interpretations.
- Independent justification of referent-specific identity criteria remains an open research obligation.
- Prospective scientific tests are recorded but not yet resolved.

---

## Notes on Versioning and Releases

- We use **SemVer**:
  - **MAJOR** - breaking changes
  - **MINOR** - backward-compatible features
  - **PATCH** - fixes, documentation, tests, tooling
- Versions are driven by git tags.
- Tag `vX.Y.Z` to release.

## Release Procedure (Required)

Follow these steps exactly when creating a new release.

### Task 1. Update release metadata (manual edits)

1.1. `CITATION.cff` - update `version` and `date-released`
1.2. `CHANGELOG.md` - add section, move unreleased entries, update links
1.3. `pyproject.toml` - update project version (towards the top)

### Task 2. Validate

```pwsh
# set up or update Python environment
# Run repository checks.
.\sit.ps1

# Update GitHub Actions and pin all action references to immutable SHAs.
uvx gha-tools autoupdate --pin=all --write .github/workflows

# Audit the resulting GitHub configuration for security findings.
# NO .github\workflows\deploy-zensical.yml
# YES  .github\workflows\deploy-zensical-lean.yml
uvx zizmor@latest .github/

# Validate.
uvx cffconvert --validate
uvx se-manifest-schema validate-manifest --strict

# Format Markdown.
npx markdownlint-cli2 --fix

# update lean after fresh clone or manifest change
elan self update
lake exe cache get
lake build
lake test
lake lint

.\rel.ps1
```

### Task 3. Commit, push, tag

```shell
git add -A
git commit -m "Prepare X.Y.Z"
git push -u origin main
```

Verify actions run on GitHub. After success:

```shell
git tag vX.Y.Z -m "X.Y.Z"
git push origin vX.Y.Z
```

## Only As Needed (delete a tag)

```shell
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```

## Links

[Unreleased]: https://github.com/structural-explainability/se-verification-self-similarity/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/structural-explainability/se-verification-self-similarity/releases/tag/v0.1.0

<!-- markdownlint-enable MD024 -->
