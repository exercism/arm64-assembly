.section .rodata
msg: .string "Hello, World!"

.text
.global actual_hello
actual_hello:
    adrp x0, msg
    add x0, x0, :lo12:msg
    ret
