module

public import SEVerification.SelfSimilarity.Cases.AddressCollision
public import SE.Individuation

set_option autoImplicit false

/-!
# Individuation Bridge

Tests the address-collision case against SE's structural
individuation construction.

A shared represented point supplies an overlap witness.

Same-unit follows only when the supplied structural setting
has matching supports and both presentations succeed.

The mathematical collision alone does not establish success
or justify the selected whole-co-membership criterion.
-/

namespace SEVerification.SelfSimilarity.Bridges.Individuation

open SEVerification.SelfSimilarity
open SEVerification.SelfSimilarity.Cases.AddressCollision
open SE.Individuation.Structural

@[expose] public section

/-- Points represented by a symbolic address. -/
def denotationSupport (ω : Address) : Set ℝ :=
  {x | Represents ω x}

/-- The two address supports overlap. -/
theorem supports_overlap :
    ∃ x : ℝ,
      x ∈ denotationSupport oneThenZeros ∧
      x ∈ denotationSupport zeroThenOnes := by
  exact ⟨1 / 2,
    oneThenZeros_represent_half,
    zeroThenOnes_represent_half⟩

/--
If the supplied individuation setting adopts these supports
and both presentations succeed, SE establishes same-unit.

The success and support hypotheses are not inferred from
the address collision.
-/
theorem same_unit_if_success
    (s : Setting ℝ Address)
    (hSupport : ∀ ω, s.support ω = denotationSupport ω)
    (hFirst : s.Succeeds oneThenZeros)
    (hSecond : s.Succeeds zeroThenOnes) :
    s.SameUnit oneThenZeros zeroThenOnes := by
  apply (Setting.sameUnit_iff_overlap hFirst hSecond).2
  refine ⟨1 / 2, ?_, ?_⟩
  · rw [hSupport oneThenZeros]
    exact oneThenZeros_represent_half
  · rw [hSupport zeroThenOnes]
    exact zeroThenOnes_represent_half

/-- Atoms are all reals, co-membership is equality, and an address is
admissible when it represents some point. -/
def pointSetting : Setting ℝ Address where
  eligible := Set.univ
  admissible := fun ω => ∃ x, Represents ω x
  support := denotationSupport
  support_subset_eligible := fun _ _ a _ => Set.mem_univ a
  E := fun x y => x = y
  E_equivalence := ⟨fun _ => rfl, fun h => h.symm, fun h1 h2 => h1.trans h2⟩

/-- Every address with a represented point succeeds in `pointSetting`. -/
theorem pointSetting_succeeds {ω : Address} {x : ℝ} (h : Represents ω x) :
    pointSetting.Succeeds ω := by
  refine ⟨⟨x, h⟩, ?_⟩
  have hsupp : pointSetting.support ω = {x} := by
    ext y
    constructor
    · intro hy
      exact represents_unique hy h
    · intro hy
      rw [Set.mem_singleton_iff] at hy
      rw [hy]
      exact h
  rw [hsupp]
  refine Setting.wholeConditions_singleton_of_isolated (Set.mem_univ x) ?_
  intro b hb
  obtain ⟨_, _, hE⟩ := hb
  exact (congrArg Subtype.val hE).symm

/-- Some setting adopts the denotation supports and both presentations succeed. -/
theorem exists_setting_with_success :
    ∃ s : Setting ℝ Address,
      (∀ ω, s.support ω = denotationSupport ω) ∧
      s.Succeeds oneThenZeros ∧ s.Succeeds zeroThenOnes :=
  ⟨pointSetting, fun _ => rfl,
    pointSetting_succeeds oneThenZeros_represent_half,
    pointSetting_succeeds zeroThenOnes_represent_half⟩

/-- A setting in which no presentation is admissible. -/
def noAdmissibleSetting : Setting ℝ Address where
  eligible := Set.univ
  admissible := fun _ => False
  support := denotationSupport
  support_subset_eligible := fun _ h => h.elim
  E := fun x y => x = y
  E_equivalence := ⟨fun _ => rfl, fun h => h.symm, fun h1 h2 => h1.trans h2⟩

/-- Adopting the denotation supports does not by itself give same-unit. -/
theorem exists_setting_with_support_without_same_unit :
    ∃ s : Setting ℝ Address,
      (∀ ω, s.support ω = denotationSupport ω) ∧
      ¬ s.SameUnit oneThenZeros zeroThenOnes :=
  ⟨noAdmissibleSetting, fun _ => rfl, fun h => h.1.1⟩

/-- Given the denotation supports, same-unit holds exactly when both succeed. -/
theorem same_unit_iff_success
    (s : Setting ℝ Address)
    (hSupport : ∀ ω, s.support ω = denotationSupport ω) :
    s.SameUnit oneThenZeros zeroThenOnes ↔
      s.Succeeds oneThenZeros ∧ s.Succeeds zeroThenOnes := by
  constructor
  · intro h
    exact ⟨h.1, h.2.1⟩
  · rintro ⟨h1, h2⟩
    exact same_unit_if_success s hSupport h1 h2

/-- In `pointSetting`, an address that represents `x` has support `{x}`. -/
theorem pointSetting_support {ω : Address} {x : ℝ} (h : Represents ω x) :
    pointSetting.support ω = {x} := by
  ext y
  constructor
  · intro hy
    exact represents_unique hy h
  · intro hy
    rw [Set.mem_singleton_iff] at hy
    rw [hy]
    exact h

/-- At the account level, the collision addresses are in the same unit. -/
theorem collision_sameUnit_in_account :
    (individuationAccount ℝ Address).sameUnit pointSetting
      oneThenZeros zeroThenOnes :=
  individuationAccount.sameUnit_iff.2
    ⟨pointSetting_succeeds oneThenZeros_represent_half,
     pointSetting_succeeds zeroThenOnes_represent_half,
     by rw [pointSetting_support oneThenZeros_represent_half,
            pointSetting_support zeroThenOnes_represent_half]⟩

/-- The collision addresses present a common set-valued referent. -/
theorem collision_present_common_referent :
    ∃ W : Set ℝ,
      (individuationAccount ℝ Address).presents pointSetting
        oneThenZeros W ∧
      (individuationAccount ℝ Address).presents pointSetting
        zeroThenOnes W :=
  individuationAccount.sameUnit_iff_common_presents.1
    collision_sameUnit_in_account

end

end SEVerification.SelfSimilarity.Bridges.Individuation
