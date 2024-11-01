FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 3200

void rows(char *buffer, char letter);
"""

def gen_func_body(prop, inp, expected):
    letter = inp["letter"]
    str_list = []
    str_list.append(f'const char expected[] =')
    for index in range(len(expected)):
        line = expected[index]
        if index + 1 == len(expected):
            str_list.append(f'  "{line}\\n";')
        else:
            str_list.append(f'  "{line}\\n"')
    str_list.append(f'char buffer[BUFFER_SIZE];\n')
    str_list.append(f"{prop}(buffer, '{letter}');")
    str_list.append(f'TEST_ASSERT_EQUAL_STRING(expected, buffer);\n')
    return "\n".join(str_list)
