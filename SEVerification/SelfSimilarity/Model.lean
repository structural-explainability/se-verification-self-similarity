module

public import Mathlib

set_option autoImplicit false

/-!
# Binary Self-Similar Model

Two affine contractions of the unit interval.

The maps are independent of probability weights.
No SE identity semantics are defined here.

Division on ℝ is noncomputable in Lean.
The noncomputable annotation does not
weaken the theorems or their proofs.

It tells Lean these definitions are mathematical constructions
rather than executable computations.
-/

namespace SEVerification.SelfSimilarity

@[expose] public section

/-- The contraction selected by a binary symbol. -/
noncomputable def binaryMap (b : Bool) (x : ℝ) : ℝ :=
  if b then (x + 1) / 2 else x / 2

/-- Membership in the closed unit interval. -/
def InUnitInterval (x : ℝ) : Prop :=
  0 ≤ x ∧ x ≤ 1

/-- Both binary contractions preserve the unit interval. -/
theorem binaryMap_preserves_interval
    (b : Bool) {x : ℝ} (hx : InUnitInterval x) :
    InUnitInterval (binaryMap b x) := by
  rcases hx with ⟨h0, h1⟩
  cases b <;>
    simp [binaryMap, InUnitInterval] <;>
    constructor <;> linarith

/-- The two first-symbol transformations are different. -/
theorem binary_maps_distinct :
    binaryMap true ≠ binaryMap false := by
  intro h
  have h0 := congrArg (fun f : ℝ → ℝ => f 0) h
  norm_num [binaryMap] at h0

end

end SEVerification.SelfSimilarity
