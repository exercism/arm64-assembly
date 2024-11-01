.text
.globl rectangles

/* int rectangles(const char **strings); */
rectangles:
        mov     x1, x0
        mov     x0, xzr                 /* initialize count */

.top_row:
        ldr     x2, [x1], #8            /* address of start of row */
        cbz     x2, .return

        mov     x3, x2                  /* pointer into row */

.left_column:
        ldrb    w4, [x3], #1            /* load byte, post-increment */
        cbz     w4, .top_row

        cmp     w4, #'+'
        bne     .left_column

        mov     x4, x3

.right_column:
        ldrb    w5, [x4], #1            /* load byte, post-increment */
        cmp     w5, #'-'
        beq     .right_column

        cmp     w5, #'+'
        bne     .left_column

        sub     x5, x3, x2
        sub     x5, x5, #1              /* offset of left column from start of row */
        sub     x6, x4, x2
        sub     x6, x6, #1              /* offset of right column from start of row */
        mov     x7, x1

.bottom_row:
        ldr     x8, [x7], #8            /* address of start of row */
        cbz     x8, .right_column

        mov     w11, wzr                /* number of | (0, 1 or 2) */
        mov     w12, wzr                /* number of + (0, 1 or 2) */

        ldrb    w9, [x8, x5]
        cmp     w9, #'|'
        cinc    w11, w11, eq
        cmp     w9, #'+'
        cinc    w12, w12, eq

        ldrb    w9, [x8, x6]
        cmp     w9, #'|'
        cinc    w11, w11, eq
        cmp     w9, #'+'
        cinc    w12, w12, eq

        add     w11, w11, w12           /* number of | or + (0, 1 or 2) */
        cmp     w11, #2
        bne    .right_column

        cmp w12, #2
        bne    .bottom_row

        mov     x11, x5                 /* index into bottom row */

.scan_bottom:
        add     x11, x11, #1
        cmp     x11, x6
        beq     .accept

        ldrb    w9, [x8, x11]
        cmp     w9, #'-'
        beq     .scan_bottom

        cmp     w9, #'+'
        beq     .scan_bottom

        b       .bottom_row

.accept:
        add     x0, x0, #1
        b       .bottom_row

.return:
        ret
