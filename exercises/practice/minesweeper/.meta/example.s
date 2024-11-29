.text
.globl annotate

/*
# | Register | Usage        | Type    | Description                                   |
# | -------- | ------------ | ------- | --------------------------------------------- |
# | `x0`     | input/output | address | null-terminated output string                 |
# | `x1`     | input        | address | null-terminated input string                  |
# | `x2`     | temporary    | address | pointer into input                            |
# | `w3`     | temporary    | byte    | input character                               |
# | `x4`     | temporary    | address | line length (including newline character)     |
# | `x5`     | temporary    | address | location of input's null terminator           |
# | `x6`     | temporary    | address | previous row (or current for first row)       |
# | `x7`     | temporary    | address | current row                                   |
# | `x8`     | temporary    | address | next row (or current for last row)            |
# | `x9`     | temporary    | integer | previous column (or current for first column) |
# | `x10`    | temporary    | integer | current column                                |
# | `x11`    | temporary    | integer | next column (or current for last column)      |
# | `x12`    | temporary    | address | row of adjacent square                        |
# | `x13`    | temporary    | integer | column of adjacent square                     |
# | `w14`    | temporary    | byte    | newline character                             |
# | `w15`    | temporary    | integer | number of adjacent mines                      |
# | `w16`    | temporary    | byte    | mine character '*'                            |
*/

/* extern void annotate(char *buffer, const char *minefield); */
annotate:
        mov     x2, x1
        ldrb    w3, [x2]                /* read first byte of minefield */
        cbz     w3, .return

        mov     w16, #'*'               /* mine character */
        mov     w14, #'\n'

.find_newline:
        ldrb    w3, [x2], #1
        cmp     w3, w14
        bne     .find_newline

        sub     x4, x2, x1              /* line length (including newline character) */
        mov     x2, x1

.find_null:
        add     x2, x2, x4              /* jump ahead by line length */
        ldrb    w3, [x2]
        cbnz    w3, .find_null

        mov     x5, x2                  /* location of input's null terminator */
        mov     x7, x1
        mov     x8, x1                  /* start of first row */

.next_row:
        mov     x10, xzr                /* first column */
        mov     x11, xzr
        mov     x6, x7                  /* current row becomes previous row */
        mov     x7, x8                  /* next row becomes current row */

        add     x8, x7, x4              /* next row */
        cmp     x8, x5
        bne     .first_column

        mov     x8, x7                  /* last row */

.first_column:
        cmp     x4, #1
        beq     .write_newline          /* jump ahead if rows contain no squares */

.next_column:
        mov     x9, x10                 /* current column becomes previous column */
        mov     x10, x11                /* next column becomes current column */
        add     x11, x10, #2
        cmp     x11, x4
        cset    x11, ne                 /* Set x11 to 1 if there are more columns, otherwise 0 */
        add     x11, x10, x11           /* next column */

        ldrb    w3, [x7, x10]           /* minefield square */
        cmp     w3, w16
        beq     .write_square           /* jump ahead if we have reached a mine */

        mov     w15, wzr                /* number of adjacent mines */
        sub     x12, x6, x4

.adjacent_row:
        add     x12, x12, x4            /* address of adjacent row: x6, x6+x4, x8 */
        sub     x13, x9, #1

.adjacent_column:
        add     x13, x13, #1            /* index of adjacent column: x9, x9+1, x11 */

        ldrb    w3, [x12, x13]          /* adjacent square */
        cmp     w3, w16
        cset    x2, eq                  /* 1 if square contains mine, 0 otherwise */
        add     w15, w15, w2            /* update mine count */
        cmp     x13, x11
        bne     .adjacent_column

        cmp     x12, x8
        bne     .adjacent_row

        mov     w3, #' '
        cbz     w15, .write_square

        add     w3, w15, #'0'           /* mine count, as ASCII digit */

.write_square:
        strb    w3, [x0], #1
        cmp     x10, x11
        bne     .next_column

.write_newline:
        strb    w14, [x0], #1           /* write '\n' */
        cmp     x7, x8
        bne     .next_row

.return:
        strb    wzr, [x0]               /* null terminator */
        ret
