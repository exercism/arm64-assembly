FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 20

extern void roman(char *buffer, unsigned number);
"""


def gen_func_body(prop, inp, expected):
    number = inp["number"]
    str_list = []
    str_list.append("char buffer[BUFFER_SIZE];\n\n")
    str_list.append(f"roman(buffer, {number});\n")
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
