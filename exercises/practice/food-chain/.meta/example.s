.data

i_know: .string "I know an old lady who swallowed a "
stop:   .string ".\n"
shes:   .string "She's dead, of course!\n"
i_dont: .string "I don't know why she swallowed the fly. Perhaps she'll die.\n"
she:    .string "She swallowed the "
to:     .string " to catch the "
that:   .string " that wriggled and jiggled and tickled inside her"

fly:    .string "fly"
spider: .string "spider"
bird:   .string "bird"
cat:    .string "cat"
dog:    .string "dog"
goat:   .string "goat"
cow:    .string "cow"
horse:  .string "horse"

spider2:
        .string "It wriggled and jiggled and tickled inside her.\n"
bird2:  .string "How absurd to swallow a bird!\n"
cat2:   .string "Imagine that, to swallow a cat!\n"
dog2:   .string "What a hog, to swallow a dog!\n"
goat2:  .string "Just opened her throat and swallowed a goat!\n"
cow2:   .string "I don't know how she swallowed a cow!\n"

animal_array:
        .dword 0
        .dword fly
        .dword spider
        .dword bird
        .dword cat
        .dword dog
        .dword goat
        .dword cow
        .dword horse

animal2_array:
        .dword 0
        .dword 0
        .dword spider2
        .dword bird2
        .dword cat2
        .dword dog2
        .dword goat2
        .dword cow2

.macro LOAD register, label
        adrp    \register, \label
        add     \register, \register, :lo12:\label
.endm

.macro APPEND str

.copy_\str:
        ldrb    w15, [x14], #1          /* load byte, with post-increment */
        strb    w15, [x0], #1           /* store byte, post-increment */
        cbnz    w15, .copy_\str

        sub     x0, x0, #1
.endm

.text
.globl recite

/* extern void recite(char *buffer, int start_verse, int end_verse); */
recite:
        LOAD    x3, i_know
        LOAD    x4, stop
        LOAD    x5, shes
        LOAD    x6, i_dont
        LOAD    x7, she
        LOAD    x8, to
        LOAD    x9, that
        LOAD    x10, animal_array
        LOAD    x11, animal2_array

        lsl     x1, x1, #3
        lsl     x2, x2, #3

.verse:
        mov     x14, x3
        APPEND  i_know

        ldr     x14, [x10, x1]
        APPEND  animal

        mov     x14, x4
        APPEND  stop

        cmp     x1, #64
        beq     .shes

        cmp     x1, #8
        beq     .i_dont

        ldr     x14, [x11, x1]
        APPEND  second

        mov     x13, x1

.reason:
        mov     x14, x7
        APPEND  she

        ldr     x14, [x10, x13]
        APPEND  animal2

        mov     x14, x8
        APPEND  to

        sub     x13, x13, #8
        ldr     x14, [x10, x13]
        APPEND  animal3

        cmp     x13, #16
        bne     .stop

        mov     x14, x9
        APPEND  that

.stop:
        mov     x14, x4
        APPEND  stop2

        cmp     x13, #8
        bne     .reason

.i_dont:
        mov     x14, x6
        APPEND  i_dont

        cmp     x1, x2
        beq     .return

        add     x1, x1, #8
        mov     w15, #'\n'
        strb    w15, [x0], #1
        b       .verse

.shes:
        mov     x14, x5
        APPEND  shes

.return:
        ret
