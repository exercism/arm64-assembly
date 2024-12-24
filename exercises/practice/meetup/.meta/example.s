.equ FIRST, 1
.equ SECOND, 2
.equ THIRD, 3
.equ FOURTH, 4
.equ TEENTH, 5
.equ LAST, 6

.equ MONDAY, 1
.equ TUESDAY, 2
.equ WEDNESDAY, 3
.equ THURSDAY, 4
.equ FRIDAY, 5
.equ SATURDAY, 6
.equ SUNDAY, 7

.data
offset_array:
        .hword -1
        .hword -1
        .hword -1
        .hword 2 /* March */
        .hword 33
        .hword 63
        .hword 94
        .hword 124
        .hword 155
        .hword 186
        .hword 216
        .hword 247
        .hword 277
        .hword 308
        .hword 339 /* February */

week_array:
        .byte -1
        .byte 7 /* first */
        .byte 14
        .byte 21
        .byte 28
        .byte 19 /* teenth */

.text
.globl meetup

/* extern void meetup(char *buffer, int year, int month, week_t week, dayofweek_t dayofweek); */
meetup:
        adrp    x5, offset_array
        add     x5, x5, :lo12:offset_array

        mov     w7, w1                  /* adjusted year */
        mov     w8, w2                  /* adjusted month */
        cmp     w2, #2
        bgt     .find_offset

        sub     w7, w7, #1
        add     w8, w8, #12             /* Consider January and February to be the 13th and 14th months of previous year */

.find_offset:
        lsl     w8, w8, #1
        ldrh    w9, [x5, x8]            /* offset */
        cmp     w3, LAST
        beq     .last

        adrp    x6, week_array
        add     x6, x6, :lo12:week_array
        ldrb    w3, [x6, x3]            /* day in month at end of requested week */

.total:
        mov     w5, w7                  /* adjusted year */

        lsr     w7, w7, #2              /* adjusted year / 4 */
        add     w5, w5, w7

        mov     w10, #25
        udiv    w7, w7, w10             /* adjusted year / 100 */
        sub     w5, w5, w7

        lsr     w7, w7, #2              /* adjusted year / 400 */
        add     w5, w5, w7

        add     w5, w5, w9              /* add offset */
        add     w5, w5, w3              /* add day in month at end of requested week */
        mov     w10, #7
        udiv    w12, w5, w10            /* quotient */
        msub    w13, w12, w10, w5       /* remainder */

        add     w6, w3, w4
        sub     w6, w6, w13
        cmp     w6, w3
        ble     .write

        sub     w6, w6, #7

.write:
        mov     w10, #'-'
        strb    w10, [x0, #4]
        strb    w10, [x0, #7]
        strb    wzr, [x0, #10]

        mov     w10, 10                 /* divisor */

        mov     w11, w1                 /* year */
        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder */
        mov     w11, w12
        add     w13, w13, #'0'
        strb    w13, [x0, #3]

        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder */
        mov     w11, w12
        add     w13, w13, #'0'
        strb    w13, [x0, #2]

        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder */
        add     w13, w13, #'0'
        strb    w13, [x0, #1]

        add     w12, w12, #'0'
        strb    w12, [x0]

        mov     w11, w2                 /* month */
        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder */
        add     w13, w13, #'0'
        strb    w13, [x0, #6]

        add     w12, w12, #'0'
        strb    w12, [x0, #5]

        mov     w11, w6                 /* day in month */
        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder */
        add     w13, w13, #'0'
        strb    w13, [x0, #9]

        add     w12, w12, #'0'
        strb    w12, [x0, #8]
        ret

.last:
        cmp     w2, #2
        beq     .february

        add     w8, w8, #2
        ldrh    w10, [x5, x8]           /* offset */
        sub     w3, w10, w9
        b       .total

.february:
        mov     w10, #100               /* divisor */
        udiv    w12, w1, w10            /* quotient, i.e. century */
        msub    w13, w12, w10, w1       /* remainder, i.e. year within century */
        tst     w13, w13                /* check if 0 */
        csel    w3, w12, w13, eq        /* either century, or year within century */
        tst     w3, #3                  /* check if multiple of 4 */
        cset    w3, eq
        add     w3, w3, #28
        b       .total
