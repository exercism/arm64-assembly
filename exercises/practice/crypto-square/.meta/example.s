.text
.globl ciphertext

/* extern void ciphertext(char *buffer, const char *plaintext); */
ciphertext:
        mov     w8, wzr                 /* number of alphanumeric characters */
        mov     x9, x1                  /* source pointer */
        b       .scan

.count:
        sub     w11, w10, #'0'
        cmp     w11, #10
        blo     .accept                 /* digit? */

        orr     w10, w10, #32
        sub     w10, w10, #'a'
        cmp     w10, #26
        bhs    .scan                    /* non-letter? */

.accept:
        add     w8, w8, #1

.scan:
        ldrb    w10, [x9], #1           /* read, post-increment */
        cbnz    w10, .count

        strb    wzr, [x0]
        cbz     w8, .return

        mov     w12, wzr                /* number of columns */
        b       .square

.increment_columns:
        add     w12, w12, #1

.square:
        mul     w9, w12, w12
        cmp     w9, w8
        blt     .increment_columns

        add     w13, w12, #-1           /* number of rows */
        mul     w9, w13, w12
        cmp     w9, w8
        csel    w13, w12, w13, lt

        mul     w14, w13, w12
        add     w14, w14, w12
        add     w14, w14, #-1           /* length of output: (rows + 1) * columns - 1 */

        strb    wzr, [x0, x14]
        mov     w7, #' '

.space:
        add     w14, w14, #-1
        strb    w7, [x0, x14]
        cbnz    w14, .space

        add     w13, w13, #1

.next_row:
        mov     w7, w12                 /* column */
        mov     w6, wzr

.read:
        ldrb    w10, [x1], #1           /* read, post-increment */
        sub     w11, w10, #'0'
        cmp     w11, #10
        blo     .write                  /* digit? */

        orr     w10, w10, #32
        sub     w11, w10, #'a'
        cmp     w11, #26
        bhs    .read                    /* non-letter? */

.write:
        strb    w10, [x0, x6]

        add     w8, w8, #-1
        cbz     w8, .return

        add     w6, w6, w13
        add     w7, w7, #-1
        cbnz    w7, .read

        add     x0, x0, #1
        b      .next_row

.return:
        ret
