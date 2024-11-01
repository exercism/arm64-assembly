.text
.globl can_create
.globl can_attack

/* extern int can_create(int row, int column); */
can_create:
        cmp     w0, #8
        bhs     reject                  /* unsigned >= */

        cmp     w1, #8
        bhs     reject                  /* unsigned >= */

accept:
        mov     x0, #1
        ret

reject:
        mov     x0, #0
        ret

/* extern int can_attack(int white_row, int white_column, int black_row, int black_column); */
can_attack:
        sub     x0, x0, x2
        cbz     x0, accept

        sub     x1, x1, x3
        cbz     x1, accept

        cmp     x0, x1
        beq     accept

        add     x0, x0, x1
        cmp     x0, xzr
        cset    x0, eq
        ret
