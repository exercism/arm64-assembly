.equ INVALID_CHARACTER, -1
.equ NEGATIVE_SPAN, -2
.equ INSUFFICIENT_DIGITS, -3

.text
.globl largest_product

/* extern int64_t largest_product(int span, const char *digits); */
largest_product:
        mov     x2, x1                  /* input pointer */

.scan:
        ldrb    w3, [x2], #1            /* load byte, with post-increment */
        cbz     w3, .check_length

        sub     w3, w3, #'0'
        cmp     w3, #10
        blo     .scan                   /* unsigned < */

        mov     x0, INVALID_CHARACTER
        ret

.check_length:
        sub     x2, x2, #1              /* address of null terminator */

        cmp     w0, wzr                 /* compare with zero */
        blt     .negative_span

        sub     x3, x2, x1              /* number of digits */
        cmp     x3, x0
        blt     .insufficient_digits

        mov     x4, x0                  /* span */
        mov     x0, xzr                 /* largest product */

.series:
        add     x5, x1, x4              /* end of series */
        mov     x6, #1                  /* current product */
        mov     x7, x1                  /* input pointer */

.digit:
        cmp     x7, x5
        beq     .update_largest

        ldrb    w8, [x7], #1            /* load digit */
        sub     w8, w8, #'0'
        mul     x6, x6, x8
        b       .digit

.update_largest:
        cmp     x6, x0
        csel    x0, x6, x0, hi
        cmp     x7, x2
        add     x1, x1, #1              /* start of next series */
        bne     .series

        ret

.negative_span:
        mov     x0, NEGATIVE_SPAN
        ret

.insufficient_digits:
        mov     x0, INSUFFICIENT_DIGITS
        ret
