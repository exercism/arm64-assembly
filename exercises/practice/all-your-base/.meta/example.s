.equ BAD_BASE, -1
.equ BAD_DIGIT, -2

.text
.globl rebase

/* extern int rebase(int32_t in_base, const int32_t* in_digits, int in_digit_count, int32_t out_base, int32_t* out_digits); */
rebase:
        cmp     w0, #2                  /* minimum valid base */
        blt     .bad_base

        cmp     w3, #2
        blt     .bad_base

        mov     x5, #0                  /* value represented by digits */
        mov     x7, x4                  /* output pointer */

.read:
        cbz     x2, .write
        ldr     w6, [x1], 4             /* load input digit, post-increment */
        cmp     w6, w0
        bhs     .bad_digit              /* unsigned >= */

        madd    x5, x0, x5, x6          /* in_base * value + digit */
        sub     x2, x2, #1              /* decrement number of digits remaining */
        b       .read

.bad_base:
        mov     x0, BAD_BASE
        ret

.bad_digit:
        mov     x0, BAD_DIGIT
        ret

.write:
        udiv    x1, x5, x3              /* divide value by out_base */
        msub    x6, x1, x3, x5          /* remainder, i.e. output digit */
        str     w6, [x7], #4            /* store, post-increment */
        mov     x5, x1
        cbnz    x5, .write              /* loop until value is 0 */

        sub     x0, x7, x4              /* length of output, in bytes */
        lsr     x0, x0, #2

.reverse:
        ldr     w1, [x7, #-4]!          /* load, pre-decrement */
        cmp     x7, x4
        beq     .return

        ldr     w2, [x4]
        str     w2, [x7]
        str     w1, [x4], #4            /* store, post-increment */
        cmp     x7, x4
        bne     .reverse

.return:
        ret
