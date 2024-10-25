.text
.globl clean

/* extern void clean(char *str); */
clean:
        mov     x1, x0                  /* address for next write */
        mov     x2, x0                  /* address for next read */

.read:
        ldrb    w3, [x2], #1            /* read byte, post-increment */
        cbz     w3, .validate

        cmp     w3, #' '
        beq     .read

        cmp     w3, #'('
        beq     .read

        cmp     w3, #')'
        beq     .read

        cmp     w3, #'+'
        beq     .read

        cmp     w3, #'-'
        beq     .read

        cmp     w3, #'.'
        beq     .read

        sub     w4, w3, #'0'
        cmp     w4, #10
        bhs     .reject                 /* unsigned >= */

        strb    w3, [x1], #1            /* write byte, post-increment */
        b       .read

.reject:
        strb    wzr, [x0]               /* write empty string */
        ret

.validate:
        strb    wzr, [x1]               /* write null terminator */
        sub     x1, x1, x0              /* number of digits */
        cmp     x1, #11
        beq     .eleven

        cmp     x1, #10
        bne     .reject

.ten:
        ldrb    w3, [x0]                /* first digit of exchange code */
        sub     w4, w3, #'0'
        cmp     w4, #2
        blt     .reject

        ldrb    w3, [x0, #3]            /* first digit of subscriber number */
        sub     w4, w3, #'0'
        cmp     w4, #2
        blt     .reject

        ret

.eleven:
        mov     x1, x0                  /* address for next write */
        mov     x2, x0                  /* address for next read */
        ldrb    w3, [x2], #1
        cmp     w3, #'1'                /* country code */
        bne     .reject

.move:
        ldrb    w3, [x2], #1
        strb    w3, [x1], #1
        cbnz    w3, .move

        b       .ten
