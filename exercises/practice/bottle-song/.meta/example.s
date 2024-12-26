.data

green_bottles:
        .string " green bottles hanging on the wall"
green_bottle:
        .string " green bottle hanging on the wall"
and:
        .string "And if one green bottle should accidentally fall,\nThere'll be "
comma:  .string ",\n"
stop:   .string ".\n"

no:     .string "No"
one:    .string "One"
two:    .string "Two"
three:  .string "Three"
four:   .string "Four"
five:   .string "Five"
six:    .string "Six"
seven:  .string "Seven"
eight:  .string "Eight"
nine:   .string "Nine"
ten:    .string "Ten"

number_array:
        .dword no
        .dword one
        .dword two
        .dword three
        .dword four
        .dword five
        .dword six
        .dword seven
        .dword eight
        .dword nine
        .dword ten

.macro LOAD register, label
        adrp    \register, \label
        add     \register, \register, :lo12:\label
.endm

.macro APPEND str

.copy_\str:
        ldrb    w15, [x14], #1          /* load byte, with post-increment */
        strb    w15, [x0], #1           /* store byte, post-increment */
        cbnz    w15, .copy_\str

        sub     x0, x0, #1
.endm

.text
.globl recite

/* extern void recite(char *buffer, int start_bottles, int take_down); */
recite:
        LOAD    x3, green_bottles
        LOAD    x4, green_bottle
        LOAD    x5, and
        LOAD    x6, comma
        LOAD    x7, stop
        LOAD    x8, number_array

        lsl     x1, x1, #3
        lsl     x2, x2, #3
        sub     x2, x1, x2              /* end bottles */

.verse:
        ldr     x14, [x8, x1]
        APPEND  number1

        cmp     x1, #8
        csel    x14, x4, x3, eq
        APPEND  green1

        mov     x14, x6
        APPEND  comma1

        ldr     x14, [x8, x1]
        APPEND  number2

        cmp     x1, #8
        csel    x14, x4, x3, eq
        APPEND  green2

        mov     x14, x6
        APPEND  comma2

        mov     x14, x5
        APPEND  and

        sub     x1, x1, #8
        ldr     x14, [x8, x1]
        ldrb    w15, [x14], #1          /* load byte, with post-increment */
        orr     w15, w15, #32           /* force lower case */
        strb    w15, [x0], #1           /* store byte, post-increment */
        APPEND  number3

        cmp     x1, #8
        csel    x14, x4, x3, eq
        APPEND  green3

        mov     x14, x7
        APPEND  stop1

        cmp     x1, x2
        beq     .return

        mov     w15, #'\n'
        strb    w15, [x0], #1
        b       .verse

.return:
        ret
