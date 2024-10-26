.text
.globl factors

/* extern size_t factors(uint64_t* dest, uint64_t value); */
factors:
        mov     x2, x0                  /* start of output */
        mov     x3, #2                  /* candidate factor */

.search:
        cmp     x1, #1
        beq     .return

        udiv    x4, x1, x3              /* quotient */
        msub    x5, x3, x4, x1          /* remainder */
        cbz     x5, .factor

        cmp     x3, x4
        bgt     .last

        add     x3, x3, 1
        b       .search

.last:
        mov     x3, x1
        mov     x4, #1

.factor:
        str     x3, [x0], #8            /* store, post-increment */
        mov     x1, x4
        b       .search

.return:
        sub     x0, x0, x2              /* number of bytes output */
        lsr     x0, x0, #3              /* number of primes output */
        ret
