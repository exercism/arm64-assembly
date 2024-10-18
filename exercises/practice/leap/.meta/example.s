.text
.globl leap_year

/* extern int leap_year(int year); */
leap_year:
        mov     x1, #100                /* divisor */
        udiv    x2, x0, x1              /* quotient, i.e. century */
        msub    x3, x2, x1, x0          /* remainder, i.e. year within century */
        tst     x3, x3                  /* check if 0 */
        csel    x0, x2, x3, eq          /* either century, or year within century */
        mov     x4, #0
        mov     x5, #1
        tst     x0, #3                  /* check if multiple of 4 */
        csel    x0, x5, x4, eq
        ret


