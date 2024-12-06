.text
.globl encode
.globl decode

/* extern void encode(char *buffer, const char *string); */
encode:
        mov     w10, #10

.encode_next:
        mov     x2, x1                  /* address at start of run */
        ldrb    w3, [x1], #1            /* read byte, post-increment */
        cbz     w3, terminate

.encode_read:
        ldrb    w4, [x1], #1            /* read byte, post-increment */
        cmp     w4, w3
        beq     .encode_read

        sub     x1, x1, #1              /* address of first byte after run */
        mov     x4, x0
        sub     x2, x1, x2              /* length of run */
        cmp     x2, #1
        beq     .encode_write

.encode_digit:
        udiv    w5, w2, w10              /* quotient */
        msub    w6, w5, w10, w2          /* remainder */
        mov     w2, w5
        add     w6, w6, #'0'
        strb    w6, [x0], #1
        cbnz    w2, .encode_digit

        mov     x5, x0

.encode_reverse:
        sub     x5, x5, #1
        cmp     x5, x4
        beq     .encode_write           /* middle byte of odd length string */

        ldrb    w6, [x5]
        ldrb    w7, [x4]
        strb    w6, [x4], #1            /* store byte, post-increment */
        strb    w7, [x5]
        cmp     x5, x4
        bne     .encode_reverse
                                        /* middle bytes of even length string */

.encode_write:
        strb    w3, [x0], #1
        b       .encode_next

terminate:
        strb    wzr, [x0]
        ret

/* extern void decode(char *buffer, const char *string); */
decode:
        mov     w10, #10

.decode_next:
        mov     w2, wzr                 /* count */

.decode_read:
        ldrb    w3, [x1], #1            /* read byte, post-increment */
        cbz     w3, terminate

        sub     w4, w3, #'0'
        cmp     w4, w10
        blo     .decode_digit

        cmp     w2, wzr
        cinc    w2, w2, eq

.decode_write:
        strb    w3, [x0], #1            /* write byte, post-increment */
        sub     w2, w2, #1
        cbnz    w2, .decode_write

        b       .decode_next

.decode_digit:
        madd    w2, w2, w10, w4
        b       .decode_read
