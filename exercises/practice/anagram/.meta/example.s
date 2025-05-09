.text
.globl find_anagrams

.macro TOUPPER reg
        bic     \reg, \reg, #('a' - 'A')
.endm

.macro COUNT word_reg, cnt_reg
        stp     xzr, xzr, [\cnt_reg, #0]
        stp     xzr, xzr, [\cnt_reg, #16]
.loop\@:
        ldrb    w2, [\word_reg], #1
        cbz     w2, .out\@
        TOUPPER w2
        sub     w2, w2, #'A'
        ldrb    w3, [\cnt_reg, x2]
        add     w3, w3, #1
        strb    w3, [\cnt_reg, x2]
        b       .loop\@
.out\@:
.endm

/* extern void find_anagrams(int *is_anagram, const char *candidates[], size_t num_candidates, const char *subject); */
find_anagrams:
        mov     x10, x3         /* subject */
        mov     x11, x1         /* candidates */
        mov     x12, x2         /* number of candidates */
        mov     x13, x0         /* output array */

        mov     x15, xzr        /* current candidate index */

        sub     sp, sp, #64     /* allocate space for counts */
        add     x16, sp, #32    /* counts for subject */
        mov     x17, sp         /* counts for candidate */

                                /* count letters of subject */
        mov     x0, x10         /* pointer to subject */
        mov     x1, x16         /* pointer to output array */
        COUNT   x0, x1
.next_candidate:
        ldr     x5, [x11], #8   /* load address of next candidate */

        mov     x0, x10         /* pointer to current subject character */
        mov     x1, x5          /* pointer to current candidate character */

        mov     w7, #0          /* start with assuming no anagram */
.next_character:
        ldrb    w2, [x0], #1    /* load subject character and advance pointer */
        ldrb    w3, [x1], #1    /* load candidate character and advance pointer */

        orr     w4, w2, w3
        cbz     w4, .store      /* both words at end and no difference found --> same */

        and     w4, w2, w3      /* check if only one word has ended */
        cbz     w4, .not_same   /* if zero, one word is longer than the other */

        TOUPPER w2              /* valid character --> make uppercase */
        TOUPPER w3
        cmp     w2, w3          /* check if they are identical */
        beq     .next_character
.not_same:
        mov     x0, x5          /* pointer to first character of candidate */
        mov     x1, x17         /* pointer to output array with counts */
        COUNT   x0, x1

        mov     x1, xzr         /* count array index */
.next_count:
        ldrb    w3, [x16, x1]
        ldrb    w4, [x17, x1]
        cmp     w3, w4
        bne     .store
        add     x1, x1, #1      /* advance index */
        cmp     x1, #26         /* are we done yet? */
        blt     .next_count
.anagram:
        mov     w7, #1
.store:
        str     w7, [x13], #4   /* store result in output array and advance pointer */

        add     x15, x15, #1    /* increase candidate counter */
        cmp     x15, x12        /* see if we're done checking all candidates */
        blt     .next_candidate

        add     sp, sp, #64     /* clean up stack */
        ret
