.text
.globl tick

/* extern void tick(uint64_t *buffer, const uint64_t *matrix, size_t row_count, size_t column_count); */
tick:
        stp     x22, x23, [sp, #-48]!   /* preserve registers */
        stp     x24, x25, [sp, #16]
        stp     x26, x27, [sp, #32]
        cbz     x2, .return             /* 0 rows? */

        mov     x5, xzr
        ldr     x6, [x1], #8            /* read first row */

.outer:
        add     x2, x2, #-1
        mov     x4, x5                  /* previous row */
        mov     x5, x6                  /* current row */
        mov     x6, xzr
        cbz     x2, .process_row

        ldr     x6, [x1], #8            /* read next row */

.process_row:
        mov     x17, xzr
        mov     x14, x4
        mov     x15, x5
        mov     x16, x6

        and     x23, x15, #1
        mov     x25, xzr
        and     x26, x16, #1
        add     x26, x26, x23
        and     x9, x14, #1
        add     x26, x26, x9            /* total for first column across 3 rows */

        mov     x13, x3                 /* number of columns remaining */
        cbz     x3, .write

.inner:
        add     x13, x13, #-1
        lsr     x14, x14, #1            /* previous row, shifted */
        lsr     x15, x15, #1            /* current row, shifted */
        lsr     x16, x16, #1            /* next row, shifted */

        mov     x22, x23                /* current cell */
        and     x23, x15, #1            /* next cell */
        mov     x24, x25                /* total for previous column across 3 rows */
        mov     x25, x26                /* total for current column across 3 rows */
        and     x26, x16, #1
        add     x26, x26, x23
        and     x9, x14, #1
        add     x26, x26, x9            /* total for next column across 3 rows */

        add     x27, x24, x25
        add     x27, x27, x26
        sub     x27, x27, x22           /* total of 8 neighbours */
        orr     x27, x27, x22           /* if current cell is alive, treat 2 alive neighbours as 3 */
        cmp     x27, #3
        cinc    x17, x17, eq            /* conditionally sets low bit */

        ror     x17, x17, #1            /* rotate right */
        cbnz    x13, .inner             /* remaining columns? */

.write:
        neg     x9, x3
        rorv    x17, x17, x9            /* rotate left by x3 */
        str     x17, [x0], #8
        cbnz    x2, .outer              /* remaining rows? */

.return:
        ldp     x26, x27, [sp, #32]     /* restore registers */
        ldp     x24, x25, [sp, #16]
        ldp     x22, x23, [sp], #48
        ret
