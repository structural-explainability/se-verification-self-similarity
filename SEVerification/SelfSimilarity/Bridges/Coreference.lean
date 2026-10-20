module

public import SEVerification.SelfSimilarity.Cases.AddressCollision
public import SE.Coreference

set_option autoImplicit false

/-!
# Coreference Bridge

Constructs two explicit context-indexed co-reference accounts.

The first treats a shared represented point as a co-reference link.
The second asserts no co-reference links.

The accounts demonstrate that the mathematical representation
relation does not independently determine an SE co-reference
commitment. The first account is a candidate interpretation,
not a universally warranted criterion.
-/

namespace SEVerification.SelfSimilarity.Bridges.Coreference

open SEVerification.SelfSimilarity
open SEVerification.SelfSimilarity.Cases.AddressCollision
open SE.Substrate
open SE.Coreference

@[expose] public section

/-- Candidate account relating addresses with a common point witness. -/
def witnessedAccount : CoReferenceAccount.{0} ℝ where
  Context := Unit
  Reference := Address
  coReference := fun _ ω ν =>
    ∃ x : ℝ, Represents ω x ∧ Represents ν x

/-- The candidate account relates the collision addresses. -/
theorem witnessed_coreference :
    witnessedAccount.coReference ()
      oneThenZeros zeroThenOnes := by
  exact ⟨1 / 2,
    oneThenZeros_represent_half,
    zeroThenOnes_represent_half⟩

/-- The asserted relation enters generated co-reference. -/
theorem witnessed_generated_coreference :
    GeneratedCoReference witnessedAccount ()
      oneThenZeros zeroThenOnes := by
  exact coReference_imp_generatedCoReference
    witnessedAccount () witnessed_coreference

/-- An account with no asserted co-reference links. -/
def uncommittedAccount : CoReferenceAccount.{0} ℝ where
  Context := Unit
  Reference := Address
  coReference := fun _ _ _ => False

/-- The uncommitted account does not assert this pair. -/
theorem uncommitted_not_coreferent :
    ¬ uncommittedAccount.coReference ()
      oneThenZeros zeroThenOnes := by
  intro h
  exact h

/-- The collision pair has a common point witness, one account
links it, and another does not. -/
theorem same_representation_different_commitments :
    (∃ x : ℝ, Represents oneThenZeros x ∧ Represents zeroThenOnes x) ∧
    witnessedAccount.coReference () oneThenZeros zeroThenOnes ∧
    ¬ uncommittedAccount.coReference () oneThenZeros zeroThenOnes := by
  exact ⟨⟨1 / 2, oneThenZeros_represent_half, zeroThenOnes_represent_half⟩,
    witnessed_coreference, uncommitted_not_coreferent⟩

/--
The existence of a common point witness does not make a
co-reference assertion mandatory for every account.
-/
theorem representation_does_not_force_account_commitment :
    ∃ (A : CoReferenceAccount.{0} ℝ) (c : A.Context)
      (f : Address → A.Reference),
      ¬ A.coReference c (f oneThenZeros) (f zeroThenOnes) := by
  exact ⟨uncommittedAccount, (), id, uncommitted_not_coreferent⟩



/-- Account that links two addresses only with a common point
witness and a supplied warrant. -/
def warrantedAccount (W : Address → Address → Prop) :
    CoReferenceAccount.{0} ℝ where
  Context := Unit
  Reference := Address
  coReference := fun _ ω ν =>
    (∃ x : ℝ, Represents ω x ∧ Represents ν x) ∧ W ω ν

/-- A warranted link always has a common point witness. -/
theorem warranted_coreference_has_witness
    (W : Address → Address → Prop) (ω ν : Address)
    (h : (warrantedAccount W).coReference () ω ν) :
    ∃ x : ℝ, Represents ω x ∧ Represents ν x := by
  exact h.1

/-- Two accounts that both require a common witness disagree
on the collision pair. -/
theorem witness_respecting_accounts_diverge :
    (warrantedAccount (fun _ _ => True)).coReference ()
      oneThenZeros zeroThenOnes ∧
    ¬ (warrantedAccount (fun _ _ => False)).coReference ()
      oneThenZeros zeroThenOnes := by
  refine ⟨⟨⟨1 / 2, oneThenZeros_represent_half,
    zeroThenOnes_represent_half⟩, trivial⟩, ?_⟩
  intro h
  exact h.2

/-- A distinct-commitment on exactly the collision pair, for the witnessed account. -/
def collisionDistinctWitnessed : DistinctCommitments witnessedAccount where
  distinct := fun _ ω ν => ω = oneThenZeros ∧ ν = zeroThenOnes

/-- A distinct-commitment on exactly the collision pair, for the uncommitted account. -/
def collisionDistinctUncommitted : DistinctCommitments uncommittedAccount where
  distinct := fun _ ω ν => ω = oneThenZeros ∧ ν = zeroThenOnes

/-- The witnessed account is inconsistent with a distinct-commitment on the collision pair. -/
theorem witnessed_inconsistent_with_distinct :
    ¬ ContextConsistent witnessedAccount collisionDistinctWitnessed () := by
  intro h
  exact h oneThenZeros zeroThenOnes
    (show oneThenZeros = oneThenZeros ∧ zeroThenOnes = zeroThenOnes from ⟨rfl, rfl⟩)
    (SE.Persistence.Generated.rel witnessed_coreference)

/-- The uncommitted account is consistent with the same commitment. -/
theorem uncommitted_consistent_with_distinct :
    ContextConsistent uncommittedAccount collisionDistinctUncommitted () := by
  intro x y hd hg
  obtain ⟨hx, hy⟩ := hd
  have hxy : x = y :=
    SE.Persistence.Generated.le_of_equivalence (s := fun a b : Address => a = b)
      ⟨(fun _ => rfl), (fun h => h.symm), (fun h1 h2 => h1.trans h2)⟩
      (fun _ _ hab => False.elim hab) hg
  exact addresses_distinct (hx.symm.trans (hxy.trans hy))

/-- With no distinct-commitments, the uncommitted account leaves the pair
undetermined, not distinct. -/
theorem uncommitted_pair_undetermined :
    SE.Persistence.Undetermined (uncommittedAccount.coReference ())
      (fun _ _ => False) oneThenZeros zeroThenOnes := by
  apply undetermined_of_not_generatedCoReference_of_no_distinct uncommittedAccount ()
  intro h
  exact addresses_distinct
    (SE.Persistence.Generated.le_of_equivalence (s := fun a b : Address => a = b)
      ⟨(fun _ => rfl), (fun h => h.symm), (fun h1 h2 => h1.trans h2)⟩
      (fun _ _ hab => False.elim hab) h)
end

end SEVerification.SelfSimilarity.Bridges.Coreference
