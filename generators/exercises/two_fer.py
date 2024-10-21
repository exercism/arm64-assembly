FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

#define BUFFER_SIZE 80

extern void two_fer(char *buffer, const char *name);
"""

def gen_func_body(prop, inp, expected):
    name = inp["name"]
    if name:
        name = f'"{name}"'
    else:
        name = 'NULL'
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, {name});\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
