.equ MERCURY, 1
.equ VENUS, 2
.equ EARTH, 3
.equ MARS, 4
.equ JUPITER, 5
.equ SATURN, 6
.equ URANUS, 7
.equ NEPTUNE, 8

.section .data

year: .double 31557600.0
      .double 0.2408467
      .double 0.61519726
      .double 1.0
      .double 1.8808158
      .double 11.862615
      .double 29.447498
      .double 84.016846
      .double 164.79132

.text
.globl age

/* extern double age(planet_t planet, int seconds); */
age:
        scvtf   d0, w1

        adrp    x9, year
        add     x9, x9, :lo12:year

        ldr     d1, [x9]
        fdiv    d0, d0, d1

        lsl     w0, w0, #3
        add     x9, x9, x0
        ldr     d1, [x9]
        fdiv    d0, d0, d1

        ret
