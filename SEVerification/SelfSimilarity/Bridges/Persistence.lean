module

public import SEVerification.SelfSimilarity.Cases.Reweighting
public import SE.Persistence

set_option autoImplicit false

/-!
# Persistence Bridge

Tests whether equality of geometric attractors is sufficient
to establish generated identity of weighted systems.

The test supplies a classification with no preserving steps
and dynamics with no steps.

Under those declared conditions, the two weighted systems
are not generated-identical despite equal attractors.

This is a countermodel to unconditional identification from
attractor equality, not a claim that real-world reweighting
must break identity.
-/

namespace SEVerification.SelfSimilarity.Bridges.Persistence

open SEVerification.SelfSimilarity.Cases.Reweighting
open SE.Persistence

@[expose] public section

/-- No transformation is classified as preserving. -/
def noPreservation : Classification Unit where
  pattern := fun _ => none
  persist := fun _ => False

/-- Dynamics with no transformation steps. -/
def noDynamics : Dynamics Unit WeightedSystem where
  step := fun _ _ _ => False

/-- Generated identity in this model implies record equality. -/
theorem identity_implies_equality
    {x y : WeightedSystem}
    (h : noPreservation.identityRel noDynamics x y) :
    x = y := by
  apply Generated.le_of_equivalence
    (s := fun a b : WeightedSystem => a = b)
    ⟨(fun _ => rfl),
      (fun hab => hab.symm),
      (fun hab hbc => hab.trans hbc)⟩
    (fun a b hab => by
      obtain ⟨t, _, hstep⟩ := hab
      exact False.elim hstep)
    h

/-- Equal attractors do not force generated identity. -/
theorem equal_attractors_without_generated_identity :
    attractor fair = attractor biased ∧
    ¬ noPreservation.identityRel noDynamics fair biased := by
  refine ⟨attractor_invariant, ?_⟩
  intro h
  exact systems_distinct (identity_implies_equality h)

/-- The attractor presentation is sound in this model. -/
theorem attractor_presentation_sound :
    noPreservation.PresentationSound noDynamics attractor := by
  intro x y h
  exact congrArg attractor (identity_implies_equality h)

/-- The attractor presentation is not complete in this model. -/
theorem attractor_presentation_not_complete :
    ¬ noPreservation.PresentationComplete
      noDynamics attractor := by
  intro h
  exact systems_distinct
    (identity_implies_equality
      (h fair biased attractor_invariant))


/-- Dynamics with one step: reweighting the fair system to the biased one. -/
def reweightDynamics : Dynamics Unit WeightedSystem where
  step := fun _ a b => a = fair ∧ b = biased

/-- Every transformation is applicable and identity-preserving. -/
def reweightPreserving : Classification Unit where
  pattern := fun _ => some ClassificationValue.prs
  persist := fun _ => True

/-- The declared persistence set contains only preserving transformations. -/
theorem reweightPreserving_wellFormed : reweightPreserving.WellFormed :=
  fun _ _ => rfl

/-- With the reweighting step classified preserving, fair and biased are
generated-identical. -/
theorem reweight_preserving_identity :
    reweightPreserving.identityRel reweightDynamics fair biased :=
  Generated.rel ⟨(), rfl, rfl, rfl⟩

/-- Same dynamics, nothing preserving: they are not generated-identical. -/
theorem reweight_not_preserving_not_identity :
    ¬ noPreservation.identityRel reweightDynamics fair biased := by
  intro h
  apply systems_distinct
  exact Generated.le_of_equivalence
    (s := fun a b : WeightedSystem => a = b)
    ⟨(fun _ => rfl), (fun hab => hab.symm), (fun hab hbc => hab.trans hbc)⟩
    (fun a b hab => by
      obtain ⟨t, hp, _⟩ := hab
      simp [Classification.IsPrs, noPreservation] at hp)
    h

/-- Attractor and dynamics held fixed; only the classification changes the verdict. -/
theorem classification_decides_identity :
    attractor fair = attractor biased ∧
    reweightPreserving.identityRel reweightDynamics fair biased ∧
    ¬ noPreservation.identityRel reweightDynamics fair biased :=
  ⟨attractor_invariant, reweight_preserving_identity,
    reweight_not_preserving_not_identity⟩

/-- In Persistence's own terms, the two classifications are non-collapsing here. -/
theorem reweight_classifications_noncollapsing :
    Classification.NonCollapsing reweightDynamics
      reweightPreserving noPreservation := by
  intro h
  apply reweight_not_preserving_not_identity
  rw [← h]
  exact reweight_preserving_identity

end

end SEVerification.SelfSimilarity.Bridges.Persistence
