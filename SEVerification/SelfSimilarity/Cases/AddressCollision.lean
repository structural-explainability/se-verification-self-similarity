module

public import SEVerification.SelfSimilarity.FiniteWords

set_option autoImplicit false

/-!
# Case SS-001: Address Collision

Two different infinite binary addresses represent the same point.

The witnesses are:

- one followed by zeros;
- zero followed by ones.

Both represent 1/2 under the recursive coding relation.

This establishes coincident denotation witnesses, not an
independently warranted SE co-reference judgment.

The noncomputable annotation does not
weaken the theorems or their proofs.

It tells Lean these definitions are mathematical constructions
rather than executable computations.
-/

namespace SEVerification.SelfSimilarity.Cases.AddressCollision

open SEVerification.SelfSimilarity

@[expose] public section

/-- Binary address 1000... -/
def oneThenZeros : Address :=
  fun n => if n = 0 then true else false

/-- Binary address 0111... -/
def zeroThenOnes : Address :=
  fun n => if n = 0 then false else true

/-- The symbolic addresses are different. -/
theorem addresses_distinct :
    oneThenZeros ≠ zeroThenOnes := by
  intro h
  have h0 := congrArg (fun ω : Address => ω 0) h
  simp [oneThenZeros, zeroThenOnes] at h0

private noncomputable def firstTail (n : ℕ) : ℝ :=
  if n = 0 then 1 / 2 else 0

private noncomputable def secondTail (n : ℕ) : ℝ :=
  if n = 0 then 1 / 2 else 1

/-- The first infinite address represents 1/2. -/
theorem oneThenZeros_represent_half :
    Represents oneThenZeros (1 / 2 : ℝ) := by
  refine ⟨firstTail, ?_, ?_, ?_⟩
  · simp [firstTail]
  · intro n
    by_cases h : n = 0
    · subst n
      norm_num [firstTail, InUnitInterval]
    · simp [firstTail, InUnitInterval, h]
  · intro n
    by_cases h : n = 0
    · subst n
      norm_num [firstTail, oneThenZeros, binaryMap]
    · simp [firstTail, oneThenZeros, binaryMap, h]

/-- The second infinite address represents 1/2. -/
theorem zeroThenOnes_represent_half :
    Represents zeroThenOnes (1 / 2 : ℝ) := by
  refine ⟨secondTail, ?_, ?_, ?_⟩
  · simp [secondTail]
  · intro n
    by_cases h : n = 0
    · subst n
      norm_num [secondTail, InUnitInterval]
    · simp [secondTail, InUnitInterval, h]
  · intro n
    by_cases h : n = 0
    · subst n
      norm_num [secondTail, zeroThenOnes, binaryMap]
    · simp [secondTail, zeroThenOnes, binaryMap, h]

/-- Different addresses have a common represented point. -/
theorem shared_point :
    Represents oneThenZeros (1 / 2 : ℝ) ∧
    Represents zeroThenOnes (1 / 2 : ℝ) :=
  ⟨oneThenZeros_represent_half, zeroThenOnes_represent_half⟩

/-- The representation relation admits an address collision. -/
theorem address_collision :
    ∃ (ω ν : Address) (x : ℝ),
      ω ≠ ν ∧ Represents ω x ∧ Represents ν x := by
  exact ⟨oneThenZeros, zeroThenOnes, 1 / 2,
    addresses_distinct,
    oneThenZeros_represent_half,
    zeroThenOnes_represent_half⟩

end

end SEVerification.SelfSimilarity.Cases.AddressCollision
