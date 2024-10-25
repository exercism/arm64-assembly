.text
.globl truncate

/* extern void truncate(char *buffer, const char *phrase); */
truncate:
        mov     x2, #6

.read:
        ldrb    w3, [x1], #1            /* load byte, post-increment */
        strb    w3, [x0], #1            /* store byte, post-increment */
        cbz     w3, .return             /* null terminator */

        and     w4, w3, #0xC0
        cmp     w4, #0x80
        beq     .read                   /* non-initial byte of code point */

        sub     x2, x2, #1
        cbnz    x2, .read
                                        /* start of the 6th code point */

.return:
        strb    wzr, [x0, #-1]          /* overwrite most recent byte with '\0' */
        ret
