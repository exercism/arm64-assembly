.text
.globl reverse

/* extern void reverse(char *str); */
reverse:
        mov     x1, x0

.scan:
        ldrb    w2, [x1], #1            /* load byte, post-increment */
        cbnz    w2, .scan

        sub     x1, x1, #1
        cmp     x1, x0
        beq     .done                   /* zero length string */

.reverse:
        sub     x1, x1, #1
        cmp     x1, x0
        beq     .done                   /* middle byte of odd length string */

        ldrb    w2, [x1]
        ldrb    w3, [x0]
        strb    w3, [x1]
        strb    w2, [x0], #1            /* store byte, post-increment */
        cmp     x1, x0
        bne     .reverse
                                        /* middle bytes of even length string */

.done:
        ret
