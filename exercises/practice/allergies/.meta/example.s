.text
.equ EGGS, 0
.equ PEANUTS, 1
.equ SHELLFISH, 2
.equ STRAWBERRIES, 3
.equ TOMATOES, 4
.equ CHOCOLATE, 5
.equ POLLEN, 6
.equ CATS, 7
.equ MAX_ITEMS, 8

.globl allergic_to
.globl list

/* extern int allergic_to(item_t item, unsigned int score); */
allergic_to:
        mov     w9, #1
        lsl     w0, w9, w0
        tst     w0, w1
        cset    w0, ne
        ret

/* extern void list(unsigned int score, item_list_t *list);  */
list:
        mov     x15, lr                 /* save return address so we can use bl below */
        mov     w3, w0                  /* score */
        mov     x4, x1                  /* pointer to list->size */
        add     x5, x1, #4              /* pointer to list->items */
        mov     w2, #0                  /* current item */
        mov     w7, #0                  /* item count */
.loop:
        mov     w0, w2                  /* item */
        mov     w1, w3                  /* score */
        bl      allergic_to
        cbz     w0, .next               /* skip if not allergic */
        str     w2, [x5], #4            /* store item and advance pointer */
        add     w7, w7, #1              /* increase counter */
.next:
        add     w2, w2, #1              /* next item */
        cmp     w2, #MAX_ITEMS
        bne     .loop
        str     w7, [x4]                /* update list->size */
        ret     x15
