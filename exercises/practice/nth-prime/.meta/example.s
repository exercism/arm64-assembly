.text
.globl prime

/* extern uint64_t prime(uint64_t number); */
prime:
        cmp     x0, #3
        blt     .small

        clz     x1, x0                  /* count leading zero bits */
        mov     x2, #64
        sub     x1, x2, x1              /* ceil(log2(number + 1)) */
        mul     x1, x0, x1              /* number * ceil(log2(number + 1)) */
        add     x1, x1, #15
        and     x1, x1, #-16            /* round up to multiple of 16 */
        mov     x3, sp
        sub     sp, sp, x1              /* allocate space on stack */
        mov     x4, #-1
        mov     x5, sp

.fill:
        stp     x4, x4, [x3, #-16]!     /* store pair, pre-decrement */
        cmp     x3, x5
        bne     .fill

        mov     x4, #1

.search:
        add     x4, x4, #1              /* candidate prime */
        ldrb    w5, [sp, x4]
        cbz     w5, .search             /* if composite, move on to next candidate */

        sub     x0, x0, #1              /* number of primes required */
        cbz     x0, .exit

        mul     x5, x4, x4              /* multiple of prime */

.mark:
        cmp     x5, x1
        bhs     .search                 /* unsigned >= */

        strb    wzr, [sp, x5]           /* mark as composite */
        add     x5, x5, x4
        b       .mark

.exit:
        mov     x0, x4
        add     sp, sp, x1              /* restore original stack pointer */ 
        ret

.small:
        add     x0, x0, #1
        ret
