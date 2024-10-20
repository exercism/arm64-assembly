.section .rodata
pling: .string "Pling"
plang: .string "Plang"
plong: .string "Plong"

.macro APPEND sound, factor
        mov     x3, \factor
        udiv    x4, x1, x3
        msub    x5, x4, x3, x1          /* remainder */
        cbnz    x5, .end_\sound

        adrp    x4, \sound
        add     x4, x4, :lo12:\sound

.copy_\sound:
        ldrb    w3, [x4], #1            /* load byte, with post-increment */
        strb    w3, [x2], #1            /* store byte, post-increment */
        cbnz    w3, .copy_\sound

        sub     x2, x2, #1
.end_\sound:

.endm

.text
.globl convert

/* extern void convert(char *buffer, uint64_t number); */
convert:
        mov     x2, x0
        APPEND  pling, #3
        APPEND  plang, #5
        APPEND  plong, #7

        cmp     x2, x0
        bne     .done

        mov     x3, #10

.write:
        mov     x5, x1
        udiv    x1, x5, x3              /* divide value by 10 */
        msub    x6, x1, x3, x5          /* remainder, i.e. output digit */
        add     w6, w6, #48             /* '0' */
        strb    w6, [x2], #1            /* store, post-increment */
        cbnz    x1, .write              /* loop until value is 0 */

        strb    wzr, [x2]               /* store null terminator */

.reverse:
        sub     x2, x2, #1
        cmp     x2, x0
        beq     .done                   /* middle byte of odd length string */

        ldrb    w4, [x2]
        ldrb    w3, [x0]
        strb    w3, [x2]
        strb    w4, [x0], #1            /* store byte, post-increment */
        cmp     x2, x0
        bne     .reverse
                                        /* middle bytes of even length string */

.done:
        ret
