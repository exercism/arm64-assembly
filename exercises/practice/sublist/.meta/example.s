.equ UNEQUAL, 0
.equ EQUAL, 1
.equ SUBLIST, 2
.equ SUPERLIST, 3

.text
.globl sublist

/* extern relation_t sublist(const int64_t* list_one, size_t list_one_count, const int64_t* list_two, size_t list_two_count); */
sublist:
        cmp     x1, x3
        bne     .different_len

        cbz     x1, .equal              /* empty lists are equal */

        lsl     x9, x1, #3              /* size of each array, in bytes */
        add     x9, x0, x9              /* pointer to end of array one */

.full_scan:
        ldr     x12, [x0], #8           /* load from array one, post-increment */
        ldr     x13, [x2], #8           /* load from array two, post-increment */

        cmp     x12, x13
        bne     .unequal

        cmp     x0, x9
        bne     .full_scan

.equal:
        mov     x0, EQUAL
        ret

.different_len:
        mov     x14, SUBLIST
        cmp     x1, x3
        blt     .prepare_nested_scan

        mov     x14, SUPERLIST
        mov     x9, x0                  /* swap x0 and x2 */
        mov     x0, x2
        mov     x2, x9
        mov     x10, x1                 /* swap x1 and x3 */
        mov     x1, x3
        mov     x3, x10

.prepare_nested_scan:
                                        /* check if list one is a sublist of list two */
        cbz     x1, .prefix_match_found /* an empty list is a sublist */

        lsl     x9, x1, #3              /* size of array one, in bytes */
        add     x9, x0, x9              /* pointer to end of array one */
        b       .prepare_prefix_scan

.discard_list_two_head:
                                        /* drop the first element from list two,
                                           and check again for a prefix match */
        add    x2, x2, #8
        add    x3, x3, #-1
        cmp    x3, x1
        blt    .unequal

.prepare_prefix_scan:
        mov    x10, x0
        mov    x11, x2

.prefix_scan:
        ldr     x12, [x10], #8          /* load from array one, post-increment */
        ldr     x13, [x11], #8          /* load from array two, post-increment */
        cmp     x12, x13
        bne     .discard_list_two_head

        cmp     x10, x9
        bne     .prefix_scan

.prefix_match_found:
                                        /* x14 is SUBLIST or SUPERLIST */
        mov     x0, x14
        ret

.unequal:
        mov     x0, UNEQUAL
        ret
