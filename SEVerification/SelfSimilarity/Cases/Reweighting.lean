module

public import SEVerification.SelfSimilarity.Cases.AddressCollision

set_option autoImplicit false

/-!
# Case SS-002: Reweighting

Probability weights are assigned to the two binary symbols.

The geometric attractor depends on the binary coding relation,
not on the probability weights.

The finite first-symbol distributions can therefore differ while
the geometric attractor remains equal.

This module does not construct invariant probability measures.
-/

namespace SEVerification.SelfSimilarity.Cases.Reweighting

open SEVerification.SelfSimilarity
open SEVerification.SelfSimilarity.Cases.AddressCollision

@[expose] public section

/-- Normalized nonnegative weights for two binary symbols. -/
structure WeightedSystem where
  weightZero : ℚ
  weightOne : ℚ
  zero_nonneg : 0 ≤ weightZero
  one_nonneg : 0 ≤ weightOne
  normalized : weightZero + weightOne = 1

/-- Probability assigned to an individual first symbol. -/
def firstSymbolMass (s : WeightedSystem) (b : Bool) : ℚ :=
  if b then s.weightOne else s.weightZero

/-- The geometric attractor defined by the coding relation. -/
def attractor (_s : WeightedSystem) : Set ℝ :=
  {x | ∃ ω : Address, Represents ω x}

/-- Uniform first-symbol weights. -/
def fair : WeightedSystem where
  weightZero := 1 / 2
  weightOne := 1 / 2
  zero_nonneg := by norm_num
  one_nonneg := by norm_num
  normalized := by norm_num

/-- Nonuniform first-symbol weights. -/
def biased : WeightedSystem where
  weightZero := 1 / 3
  weightOne := 2 / 3
  zero_nonneg := by norm_num
  one_nonneg := by norm_num
  normalized := by norm_num

/-- The first-symbol probability distributions differ. -/
theorem first_symbol_distributions_differ :
    firstSymbolMass fair false ≠
      firstSymbolMass biased false := by
  norm_num [firstSymbolMass, fair, biased]

/-- The weighted system records are different. -/
theorem systems_distinct : fair ≠ biased := by
  intro h
  have hw := congrArg WeightedSystem.weightZero h
  exact first_symbol_distributions_differ hw

/-- Reweighting preserves the geometric attractor exactly. -/
theorem attractor_invariant :
    attractor fair = attractor biased := rfl

/-- The common geometric attractor is nonempty. -/
theorem attractor_nonempty :
    (attractor fair).Nonempty := by
  exact ⟨1 / 2, oneThenZeros,
    oneThenZeros_represent_half⟩

/-- Equal attractors do not imply equal weighted systems. -/
theorem attractor_equality_not_system_equality :
    attractor fair = attractor biased ∧ fair ≠ biased :=
  ⟨attractor_invariant, systems_distinct⟩

end

end SEVerification.SelfSimilarity.Cases.Reweighting
