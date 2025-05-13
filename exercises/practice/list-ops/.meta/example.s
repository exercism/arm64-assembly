.text
.globl append
.globl filter
.globl map
.globl foldl
.globl foldr
.globl reverse


/* extern size_t append(int64_t *buffer, const int64_t *list1, size_t list1_count, const int64_t *list2, size_t list2_count); */
append:
        mov     x9, x0
        cbz     x2, .append_check_list2_count

        lsl     x2, x2, #3
        add     x2, x1, x2

.append_copy_list1:
        ldr     x10, [x1], #8
        str     x10, [x0], #8
        cmp     x1, x2
        bne     .append_copy_list1

.append_check_list2_count:
        cbz     x4, .append_return

        lsl     x4, x4, #3
        add     x4, x3, x4

.append_copy_list2:
        ldr     x10, [x3], #8
        str     x10, [x0], #8
        cmp     x3, x4
        bne     .append_copy_list2

.append_return:
        sub     x0, x0, x9
        lsr     x0, x0, #3
        ret


/* extern size_t filter(int64_t *buffer, const int64_t *list, size_t list_count, bool (*function)(int64_t)); */
filter:
        stp     x19, x20, [sp, #-64]!
        stp     x21, x22, [sp, #16]
        stp     x23, x24, [sp, #32]
        stp     x25, x26, [sp, #48]

        mov     x19, x0                 /* buffer */
        mov     x20, x1                 /* list */
        mov     x21, x2                 /* list_count */
        mov     x22, x3                 /* function */
        mov     x23, x0                 /* destination */
        mov     x24, x1                 /* source */
        mov     x25, lr                 /* return address */

.filter_loop:
        cbz     x21, .filter_return

        ldr     x26, [x24], #8
        mov     x0, x26
        add     x21, x21, #-1
        blr     x22
        cbz     x0, .filter_loop

        str     x26, [x23], #8
        b       .filter_loop

.filter_return:
        sub     x0, x23, x19
        lsr     x0, x0, #3
        mov     lr, x25
        ldp     x25, x26, [sp, #48]
        ldp     x23, x24, [sp, #32]
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #64
        ret


/* extern size_t map(int64_t *buffer, const int64_t *list, size_t list_count, int64_t (*function)(int64_t)); */
map:
        stp     x19, x20, [sp, #-64]!
        stp     x21, x22, [sp, #16]
        stp     x23, x24, [sp, #32]
        stp     x25, x26, [sp, #48]

        mov     x19, x0                 /* buffer */
        mov     x20, x1                 /* list */
        mov     x21, x2                 /* list_count */
        mov     x22, x3                 /* function */
        mov     x23, x0                 /* destination */
        mov     x24, x1                 /* source */
        mov     x25, lr                 /* return address */

.map_loop:
        cbz     x21, .map_return

        ldr     x0, [x24], #8
        add     x21, x21, #-1
        blr     x22
        str     x0, [x23], #8
        b       .map_loop

.map_return:
        sub     x0, x23, x19
        lsr     x0, x0, #3
        mov     lr, x25
        ldp     x25, x26, [sp, #48]
        ldp     x23, x24, [sp, #32]
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #64
        ret


/* extern int64_t foldl(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t)); */
foldl:
        stp     x19, x20, [sp, #-32]!
        stp     x21, x22, [sp, #16]

        mov     x19, x0                 /* list */
        mov     x20, x1                 /* list_count */
        mov     x21, x3                 /* function */
        mov     x22, lr                 /* return address */
        mov     x0, x2                  /* initial */

.foldl_loop:
        cbz     x20, .foldl_return

        ldr     x1, [x19], #8
        add     x20, x20, #-1
        blr     x21
        b       .foldl_loop

.foldl_return:
        mov     lr, x22
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #32
        ret


/* extern int64_t foldr(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t)); */
foldr:
        stp     x19, x20, [sp, #-32]!
        stp     x21, x22, [sp, #16]

        mov     x20, x1                 /* list_count */
        lsl     x1, x1, #3
        add     x19, x0, x1             /* list end */
        mov     x21, x3                 /* function */
        mov     x22, lr                 /* return address */
        mov     x0, x2                  /* initial */
        cbz     x20, .foldr_return

.foldr_loop:
        ldr     x1, [x19, #-8]!
        add     x20, x20, #-1
        blr     x21
        cbnz    x20, .foldr_loop

.foldr_return:
        mov     lr, x22
        ldp     x21, x22, [sp, #16]
        ldp     x19, x20, [sp], #32
        ret


/* extern size_t reverse(int64_t *buffer, const int64_t *list, size_t list_count); */
reverse:
        mov     x15, x2
        cbz     x2, .reverse_return

        lsl     x9, x2, #3
        add     x9, x1, x9              /* end of list */

.reverse_loop:
        ldr     x10, [x9, #-8]!
        str     x10, [x0], #8
        add     x2, x2, #-1
        cbnz    x2, .reverse_loop

.reverse_return:
        mov     x0, x15
        ret
