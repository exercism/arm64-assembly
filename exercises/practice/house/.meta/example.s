.data
lyrics:
        .string "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"

table:
        .hword -1, 388, 367, 350, 330, 309, 266, 231, 189, 144, 98, 61, 7

.text
.globl recite

/* extern void recite(char *buffer, int start_verse, int end_verse); */
recite:
        lsl     x1, x1, #1              /* offset into start_verse for table */
        lsl     x2, x2, #1              /* offset into end_verse for table */

        adrp    x5, table
        add     x5, x5, :lo12:table

        adrp    x3, lyrics
        add     x3, x3, :lo12:lyrics

        add     x1, x1, x5              /* address of offset of start verse */
        add     x2, x2, x5              /* address of offset of end verse */
        add     x4, x3, 7               /* end of "This is" */
        mov     x6, x3                  /* "This is" */

.line:
        ldrb    w7, [x6], #1
        strb    w7, [x0], #1
        cmp     x6, x4
        bne     .line

        ldrh    w8, [x1]                /* offset of current verse */
        add     x6, x3, x8              /* " the ..." for current verse */

.copy:
        ldrb    w7, [x6], #1
        strb    w7, [x0], #1
        cbnz    w7, .copy

        sub     x0, x0, #1              /* output address for next verse */
        mov     x6, x3                  /* "This is" */
        cmp     x1, x2
        add     x1, x1, #2              /* address of offset of next verse */
        bne     .line

        ret
