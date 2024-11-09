.text
.globl sieve

/* extern size_t sieve(uint64_t* primes, uint64_t limit); */
sieve:
        add     x2, x1, #16
        and     x2, x2, #-16            /* limit, rounded up to the next multiple of 16 */
        mov     x3, sp
        sub     sp, sp, x2              /* allocate space on stack */
        mov     x4, #-1
        mov     x5, sp

.fill:
        stp     x4, x4, [x3, #-16]!     /* store pair, pre-decrement */
        cmp     x3, x5
        bne     .fill

        mov     x3, x0                  /* output pointer */
        mov     x4, #1

.search:
        add     x4, x4, #1              /* candidate prime */
        cmp     x1, x4
        blo     .exit                   /* unsigned < */

        ldrb    w5, [sp, x4]
        cbz     w5, .search             /* if composite, move on to next candidate */

        str     x4, [x3], #8
        mul     x5, x4, x4              /* multiple of prime */

.mark:
        cmp     x1, x5
        blo     .search                 /* unsigned < */

        strb    wzr, [sp, x5]           /* mark as composite */
        add     x5, x5, x4
        b       .mark

.exit:
        sub     x0, x3, x0
        lsr     x0, x0, #3              /* number of primes */
        add     sp, sp, x2              /* restore original stack pointer */ 
        ret
