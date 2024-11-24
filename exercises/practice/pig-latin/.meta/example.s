.data
vowels:
        /* non-zero for 'a' 'e' 'i' 'o' 'u' 'y' */
        .byte 1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0

.text
.globl translate

/*
# | Register | Usage        | Type    | Description                             |
# | -------- | ------------ | ------- | --------------------------------------- |
# | `x0`     | input/output | address | output pointer                          |
# | `x1`     | input        | address | beginning of word(s)                    |
# | `x3`     | temporary    | byte    | previous letter in word                 |
# | `x4`     | temporary    | byte    | current letter in word                  |
# | `x5`     | temporary    | byte    | second letter in word                   |
# | `x6`     | temporary    | byte    | non-zero when current letter is a vowel |
# | `x7`     | temporary    | byte    | 'a'                                     |
# | `x8`     | temporary    | byte    | 'y'                                     |
# | `x9`     | temporary    | address | vowels table, minus 'a'                 |
# | `x10`    | temporary    | address | position in current word                |
# | `x11`    | temporary    | address | end of current word                     |
*/

/* extern void translate(char *buffer, const char *phrase); */
translate:
        mov     w7, #'a'
        mov     w8, #'y'
        adrp    x9, vowels
        add     x9, x9, :lo12:vowels
        sub     x9, x9, x7              /* vowels table, minus 'a' */

start_word:
        mov     x10, x1                 /* beginning of word */
        ldrb    w4, [x1]                /* first letter in word */
        cbz     w4, return

        ldrb    w5, [x1, #1]            /* second letter in word */
        ldrb    w6, [x9, x4]            /* non-zero if first letter is a vowel or 'y' */
        cbnz    w6, check_yt

check_xr:
        cmp     w4, #'x'
        bne     consonant

        cmp     w5, 'r'
        bne     consonant

        b       vowel                   /* Treat initial 'x' 'r' as vowel */

check_yt:
        cmp     w4, #'y'
        bne     vowel

        cmp     w5, #'t'
        beq     vowel                   /* Treat initial 'y' 't' as vowel */

consonant:
        mov     w3, w4                  /* previous letter */
        ldrb    w4, [x10, #1]!          /* current letter in word, pre-increment x10 */
        cmp     w4, w7
        blt     vowel                   /* jump forward as we have reached the end of the word */

        ldrb    w6, [x9, x4]            /* non-zero if current letter is a vowel or 'y' */
        cbz     w6, consonant

        cmp     w4, #'u'
        bne     vowel

        cmp     w3, #'q'
        bne     vowel

        add     x10, x10, #1            /* group 'u' after 'q' with leading consonants */

vowel:
                                        /* Letters x1 (inclusive) through x10 (exclusive)
                                           will be output after the word's remaining letters. */
        mov     x11, x10
        b       check_for_remaining_letters

copy_remaining_letters:
        add     x11, x11, #1
        strb    w4, [x0], #1

check_for_remaining_letters:
        ldrb    w4, [x11]
        cmp     w4, w7
        bge     copy_remaining_letters

        b       check_for_leading_consonants

copy_leading_consonants:
        ldrb    w5, [x1], #1
        strb    w5, [x0], #1

check_for_leading_consonants:
        cmp     x1, x10
        bne     copy_leading_consonants

        strb    w7, [x0], #1            /* 'a', post-increment output pointer */
        strb    w8, [x0], #1            /* 'y', post-increment output pointer */
        cbz     w4, return              /* Check for null terminator */

        strb    w4, [x0], #1            /* Output space between words, post-increment output pointer */
        add     x1, x11, #1             /* Start of next word */
        b       start_word

return:
        strb    wzr, [x0]
        ret
