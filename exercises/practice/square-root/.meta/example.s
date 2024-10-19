.text
.globl square_root

/* extern uint64_t square_root(uint64_t radicand); */
square_root:
        mov     x1, x0                  /* radicand */
        mov     x0, #1                  /* initial guess */

.loop:
        mov     x2, x0                  /* current guess */
        add     x3, x2, #1
        madd    x3, x3, x2, x1          /* guess (guess + 1) + radicand */
        lsl     x4, x2, #1              /* 2 * guess */
        udiv    x0, x3, x4              /* new guess */
        cmp     x0, x2
        bne     .loop

        ret
