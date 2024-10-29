.data
for: .string "For want of a "
the: .string " the "
was: .string " was lost.\n"
and: .string "And all for the want of a ";
end: .string ".\n";

.macro APPEND str

.copy_\str:
        ldrb    w6, [x5], #1            /* load byte, with post-increment */
        strb    w6, [x0], #1            /* store byte, post-increment */
        cbnz    w6, .copy_\str

        sub     x0, x0, #1
.endm

.text
.globl recite

/* extern void recite(char *buffer, const char **strings); */
recite:
        mov     x2, x1
        ldr     x3, [x2], #8            /* load, post-increment */
        cbz     x3, .empty

.next_line:
        ldr     x4, [x2], #8            /* load, post-increment */
        cbz     x4, .last

        adrp    x5, for
        add     x5, x5, :lo12:for
        APPEND  for

        mov     x5, x3
        APPEND  cause

        adrp    x5, the
        add     x5, x5, :lo12:the
        APPEND  the

        mov     x5, x4
        APPEND  effect

        adrp    x5, was
        add     x5, x5, :lo12:was
        APPEND  was

        mov     x3, x4
        b       .next_line

.last:
        adrp    x5, and
        add     x5, x5, :lo12:and
        APPEND  and

        ldr     x5, [x1]
        APPEND  first

        adrp    x5, end
        add     x5, x5, :lo12:end
        APPEND  end

.empty:
        strb    wzr, [x0]
        ret
