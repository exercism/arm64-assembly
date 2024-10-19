.text
.globl is_valid

/* extern int is_valid(const char *isbn); */
is_valid:
        mov     x1, #10                 /* number of digits remaining */
        mov     x4, #0                  /* sum */
        mov     x5, #0                  /* weighted sum */

.loop:
        ldrb    w2, [x0], #1            /* load byte, with post-increment */
        cbz     x2, .end

        cmp     x2, #45                 /* hyphen */
        beq     .loop

        sub     x1, x1, #1              /* decrement number of digits remaining */
        sub     x3, x2, #48             /* '0' */
        cmp     x3, #10
        bhs     .non_digit              /* unsigned >= */

.add:
        add     x4, x4, x3
        add     x5, x5, x4
        b       .loop

.non_digit:
        tst     x1, x1
        bne     .reject

        mov     x3, #10
        cmp     x2, #88                 /* 'X' */
        beq     .add

.reject:
        mov     x0, #0
        ret

.end:
        tst     x1, x1
        bne     .reject

        mov     x1, #11
        udiv    x4, x5, x1              /* weighted sum / 11 */
        msub    x3, x4, x1, x5          /* weighted sum % 11 */
        tst     x3, x3
        cset    x0, eq
        ret
