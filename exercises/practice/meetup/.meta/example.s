.equ FIRST, 1
.equ SECOND, 2
.equ THIRD, 3
.equ FOURTH, 4
.equ TEENTH, 5
.equ LAST, 6

.equ MONDAY, 1
.equ TUESDAY, 2
.equ WEDNESDAY, 3
.equ THURSDAY, 4
.equ FRIDAY, 5
.equ SATURDAY, 6
.equ SUNDAY, 7

.data

/* offset from end February for the start of the specified month */
offset_array:
        .hword -1
        .hword 307
        .hword 338
        .hword 1 /* March */
        .hword 32
        .hword 62
        .hword 93
        .hword 123
        .hword 154
        .hword 185
        .hword 215
        .hword 246
        .hword 276
        .hword 307
        .hword 338 /* February */

/* day in month for last day in specified week */
week_array:
        .byte -1
        .byte 7 /* first */
        .byte 14
        .byte 21
        .byte 28
        .byte 19 /* teenth */

.text
.globl meetup

/* void print_date(char *buffer, int year, int month, int day); */
print_date:
        mov    w9, #'-'
        mov    w10, 10                  /* divisor */

        udiv    w11, w1, w10            /* quotient */
        msub    w13, w11, w10, w1       /* remainder (year) */
        add     w13, w13, #'0'
        strb    w13, [x0, #3]

        udiv    w12, w11, w10           /* quotient */
        msub    w13, w12, w10, w11      /* remainder (decade) */
        add     w13, w13, #'0'
        strb    w13, [x0, #2]

        udiv    w11, w12, w10           /* quotient */
        msub    w13, w11, w10, w12      /* remainder (century) */
        add     w13, w13, #'0'
        strb    w13, [x0, #1]
        add     w11, w11, #'0'
        strb    w11, [x0]

        strb    w9, [x0, #4]

        udiv    w11, w2, w10            /* quotient */
        msub    w13, w11, w10, w2       /* remainder (month) */
        add     w13, w13, #'0'
        strb    w13, [x0, #6]
        add     w11, w11, #'0'
        strb    w11, [x0, #5]

        strb    w9, [x0, #7]

        udiv    w11, w3, w10            /* quotient */
        msub    w13, w11, w10, w3       /* remainder (day) */
        add     w13, w13, #'0'
        strb    w13, [x0, #9]
        add     w11, w11, #'0'
        strb    w11, [x0, #8]

        strb    wzr, [x0, #10]
        ret

/* int leap_year(void *unused, int year); */
leap_year:
        mov     w10, #100               /* divisor */
        udiv    w12, w1, w10            /* quotient, i.e. century */
        msub    w13, w12, w10, w1       /* remainder, i.e. year within century */
        tst     w13, w13                /* check if 0 */
        csel    w0, w12, w13, eq        /* either century, or year within century */
        tst     w0, #3                  /* check if multiple of 4 */
        cset    w0, eq
        ret

/* int days_in_month(void *unused, int year, int month); */
days_in_month:
        cmp     w2, #2
        beq     .february

        adrp    x9, offset_array
        add     x9, x9, :lo12:offset_array

        lsl     w10, w2, #1             /* month * sizeof(hword) */
        ldrh    w11, [x9, x10]          /* days offset for required month */

        add     w10, w10, #2            /* (month + 1) * sizeof(hword) */
        ldrh    w0, [x9, x10]           /* days offset for following month */

        sub     w0, w0, w11
        ret

.february:
        mov     x11, lr
        bl      leap_year
        add     w0, w0, #28
        ret     x11

/* int week_concludes(void *unused, int year, int month, week_t week); */
week_concludes:
        cmp     w3, LAST
        beq     days_in_month           /* tail call */

        adrp    x9, week_array
        add     x9, x9, :lo12:week_array
        ldrb    w0, [x9, x3]            /* day in month at end of requested week */
        ret

/* dayofweek_t day_of_week(void *unused, int year, int month, int day); */
day_of_week:
        mov     w12, w2                 /* month */
        mov     w11, w1                 /* year */

        add     w10, w12, #12           /* Consider January and February to be the 13th and 14th months of */
        sub     w9, w11, #1             /* the previous year */
        cmp     w2, #2
        csel    w12, w12, w10, hi       /* Conditionally adjust month */
        csel    w11, w11, w9, hi        /* Conditionally adjust year */

        lsl     w12, w12, #1            /* (adjusted month) * sizeof(hword) */
        adrp    x9, offset_array
        add     x9, x9, :lo12:offset_array
        ldrh    w13, [x9, x12]          /* days offset for required month */

        mov     w0, w11                 /* adjusted year */

        lsr     w11, w11, #2            /* adjusted year / 4 */
        add     w0, w0, w11

        mov     w9, #25
        udiv    w11, w11, w9            /* adjusted year / 100 */
        sub     w0, w0, w11

        lsr     w11, w11, #2            /* adjusted year / 400 */
        add     w0, w0, w11

        add     w0, w0, w13             /* add offset */
        add     w0, w0, w3              /* add day in month */

        mov     w9, #7
        udiv    w10, w0, w9             /* quotient */
        msub    w0, w10, w9, w0         /* remainder */
        add     w0, w0, #1              /* day of week, in range 1..7 */
        ret

/* extern void meetup(char *buffer, int year, int month, week_t week, dayofweek_t dayofweek); */
meetup:
        mov     x14, x0                 /* buffer */
        mov     x15, lr                 /* return address */
        bl      week_concludes

        mov     w3, w0                  /* day of month when week concludes */
        bl      day_of_week

        sub     w0, w4, w0              /* delta: requested day of week minus current day of week */
        sub     w9, w0, #7
        cmp     w0, wzr
        csel    w0, w0, w9, le          /* if delta was positive, subtract 7 */
        add     w3, w3, w0              /* required day of month */
        mov     x0, x14                 /* buffer */
        bl      print_date

        ret     x15
