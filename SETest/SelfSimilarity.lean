module -- shake: keep-all

import SEVerification.SelfSimilarity

set_option autoImplicit false

/-!
# Self-Similarity Test Assertions

Checks the named mathematical results and SE bridge results
through the compiled Lean import surface.
-/

namespace SETest.SelfSimilarity

open SEVerification.SelfSimilarity
open SEVerification.SelfSimilarity.Cases
open SEVerification.SelfSimilarity.Bridges

-- Case SS-001: Address collision

example :
    AddressCollision.oneThenZeros ≠
      AddressCollision.zeroThenOnes :=
  AddressCollision.addresses_distinct

example :
    ∃ (ω ν : Address) (x : ℝ),
      ω ≠ ν ∧ Represents ω x ∧ Represents ν x :=
  AddressCollision.address_collision

example :
    wordMap [true] ≠ wordMap [false] :=
  one_symbol_maps_distinct

example :
    ∃ x : ℝ,
      x ∈ Individuation.denotationSupport
        AddressCollision.oneThenZeros ∧
      x ∈ Individuation.denotationSupport
        AddressCollision.zeroThenOnes :=
  Individuation.supports_overlap

example : Represents AddressCollision.oneThenZeros (1 / 2 : ℝ) :=
  AddressCollision.oneThenZeros_represent_half

example : Represents AddressCollision.zeroThenOnes (1 / 2 : ℝ) :=
  AddressCollision.zeroThenOnes_represent_half

example :
    Represents AddressCollision.oneThenZeros (1 / 2 : ℝ) ∧
    Represents AddressCollision.zeroThenOnes (1 / 2 : ℝ) :=
  AddressCollision.shared_point

example : binaryMap true ≠ binaryMap false :=
  binary_maps_distinct

example : wordMap [true] 0 = wordMap [false] 1 :=
  boundary_coincidence

example {ω : Address} {x : ℝ} (h : Represents ω x) :
    InUnitInterval x :=
  represented_in_interval h

example {ω : Address} {x y : ℝ}
    (hx : Represents ω x) (hy : Represents ω y) : x = y :=
  represents_unique hx hy

-- Case SS-001: Individuation bridge

example
    (s : SE.Individuation.Structural.Setting ℝ Address)
    (hSupport : ∀ ω, s.support ω = Individuation.denotationSupport ω)
    (hFirst : s.Succeeds AddressCollision.oneThenZeros)
    (hSecond : s.Succeeds AddressCollision.zeroThenOnes) :
    s.SameUnit AddressCollision.oneThenZeros
      AddressCollision.zeroThenOnes :=
  Individuation.same_unit_if_success s hSupport hFirst hSecond

example {ω : Address} {x : ℝ} (h : Represents ω x) :
    Individuation.pointSetting.Succeeds ω :=
  Individuation.pointSetting_succeeds h

example :
    ∃ s : SE.Individuation.Structural.Setting ℝ Address,
      (∀ ω, s.support ω = Individuation.denotationSupport ω) ∧
      s.Succeeds AddressCollision.oneThenZeros ∧
      s.Succeeds AddressCollision.zeroThenOnes :=
  Individuation.exists_setting_with_success

example :
    ∃ s : SE.Individuation.Structural.Setting ℝ Address,
      (∀ ω, s.support ω = Individuation.denotationSupport ω) ∧
      ¬ s.SameUnit AddressCollision.oneThenZeros
        AddressCollision.zeroThenOnes :=
  Individuation.exists_setting_with_support_without_same_unit

example
    (s : SE.Individuation.Structural.Setting ℝ Address)
    (hSupport : ∀ ω, s.support ω = Individuation.denotationSupport ω) :
    s.SameUnit AddressCollision.oneThenZeros
        AddressCollision.zeroThenOnes ↔
      s.Succeeds AddressCollision.oneThenZeros ∧
      s.Succeeds AddressCollision.zeroThenOnes :=
  Individuation.same_unit_iff_success s hSupport

-- Case SS-001: Coreference bridge

example :
    Coreference.witnessedAccount.coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.witnessed_coreference

example :
    SE.Coreference.GeneratedCoReference Coreference.witnessedAccount ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.witnessed_generated_coreference

example :
    ¬ Coreference.uncommittedAccount.coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.uncommitted_not_coreferent

example :
    (∃ x : ℝ, Represents AddressCollision.oneThenZeros x ∧
      Represents AddressCollision.zeroThenOnes x) ∧
    Coreference.witnessedAccount.coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes ∧
    ¬ Coreference.uncommittedAccount.coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.same_representation_different_commitments

example :
    ∃ (A : SE.Substrate.CoReferenceAccount.{0} ℝ) (c : A.Context)
      (f : Address → A.Reference),
      ¬ A.coReference c (f AddressCollision.oneThenZeros)
        (f AddressCollision.zeroThenOnes) :=
  Coreference.representation_does_not_force_account_commitment

example (W : Address → Address → Prop) (ω ν : Address)
    (h : (Coreference.warrantedAccount W).coReference () ω ν) :
    ∃ x : ℝ, Represents ω x ∧ Represents ν x :=
  Coreference.warranted_coreference_has_witness W ω ν h

example :
    (Coreference.warrantedAccount (fun _ _ => True)).coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes ∧
    ¬ (Coreference.warrantedAccount (fun _ _ => False)).coReference ()
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.witness_respecting_accounts_diverge

example :
    ¬ SE.Coreference.ContextConsistent Coreference.witnessedAccount
      Coreference.collisionDistinctWitnessed () :=
  Coreference.witnessed_inconsistent_with_distinct

example :
    SE.Coreference.ContextConsistent Coreference.uncommittedAccount
      Coreference.collisionDistinctUncommitted () :=
  Coreference.uncommitted_consistent_with_distinct

example :
    SE.Persistence.Undetermined
      (Coreference.uncommittedAccount.coReference ())
      (fun _ _ => False)
      AddressCollision.oneThenZeros AddressCollision.zeroThenOnes :=
  Coreference.uncommitted_pair_undetermined

-- Case SS-002: Reweighting

example :
    Reweighting.attractor Reweighting.fair =
      Reweighting.attractor Reweighting.biased :=
  Reweighting.attractor_invariant

example :
    Reweighting.fair ≠ Reweighting.biased :=
  Reweighting.systems_distinct

example :
    Reweighting.attractor Reweighting.fair =
      Reweighting.attractor Reweighting.biased ∧
    ¬ Persistence.noPreservation.identityRel
      Persistence.noDynamics
      Reweighting.fair Reweighting.biased :=
  Persistence.equal_attractors_without_generated_identity

example :
    ¬ Persistence.noPreservation.PresentationComplete
      Persistence.noDynamics Reweighting.attractor :=
  Persistence.attractor_presentation_not_complete

example :
    Reweighting.firstSymbolMass Reweighting.fair false ≠
      Reweighting.firstSymbolMass Reweighting.biased false :=
  Reweighting.first_symbol_distributions_differ

example : (Reweighting.attractor Reweighting.fair).Nonempty :=
  Reweighting.attractor_nonempty

example :
    Reweighting.attractor Reweighting.fair =
      Reweighting.attractor Reweighting.biased ∧
    Reweighting.fair ≠ Reweighting.biased :=
  Reweighting.attractor_equality_not_system_equality

-- Case SS-002: Persistence bridge, original no-preservation model

example {x y : Reweighting.WeightedSystem}
    (h : Persistence.noPreservation.identityRel
      Persistence.noDynamics x y) : x = y :=
  Persistence.identity_implies_equality h

example :
    Persistence.noPreservation.PresentationSound
      Persistence.noDynamics Reweighting.attractor :=
  Persistence.attractor_presentation_sound

-- Case SS-002: Persistence bridge, reweighting dynamics

example : Persistence.reweightPreserving.WellFormed :=
  Persistence.reweightPreserving_wellFormed

example :
    Persistence.reweightPreserving.identityRel
      Persistence.reweightDynamics
      Reweighting.fair Reweighting.biased :=
  Persistence.reweight_preserving_identity

example :
    ¬ Persistence.noPreservation.identityRel
      Persistence.reweightDynamics
      Reweighting.fair Reweighting.biased :=
  Persistence.reweight_not_preserving_not_identity

example :
    Reweighting.attractor Reweighting.fair =
      Reweighting.attractor Reweighting.biased ∧
    Persistence.reweightPreserving.identityRel
      Persistence.reweightDynamics
      Reweighting.fair Reweighting.biased ∧
    ¬ Persistence.noPreservation.identityRel
      Persistence.reweightDynamics
      Reweighting.fair Reweighting.biased :=
  Persistence.classification_decides_identity

example :
    SE.Persistence.Classification.NonCollapsing
      Persistence.reweightDynamics
      Persistence.reweightPreserving Persistence.noPreservation :=
  Persistence.reweight_classifications_noncollapsing

end SETest.SelfSimilarity
