{-# OPTIONS --without-K #-}

module Prelude.Bool where

open import Agda.Primitive
open import Prelude.Unit
open import Prelude.Void

module 𝟚ₙ ..{ℓ} where
  data 𝟚 : Set ℓ where
    ff tt : 𝟚

  or : (p q : 𝟚) → 𝟚
  or tt q = tt
  or p tt = tt
  or ff ff = ff

  and : (p q : 𝟚) → 𝟚
  and ff q = ff
  and p ff = ff
  and tt tt = tt

  _∨_ : _
  _∨_ = or
  {-# DISPLAY or p q = p ∨ q #-}

  _∧_ : _
  _∧_ = and
  {-# DISPLAY and p q = p ∧ q #-}

  if_then_else_
    : ∀ ..{ℓ₀}
    → {A : Set ℓ₀}
    → (φ : 𝟚)
    → (lhs rhs : A)
    → A
  if ff then lhs else rhs = lhs
  if tt then lhs else rhs = rhs

  ⟦_⟧ : ∀ ..{ℓ₀} (φ : 𝟚) → Set ℓ₀
  ⟦ ff ⟧ = 𝟘ₙ
  ⟦ tt ⟧ = 𝟙ₙ

module 𝟚 where
  open 𝟚ₙ {lzero} public

open 𝟚 public
  using (𝟚)
  hiding (module 𝟚)
open 𝟚ₙ public
  renaming (𝟚 to 𝟚ₙ)
  using (ff)
  using (tt)
  using (_∧_)
  using (_∨_)
  using (if_then_else_)
  using (⟦_⟧)
  hiding (module 𝟚)

{-# BUILTIN BOOL 𝟚 #-}
{-# BUILTIN FALSE ff #-}
{-# BUILTIN TRUE tt #-}
