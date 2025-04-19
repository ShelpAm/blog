---
category: Computer Organization
---

# Floating-point discussions

This documents contains some discussion about FP.

## Floating-point fallacy: Addition is associative.

Given
$$x = -1.5 * 10^{38}, y = 1.5 * 10^{38}, z = 1$$
We can find that
$$(x + y) + z = 1 \ne x + (y + z) = 0$$

## Distinguish precision and accuracy

These two words are relative but different things.

Definition:

- Precision: is a count of bits used to represent a value.
- Accuracy: is the difference between the actual value of a number and its
  computer representation.

High precision permits high accuracy but doesn't guarentee it. (It's possible to
have high precision but low accuracy.)

- Example: for `float pi = 3.14;`,

  `pi` will be represented using all 24 bits of the significant (highly
  precise), but is only an approximation (not accurate).

## Rounding

When we perform math on real numbers, we have to worry about rounding to fit the
result in the significant field.

The FP hardware carries two extra bits of precision, and then round to get the
proper value.

Rounding also occurs when converting:
- double to a single precision value, or
- floating point number to an integer.

## IEEE FP rounding modes

Note: examples in decimal, but, of course, IEEE754 in binary.

There are multiple modes of rounding floats:

- **Round towards $+∞$**: always rounds "up"

- **Round towards $-∞$**: always rounds "down"

- **Truncate**: drops the last bits (round towards $0$)

- **Unbiased** (default mode)
  - If "midway", round to even;
  - Else, round to the nearest int.

## Algorithm for addition of floating-point numbers

Steps of FP addition:
1. De-normalize to match the greater exponent.
1. Add the significands.
1. Normalize the result of last step.
