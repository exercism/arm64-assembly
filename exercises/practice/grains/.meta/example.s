.text
.globl square
.globl total

/* extern uint64_t square(int64_t number); */
square:
        sub     x0, x0, #1
        cmp     x0, #64
        bhs     .invalid                /* unsigned >= */

        mov     x1, #1
        lsl     x0, x1, x0              /* 1 << (number - 1) */
        ret

.invalid:
        mov     x0, #0
        ret

/* extern uint64_t total(void); */
total:
        mov     x0, #-1                 /* all 64 bits set */
        ret
