.data
wink:   .string "wink, "
double: .string "double blink, "
close:  .string "close your eyes, "
jump:   .string "jump, "

forwards:
        .dword wink
        .dword double
        .dword close
        .dword jump

backwards:
        .dword jump
        .dword close
        .dword double
        .dword wink

.text
.globl commands

/* extern void commands(char *buffer, int number); */
commands:
        and     x1, x1, #31
        adrp    x2, forwards
        add     x2, x2, :lo12:forwards
        tst     x1, #16
        beq     .start

        adrp    x2, backwards
        add     x2, x2, :lo12:backwards
        rbit    w1, w1                  /* reverse bit order */
        lsr     w1, w1, #28

 .start:
        cbz     x1, .empty

.check:
        ldr     x4, [x2], #8            /* address of command */
        and     x5, x1, #1
        lsr     x1, x1, #1
        cbz     x5, .check

.copy:
        ldrb    w3, [x4], #1
        strb    w3, [x0], #1
        cbnz    w3, .copy

        sub     x0, x0, #1              /* address of null terminator */
        cbnz    x1, .check

        strb    wzr, [x0, #-2]          /* remove trailing ", " */
        ret

.empty:
        strb    wzr, [x0]
        ret
