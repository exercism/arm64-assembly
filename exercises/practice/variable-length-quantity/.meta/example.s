.text
.globl encode
.globl decode

/* extern size_t encode(uint8_t *buffer, const uint32_t *integers, size_t integer_count); */
encode:
        lsl     x2, x2, #2              /* size of integers array, in bytes */
        add     x2, x1, x2              /* end of integers */
        mov     x3, x0                  /* start of output */

.encode_loop:
        cmp     x1, x2
        beq     .encode_end

        ldr     w4, [x1], #4
        cmp     w4, #127
        bls     .one

        lsr     w5, w4, #7
        cmp     w5, #127
        bls     .two

        lsr     w6, w5, #7
        cmp     w6, #127
        bls     .three

        lsr     w7, w6, #7
        cmp     w7, #127
        bls     .four

        lsr     w8, w7, #7
        orr     w8, w8, #128
        strb    w8, [x0], #1

.four:
        orr     w7, w7, #128
        strb    w7, [x0], #1

.three:
        orr     w6, w6, #128
        strb    w6, [x0], #1

.two:
        orr     w5, w5, #128
        strb    w5, [x0], #1

.one:
        and     w4, w4, #127
        strb    w4, [x0], #1
        b       .encode_loop

.encode_end:
        sub     x0, x0, x3
        ret

/* extern size_t decode(uint32_t *buffer, const uint8_t *integers, size_t integer_count); */
decode:
        add     x2, x1, x2              /* end of integers array */
        mov     x3, x0                  /* start of output */

.loop:
        mov     w4, wzr
        cmp     x1, x2
        beq     .end

.read:
        ldrb    w5, [x1], #1
        lsl     w4, w4, #7
        and     w6, w5, #127
        orr     w4, w4, w6
        tst     w5, #128
        bne     .read

        str     w4, [x0], #4
        b       .loop

.end:
        sub     x0, x0, x3              /* length of output, in bytes */
        lsr     x0, x0, #2              /* number of uint32_t values output */
        ret
