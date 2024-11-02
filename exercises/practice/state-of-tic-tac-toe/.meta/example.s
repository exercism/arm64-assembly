.equ ONGOING, 0
.equ DRAW, 1
.equ WIN, 2
.equ INVALID, 3

.data
/* bitsets representing horizontal, vertical and diagonal lines */
lines: .hword 0x007, 0x070, 0x700, 0x111, 0x222, 0x444, 0x124, 0x421, 0

.text
.globl gamestate

/* extern int gamestate(const char **board); */
gamestate:
        adrp    x1, lines
        add     x1, x1, :lo12:lines

        mov     w2, wzr                 /* bitset representing X marks on board */
        mov     w3, wzr                 /* bitset representing O marks on board */
        mov     w6, wzr                 /* number of X marks on board */
        mov     w7, wzr                 /* number of O marks on board */

.read_row:
        ldr     x4, [x0], #8            /* read address of next row */
        cbz     x4, .count

        lsl     w2, w2, #1
        lsl     w3, w3, #1

.read_mark:
        ldrb    w5, [x4], #1            /* read mark, post-increment */
        cbz     w5, .read_row

        lsl     w2, w2, #1
        lsl     w3, w3, #1
        cmp     w5, #'X'
        cinc    w2, w2, eq
        cinc    w6, w6, eq              /* update number of X marks on board */
        cmp     w5, #'O'
        cinc    w3, w3, eq
        cinc    w7, w7, eq              /* update number of O marks on board */
        b       .read_mark

.count:
        cmp     w7, w6
        bgt     .invalid                /* number of O marks > number of X marks */

        add     w5, w7, #1
        cmp     w6, w5
        bgt     .invalid                /* number of X marks > 1 + number of O marks */

        mov     w8, wzr                 /* found win for X? */
        mov     w9, wzr                 /* found win for O? */
        mov     w10, #1

.read_line:
        ldrh    w4, [x1], #2            /* read from lines, post-increment */
        cbz     w4, .report

        and     w5, w2, w4
        cmp     w5, w4
        csel    w8, w10, w8, eq         /* line formed by X marks */
        and     w5, w3, w4
        cmp     w5, w4
        csel    w9, w10, w9, eq         /* line formed by O marks */
        b       .read_line

.report:
        orr     w4, w8, w9              /* has either player won? */
        cbnz    w4, .win

        mov     x0, ONGOING
        mov     x1, DRAW
        add     w6, w6, w7              /* total number of marks on board */
        cmp     w6, #9
        csel    x0, x1, x0, eq
        ret

.win:
        mov     x2, WIN
        mov     x3, INVALID
        cmp     w8, w9                  /* check if both players "won" */
        csel    x0, x3, x2, eq
        ret

.invalid:
        mov     x0, INVALID
        ret
