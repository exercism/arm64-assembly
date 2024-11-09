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
.globl color_code
.globl colors

/* extern int color_code(const char *color); */
color_code:
        adrp    x1, color_array
        add     x1, x1, :lo12:color_array
        mov     x2, x1

.next:
        mov     x3, x0
        ldr     x4, [x2], #8            /* load pointer, post-increment */
        cbz     x4, .invalid

.compare:
        ldrb    w5, [x3], #1            /* load character, post-increment */
        ldrb    w6, [x4], #1            /* load character, post-increment */
        cmp     w5, w6
        bne     .next

        cbnz    w5, .compare

        sub     x2, x2, #8
        sub     x0, x2, x1
        lsr     x0, x0, #3
        ret

.invalid:
        mov     x0, #-1
        ret

/* extern const char **colors(void); */
colors:
        adrp    x0, color_array
        add     x0, x0, :lo12:color_array
        ret
