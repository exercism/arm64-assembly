.text
.globl is_armstrong_number

/* extern int is_armstrong_number(unsigned number); */
is_armstrong_number:
        mov     x1, #10
        mov     x4, x0                  /* number */
        mov     x5, xzr                 /* digit count */
        mov     x6, xzr                 /* sum of digit powers */

.count_digit:
        add     x5, x5, #1
        udiv    x0, x0, x1              /* quotient */
        cbnz    x0, .count_digit

        mov     x0, x4                  /* number */

.extract_digit:
        udiv    x2, x0, x1              /* quotient */
        msub    x3, x2, x1, x0          /* remainder becomes base */
        mov     x0, x2
        mov     x9, #1                  /* multiplier */
        mov     x10, x5                 /* exponent */

.raise:
        mul     x7, x9, x3
        tst     x10, #1
        csel    x9, x7, x9, ne          /* multiplier *= base, provided exponent is odd */

        mul     x3, x3, x3              /* square base */
        lsr     x10, x10, #1            /* halve exponent */
        cbnz    x10, .raise

        add     x6, x6, x9              /* update sum of digit powers */
        cbnz    x2, .extract_digit

        cmp     x6, x4
        cset    x0, eq                  /* 1 if sum of digit powers == number, otherwise 0 */
        ret
