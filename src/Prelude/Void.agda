{-# OPTIONS --without-K #-}

module Prelude.Void where

open import Agda.Primitive

module 𝟘 where
  data 𝟘 ..{ℓ} : Set ℓ where

  ¬_ : ∀ ..{ℓ₀ ℓ₁} → Set ℓ₀ → Set (ℓ₀ ⊔ ℓ₁)
  ¬_ {ℓ₁ = ℓ₁} A = A → 𝟘 {ℓ₁}

  ¡ : ∀ ..{ℓ₀ ℓ₁} {A : Set ℓ₀} → 𝟘 {ℓ₁} → A
  ¡ ()

  𝟘₀ : Set
  𝟘₀ = 𝟘

  ¬₀_ : ∀ ..{ℓ₀} → Set ℓ₀ → Set ℓ₀
  ¬₀_ = ¬_ {ℓ₁ = lzero}

  ¡₀ : ∀ ..{ℓ₀} {A : Set ℓ₀} → 𝟘₀ → A
  ¡₀ = ¡

open 𝟘 public
  using (𝟘)
  using (𝟘₀)
  hiding (module 𝟘)
