.text
.globl abbreviate

/* extern void abbreviate(char *buffer, const char *phrase); */
abbreviate:
        ldrb    w2, [x1], #1            /* load byte, post-increment */
        cbz     w2, .return

        and     w3, w2, #-33            /* force upper case */
        sub     w4, w3, #'A'
        cmp     w4, #26
        bhs     abbreviate              /* jump if word has not yet started */

        strb    w3, [x0], #1            /* store byte, post-increment */

.read:
        ldrb    w2, [x1], #1            /* load byte, post-increment */
        cbz     w2, .return

        cmp     w2, #'\''
        beq     .read                   /* if an apostrophe, keep reading current word */

        and     w3, w2, #-33            /* force upper case */
        sub     w4, w3, #'A'
        cmp     w4, #26
        blo     .read                   /* if a letter, keep reading current word */

        b       abbreviate              /* search for the start of the next word */

.return:
        strb    wzr, [x0]               /* store null terminator */
        ret
