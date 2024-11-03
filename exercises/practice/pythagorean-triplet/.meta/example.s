.text
.globl triplets_with_sum

/* extern size_t triplets_with_sum(uint64_t n, uint64_t* a, uint64_t* b, uint64_t* c); */
triplets_with_sum:
        mov     x5, #0
        mov     x4, x0                  /* n */
        mov     x0, #0                  /* number of tuples */
        cmp     x4, #2
        blo     .return                 /* stop when n < 2 */

.next:
        add     x5, x5, #1              /* a */
        sub     x9, x4, x5              /* n - a */
        sub     x10, x9, x5             /* n - 2*a */
        lsl     x11, x9, #1             /* 2*n - 2*a */
        mul     x10, x4, x10            /* n*n - 2*n*a */

        udiv    x6, x10, x11            /* b */
        msub    x12, x6, x11, x10       /* remainder */
        cmp     x5, x6
        bhs     .return                 /* stop when a >= b */

        cbnz    x12, .next

        sub     x7, x9, x6
        str     x5, [x1], #8
        str     x6, [x2], #8
        str     x7, [x3], #8
        add     x0, x0, #1
        b       .next

.return:
        ret
