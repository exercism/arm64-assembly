.section .rodata

you: .string ", you are the "
customer: .string " customer we serve today. Thank you!"
th: .string "th"
st: .string "st"
nd: .string "nd"
rd: .string "rd"

.macro DIVIDE xq, xr, xn, xd
        udiv    \xq, \xn, \xd           /* xq = xn / xd */
        msub    \xr, \xq, \xd, \xn      /* xr = xn - (xq * xd) */
.endm

.macro LOAD str
        adrp    x3, \str
        add     x3, x3, :lo12:\str
.endm

.macro APPEND

.copy_\@:
        ldrb    w4, [x3], #1            /* load byte, with post-increment */
        strb    w4, [x0], #1            /* store byte, post-increment */
        cbnz    w4, .copy_\@

        sub     x0, x0, #1
.endm

.text
.globl format

/* extern void format(char *buffer, const char *name, uint16_t number); */
format:
        mov     x3, x1
        APPEND
        LOAD    you
        APPEND

        mov     x10, 10
        DIVIDE  x12, x13, x2, x10
        cbz     x12, .units

        DIVIDE  x11, x12, x12, x10
        cbz     x11, .tens

        add     x4, x11, '0'
        strb    w4, [x0], #1

.tens:
        add     x4, x12, '0'
        strb    w4, [x0], #1

.units:
        add     w4, w13, '0'
        strb    w4, [x0], #1

        cmp     x12, 1
        beq     .th

        cmp     x13, 1
        beq     .first

        cmp     x13, 2
        beq     .second

        cmp     x13, 3
        beq     .third

.th:
        LOAD    th

.suffix:
        APPEND
        LOAD    customer
        APPEND
        ret

.first:
        LOAD    st
        b       .suffix

.second:
        LOAD    nd
        b       .suffix

.third:
        LOAD    rd
        b       .suffix
