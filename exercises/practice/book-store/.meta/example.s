.text
.globl total

/* void count(size_t basket_count, const uint16_t *basket, uint16_t *tally); */
count:
        lsl     x0, x0, #1              /* number of bytes occupied by array */
        cbz     x0, .return

.loop:
        sub     x0, x0, #2
        ldrh    w10, [x1, x0]           /* book */
        lsl     w10, w10, #1
        ldrh    w11, [x2, x10]
        add     w11, w11, #1            /* increment tally */
        strh    w11, [x2, x10]
        cbnz    x0, .loop

.return:
        ret

/* extern void sort(uint16_t *tally) */
sort:
        mov     w9, #4                  /* offsets 4..10 for books 2..5 */

.outer:
        ldrh    w12, [x0, x9]
        mov     w10, w9                 /* offset for inner loop of insertion sort */

.inner:
        sub     w11, w10, #2
        cbz     w11, .exit

        ldrh    w13, [x0, x11]
        cmp     w13, w12
        bge     .exit

        strh    w13, [x0, x10]
        mov     w10, w11
        b       .inner

.exit:
        strh    w12, [x0, x10]

        add     w9, w9, #2
        cmp     w9, #10
        ble     .outer

        ret

/* void difference(uint16_t *tally); */
difference:
        ldrh    w10, [x0, #10]
        ldrh    w11, [x0, #8]
        sub     w12, w11, w10
        strh    w12, [x0, #8]           /* tally[4] - tally[5] */

        ldrh    w10, [x0, #6]
        sub     w12, w10, w11
        strh    w12, [x0, #6]           /* tally[3] - tally[4] */

        ldrh    w11, [x0, #4]
        sub     w12, w11, w10
        strh    w12, [x0, #4]           /* tally[2] - tally[3] */

        ldrh    w10, [x0, #2]
        sub     w12, w10, w11
        strh    w12, [x0, #2]           /* tally[1] - tally[2] */
        ret

/* void adjust(uint16_t *tally); */
adjust:
        ldrh    w11, [x0, #6]
        ldrh    w12, [x0, #8]
        ldrh    w13, [x0, #10]
        cmp     w11, w13
        csel    w14, w11, w13, lt       /* smallest of tallies for 3 and 5 books */

        sub     w11, w11, w14
        sub     w13, w13, w14           /* replace each pair of groups of 3 and 5 books */
        lsl     w14, w14, #1            /* with pairs of groups of 4 books */
        add     w12, w12, w14
        strh    w11, [x0, #6]
        strh    w12, [x0, #8]
        strh    w13, [x0, #10]
        ret

/* uint32_t score(uint16_t *tally); */
score:
        ldrh    w11, [x0, #2]
        mov     w10, #800               /* price of 1 book */
        mul     w12, w10, w11

        ldrh    w11, [x0, #4]
        mov     w10, #1520              /* price of 2 books */
        madd    w12, w10, w11, w12

        ldrh    w11, [x0, #6]
        mov     w10, #2160              /* price of 3 books */
        madd    w12, w10, w11, w12

        ldrh    w11, [x0, #8]
        mov     w10, #2560              /* price of 4 books */
        madd    w12, w10, w11, w12

        ldrh    w11, [x0, #10]
        mov     w10, #3000              /* price of 5 books */
        madd    w0, w10, w11, w12
        ret

/* extern uint32_t total(size_t basket_count, const uint16_t *basket); */
total:
        mov     x15, lr                 /* save return address */
        stp     xzr, xzr, [sp, #-16]!
        mov     x2, sp
        bl      count
        mov     x0, sp
        bl      sort
        bl      difference
        bl      adjust
        bl      score
        add     sp, sp, #16
        ret     x15
