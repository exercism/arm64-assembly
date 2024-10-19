.section .rodata
sure: .string "Sure."
whoa: .string "Whoa, chill out!"
calm: .string "Calm down, I know what I'm doing!"
fine: .string "Fine. Be that way!"
whatever: .string "Whatever."

.text
.globl response

/* extern const char *response(const char *hey_bob); */
response:
        mov     x2, #0                  /* most recent non-whitespace character */
        mov     x3, #0                  /* count upper case */
        mov     x4, #0                  /* count lower case */

.read:
        ldrb    w1, [x0], #1            /* load byte, with post-increment */
        cbz     x1, .select_response

        cmp     x1, #32                 /* space */
        ble     .read

        mov     x2, x1                  /* non-whitespace character */
        sub     x1, x1, #65
        cmp     x1, #26                 /* upper case? */
        cinc    x3, x3, lo              /* increment on unsigned < */

        sub     x1, x1, #32
        cmp     x1, #26                 /* lower case? */
        cinc    x4, x4, lo              /* increment on unsigned < */

        b       .read

.select_response:
        cbz     x2, .silence

        cbnz    x4, .not_yell           /* does the input contain lower case letters? */
        cbz     x3, .not_yell           /* does the input contain no upper case letters? */

        adrp    x3, calm
        add     x3, x3, :lo12:calm
        adrp    x4, whoa
        add     x4, x4, :lo12:whoa
        cmp     x2, #63                 /* question mark */
        csel    x0, x3, x4, eq
        ret

.not_yell:
        adrp    x3, sure
        add     x3, x3, :lo12:sure
        adrp    x4, whatever
        add     x4, x4, :lo12:whatever
        cmp     x2, #63                 /* question mark */
        csel    x0, x3, x4, eq
        ret

.silence:
        adrp    x0, fine
        add     x0, x0, :lo12:fine
        ret
