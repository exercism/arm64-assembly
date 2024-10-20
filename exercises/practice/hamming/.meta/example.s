.equ UNEQUAL_LENGTHS, -1

.text
.globl distance

/* extern int distance(const char *strand1, const char *strand2); */
distance:
        mov     x2, x0
        mov     x0, #0                  /* distance */

.read:
        ldrb    w3, [x1], #1            /* load byte, with post-increment */
        ldrb    w4, [x2], #1            /* load byte, with post-increment */

        cbz     w3, .exit               /* check for null terminator */
        cbz     w4, .exit

        cmp     w3, w4
        cinc    x0, x0, ne              /* increment distance if characters differ */
        b       .read

.exit:
        cmp     w3, w4
        beq     .return

        mov     x0, UNEQUAL_LENGTHS

.return:
        ret
