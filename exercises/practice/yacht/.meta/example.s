.equ CHOICE, 0
.equ ONES, 1
.equ TWOS, 2
.equ THREES, 3
.equ FOURS, 4
.equ FIVES, 5
.equ SIXES, 6
.equ LITTLE_STRAIGHT, 7
.equ BIG_STRAIGHT, 8
.equ FULL_HOUSE, 9
.equ FOUR_OF_A_KIND, 10
.equ YACHT, 11

.text
.globl score


/* void sort(uint16_t *dice) */
sort:
        mov     w9, #2

.outer:
        ldrh    w12, [x0, x9]
        mov     w10, w9                 /* offset for inner loop of insertion sort */

.inner:
        cbz     w10, .exit
        sub     w11, w10, #2

        ldrh    w13, [x0, x11]
        cmp     w13, w12
        ble     .exit

        strh    w13, [x0, x10]
        mov     w10, w11
        b       .inner

.exit:
        strh    w12, [x0, x10]

        add     w9, w9, #2
        cmp     w9, #8
        ble     .outer

        ret


/* extern int score(category_t category, const uint16_t* dice); */
score:
        mov     w2, w0                  /* category */
        mov     x15, lr                 /* save return address */

        ldr     x10, [x1]
        ldrh    w11, [x1, #8]
        stp     x10, x11, [sp, #-16]!   /* push dice values onto stack */
        mov     x0, sp
        bl      sort

        mov     x3, sp                  /* start of sorted dice on stack */
        add     x4, x3, #10             /* end of sorted dice on stack */
        mov     x0, xzr
        mov     w9, SIXES
        cmp     w2, w9
        ble     .total

        ldrh    w10, [x3]               /* smallest */
        ldrh    w11, [x3, #2]
        ldrh    w12, [x3, #4]
        ldrh    w13, [x3, #6]
        ldrh    w14, [x3, #8]           /* largest */

        mov     w9, LITTLE_STRAIGHT
        cmp     w2, w9
        beq     .little_straight

        mov     w9, BIG_STRAIGHT
        cmp     w2, w9
        beq     .big_straight

        mov     w9, FULL_HOUSE
        cmp     w2, w9
        beq     .full_house

        mov     w9, FOUR_OF_A_KIND
        cmp     w2, w9
        beq     .four_of_a_kind

.yacht:
        mov     w9, #50
        cmp     w10, w14
        csel    w0, w9, wzr, eq
        b       .return

.little_straight:
        mov     w9, #30
        cmp     w10, 1
        ccmp    w11, 2, #0, eq
        ccmp    w12, 3, #0, eq
        ccmp    w13, 4, #0, eq
        ccmp    w14, 5, #0, eq
        csel    w0, w9, wzr, eq
        b       .return

.big_straight:
        mov     w9, #30
        cmp     w10, 2
        ccmp    w11, 3, #0, eq
        ccmp    w12, 4, #0, eq
        ccmp    w13, 5, #0, eq
        ccmp    w14, 6, #0, eq
        csel    w0, w9, wzr, eq
        b       .return

.full_house:
        cmp     w10, w11
        ccmp    w13, w14, #0, eq
        ccmp    w11, w13, #4, eq
        beq     .return

        mov     w2, wzr
        cmp     w11, w12
        ccmp    w12, w13, #4, ne
        beq     .total

        b       .return

.four_of_a_kind:
        mov     w2, w12                 /* use middle value as category */

        neg     w0, w12
        cmp     w10, w14
        csel    w0, w0, wzr, eq         /* if all match, only count four */

        cmp     w10, w13
        ccmp    w11, w14, #4, ne
        bne     .return

.total:
        ldrh    w10, [x3], #2           /* load, post-increment */
        cbz     w2, .add                /* unfiltered total? */

        cmp     w10, w2
        bne     .next                   /* not a match? */

.add:
        add     w0, w0, w10

.next:
        cmp     x3, x4
        bne     .total                  /* more dice? */

.return:
        add     sp, sp, #16             /* restore stack pointer */
        ret     x15
