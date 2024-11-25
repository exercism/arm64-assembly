.text
.globl rotate

/* extern void rotate(char *buffer, const char *text, int shift_key); */
rotate:

.read:
        ldrb    w4, [x1], #1            /* load byte, post-increment */
        and     w7, w4, #32             /* 32 if lower case, 0 if upper case */
        sub     w5, w4, w7              /* force upper case */
        sub     w5, w5, #'A'            /* index in alphabet */
        cmp     w5, #26
        bhs     .write                  /* unsigned >= */

        add     w5, w5, #'A'
        add     w5, w5, w2              /* shift */
        sub     w6, w5, #26
        cmp     w5, #'Z'
        csel    w5, w5, w6, le          /* w5 if <= 'Z', otherwise w5 - 26 */

        orr     w4, w5, w7              /* rotated letter, with original case */

.write:
        strb    w4, [x0], #1            /* store byte, post-increment */
        cbnz    w4, .read

        ret
