.text
.globl is_paired

/* extern int is_paired(const char *value); */
is_paired:
        mov     x1, x0

.scan:
        ldrb    w2, [x1], #1            /* load byte, with post-increment */
        cbnz    w2, .scan

        sub     x1, x1, x0              /* string length, including null terminator */
        add     x1, x1, #16
        and     x1, x1, #-16            /* length rounded up to a multiple of 16 */
        sub     sp, sp, x1              /* reserve stack space */
        mov     x3, sp                  /* current top of bracket stack */
        mov     x5, sp                  /* bottom of bracket stack */

.read:
        ldrb    w2, [x0], #1            /* load byte, with post-increment */
        cbz     w2, .exit

                                        /* opening bracket `[`, brace `{`, parenthesis `(` - push closer on stack */
        cmp     w2, #'['
        beq     .bracket

        cmp     w2, #'{'
        beq     .brace

        cmp     w2, #'('
        beq     .parenthesis

                                        /* closing bracket `]`, brace `}`, parenthesis `)` - pop from stack, compare */
        cmp     w2, #']'
        beq     .closing

        cmp     w2, #'}'
        beq     .closing

        cmp     w2, #')'
        bne     .read

.closing:
        cmp     x3, x5                  /* check for 'stack underflow' */
        beq     .reject

        ldrb    w4, [x3, #-1]!          /* load, pre-decrement */
        cmp     w2, w4
        beq     .read

.reject:
        mov     x0, #0
        b       .return

.exit:
        cmp     x3, x5                  /* is stack empty? */
        cset    x0, eq                  /* 1 if x3 == x5, otherwise 0 */

.return:
        add     sp, sp, x1              /* restore original stack pointer */
        ret

.bracket:
        mov     w2, #']'
        strb    w2, [x3], #1            /* store byte, post-increment */
        b       .read

.brace:
        mov     w2, #'}'
        strb    w2, [x3], #1            /* store byte, post-increment */
        b       .read

.parenthesis:
        mov     w2, #')'
        strb    w2, [x3], #1            /* store byte, post-increment */
        b       .read
