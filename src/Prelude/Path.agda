{-# OPTIONS --without-K #-}

module Prelude.Path where

open import Agda.Primitive
open import Prelude.Coproduct
open import Prelude.Diagonal
open import Prelude.Function
open import Prelude.Nat
open import Prelude.One
open import Prelude.Point
open import Prelude.Product

data _≡_ ..{ℓ} {A : Set ℓ} (a : A) : A → Set ℓ where
  refl : a ≡ a
{-# BUILTIN EQUALITY _≡_ #-}
{-# BUILTIN REFL refl #-}

module ≡ where
  idn*
    : ∀ ..{ℓ} {A : Set ℓ} {a : A}
    → 𝟙₀ ⇒ (a ≡ a)
  idn* = Δ[ refl ]

  idn : ∀ ..{ℓ} {A : Set ℓ} {a : A} → _
  idn {a = a} = idn* {a = a} *
  {-# DISPLAY idn* _ = idn #-}

  cmp
    : ∀ ..{ℓ} {A : Set ℓ} {a b c : A}
    → ((b ≡ c) ⊗ (a ≡ b)) ⇒ (a ≡ c)
  cmp (refl ⊗., refl) = refl

  seq
    : ∀ ..{ℓ} {A : Set ℓ} {a b c : A}
    → ((a ≡ b) ⊗ (b ≡ c)) ⇒ (a ≡ c)
  seq (refl ⊗., refl) = refl

  inv
    : ∀ ..{ℓ} {A : Set ℓ} {a b : A}
    → (a ≡ b) ⇒ (b ≡ a)
  inv refl = refl

  _<∘_ : _
  _<∘_ = cmp
  {-# DISPLAY cmp (q ⊗., p) = q <∘ p #-}

  _∘>_ : _
  _∘>_ = seq
  {-# DISPLAY seq (p ⊗., q) = p ∘> q #-}

  _⁻¹ : _
  _⁻¹ = inv
  {-# DISPLAY inv p = p ⁻¹ #-}

  coe
    : ∀ ..{ℓ₀ ℓ₁} {A : Set ℓ₀} {a b}
    → (Ψ : A → Set (ℓ₀ ⊔ ℓ₁))
    → (f : a ≡ b)
    → (Ψ a ⇒ Ψ b)
  coe Ψ refl ψ = ψ

  ap₁
    : ∀ ..{ℓ₀ ℓ₁} {A : Set ℓ₀} {B : Set ℓ₁} {a b}
    → (F : A ⇒ B)
    → ((a ≡ b) ⇒ (F a ≡ F b))
  ap₁ F refl = refl

  _$₁_ : _
  _$₁_ = ap₁
  {-# DISPLAY ap₁ f p = f $₁ p #-}

  idn-lhs
    : ∀ ..{ℓ}
    → ∀ {A : Set ℓ} {a b : A}
    → (ϕ : a ≡ b)
    → (cmp (idn* * ⊗., ϕ)) ≡ ϕ
  idn-lhs refl = refl

  idn-rhs
    : ∀ ..{ℓ}
    → ∀ {A : Set ℓ} {a b : A}
    → (ϕ : a ≡ b)
    → (cmp (ϕ ⊗., idn* *)) ≡ ϕ
  idn-rhs refl = refl

  cmp-ass
    : ∀ ..{ℓ}
    → ∀ {A : Set ℓ} {a b c d : A}
    → (ϕ : a ≡ b) (ψ : b ≡ c) (ϑ : c ≡ d)
    → cmp (cmp (ϑ ⊗., ψ) ⊗., ϕ) ≡ cmp (ϑ ⊗., cmp (ψ ⊗., ϕ))
  cmp-ass refl refl refl = refl

  inv-lhs
    : ∀ ..{ℓ}
    → ∀ {A : Set ℓ} {a b : A}
    → (ϕ : a ≡ b)
    → cmp (inv ϕ ⊗., ϕ) ≡ refl
  inv-lhs refl = refl

  inv-rhs
    : ∀ ..{ℓ}
    → ∀ {A : Set ℓ} {a b : A}
    → (ϕ : a ≡ b)
    → refl ≡ cmp (ϕ ⊗., inv ϕ)
  inv-rhs refl = refl

  J'
    : ∀ {ℓ₀ ℓ₁} {A : Set ℓ₀} {a : A}
    → (Φ : (b : A) → a ≡ b → Set ℓ₁)
    → (ϕ : Φ a refl)
    → ((b : A) (ψ : a ≡ b) → Φ b ψ)
  J' Φ ϕ b refl = ϕ

  J
    : ∀ {ℓ₀ ℓ₁} {A : Set ℓ₀}
    → (Φ : (a b : A) → a ≡ b → Set ℓ₁)
    → (ϕ : (a : A) → Φ a a refl)
    → ((a b : A) (ψ : a ≡ b) → Φ a b ψ)
  J Φ ϕ a = J' (Φ a) (ϕ a)

  loop : ∀ ..{ℓ} → Pt ℓ → Pt ℓ
  Pt.type (loop xs) = Pt.base xs ≡ Pt.base xs
  Pt.base (loop xs) = refl

  loop# : ∀ ..{ℓ} → Nat → Pt ℓ → Pt ℓ
  loop# ze xs = xs
  loop# (su n) xs = loop# n (loop xs)
