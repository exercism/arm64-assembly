FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void ciphertext(char *buffer, const char *plaintext);
"""


def gen_func_body(prop, inp, expected):
    plaintext = inp["plaintext"]
    str_list = []
    str_list.append("char buffer[BUFFER_SIZE];\n\n")
    str_list.append(f'{prop}(buffer, "{plaintext}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
