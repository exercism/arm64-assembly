.data
table: .byte 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

.text
.globl score

/* extern int score(const char *word); */
score:
        adrp    x1, table
        add     x1, x1, :lo12:table
        mov     x2, x0                  /* pointer into word */
        mov     w0, #0                  /* result */

.read:
        ldrb    w3, [x2], #1            /* load byte, with post-increment */
        cbz     w3, .return

        orr     w3, w3, #32             /* force lower case */
        sub     w3, w3, #'a'
        cmp     w3, #26
        bhs     .read                   /* unsigned >= */

        ldrb    w4, [x1, x3]            /* load byte from table */
        add     w0, w0, w4              /* accumulate result */
        b       .read

.return:
        ret
