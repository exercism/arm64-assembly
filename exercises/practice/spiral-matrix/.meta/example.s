.text
.globl spiral_matrix

/* extern size_t spiral_matrix(uint32_t *dest, size_t size); */
spiral_matrix:
        mul     w2, w1, w1              /* size * size */
        mov     w3, #1                  /* number to output */
        mov     x9, #4                  /* first steps: sizeof(uint32_t) */
        mov     x10, x9                 /* current steps */
        lsl     x11, x1, #2             /* next steps: size * sizeof(uint32_t) */
        add     x12, x10, x11           /* diagonal step */
        add     w1, w1, #-1             /* length of each run */

.outer:
        mov     w13, w1                 /* number of steps remaining in run */

.inner:
        cmp     w3, w2
        bgt     .return

        str     w3, [x0]                /* write number */
        add     w3, w3, #1
        add     x0, x0, x10             /* update pointer by step */
        add     w13, w13, #-1
        cbnz    w13, .inner

        neg     x16, x10
        mov     x10, x11                /* next steps */
        mov     x11, x16

        cmp     x10, x9
        bne     .outer

        add     x0, x0, x12
        add     w1, w1, #-2             /* decrease run length */
        b       .outer

.return:
        mov     w0, w2
        ret
