.equ DEFICIENT, 1
.equ PERFECT, 2
.equ ABUNDANT, 3
.equ INVALID, -1

.text
.globl classify

/* extern int classify(int64_t number); */
classify:
        cmp     x0, #1
        ble     .le_one

        mov     x1, #1                  /* product of factors */
        mov     x2, #1
        lsl     x4, x0, #1              /* 2 * number */

.next:
        add     x2, x2, #1              /* candidate factor */
        mov     x5, #1                  /* sum of powers of factor */
        mul     x3, x2, x2
        cmp     x3, x0
        csel    x2, x0, x2, hi          /* if x2*x2 exceeds x0, then set x2 to x0 */

        udiv    x6, x0, x2              /* quotient */
        msub    x7, x6, x2, x0          /* remainder */
        cbnz    x7, .next

.repeat:
        mul     x5, x5, x2
        add     x5, x5, #1
        mov     x0, x6

        udiv    x6, x0, x2              /* quotient */
        msub    x7, x6, x2, x0          /* remainder */
        cbz     x7, .repeat

        mul     x1, x1, x5
        cmp     x0, #1
        bne     .next

        cmp     x1, x4
        beq     .perfect
        blo     .deficient

.abundant:
        mov     x0, ABUNDANT
        ret

.perfect:
        mov     x0, PERFECT
        ret

.deficient:
        mov     x0, DEFICIENT
        ret

.le_one:
        beq     .deficient

        mov     x0, INVALID
        ret
