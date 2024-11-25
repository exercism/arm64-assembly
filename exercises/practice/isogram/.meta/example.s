.text
.globl is_isogram

/* extern int is_isogram(const char *phrase); */
is_isogram:
        mov     x1, x0
        mov     x0, #0                  /* bitset of letters */
        mov     x2, #1

.loop:
        ldrb    w3, [x1], #1            /* load byte, with post-increment */
        cbz     x3, .accept

        orr     x3, x3, #32             /* force lower-case */
        sub     x3, x3, #'a'
        cmp     x3, #26
        bhs     .loop                   /* unsigned >= */

        lsl     x3, x2, x3              /* 1 << (letter - 'a') */
        tst     x0, x3
        bne     .reject

        orr     x0, x0, x3
        b       .loop

.accept:
        mov     x0, #1
        ret

.reject:
        mov     x0, #0
        ret
