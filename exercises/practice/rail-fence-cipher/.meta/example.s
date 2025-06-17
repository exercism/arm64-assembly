.text
.globl encode
.globl decode

/* extern void encode(char *buffer, const char *msg, int rails); */
encode:
        mov     x3, xzr
        b       process

/* extern void decode(char *buffer, const char *msg, int rails); */
decode:
        mov     x3, #1
        b       process

/* void process(char *buffer, const char *msg, int rails, int is_decode); */
process:
        lsl     x2, x2, #4
        mov     x8, x2                  /* descending loop counter */

.zero:
        stp     xzr, xzr, [sp, -16]!    /* stack space for rail counts/offsets */
        add     x8, x8, #-16
        cbnz    x8, .zero
        add     x15, x2, #-16           /* distance between last and first rail counts */
        mov     x4, #1                  /* indicates first traverse: counting */

.traverse:
        mov     x12, xzr                /* offset into string */
        mov     x13, xzr                /* offset into rail counts */
        mov     x14, #16                /* direction */

.next:
        ldrb    w8, [x1, x12]
        cbz     w8, .null_terminator

        ldr     x17, [sp, x13]          /* read count */
        add     x16, x17, #1
        str     x16, [sp, x13]          /* store incremented count */

        mov     x16, x12
        add     x12, x12, #1            /* next offset into string */

        cbnz    x4, .advance            /* skip write to buffer? */

        cbz     x3, .write

        eor     x16, x16, x17           /* swap x16 and x17 */
        eor     x17, x16, x17
        eor     x16, x16, x17

.write:
        ldrb    w19, [x1, x16]          /* read from msg */
        strb    w19, [x0, x17]          /* write to buffer */

.advance:
        adds    x13, x13, x14           /* rail */
        ccmp    x13, x15, #4, ne        /* first rail orelse last rail? */
        cneg    x14, x14, eq
        b       .next

.null_terminator:
        cbz     x4, .return

        mov     x11, xzr                /* accumulator */
        mov     x9, xzr                 /* offset into rail counts */

.calculate_offsets:
        ldr     x10, [sp, x9]
        str     x11, [sp, x9]
        add     x11, x11, x10           /* update accumulator */
        add     x9, x9, #16
        cmp     x9, x2
        bne     .calculate_offsets

        mov     x4, xzr                 /* indicates final traverse: writing */
        b       .traverse

.return:
        strb    wzr, [x0, x12]
        add     sp, sp, x2
        ret
