.text
.globl shared_birthday
.globl estimate

/* extern bool shared_birthday(const char **birthdates); */
shared_birthday:
        stp     xzr, xzr, [sp, #-64]!   /* 32 halfwords on stack */
        stp     xzr, xzr, [sp, #16]
        stp     xzr, xzr, [sp, #32]
        stp     xzr, xzr, [sp, #48]

        mov     x2, x0
        mov     x0, xzr
        mov     w1, #1
        mov     w10, #10
        mov     w15, 528                /* 11 * '0' */

.birthdate:
        ldr     x9, [x2], #8
        cbz     x9, .return

        ldrb    w11, [x9, #8]
        ldrb    w13, [x9, #9]
        madd    w13, w10, w11, w13
        sub     w13, w13, w15           /* day 1..31 */
        lsl     w13, w13, #1

        ldrb    w11, [x9, #5]
        ldrb    w12, [x9, #6]
        madd    w12, w10, w11, w12
        sub     w12, w12, w15           /* month 1..12 */
        lsl     w12, w1, w12            /* 1 << month */

        ldrh    w11, [sp, x13]
        orr     w12, w11, w12
        strh    w12, [sp, x13]
        cmp     w11, w12
        bne     .birthdate

        mov     x0, #1

.return:
        add     sp, sp, #64
        ret

/* extern double estimate(int group_size); */
estimate:
        mov     w9, #1
        mov     w10, #100
        mov     w11, #365
        scvtf   d0, w9                  /* probability of no shared birthday */
        scvtf   d1, w9
        scvtf   d2, w11                 /* descending numerator */
        scvtf   d3, w11                 /* constant denominator */
        scvtf   d4, w10

        cbz     w0, .complement

.multiply:
        fmul    d0, d0, d2              /* multiply by 365, 364, 363, ... */
        fdiv    d0, d0, d3              /* divide by 365 */
        fsub    d2, d2, d1
        add     w0, w0, #-1             /* number of remaining birthdates */
        cbnz    w0, .multiply

.complement:
        fsub    d0, d1, d0              /* probability of shared birthday */
        fmul    d0, d0, d4              /* convert to percentage */
        ret
