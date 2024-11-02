.text
.globl sum

/* extern uint64_t sum(uint64_t limit, const uint64_t *factors, size_t factor_count); */
sum:
        lsl     x2, x2, #3              /* size of factors array, in bytes */
        add     x2, x1, x2              /* end of factors array */
        mov     x3, x0
        mov     x0, xzr                 /* initialize total */
        cbz     x3, .return

.next_number:
        sub     x3, x3, #1              /* number to check */
        cbz     x3, .return

        mov     x4, x1

.next_factor:
        cmp     x4, x2
        beq     .next_number

        ldr     x5, [x4], #8            /* load factor, post-increment */
        udiv    x6, x3, x5              /* quotient */
        msub    x7, x6, x5, x3          /* remainder */
        cbnz    x7, .next_factor

        add     x0, x0, x3              /* number x3 is a multiple of factor x5 */
        b       .next_number

.return:
        ret
