---
category: Computer Organization
---

# Denormalization

## Scope

In IEEE 754, we haven't used *exponent = 0, significand nonzero* bits. And a
big "gap" is between $-(1 * 2^{-23}) * 2^{-126}$ and $(1 * 2^{-23}) * 2^{-126}$.

## Solution

Denormalized number: doesn't have (implied) leading 1, but implicit
*exponent = -126*.

And now space between every adjacant pair of numbers hold the same
($2^{-23} * 2^{-126} = 2^{-149}$).

## Consequence

After denormalization, the representation of bits is like following table:

| Exponent | Significand | Object        |
| ---      | ---         | ---           |
| 0        | 0           | 0             |
| 0        | nonzero     | Denorm        |
| 1-254    | anything    | +/- fl. pt. # |
| 255      | 0           | $+/- ∞$       |
| 255      | nonzero     | NaN           |
