.text
.globl rows

/* void rows(char *buffer, char letter); */
rows:
        mov     w9, #' '
        mov     w10, #'\n'
        mov     x14, x0
        sub     w2, w1, #'A'            /* offset from start of the alphabet */
        lsl     w3, w2, #1
        add     w3, w3, #1              /* number of rows */
        add     w4, w3, #2
        mov     w7, w3                  /* number of rows remaining */

.row:
        mov     w8, w3                  /* number of columns remaining, excluding newline */

.column:
        strb    w9, [x14], #1           /* store ' ' byte, post-increment */
        sub     w8, w8, #1
        cbnz    w8, .column

        strb    w10, [x14], #1          /* store '\n' byte, post-increment */
        sub     w7, w7, #1
        cbnz    w7, .row

        strb    wzr, [x14], #-2         /* store '\0' byte, post-decrement */
        mov     w11, #'A'
        add     x12, x0, x2
        mov     x13, x12
        sub     x14, x14, x2
        mov     x15, x14

.letter:
        strb    w11, [x12]
        strb    w11, [x13]
        strb    w11, [x14]
        strb    w11, [x15]
        add     x12, x12, x3
        add     x13, x13, x4
        sub     x14, x14, x4
        sub     x15, x15, x3
        add     w11, w11, #1
        cmp     w11, w1
        ble     .letter

        ret
