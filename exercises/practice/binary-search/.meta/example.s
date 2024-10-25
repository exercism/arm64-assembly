.text
.globl find

/* extern ptrdiff_t find(int16_t value, int16_t *array, size_t count); */
find:
        mov     x3, #0                  /* lower bound, as byte offset */
        lsl     x4, x2, #1              /* upper bound, as byte offset */

.search:
        cmp     x3, x4
        beq     .absent

        add     x5, x3, x4
        lsr     x5, x5, #2              /* midpoint, as index */
        lsl     x5, x5, #1              /* midpoint, as byte offset */
        ldrh    w6, [x1, x5]

        cmp     w6, w0
        bgt     .earlier

        cmp     w6, w0
        blt     .later

        lsr     x0, x5, #1              /* midpoint, as index */
        ret

.absent:
        mov     x0, #-1
        ret

.earlier:
        mov     x4, x5                  /* update upper bound */
        b       .search

.later:
        add     x3, x5, #2              /* update lower bound */
        b       .search
