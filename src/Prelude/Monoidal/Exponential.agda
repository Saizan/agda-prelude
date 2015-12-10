{-# OPTIONS --without-K #-}

module Prelude.Monoidal.Exponential where

open import Agda.Primitive
open import Prelude.Monoidal.Exponential.Boot public
  hiding (module ⇒)
open import Prelude.Monoidal.Product

module ⇒ where
  open Prelude.Monoidal.Exponential.Boot.⇒ public

  open ⊗
    using (_,_)
    using (fst)

  λ⇑
    : ∀ ..{ℓ₀ ℓ₁ ℓ₂}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → {C : Set ℓ₂}
    → (A ⊗ B → C)
    → (A → B ⇒ C)
  λ⇑ f a b = f (a , b)

  λ⇓
    : ∀ ..{ℓ₀ ℓ₁ ℓ₂}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → {C : Set ℓ₂}
    → (A → B ⇒ C)
    → (A ⊗ B → C)
  λ⇓ f (a , b) = f a b

  syntax λ⇓ (λ a → M) = λ⇓[ a ] M

  ap
    : ∀ ..{ℓ₀ ℓ₁}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → (A ⇒ B) ⊗ A → B
  ap (f , a) = f a

  Δ[_]
    : ∀ ..{ℓ₀ ℓ₁}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → A → (B → A)
  Δ[_] = λ⇑ fst