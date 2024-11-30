.data
inverses: .byte 0, 1, 0, 9, 0, 21, 0, 15, 0, 3, 0, 19, 0, 0, 0, 7, 0, 23, 0, 11, 0, 5, 0, 17, 0, 25

.text
.globl encode
.globl decode

/* extern void encode(char *buffer, const char *phrase, unsigned a, unsigned b); */
encode:
        adrp    x12, inverses
        add     x12, x12, :lo12:inverses
        ldrb    w9, [x12, x2]
        cbz     w9, end

        mov     w9, w2                  /* a */
        mov     w10, w3                 /* b */
        mov     x2, #5                  /* group length */
        b       process

/* extern void decode(char *buffer, const char *phrase, unsigned a, unsigned b); */
decode:
        adrp    x12, inverses
        add     x12, x12, :lo12:inverses
        ldrb    w9, [x12, x2]           /* inverse of a */
        cbz     w9, end

        sub     w10, w3, #4082          /* subtract from `b` a multiple of 26, producing a negative */
        mneg    w10, w10, w9            /* inverse of `a`, multiplied by the additive inverse of `b` */
        mov     x2, #-1                 /* no groups */
        b       process

end:
        strb    wzr, [x0]               /* store null terminator */
        ret

process:
        mov     x3, x2                  /* remaining letters in group */
        mov     w6, #' '
        mov     w7, #26

.read:
        ldrb    w4, [x1], #1            /* load byte, post-increment */
        cbz     w4, end

        sub     w5, w4, #'0'
        cmp     w5, #10
        blo     .accept                 /* unsigned < */

        orr     w5, w4, #32             /* force lower case */
        sub     w5, w5, #'a'
        cmp     w5, w7
        bhs     .read                   /* unsigned >= */

        madd    w5, w9, w5, w10         /* a * letter + b */
        udiv    w12, w5, w7             /* divide by 26 */
        msub    w4, w12, w7, w5         /* remainder */
        add     w4, w4, #'a'

.accept:
        cbnz    x3, .write

        strb    w6, [x0], #1            /* store space, post-increment */
        mov     x3, x2                  /* remaining letters in group */

.write:
        strb    w4, [x0], #1            /* store letter or digit, post-increment */
        sub     x3, x3, 1               /* decrement remaining letters in group */
        b       .read
