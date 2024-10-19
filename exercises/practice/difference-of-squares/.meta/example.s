.text
.globl square_of_sum
.globl sum_of_squares
.globl difference_of_squares

/* extern uint64_t square_of_sum(uint64_t number); */
square_of_sum:
        add     x1, x0, #1
        mul     x0, x0, x1
        lsr     x0, x0, #1              /* number (number + 1) / 2 */
        mul     x0, x0, x0              /* number**2 (number + 1)**2 / 4 */
        ret

/* extern uint64_t sum_of_squares(uint64_t number); */
sum_of_squares:
        add     x1, x0, #1
        mul     x2, x0, x1              /* number (number + 1) */
        add     x0, x0, x1              /* 2 * number + 1 */
        mul     x0, x0, x2
        mov     x1, #6
        udiv    x0, x0, x1              /* number (number + 1) (2 * number + 1) / 6 */
        ret

/* extern uint64_t difference_of_squares(uint64_t number); */
difference_of_squares:
        add     x1, x0, #1
        add     x2, x0, x1              /* 2 * number + 1 */
        mul     x0, x0, x1
        lsr     x0, x0, #1              /* number (number + 1) / 2 */
        mul     x2, x0, x2
        mov     x1, #3
        udiv    x2, x2, x1              /* number (number + 1) (2 * number + 1) / 6 */
        mul     x0, x0, x0              /* number**2 (number + 1)**2 / 4 */
        sub     x0, x0, x2
        ret
