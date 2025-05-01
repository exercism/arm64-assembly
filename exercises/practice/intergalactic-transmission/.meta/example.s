.equ WRONG_PARITY, -1

.text
.globl transmit_sequence
.globl decode_message

/* extern int transmit_sequence(uint8_t *buffer, const uint8_t *message, int message_length); */
transmit_sequence:
        mov     x15, x0                 /* buffer */
        cbz     x2, .transmit_success

        mov     x7, 7
        mov     x10, xzr                /* number of pending bits */
        mov     x12, xzr                /* value of pending bits */
        b       .transmit_read

.transmit_odd_parity:
        orr     x6, x6, #1

.transmit_even_parity:
        strb    w6, [x0], #1            /* write, post-increment */

        cmp     x10, 7
        beq     .transmit_encode

        cbnz    x2, .transmit_read      /* more to read? */

        cbz     x10, .transmit_success  /* no more bits to transmit? */

        sub     x14, x7, x10            /* 7 minus number of pending bits */
        mov     x10, x7
        lsl     x12, x12, x14
        b       .transmit_encode

.transmit_read:
        lsl     x12, x12, #8
        ldrb    w11, [x1], #1           /* read, post-increment */
        add     x2, x2, #-1
        orr     x12, x12, x11
        add     x10, x10, #8

.transmit_encode:
        add     x10, x10, #-7
        lsr     x13, x12, x10
        lsl     x6, x13, #1
        and     x13, x13, #127

.transmit_parity:
        cbz     x13, .transmit_even_parity

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbz     x13, .transmit_odd_parity

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        b       .transmit_parity

.transmit_success:
        sub     x0, x0, x15
        ret


/* extern int decode_message(uint8_t *buffer, const uint8_t *message, int message_length); */
decode_message:
        mov     x15, x0                 /* buffer */
        mov     x10, xzr                /* number of pending bits */
        mov     x12, xzr                /* value of pending bits */

        b       .decode_check_remaining

.decode_without_write:
        mov     x10, #7

.decode_read:
        lsl     x11, x12, #7
        ldrb    w12, [x1], #1           /* read, post-increment */
        add     x2, x2, #-1
        mov     x13, x12
        cbz     x12, .decode_consume

.decode_parity:
        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbz     x13, .decode_failure

        neg     x14, x13
        and     x14, x13, x14
        sub     x13, x13, x14
        cbnz    x13, .decode_parity

.decode_consume:
        lsr     x12, x12, #1            /* discard parity bit */
        cbz     x10, .decode_without_write

        orr     x11, x11, x12
        add     x10, x10, #-1           /* we read 7 bits but write 8 */
        lsr     x11, x11, x10
        strb    w11, [x0], #1           /* write, post-increment */

.decode_check_remaining:
        cbnz    x2, .decode_read

.decode_success:
        sub     x0, x0, x15
        ret

.decode_failure:
        mov     x0, WRONG_PARITY
        ret
