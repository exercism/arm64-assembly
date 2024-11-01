.text
.globl nucleotide_counts

/* extern void nucleotide_counts(int16_t *counts, const char *strand); */
nucleotide_counts:
        mov     w4, wzr
        mov     w5, wzr
        mov     w6, wzr
        mov     w7, wzr

.read:
        ldrb    w2, [x1], #1            /* load byte, post-increment */
        cbz     w2, .report

        cmp     w2, 'A'
        beq     .adenine

        cmp     w2, 'C'
        beq     .cytosine

        cmp     w2, 'G'
        beq     .guanine

        cmp     w2, 'T'
        beq     .thymine

        mov     w2, -1
        strh    w2, [x0], #2
        strh    w2, [x0], #2
        strh    w2, [x0], #2
        strh    w2, [x0]
        ret

.report:
        strh    w4, [x0], #2
        strh    w5, [x0], #2
        strh    w6, [x0], #2
        strh    w7, [x0]
        ret

.adenine:
        add     w4, w4, #1
        b       .read

.cytosine:
        add     w5, w5, #1
        b       .read

.guanine:
        add     w6, w6, #1
        b       .read

.thymine:
        add     w7, w7, #1
        b       .read
