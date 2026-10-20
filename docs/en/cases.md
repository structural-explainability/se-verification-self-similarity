# Mathematical Cases

## Purpose

Each case provides a mathematical construction for examining
claims about presentations, denotations, structures, or persistence.

The Lean source is authoritative for definitions and proofs.
The [case registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml).
records the questions, formal results, status, limitations,
and prospective scientific tests.

## SS-001: Address Collision

**Question:** Can distinct infinite symbolic addresses represent
the same point while their first-symbol transformations differ?

### Mathematical Sources

- [Binary Model](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Model.lean)
- [Symbolic Coding](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Coding.lean)
- [Finite Words](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/FiniteWords.lean)
- [Address Collision](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Cases/AddressCollision.lean)

The case examines distinct symbolic addresses with a common
represented point.

Proved and open properties of the coding relation are recorded in the
[case registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml).

### SE Connections

- [Individuation Bridge](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Bridges/Individuation.lean)
- [Coreference Bridge](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Bridges/Coreference.lean)

The Individuation bridge examines concrete structural settings,
presentation success, and same-unit judgments.

The Coreference bridge examines alternative accounts,
common-point witnesses, and compatibility with distinct-commitments.
The distinct-commitment used is chosen for the test and is not
independently warranted.

These constructions establish formal consequences under specified
criteria. They do not independently justify those criteria as
adequate accounts of intended mathematical referents.

## SS-002: Reweighting

**Question:** Can different weighted systems have the same
geometric attractor, and does attractor equality determine
their generated identity?

### Mathematical Source

- [Reweighting](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Cases/Reweighting.lean)

The case distinguishes the geometric attractor from
the weights assigned to the generating transformations.

It does not construct invariant self-similar probability measures.

### SE Connection

- [Persistence Bridge](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SEVerification/SelfSimilarity/Bridges/Persistence.lean)

The bridge examines generated identity under specified
classifications and dynamics, including a declared reweighting step.

It tests how different preservation classifications affect
the identity judgment while the mathematical systems and
transformation remain fixed.

Both classifications act on a single carrier of weighted systems;
persistence of the attractor as a separate referent is not modeled.

The formal results do not independently establish which
persistence classification is scientifically justified.

## Prospective Scientific Tests

The mathematical cases and their formal bridges provide
the basis for further scientific assessment.

The [case registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml)
records prospective predictions for:

- individuation under justified point-based criteria;
- co-reference under justified point-denotation criteria;
- persistence under justified referent-specific criteria.

These predictions require independent warrants and
rejection-capable tests.

Their scientific status is separate from Lean compilation.

## Verification Evidence

The [Lean test suite](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/SETest/SelfSimilarity.lean)
checks the formal results.

The case registry records the current scope and limitations.

See [Findings and Limits](findings.md)
for interpretation and scientific acceptance boundaries.
