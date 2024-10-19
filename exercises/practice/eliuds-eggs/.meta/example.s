.text
.globl egg_count

/* extern int egg_count(uint64_t number); */
egg_count:
        mov     x1, #1
        mov     x2, x0                  /* current number */
        ror     x3, x1, #1              /* most significant bit 1, other bits 0 */
        mov     x0, #0                  /* egg count */

.loop:
        cmp     x2, #0
        beq     .return

        clz     x4, x2                  /* count leading zero bits */
        ror     x5, x3, x4
        eor     x2, x2, x5              /* clear highest bit */
        add     x0, x0, #1              /* increment egg count */
        b       .loop

.return:
        ret
