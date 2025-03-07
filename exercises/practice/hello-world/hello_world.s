.section .rodata
msg: .string "Hello, World!"

.text
.global act_hello
act_hello:
    adrp x0, msg
    add x0, x0, :lo12:msg
    ret
