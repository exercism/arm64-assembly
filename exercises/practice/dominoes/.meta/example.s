.text
.globl can_chain

/* int root(int number, void*, uint8_t *table); */
root:
        mov     w9, w0
        ldrb    w0, [x2, x0]
        cmp     w0, w9
        bne     root

        ret

/* void merge(size_t domino_count, const domino_t *dominoes, uint8_t *table); */
merge:
        mov     x14, lr                 /* preserve return address */
        lsl     w10, w0, #2             /* number of bytes occupied by dominoes array */

.merge_loop:
        sub     w10, w10, #2
        ldrh    w0, [x1, x10]           /* number on domino half */
        bl      root
        mov     w11, w0

        sub     w10, w10, #2
        ldrh    w0, [x1, x10]            /* number on domino half */
        bl      root

        strb    w0, [x2, x11]           /* link domino halves in table */

        cbnz    w10, .merge_loop

        ret     x14

/* extern int can_chain(size_t domino_count, const domino_t *dominoes); */
can_chain:
        stp     xzr, xzr, [sp, #-16]!
        mov     x15, lr                 /* preserve return address */
        cmp     w0, wzr
        beq     .accept

        mov     x2, sp
        lsl     w9, w0, #2              /* number of bytes occupied by dominoes array */

.count_numbers:
        sub     w9, w9, #2
        ldrh    w10, [x1, x9]           /* number on domino half */
        ldrb    w11, [x2, x10]
        add     w11, w11, #1            /* increment tally */
        strb    w11, [x2, x10]
        cbnz    w9, .count_numbers

        mov     w9, #16
        mov     w14, #255

.parity:
        sub     w9, w9, #1
        ldrb    w10, [sp, x9]
        tst     w10, #1                 /* check if number appears an odd number of times */
        bne     .reject

        tst     w10, w10
        csel    w11, w14, w9, eq
        strb    w11, [sp, x9]           /* populate disjoint set (union find) array */
        cbnz    w9, .parity

        bl      merge

        mov     w9, #16
        mov     w11, wzr

.count_roots:
        sub     w9, w9, #1
        ldrb    w10, [x2, x9]
        cmp     w10, w9
        cinc    w11, w11, eq
        cbnz    w9, .count_roots

        cmp     w11, #1
        bne     .reject

.accept:
        mov     w0, #1
        add     sp, sp, #16             /* restore stack pointer */
        ret     x15

.reject:
        mov     w0, wzr
        add     sp, sp, #16             /* restore stack pointer */
        ret     x15
