.text
.globl square_root

/* extern uint64_t square_root(uint64_t radicand); */
square_root:
        mov     x1, x0                  /* radicand */

        clz     x0, x1                  /* count leading zero bits */
        mov     x2, #64
        sub     x0, x2, x0              /* number of bits, excluding leading zero bits */
        lsr     x0, x0, #1              /* number of bits, halved */
        mov     x2, #1
        lsl     x0, x2, x0              /* initial guess */

.loop:
        mov     x2, x0                  /* current guess */
        add     x3, x2, #1
        madd    x3, x3, x2, x1          /* guess (guess + 1) + radicand */
        lsl     x4, x2, #1              /* 2 * guess */
        udiv    x0, x3, x4              /* new guess */
        cmp     x0, x2
        bne     .loop

        ret
