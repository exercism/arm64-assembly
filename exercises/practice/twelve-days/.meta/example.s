.data
on:     .string "On the "
day:    .string " day of Christmas my true love gave to me: "
gifts:  .string "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"

first:  .string "first"
second: .string "second"
third:  .string "third"
fourth: .string "fourth"
fifth:  .string "fifth"
sixth:  .string "sixth"
seventh:
        .string "seventh"
eighth: .string "eighth"
ninth:  .string "ninth"
tenth:  .string "tenth"
eleventh:
        .string "eleventh"
twelfth:
        .string "twelfth"

ordinals:
        .dword 0
        .dword first
        .dword second
        .dword third
        .dword fourth
        .dword fifth
        .dword sixth
        .dword seventh
        .dword eighth
        .dword ninth
        .dword tenth
        .dword eleventh
        .dword twelfth

offsets:
        .dword 0
        .dword 235
        .dword 213
        .dword 194
        .dword 174
        .dword 157
        .dword 137
        .dword 113
        .dword 90
        .dword 69
        .dword 48
        .dword 26
        .dword 0

.macro LOAD register, label
        adrp    \register, \label
        add     \register, \register, :lo12:\label
.endm

.macro APPEND str

.copy_\str:
        ldrb    w9, [x8], #1            /* load byte, with post-increment */
        strb    w9, [x0], #1            /* store byte, post-increment */
        cbnz    w9, .copy_\str

        sub     x0, x0, #1
.endm

.text
.globl recite

/* extern void recite(char *buffer, int start_verse, int end_verse); */
recite:
        LOAD    x3, on
        LOAD    x4, day
        LOAD    x5, gifts
        LOAD    x6, ordinals
        LOAD    x7, offsets
        lsl     x1, x1, #3
        lsl     x2, x2, #3

.line:
        mov     x8, x3
        APPEND  on

        ldr     x8, [x6, x1]
        APPEND  ordinal

        mov     x8, x4
        APPEND  day

        ldr     x8, [x7, x1]
        add     x8, x5, x8
        APPEND  gift

        cmp     x1, x2
        add     x1, x1, #8
        bne     .line
        ret
