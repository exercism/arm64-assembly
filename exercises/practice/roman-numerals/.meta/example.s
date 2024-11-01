.macro SINGLE name, value, numeral
        mov     x2, \value
        mov     w3, \numeral

.compare_\name:
        cmp     x1, x2
        blt     .end_\name

        strb    w3, [x0], #1
        sub     x1, x1, x2
        b       .compare_\name

.end_\name:

.endm

.macro DOUBLE name, value, first, second
        mov     x2, \value

.compare_\name:
        cmp     x1, x2
        blt     .end_\name

        mov     w3, \first
        mov     w4, \second
        strb    w3, [x0], #1
        strb    w4, [x0], #1
        sub     x1, x1, x2

.end_\name:

.endm

.text
.globl roman

/* extern void roman(char *buffer, unsigned number); */
roman:
        SINGLE  M, #1000, #'M'
        DOUBLE  CM, #900, #'C', #'M'
        SINGLE  D, #500, #'D'
        DOUBLE  CD, #400, #'C', #'D'
        SINGLE  C, #100, #'C'
        DOUBLE  XC, #90, #'X', #'C'
        SINGLE  L, #50, #'L'
        DOUBLE  XL, #40, #'X', #'L'
        SINGLE  X, #10, #'X'
        DOUBLE  IX, #9, #'I', #'X'
        SINGLE  V, #5, #'V'
        DOUBLE  IV, #4, #'I', #'V'
        SINGLE  I, #1, #'I'
        strb    wzr, [x0]
        ret
