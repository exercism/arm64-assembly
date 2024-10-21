.text
.globl encode
.globl decode

/* extern void encode(char *buffer, const char *phrase); */
encode:
        mov     x2, #5                  /* no groups */
        b       process
        ret

/* extern void decode(char *buffer, const char *phrase); */
decode:
        mov     x2, #-1                 /* no groups */
        b       process

process:
        mov     x3, x2                  /* remaining letters in group */
        mov     w6, 32                  /* space */
        mov     w7, #122                /* 'z' */

.read:
        ldrb    w4, [x1], #1            /* load byte, post-increment */
        cbz     w4, .end

        sub     w5, w4, #48             /* '0' */
        cmp     w5, #10
        blo     .accept                 /* unsigned < */

        orr     w5, w4, #32             /* force lower case */
        sub     w5, w5, 97              /* 'a' */
        cmp     w5, #26
        bhs     .read                   /* unsigned >= */

        sub     w5, w7, w5              /* 'z' - letter index */
        and     w4, w4, #32
        orr     w4, w4, w5              /* rotated letter, with original case */

.accept:
        cbnz    x3, .write

        strb    w6, [x0], #1            /* store space, post-increment */
        mov     x3, x2                  /* remaining letters in group */

.write:
        strb    w4, [x0], #1            /* store byte, post-increment */
        sub     x3, x3, 1               /* decrement remaining letters in group */
        b       .read

.end:
        strb    w4, [x0]                /* store byte */
        ret
