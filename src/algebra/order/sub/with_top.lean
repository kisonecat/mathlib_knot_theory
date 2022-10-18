/-
Copyright (c) 2021 Floris van Doorn. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Floris van Doorn
-/
import algebra.order.sub.basic
import algebra.order.monoid.with_top

/-!
# Lemma about subtraction in ordered monoids with a top element adjoined.
-/

variables {α : Type*}

namespace with_top

section
variables [has_sub α] [has_zero α]

/-- If `α` has subtraction and `0`, we can extend the subtraction to `with_top α`. -/
protected def sub : Π (a b : with_top α), with_top α
| _       ⊤       := 0
| ⊤       (x : α) := ⊤
| (x : α) (y : α) := (x - y : α)

instance : has_sub (with_top α) :=
⟨with_top.sub⟩

@[simp, norm_cast] lemma coe_sub {a b : α} : (↑(a - b) : with_top α) = ↑a - ↑b := rfl
@[simp] lemma top_sub_coe {a : α} : (⊤ : with_top α) - a = ⊤ := rfl
@[simp] lemma sub_top {a : with_top α} : a - ⊤ = 0 := by { cases a; refl }

end

variables [canonically_ordered_add_monoid α] [has_sub α] [has_ordered_sub α]
instance : has_ordered_sub (with_top α) :=
begin
  constructor,
  rintro x y z,
  induction y using with_top.rec_top_coe, { simp },
  induction x using with_top.rec_top_coe, { simp },
  induction z using with_top.rec_top_coe, { simp },
  norm_cast, exact tsub_le_iff_right
end

end with_top