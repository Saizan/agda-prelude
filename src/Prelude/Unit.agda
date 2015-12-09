{-# OPTIONS --without-K #-}

module Prelude.Unit where

open import Agda.Primitive

module 𝟙ₙ ..{ℓ} where
  record 𝟙 : Set ℓ where
    constructor *

  ! : ∀ ..{ℓ₀} {A : Set ℓ₀} → A → 𝟙
  ! _ = *

module 𝟙 where
  open 𝟙ₙ {lzero} public

open 𝟙 public
  using (𝟙)
  using (*)
  hiding (module 𝟙)
open 𝟙ₙ public
  using ()
  renaming (𝟙 to 𝟙ₙ)
  hiding (module 𝟙)
