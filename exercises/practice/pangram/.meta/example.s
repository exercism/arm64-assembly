.text
.globl is_pangram

/* extern int is_pangram(const char *phrase); */
is_pangram:
        mov     x1, x0
        mov     x0, #0                  /* bitset of letters */
        mov     x2, #1

.loop:
        ldrb    w3, [x1], #1            /* load byte, with post-increment */
        cbz     x3, .return

        orr     x3, x3, #32             /* force lower-case */
        sub     x3, x3, #'a'
        cmp     x3, #26
        bhs     .loop                   /* unsigned >= */

        lsl     x3, x2, x3              /* 1 << (letter - 'a') */
        orr     x0, x0, x3
        b       .loop

.return:
        add     x0, x0, #1              /* 2**26 iff sentence contains all letters */
        lsr     x0, x0, #26
        ret
