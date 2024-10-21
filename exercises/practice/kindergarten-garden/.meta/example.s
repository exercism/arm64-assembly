.data
names:  .string "        clover,         grass,                                      radishes,       violets, "

.text
.globl plants

/* extern void plants(char *buffer, const char *diagram, const char *student); */
plants:
        adrp    x9, names
        add     x9, x9, :lo12:names

        ldrb    w2, [x2]                /* first letter of student */
        sub     w2, w2, #'A'
        lsl     w2, w2, #1              /* index into diagram for student's first plant */
        add     w3, w2, #1              /* index into diagram for student's second plant */
        mov     x4, x1                  /* pointer into diagram */

.scan:
        ldrb    w5, [x4], #1            /* load diagram byte, post-increment */
        cbnz    w5, .scan

        sub     x4, x4, x1              /* length of diagram */
        lsr     x4, x4, #1              /* half of length of diagram */
        mov     x7, sp
        stp     w2, w3, [sp, #-16]!
        add     w2, w2, w4              /* index into diagram for student's third plant */
        add     w3, w3, w4              /* index into diagram for student's fourth plant */
        stp     w2, w3, [sp, #8]
        mov     x6, sp

.next:
        ldr     w2, [x6], #4            /* index into diagram for current plant */
        ldrb    w2, [x1, x2]            /* load diagram byte */
        sub     w2, w2, #'A'
        lsl     w2, w2, #2
        add     x2, x9, x2              /* pointer into names */

.copy:
        ldrb    w3, [x2], #1
        strb    w3, [x0], #1
        cmp     w3, #' '
        bne     .copy

        cmp     x6, x7
        bne     .next

        strb    wzr, [x0, #-2]          /* null terminator */
        mov     sp, x7
        ret
