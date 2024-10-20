.equ INVALID_NUMBER, -1

.text
.globl steps

/* extern int steps(int number); */
steps:
        mov     x1, #1
        cmp     x0, x1
        blt     .invalid

        mov     x2, x0                  /* current number */
        mov     x3, #3
        mov     x0, #0                  /* step count */

.loop:
        cmp     x2, x1
        beq     .return

        tbz     x2, #0, .even           /* jump ahead if low bit is clear */

        madd    x2, x3, x2, x1          /* 3 * number + 1 */
        add     x0, x0, #1              /* increment step count */

.even:
        lsr     x2, x2, #1              /* number / 2 */
        add     x0, x0, #1              /* increment step count */
        b       .loop

.invalid:
        mov     x0, INVALID_NUMBER

.return:
        ret
