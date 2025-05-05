.section .rodata
msg: .string "Hello, World!"

.text
.global hello
hello:
        adrp    x0, msg
        add     x0, x0, :lo12:msg
        ret
