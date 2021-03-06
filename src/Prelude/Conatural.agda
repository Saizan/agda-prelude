{-# OPTIONS --without-K #-}

module Prelude.Conatural where

open import Agda.Primitive
open import Prelude.Natural

module Nat∞ where
  mutual
    data Nat∞ : Set where
      ze : Nat∞
      su_ : (n : [Nat∞]) → Nat∞

    record [Nat∞] : Set where
      no-eta-equality
      coinductive
      constructor ι
      field
        π : Nat∞
  open [Nat∞] public
    hiding (π)

  fromNat : Nat → Nat∞
  fromNat (Nat.ze) = ze
  fromNat (Nat.su n) = su (ι (fromNat n))

  instance
    nat⊆nat∞ : Nat.⊆ Nat∞
    nat⊆nat∞ = record { fromNat = fromNat }

  mutual
    ∞ : Nat∞
    ∞ = su [∞]

    [∞] : [Nat∞]
    [Nat∞].π [∞] = ∞

  pred : Nat∞ → Nat∞
  pred (ze) = ze
  pred (su n) = [Nat∞].π n

  module ≈ where
    infix 0 _≈_
    infix 0 _[≈]_

    mutual
      data _≈_ : (m n : Nat∞) → Set where
        ze  : ze ≈ ze
        su_ : ∀ {m n} → m [≈] n → su m ≈ su n

      record _[≈]_ (m n : [Nat∞]) : Set where
        no-eta-equality
        coinductive
        constructor ι
        field
          π : [Nat∞].π m ≈ [Nat∞].π n
    open _[≈]_ public

    mutual
      idn : ∀ {m} → m ≈ m
      idn {ze} = ze
      idn {su n} = su [idn]

      [idn] : ∀ {m} → m [≈] m
      π ([idn] {m}) = idn

    mutual
      cmp : ∀ {m n o} → n ≈ o → m ≈ n → m ≈ o
      cmp (ze) p = p
      cmp (su q) (su p) = su ([cmp] q p)

      [cmp] : ∀ {m n o} → n [≈] o → m [≈] n → m [≈] o
      π ([cmp] q p) = cmp (π q) (π p)

    seq : ∀ {m n o} → m ≈ n → n ≈ o → m ≈ o
    seq p q = cmp q p

    mutual
      inv : ∀ {m n} → m ≈ n → n ≈ m
      inv (ze) = ze
      inv (su p) = su ([inv] p)

      [inv] : ∀ {m n} → m [≈] n → n [≈] m
      π ([inv] p) = inv (π p)

    ∞-1≈∞ : pred ∞ ≈ ∞
    ∞-1≈∞ = su [idn]

    ∞+1≈∞ : su (ι ∞) ≈ ∞
    ∞+1≈∞ = su (ι idn)

  open ≈ public
    using (_≈_)
    using (_[≈]_)
    using (su_)
    using (ze)

  module  ≲ where
    infix 0 _≲_
    infix 0 _[≲]_

    mutual
      data _≲_ : (m n : Nat∞) → Set where
        ze : ∀ {n} → ze ≲ n
        su_ : ∀ {m n} → m [≲] n → su m ≲ su n

      record _[≲]_ (m n : [Nat∞]) : Set where
        no-eta-equality
        coinductive
        constructor ι
        field
          π : [Nat∞].π m ≲ [Nat∞].π n
    open _[≲]_ public

    mutual
      idn : ∀ {m} → m ≲ m
      idn {ze} = ze
      idn {su n} = su [idn]

      [idn] : ∀ {m} → m [≲] m
      π [idn] = idn

    mutual
      cmp : ∀ {m n o} → n ≲ o → m ≲ n → m ≲ o
      cmp q ze = ze
      cmp (su q) (su p) = su ([cmp] q p)

      [cmp] : ∀ {m n o} → n [≲] o → m [≲] n → m [≲] o
      π ([cmp] q p) = cmp (π q) (π p)

    seq : ∀ {m n o} → m ≲ n → n ≲ o → m ≲ o
    seq p q = cmp q p

    z≲n : ∀ {n} → 0 ≲ n
    z≲n = ze

    mutual
      n≲∞ : ∀ {n} → n ≲ ∞
      n≲∞ {ze} = ze
      n≲∞ {su n} = su [n≲∞]

      [n≲∞] : ∀ {n} → n [≲] [∞]
      π [n≲∞] = n≲∞

    s≲s : ∀ {m n} → m ≲ n → su (ι m) ≲ su (ι n)
    s≲s (ze) = su (ι ze)
    s≲s (su p) = su (ι (su p))

    p≲p : ∀ {m n} → m ≲ n → pred m ≲ pred n
    p≲p (ze) = ze
    p≲p (su p) = π p

    mutual
      beq-leq : ∀ {m n} → m ≈ n → m ≲ n
      beq-leq (ze) = ze
      beq-leq (su p) = su ([beq-leq] p)

      [beq-leq] : ∀ {m n} → m [≈] n → m [≲] n
      π ([beq-leq] p) = beq-leq (≈.π p)

  open ≲ public
    using (_≲_)
    using (_[≲]_)

  open [Nat∞] public
    using (π)

  mutual
    _+_ : Nat∞ → Nat∞ → Nat∞
    (ze) + n = n
    (su m) + n = su (m [+] n)

    _[+]_ : [Nat∞] → Nat∞ → [Nat∞]
    π (m [+] n) = π m + n

open Nat∞ public
  hiding (module Nat∞)
  using (Nat∞)
  using ([Nat∞])
  using (su_)
  using (ze)
