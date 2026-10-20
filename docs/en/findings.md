# Findings and Limits

## Purpose

This page explains how to interpret the mathematical verification
results and their relevance to Structural Explainability.

It does not maintain a separate list of theorem statements,
proof outcomes, case statuses, or unresolved obligations.

Those remain in the authoritative sources.

## Where Results Are Recorded

### Mathematical Results

Definitions and theorems are established in the
[Lean source](https://github.com/structural-explainability/se-verification-self-similarity/tree/main/SEVerification/SelfSimilarity).

Each mathematical claim must be evaluated using its actual
statement, assumptions, and proof.

### Verification Status and Limitations

The [case registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml)
records expected results, verification status, known limits,
and prospective scientific tests.

The [test suite](https://github.com/structural-explainability/se-verification-self-similarity/tree/main/SETest)
provides executable checks against the Lean source.

### SE Interpretations

The [theory bridges](https://github.com/structural-explainability/se-verification-self-similarity/tree/main/SEVerification/SelfSimilarity/Bridges)
connect the mathematical cases to canonical SE definitions.

Each bridge must distinguish:

- mathematical facts established by the case;
- SE conclusions following under explicit hypotheses;
- interpretation criteria not established by the mathematics;
- proposed implications rejected by counterexamples;
- scientific obligations that remain unresolved.

## Interpretation Boundaries

### Mathematical Equality

Equality of mathematical objects does not independently
establish that they represent the same intended referent.

The referent kind and applicable individuation or identity
criterion must be specified.

### Individuation

A structural setting may establish same-unit judgments
for successful presentations under its specified
whole-co-membership criterion.

Constructing such a setting does not independently justify
that criterion for the intended referent kind.

### Co-reference

A shared mathematical denotation is not automatically
a scientifically warranted co-reference judgment.

The relevant account, its commitments, and their
independent justification remain explicit.

Consistency of commitments establishes formal compatibility,
not the correctness of the commitments themselves.

### Persistence

Invariance of a mathematical property does not by itself
establish persistence of an intended referent.

A persistence judgment depends on the intended referent,
the transformations under consideration, and the
identity-preservation classification.

In the Persistence definitions this repository consumes,
the identity relation depends on a classification
only through its set of identity-preserving transformations.
Classifying a transformation as identity-breaking,
identity-ignoring, or inapplicable gives the same judgment.

### Counterexamples

A valid counterexample rejects or narrows a particular
proposition under its stated interpretation.

It does not refute a canonical SE theory unless that theory
actually entails the challenged proposition.

A countermodel relying on an arbitrary or degenerate
interpretation may establish logical underdetermination
without establishing a scientifically significant failure.

## Scientific Acceptance

The research distinguishes three achievements:

1. **Mathematical correctness:** definitions and theorems
   are formally checked under their assumptions.
2. **Scientific adequacy:** the formal criteria adequately
   represent intended phenomena under independently
   justified interpretation conditions.
3. **Theoretical contribution:** the results establish
   substantive claims rather than merely demonstrating
   that existing definitions can be instantiated.

Successful Lean verification, with no `sorry` in the source,
establishes the first achievement.

The second and third require independent assessment,
meaningful counterexamples, and explicit rejection conditions.

Prospective tests and outstanding warrants are recorded
in the [case registry](https://github.com/structural-explainability/se-verification-self-similarity/blob/main/reference/cases.toml).

Results from this repository may inform theory construction
and revision, but do not independently authorize changes
to canonical SE theory.

See the
[Theory Acceptance Protocol](https://github.com/structural-explainability/se-protocols-research/blob/main/protocols/theory-acceptance/SKILL.md)
for the governing evaluation criteria.
