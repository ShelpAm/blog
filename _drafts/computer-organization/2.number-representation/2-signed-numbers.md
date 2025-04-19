# Signed numbers

## One obvious solution: taking leftmost bit as sign

This representation is called *Sign and Magnitude*.

Shortcomings of sign and magnitude are:
- Arithmetic circuit complicated
  - Special steps depending on if signs are the same or not
- **Two** zeros
  - 0x00000000 $= +0_{ten}$
  - 0x80000000 $= -0_{ten}$
  - What would two 0s mean for programming?
- Incrementing "binary odometer", sometimes increases values, and sometimes decreases!

THerefore sign and magnitude used only in signal processors.

## Another try: complement the bits

Example:
- $+7_{10} = 00111_2$
- $-7_{10} = 11000_2$

This is called *One's Complement*.

Shortcomings of one's complement:
- Arithmetic still somewhat complicated
- Still two zeros
  - 0x00000000 $= +0_{ten}$
  - 0xFFFFFFFF $= -0_{ten}$

Although used for a while on some computer products, one's complement was
eventually abandoned, because another solution was better.

## Standard negative representation

- Problem is the negative mappings "overlap" with the positive ones (the two
0s). Want to shift the negative mappings left by one. Like following:

<pre>
                           00000 00001 00010 .. 01110 01111
<--------------------------------------------------------->
10000 10001 .. 11101 11110 11111
                            /|\
                             |
                          Overlap here
                          So we just "shift" them left.
</pre>

- Solution! For negative numbers, complement, then add 1 to the result.

This representation is *Two's Complement*.

It makes the hardware simple. And it's C's `int`.

### Two's complement formula

Weight of each bits (32 bits as an example): $-2^{31}, 2^{30}, ..., 2^2, 2^1, 2^0$

Example: $1101_{two}$ in a nibble?

$= 1 * (-2^3) + 1 * 2^2 + 0 * 2^1 + 1 * 2^0$

$= -2^3 + 2^2 + 0 + 2^0$

$= -8 + 4 + 0 + 1$

$= -3_{ten}$

## Bias encoding

\# = unsigned + bias

- Bias for N bits chosen as $-(2^{N-1} - 1)$
- one zero
- how many positives?
  - $2^{N-1}$

## In summary

These 5 integer representations have different benefits; 1s complement and
sign/mag have most problems.
