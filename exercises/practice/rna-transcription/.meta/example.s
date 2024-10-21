.text
.globl to_rna

.macro MAP from, to
        mov     w4, \to
        cmp     w2, \from
        csel    w3, w4, w3, eq          /* conditionally update output byte */
.endm

/* extern void to_rna(char *buffer, const char *dna); */
to_rna:
        ldrb    w2, [x1], #1            /* load byte, with post-increment */
        mov     w3, w2
        MAP     #'G', #'C'
        MAP     #'C', #'G'
        MAP     #'T', #'A'
        MAP     #'A', #'U'
        strb    w3, [x0], #1            /* store byte, post-increment */
        cbnz    w3, to_rna

        ret
