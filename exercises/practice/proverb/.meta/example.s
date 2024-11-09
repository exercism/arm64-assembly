.data
for: .string "For want of a "
the: .string " the "
was: .string " was lost.\n"
and: .string "And all for the want of a ";
end: .string ".\n";

.macro APPEND str
        adrp    x5, \str
        add     x5, x5, :lo12:\str
        bl      append
.endm

.text
.globl recite

append:
        ldrb    w6, [x5], #1            /* load byte, with post-increment */
        strb    w6, [x0], #1            /* store byte, post-increment */
        cbnz    w6, append

        sub     x0, x0, #1
        ret

/* extern void recite(char *buffer, const char **strings); */
recite:
        mov     x7, lr
        mov     x2, x1
        ldr     x3, [x2], #8            /* load, post-increment */
        cbz     x3, .empty

.next_line:
        ldr     x4, [x2], #8            /* load, post-increment */
        cbz     x4, .last

        APPEND  for

        mov     x5, x3
        bl      append

        APPEND  the

        mov     x5, x4
        bl      append

        APPEND  was

        mov     x3, x4
        b       .next_line

.last:
        APPEND  and

        ldr     x5, [x1]
        bl      append

        APPEND  end

        mov     lr, x7

.empty:
        strb    wzr, [x0]
        ret
