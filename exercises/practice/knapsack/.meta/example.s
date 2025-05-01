.text
.globl maximum_value

/* extern uint32_t maximum_value(uint32_t maximum_weight, const item_t *items, size_t item_count); */
maximum_value:
        lsl     x2, x2, #3              /* number of bytes occupied by items */
        add     x2, x1, x2              /* end of items */
        lsl     x0, x0, #2
        add     x3, x0, #16
        and     x3, x3, #-16            /* number of bytes occupied by table, with (maximum_weight+1) uint32_t values, rounded up to a multiple of 16 */
        mov     x4, sp
        sub     sp, sp, x3
        mov     x5, sp

.clear:
        stp     xzr, xzr, [x4, #-16]!   /* fill table with 0 */
        cmp     x4, x5
        bne     .clear

.next_item:
        cmp     x1, x2
        beq     .report

        ldr     w9, [x1], #4            /* load item weight, post-increment */
        ldr     w10, [x1], #4           /* load item value, post-increment */
        lsl     x9, x9, 2
        mov     x7, x0
        subs    x11, x7, x9
        blt     .next_item

.loop:
        ldr     w12, [sp, x11]
        add     w12, w12, w10           /* table value plus item value */
        ldr     w13, [sp, x7]
        cmp     w13, w12
        bhs     .skip                   /* unsigned >= */

        str     w12, [sp, x7]           /* update table value */

.skip:
        cbz     x11, .next_item
        sub     x7, x7, #4
        sub     x11, x11, #4
        b       .loop

.report:
        ldr     w0, [sp, x0]
        add     sp, sp, x3
        ret
