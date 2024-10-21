FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void rotate(char *buffer, const char *text, int shift_key);
"""

def gen_func_body(prop, inp, expected):
    text = inp["text"]
    shift_key = inp["shiftKey"]
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, "{text}", {shift_key});\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
