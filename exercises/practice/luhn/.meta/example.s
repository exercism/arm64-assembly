.text
.globl valid

/* extern int valid(const char *value); */
valid:
        mov     x1, x0
        mov     x2, #0                  /* digit count */
        mov     x3, #0                  /* digit sum */

.first_scan:
        ldrb    w4, [x1], #1            /* load byte, post-increment */
        cbz     w4, .end_first_scan

        cmp     w4, #' '
        beq     .first_scan

        sub     w4, w4, #'0'
        cmp     w4, #10
        bhs     .reject                 /* unsigned >= */

        add     x2, x2, #1
        b       .first_scan

.end_first_scan:
        mov     x1, x0
        cmp     x2, #2
        blt     .reject

.second_scan:
        ldrb    w4, [x1], #1            /* load byte, post-increment */
        cbz     w4, .end_second_scan

        cmp     w4, #' '
        beq     .second_scan

        sub     w4, w4, #'0'
        tst     x2, #1
        bne     .add

        lsl     w4, w4, #1              /* multiply by 2 */
        cmp     w4, #10
        blo     .add                    /* unsigned < */

        sub     w4, w4, #9

.add:
        add     x3, x3, x4
        sub     x2, x2, #1
        b       .second_scan

.end_second_scan:
        mov     x6, #10
        udiv    x7, x3, x6              /* divide value by 10 */
        msub    x0, x7, x6, x3          /* remainder */

        cmp     x0, xzr
        cset    x0, eq
        ret

.reject:
        mov     x0, #0
        ret
