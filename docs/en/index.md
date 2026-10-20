# SE Verification: Self-Similarity

## Purpose

This repository provides independently constructed mathematical cases
for examining Structural Explainability (SE) theories of individuation,
co-reference, and persistence.

The initial cases use self-similar mathematical systems to examine
distinctions among symbolic presentations, denoted points,
generated structures, and identity under transformation.

This is a formal verification testbed, not a foundational SE theory
or an empirical research pilot.

## Contents

1. [Mathematical Cases](cases.md):
   the constructions being tested and their connections to SE theory.
2. [Findings and Limits](findings.md):
   how to interpret formal results, counterexamples, and unresolved questions.

## Authoritative Sources

The Lean source files define the mathematical constructions
and establish the formal results.

- [Lean Verification Library](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity.lean)
- [Lean Test Suite](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SETest/SelfSimilarity.lean)
- [Case Registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml)
- [Upstream Provenance](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/upstream.toml)

The case registry identifies the research questions, expected results,
verification status, interpretation limits, and prospective scientific tests.

Documentation does not independently define mathematical results
or canonical SE theory semantics.

## Verification

From the repository root:

```powershell
lake build
lake test
lake lint
```

Successful compilation, with no `sorry` in the source, establishes
that Lean accepts the stated proofs under their declared assumptions.

It does not independently establish that the SE interpretation criteria
are scientifically adequate.

Scientific acceptance follows the procedures in
[SE Research Protocols](https://github.com/structural-explainability/se-protocols-research).
