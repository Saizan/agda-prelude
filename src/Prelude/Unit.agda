{-# OPTIONS --without-K #-}

module Prelude.Unit where

open import Agda.Primitive

module 𝟙 where
  record 𝟙 ..{ℓ} : Set ℓ where
    constructor *

  ! : ∀ ..{ℓ₀ ℓ₁} {A : Set ℓ₀} → A → 𝟙 {ℓ₁}
  ! _ = *

  𝟙₀ : Set
  𝟙₀ = 𝟙

  !₀ : ∀ ..{ℓ₀} {A : Set ℓ₀} → A → 𝟙₀
  !₀ = !

open 𝟙 public
  using (𝟙)
  using (𝟙₀)
  using (*)
  hiding (module 𝟙)
