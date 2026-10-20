module

public import SEVerification.SelfSimilarity.Model

set_option autoImplicit false

/-!
# Infinite Symbolic Coding

An address is an infinite binary sequence.

`Represents ω x` states that a bounded sequence of tail points
realizes the recursive coding equations and starts at `x`.

This is a relational coding model. Uniqueness and totality
of the represented point are separate mathematical obligations.
-/

namespace SEVerification.SelfSimilarity

@[expose] public section

/-- Infinite binary symbolic address. -/
abbrev Address := ℕ → Bool

/-- A point is represented by an address through bounded tails. -/
def Represents (ω : Address) (x : ℝ) : Prop :=
  ∃ tail : ℕ → ℝ,
    tail 0 = x ∧
    (∀ n, InUnitInterval (tail n)) ∧
    (∀ n, tail n = binaryMap (ω n) (tail (n + 1)))

/-- Every represented point belongs to the unit interval. -/
theorem represented_in_interval
    {ω : Address} {x : ℝ}
    (h : Represents ω x) :
    InUnitInterval x := by
  obtain ⟨tail, h0, hb, _⟩ := h
  rw [← h0]
  exact hb 0

/-- A bounded tail sequence determines its starting point. -/
theorem represents_unique {ω : Address} {x y : ℝ}
    (hx : Represents ω x) (hy : Represents ω y) : x = y := by
  obtain ⟨t, ht0, htI, hts⟩ := hx
  obtain ⟨u, hu0, huI, hus⟩ := hy
  have hstep : ∀ n, t (n + 1) - u (n + 1) = 2 * (t n - u n) := by
    intro n
    have h1 := hts n
    have h2 := hus n
    cases hb : ω n <;> simp [binaryMap, hb] at h1 h2 <;> linarith
  have hpow : ∀ n : ℕ, t n - u n = 2 ^ n * (t 0 - u 0) := by
    intro n
    induction n with
    | zero => simp
    | succ k ih => rw [hstep k, ih]; ring
  have hbound : ∀ n, |t n - u n| ≤ 1 := by
    intro n
    obtain ⟨h0, h1⟩ := htI n
    obtain ⟨g0, g1⟩ := huI n
    rw [abs_le]
    constructor <;> linarith
  by_contra hne
  have hd : t 0 - u 0 ≠ 0 := by
    rw [ht0, hu0]
    exact sub_ne_zero.mpr hne
  have hpos : 0 < |t 0 - u 0| := abs_pos.mpr hd
  obtain ⟨n, hn⟩ :=
    pow_unbounded_of_one_lt (1 / |t 0 - u 0|) (by norm_num : (1 : ℝ) < 2)
  have h1 := hbound n
  rw [hpow n, abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 ^ n)] at h1
  rw [div_lt_iff₀ hpos] at hn
  linarith

end

end SEVerification.SelfSimilarity
