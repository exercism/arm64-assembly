.text
.globl rows

/* extern size_t rows(uint64_t* dest, size_t count); */
rows:

/*
| `x0`    | input/output | address | start of array                   |
| `x0`    | output       | integer | number of output elements        |
| `x1`    | input        | integer | count of triangle rows           |
| `x1`    | temporary    | integer | number of bytes in x1 elements   |
| `x2`    | temporary    | address | output pointer                   |
| `x3`    | temporary    | integer | sum two values from previous row |
| `x4`    | temporary    | integer | row length, in bytes             |
| `x5`    | temporary    | address | pointer into previous row        |
| `x6`    | temporary    | address | initial 1 of current row         |
| `x7`    | temporary    | address | final 1 of current row           |
| `x8`    | temporary    | integer | left value from previous row     |
| `x9`    | temporary    | integer | right value from previous row    |
*/

        mov     x2, x0                  /* output pointer */
        cbz     x1, .done               /* stop immediately if 0 rows */

        lsl     x1, x1, #3              /* number of bytes in count elements */
        mov     x4, xzr                 /* current row length, in bytes */
        mov     x9, #1                  /* right value from previous row */

.next_row:
        mov     x6, x2                  /* address of initial 1 of current row */
        add     x7, x2, x4              /* address of final 1 of current row */
        add     x4, x4, #8              /* row length, in bytes */
        mov     x8, xzr                 /* left value from previous row */
        cmp     x2, x7
        beq     .last_column

.next_column:
        ldr     x9, [x5], #8            /* read from previous row, post-increment */
        add     x3, x8, x9              /* sum two values from previous row */
        mov     x8, x9
        str     x3, [x2], #8            /* write output, post-increment */
        cmp     x2, x7
        bne     .next_column

.last_column:
        str     x9, [x2], #8            /* write output, post-increment */
        mov     x5, x6                  /* start of most recent row */
        cmp     x4, x1
        bne     .next_row               /* repeat until we have final row length */

.done:
        sub     x0, x2, x0              /* subtract start of output */
        lsr     x0, x0, #3              /* convert to number of elements */
        ret
