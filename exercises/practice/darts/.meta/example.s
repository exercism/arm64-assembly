.text
.globl score

/* extern int score(double x, double y); */
score:
        fmul d0, d0, d0                 /* x * x */
        fmadd d0, d1, d1, d0            /* y * y + x * x */

        mov w9, #100
        ucvtf d2, w9
        fcmpe d0, d2
        bgt .zero

        mov w9, #25
        ucvtf d2, w9
        fcmpe d0, d2
        bgt .one

        mov w9, #1
        ucvtf d2, w9
        fcmpe d0, d2
        bgt .five

.ten:
        mov x0, #10
        ret

.five:
        mov x0, #5
        ret

.one:
        mov x0, #1
        ret

.zero:
        mov x0, #0
        ret
