.text
.globl equilateral
.globl isosceles
.globl scalene

/* extern int equilateral(int a, int b, int c); */
equilateral:
        cbz     x0, reject

        cmp     x0, x1
        bne     reject

        cmp     x0, x2
        bne     reject

accept:
        mov     x0, #1
        ret

/* extern int isosceles(int a, int b, int c); */
isosceles:
        cmp     x0, x1
        beq     triangle

        cmp     x0, x2
        beq     triangle

        cmp     x1, x2
        beq     triangle

reject:
        mov     x0, xzr
        ret

/* extern int scalene(int a, int b, int c); */
scalene:
        cmp     x0, x1
        beq     reject

        cmp     x0, x2
        beq     reject

        cmp     x1, x2
        beq     reject

triangle:
        cbz     x0, reject

        cbz     x1, reject

        cbz     x2, reject

        add     x3, x1, x2
        cmp     x0, x3
        bgt     reject

        add     x3, x0, x2
        cmp     x1, x3
        bgt     reject

        add     x3, x0, x1
        cmp     x2, x3
        bgt     reject

        b       accept
