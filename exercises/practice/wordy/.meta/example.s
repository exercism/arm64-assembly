.equ WHAT_IS, 8
.equ PLUS, 8
.equ MINUS, 16
.equ MULTIPLIED_BY, 24
.equ DIVIDED_BY, 32
.equ QUESTION_MARK, 40

.data
what_is:        .string "What is "
plus:           .string " plus "
minus:          .string " minus "
multiplied_by:  .string " multiplied by "
divided_by:     .string " divided by "
question_mark:  .string "?"

word_array:
                .quad what_is
                .quad 0
                .quad plus
                .quad minus
                .quad multiplied_by
                .quad divided_by
                .quad question_mark
                .quad 0


.text
.globl answer

/*
    Attempts to read a known word from input string x1
    Writes to x2 the id of the matched word
    Jumps to `reject` if the input is invalid
*/
read_word:
        mov     x9, x1                  /* input pointer */
        mov     x2, x14                 /* array of pointers to words */
        b       .next

.compare:
        ldrb    w11, [x10], #1          /* load word character, post-increment */
        cbz     w11, .match

        ldrb    w12, [x1], #1           /* load input character, post-increment */
        cmp     w12, w11
        beq     .compare

.next:
        mov     x1, x9
        ldr     x10, [x2], #8           /* load pointer to word, post-increment */
        cbnz    x10, .compare

        b       reject

.match:
        sub     x2, x2, x14
        ret


/*
    Attempts to read a number from input string x1
    Writes the number to x3
    Jumps to `reject` if the input is invalid
*/
read_number:
        mov     w10, #10
        ldrb    w11, [x1]
        cmp     w11, #'-'
        cset    x9, eq                  /* 0 for positive, 1 for negative */
        cinc    x1, x1, eq

        mov     x3, xzr                 /* value of digits so far */
        ldrb    w11, [x1], #1
        add     w11, w11, #-48
        cmp     w11, w10
        bhs     reject                  /* unsigned >= */

.accept_digit:
        madd    x3, x3, x10, x11
        ldrb    w11, [x1], #1
        add     w11, w11, #-48
        cmp     w11, w10
        blo     .accept_digit           /* unsigned < */

        add     x1, x1, #-1
        cmp     x9, xzr
        cneg    x3, x3, ne              /* conditionally negate */
        ret


/* extern bool answer(int64_t *result, const char *question); */
answer:
        mov     x15, lr                 /* preserve return address */

        adrp    x14, word_array
        add     x14, x14, :lo12:word_array
        bl      read_word               /* Read "What is " */
        add     x14, x14, #16           /* from now on, the words are operations */
        bl      read_number
        mov     x4, x3

.read_operation:
        bl      read_word
        cmp     x2, QUESTION_MARK
        beq     .success

        bl      read_number
        cmp     x2, MINUS
        beq     .subtract

        cmp     x2, MULTIPLIED_BY
        beq     .multiply

        cmp     x2, DIVIDED_BY
        beq     .divide

.add:
        add     x4, x4, x3
        b       .read_operation

.subtract:
        sub     x4, x4, x3
        b       .read_operation

.multiply:
        mul     x4, x4, x3
        b       .read_operation

.divide:
        sdiv    x4, x4, x3
        b       .read_operation

.success:
        str     x4, [x0]
        mov     x0, #1
        ret     x15


reject:
        mov     x0, xzr
        ret     x15
