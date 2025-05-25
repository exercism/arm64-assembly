.data

zero:   .string "zero"
one:    .string "one"
two:    .string "two"
three:  .string "three"
four:   .string "four"
five:   .string "five"
six:    .string "six"
seven:  .string "seven"
eight:  .string "eight"
nine:   .string "nine"
ten:    .string "ten"
eleven: .string "eleven"
twelve: .string "twelve"
thirteen:
        .string "thirteen"
fourteen:
        .string "fourteen"
fifteen:
        .string "fifteen"
sixteen:
        .string "sixteen"
seventeen:
        .string "seventeen"
eighteen:
        .string "eighteen"
nineteen:
        .string "nineteen"
twenty: .string "twenty"
thirty: .string "thirty"
forty:  .string "forty"
fifty:  .string "fifty"
sixty:  .string "sixty"
seventy:
        .string "seventy"
eighty: .string "eighty"
ninety: .string "ninety"
hundred:
        .string "hundred"
thousand:
        .string "thousand"
million:
        .string "million"
billion:
        .string "billion"

number_array:
        .dword zero
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
        .dword eleven
        .dword twelve
        .dword thirteen
        .dword fourteen
        .dword fifteen
        .dword sixteen
        .dword seventeen
        .dword eighteen
        .dword nineteen
        .dword twenty
        .dword thirty
        .dword forty
        .dword fifty
        .dword sixty
        .dword seventy
        .dword eighty
        .dword ninety

.macro LOAD register, label
        adrp    \register, \label
        add     \register, \register, :lo12:\label
.endm

/* register must be the address of a non-empty word */
.macro APPEND register
        ldrb    w8, [\register], #1     /* load byte, post-increment */

.copy_\@:
        strb    w8, [x0], #1            /* store byte, post-increment */
        ldrb    w8, [\register], #1     /* load byte, post-increment */
        cbnz    w8, .copy_\@

        strb    w23, [x0], #1           /* ' ' */
.endm

/* quotient must not be the same register as dividend or divisor */
.macro DIVIDE quotient, remainder, dividend, divisor
        udiv    \quotient, \dividend, \divisor
        msub    \remainder, \quotient, \divisor, \dividend
.endm


.text
.globl say


/* void say_digit_group(char *buffer, int64_t number, const char* place); */
say_digit_group:
        cbz     x1, .say_digit_group_return

        DIVIDE  x3, x9, x1, x26         /* divide by 100 */
        cbz     x3, .say_digit_group_tens

        lsl     x3, x3, #3
        ldr     x3, [x19, x3]
        APPEND  x3

        mov     x3, x21
        APPEND  x3

.say_digit_group_tens:
        cbz     x9, .say_digit_group_place

        cmp     x9, 20
        ble     .say_digit_group_units

        DIVIDE  x3, x9, x9, x25         /* divide by 10 */

        lsl     x3, x3, #3
        ldr     x3, [x20, x3]
        APPEND  x3

        cbz     x9, .say_digit_group_place

        strb    w24, [x0, #-1]          /* replace space with '-' */

.say_digit_group_units:
        lsl     x3, x9, #3
        ldr     x3, [x19, x3]
        APPEND  x3

.say_digit_group_place:
        cbz     x2, .say_digit_group_return
        APPEND  x2

.say_digit_group_return:
        ret


/* extern void say(char *buffer, int64_t number); */
say:
        stp     x19, x20, [sp, #-64]!   /* preserve registers */
        stp     x21, x22, [sp, #16]
        stp     x23, x24, [sp, #32]
        stp     x25, x26, [sp, #48]

        LOAD    x19, number_array
        add     x20, x19, #144          /* tens array */
        LOAD    x21, hundred
        mov     x22, lr                 /* preserve return address */
        mov     w23, #' '
        mov     w24, #'-'
        mov     x25, #10
        mov     x26, #100

        cbz     x1, .zero

        mov     x8, #1000
        DIVIDE  x12, x11, x1, x8        /* x11 ones */
        DIVIDE  x13, x12, x12, x8       /* x12 thousands */
        DIVIDE  x1, x13, x13, x8        /* x13 millions, x1 billions */

        cmp     x1, x8
        bpl     .out_of_range

        LOAD    x2, billion
        bl      say_digit_group

        mov     x1, x13
        LOAD    x2, million
        bl      say_digit_group

        mov     x1, x12
        LOAD    x2, thousand
        bl      say_digit_group

        mov     x1, x11
        mov     x2, xzr                 /* units */
        bl      say_digit_group

.return:
        strb    wzr, [x0, #-1]          /* remove trailing space */
        mov     lr, x22
        ldp     x25, x26, [sp, #48]     /* restore registers */
        ldp     x23, x24, [sp, #32]
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #64
        ret

.zero:
        ldr     x3, [x19]
        APPEND  x3
        b       .return

.out_of_range:
        add     x0, x0, #1              /* .return expects trailing "space" */
        b       .return
