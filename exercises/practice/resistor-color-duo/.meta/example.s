.data
black:  .string "black"
brown:  .string "brown"
red:    .string "red"
orange: .string "orange"
yellow: .string "yellow"
green:  .string "green"
blue:   .string "blue"
violet: .string "violet"
grey:   .string "grey"
white:  .string "white"

color_array:
        .dword black
        .dword brown
        .dword red
        .dword orange
        .dword yellow
        .dword green
        .dword blue
        .dword violet
        .dword grey
        .dword white
        .dword 0                        /* Sentinel value to indicate end of array */

.text
.globl value

color_code:
        adrp    x7, color_array
        add     x7, x7, :lo12:color_array
        mov     x2, x7

.next:
        mov     x3, x0
        ldr     x4, [x2], #8            /* load pointer, post-increment */

.compare:
        ldrb    w5, [x3], #1            /* load character, post-increment */
        ldrb    w6, [x4], #1            /* load character, post-increment */
        cmp     w5, w6
        bne     .next

        cbnz    w5, .compare

        sub     x2, x2, #8
        sub     x0, x2, x7
        lsr     x0, x0, #3
        ret

/* extern int value(const char *first, const char *second, const char *third); */
value:
        mov     x9, lr
        bl      color_code
        mov     x11, x0
        mov     x0, x1
        bl      color_code
        mov     x10, #10
        madd    x0, x10, x11, x0
        mov     lr, x9
        ret
