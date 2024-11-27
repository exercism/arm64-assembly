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

ohms:   .string " ohms"
kiloohms:
        .string " kiloohms"
megaohms:
        .string " megaohms"
gigaohms:
        .string " gigaohms"

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

units_array:
        .dword ohms
        .dword kiloohms
        .dword megaohms
        .dword gigaohms
        .dword 0                        /* Sentinel value to indicate end of array */

.text
.globl label

color_code:
        adrp    x1, color_array
        add     x1, x1, :lo12:color_array
        mov     x2, x1

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
        sub     x0, x2, x1
        lsr     x0, x0, #3
        ret

/* extern void label(char *buffer, const char **colors); */
label:
        mov     x7, x0
        mov     x8, x1
        mov     x9, lr                 /* preserve return address */
        mov     x10, #10
        ldr     x0, [x8], #8           /* load address of first color */
        bl      color_code
        mov     w11, w0
        ldr     x0, [x8], #8           /* load address of second color */
        bl      color_code
        mov     w12, w0
        ldr     x0, [x8]               /* load address of third color */
        bl      color_code
        add     w0, w0, #1
        mov     w3, #3
        udiv    w2, w0, w3              /* quotient, indicates units */
        msub    w4, w2, w3, w0          /* remainder */

        cbz     w4, .divide

        cbz     w11, .skip_first

        add     w11, w11, #'0'
        strb    w11, [x7], #1           /* write first digit */

.skip_first:
        add     w12, w12, #'0'
        strb    w12, [x7], #1           /* write second digit */
        cmp     w4, #1
        beq     .append_units

        mov     w12, #'0'
        strb    w12, [x7], #1           /* write zero */
        b .append_units

.divide:
        add     w11, w11, #'0'
        strb    w11, [x7], #1           /* write first digit */
        cbz     w12, .append_units

        mov     w11, #'.'
        strb    w11, [x7], #1           /* write '.' */
        add     w12, w12, #'0'
        strb    w12, [x7], #1           /* write second digit */

.append_units:
        adrp    x1, units_array
        add     x1, x1, :lo12:units_array
        lsl     w2, w2, #3
        ldr     x2, [x1, x2]

.copy:
        ldrb    w3, [x2], #1
        strb    w3, [x7], #1
        cbnz    w3, .copy

        mov     lr, x9
        ret
