FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

#define BUFFER_SIZE 100

extern void format(char *buffer, const char *name, uint16_t number);
"""


def gen_func_body(prop, inp, expected):
    name = inp["name"]
    number = inp["number"]
    str_list = []
    str_list.append("char buffer[BUFFER_SIZE];\n\n")
    str_list.append(f'{prop}(buffer, "{name}", {number});\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "\n".join(str_list)
