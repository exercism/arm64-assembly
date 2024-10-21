.section .rodata
prefix: .string "One for "
you: .string "you"
suffix: .string ", one for me."

.macro LOAD str
        adrp    x2, \str
        add     x2, x2, :lo12:\str
.endm

.macro APPEND str

.copy_\str:
        ldrb    w3, [x2], #1            /* load byte, with post-increment */
        strb    w3, [x0], #1            /* store byte, post-increment */
        cbnz    w3, .copy_\str

        sub     x0, x0, #1
.endm

.text
.globl two_fer

/* extern void two_fer(char *buffer, const char *name); */
two_fer:
        LOAD    prefix
        APPEND  prefix

        LOAD    you
        tst     x1, x1
        csel    x2, x1, x2, ne          /* name if non-null, otherwise you */
        APPEND  you

        LOAD    suffix
        APPEND  suffix
        ret
