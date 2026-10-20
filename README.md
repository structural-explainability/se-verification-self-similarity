# se-verification-self-similarity

[![Docs Site](https://img.shields.io/badge/docs-site-blue?logo=github)](https://structural-explainability.github.io/se-verification-self-similarity/)
[![Repo](https://img.shields.io/badge/repo-GitHub-black?logo=github)](https://github.com/structural-explainability/se-verification-self-similarity)
[![License](https://img.shields.io/badge/license-MIT-yellow.svg)](./LICENSE)

[![CI](https://github.com/structural-explainability/se-verification-self-similarity/actions/workflows/ci-python-zensical.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-verification-self-similarity/actions/workflows/ci-python-zensical.yml)
[![Docs Deploy](https://github.com/structural-explainability/se-verification-self-similarity/actions/workflows/deploy-zensical.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-verification-self-similarity/actions/workflows/deploy-zensical.yml)

> Independent Lean 4 mathematical verification testbed
> examining individuation, co-reference, and persistence
> in Structural Explainability.

## Purpose

This repository develops mathematical examples and counterexamples
to examine Structural Explainability (SE) theories
against independently established mathematical facts.

The initial subject is **self-similar mathematical systems**,
particularly relationships among symbolic addresses, denoted points,
generated structures, probability weights, and transformations.

The repository belongs to the **Verification and Executable Research**
category of the Structural Explainability research program.
It does not define new canonical SE theory semantics.

## Research Questions

The investigation asks:

1. When can distinct symbolic presentations denote the same mathematical point?
2. How do symbolic addresses, finite transformations, and denoted points differ?
3. When can mathematical structure remain invariant while properties of its generating system change?
4. What do canonical SE individuation, co-reference, and persistence definitions
   establish under specified interpretations?
5. Which conclusions are mathematically established, interpretation-dependent, inconsistent, or unresolved?

The objective is to expose and evaluate the assumptions required for SE identity judgments,
not to infer referent identity from mathematical equality alone.

## Mathematical Cases

### SS-001: Address Collision

Two distinct infinite binary addresses represent the same real point.

The case distinguishes symbolic address equality,
finite-word affine transformations, and
point representation.

Proved and open properties of the coding relation are recorded in the
[case registry](reference/cases.toml).

The SE bridges examine:

- **Individuation:** successful and unsuccessful structural settings
  using denotation supports, including conditions for same-unit judgments.
- **Coreference:** alternative context-indexed accounts, common-point witnesses, and
  consistency or inconsistency with supplied distinct-commitments.

The formal constructions do not independently establish
that the selected individuation or co-reference criteria
are scientifically warranted.

### SS-002: Reweighting

Two weighted systems assign finite first-symbol probabilities
to the two generating transformations.
They have the same geometric attractor but
different probability distributions.

The Persistence bridge compares classifications
over an explicitly declared reweighting step
on a single carrier of weighted systems.
The resulting generated identity judgment depends on which
transformations are classified as preserving.

The case also examines the soundness and completeness
of the attractor presentation under a specified model.

The persistence classifications are declared choices.
The formal results do not independently establish
which classification is scientifically justified
for an intended referent.

See [Mathematical Cases](docs/en/cases.md) and the
[case registry](reference/cases.toml) for the authoritative
case scope, theorem references, results, and limitations.

## Relationship to SE Theory

The repository consumes canonical definitions and results from:

- [Neutral Substrate](https://github.com/structural-explainability/se-theory-neutral-substrate)
- [Individuation](https://github.com/structural-explainability/se-theory-individuation)
- [Coreference](https://github.com/structural-explainability/se-theory-coreference)
- [Persistence](https://github.com/structural-explainability/se-theory-persistence)

The mathematical cases are constructed separately from their SE interpretation bridges.

The bridges use the canonical theory interfaces
without changing the definitions owned by the upstream repositories.

The testbed establishes what follows under explicit formal assumptions.
Whether those assumptions adequately represent
intended referents requires independent scientific assessment.

## Authoritative Sources

The repository maintains distinct sources of authority:

- [Lean verification modules](SEVerification/SelfSimilarity.lean):
  public import surface for mathematical constructions, bridge definitions, and proofs.
- [Lean tests](SETest/SelfSimilarity.lean):
  checks of the named formal results.
- [Case registry](reference/cases.toml):
  case identifiers, expected results, limitations, and prospective scientific tests.
- [Upstream provenance](reference/upstream.toml):
  external mathematical sources and canonical SE theory dependencies.
- [Repository manifest](SE_MANIFEST.toml):
  repository classification, scope, dependencies, and validation declarations.

Documentation provides navigation and interpretation.
It does not independently define mathematical results or maintain a second findings ledger.

## Scientific Boundaries

The research distinguishes three achievements:

1. **Mathematical correctness:** Lean accepts the stated definitions and proofs under their assumptions.
2. **Scientific adequacy:** the supplied formal criteria adequately represent the intended referents and judgments, with independently justified interpretation conditions.
3. **Theoretical contribution:** the investigation establishes substantive results
   about SE concepts rather than only demonstrating that existing definitions can be instantiated.

A mathematical counterexample may reject a proposed implication
without rejecting a canonical SE theory that does not assert that implication.

The mathematical cases establish useful distinctions,
but formal consistency and alternative model constructions
are not by themselves evidence that an interpretation is scientifically adequate.

Prospective scientific tests, rejection conditions, and
required warrants are recorded in
[reference/cases.toml](reference/cases.toml).
Their status remains separate from compilation success.

See [Findings and Limits](docs/en/findings.md) and the
[SE Research Protocols](https://github.com/structural-explainability/se-protocols-research)
for the governing evaluation boundaries.

## External Mathematical Sources

The research is motivated in part by the
[OpenAI Math SelfSimilar formalization](https://github.com/openai/math/tree/main/lean/OAI/MeasureTheory/SelfSimilar).

The repository implements its initial mathematical constructions independently.
It does not import the OpenAI mathematical repository as a Lean dependency.

The precise external source revision and provenance are recorded in
[reference/upstream.toml](reference/upstream.toml).

## Development and Verification

The project uses Lean 4, Lake, and Mathlib for formal verification.
Python is used only for supporting tooling through uv, including Zensical documentation.
No Python package or project-specific Python CLI is required.

From the repository root, using PowerShell:

```shell
# set up or update Python environment
uv lock --upgrade
uv sync
uv audit

# lake build-test-lint
lake build
lake test
lake lint

# build docs
uv run python -m zensical build

# save progress
git add -A
git commit -m "your message here"
git push -u origin main
```

Passing `lake build`, `lake test`, and `lake lint` does not independently
verify the interpretation criteria or prospective scientific predictions.
Those obligations remain governed by the case registry and research protocols.

## Initial Acceptance Criteria

The initial release requires:

- Precisely defined mathematical test cases.
- Machine-checked constructions and counterexamples.
- Explicit connections to canonical SE theory interfaces.
- Verification tests and reproducible dependencies.
- Recorded distinctions between formal results and scientific interpretation.
- Explicit limitations, prospective predictions, and rejection conditions.
- Traceable external mathematical provenance.
- Successful `lake build`, `lake test`, and `lake lint`, with no `sorry` in the Lean source.

Scientific adequacy and theoretical contribution
must be assessed separately.
A successful release of the testbed
does not imply that every prospective scientific test has been resolved.

The initial contribution is a reusable formal verification method
for investigating SE theory against mathematical cases.

## Annotations

[.annotations/annotations.md](.annotations/annotations.md)

## Changelog

[CHANGELOG](CHANGELOG.md)

## Citation

[CITATION.cff](CITATION.cff).

## Documentation

[Documentation Site](https://structural-explainability.github.io/se-verification-self-similarity/)

## License

[MIT](LICENSE)

## Repository Manifest

The repository's role, scope, and dependencies are declared in
[SE_MANIFEST.toml](./SE_MANIFEST.toml).
