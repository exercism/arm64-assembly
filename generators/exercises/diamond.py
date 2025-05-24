FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 3200

extern void rows(char *buffer, char letter);
"""


def gen_func_body(prop, inp, expected):
    letter = inp["letter"]
    str_list = []
    str_list.append("const char expected[] =")
    if len(expected) == 1:
        str_list[-1] += f' "{expected[0]}\\n";'
    else:
        for index in range(len(expected)):
            line = expected[index]
            if index + 1 == len(expected):
                str_list.append(f'    "{line}\\n";')
            else:
                str_list.append(f'    "{line}\\n"')
    str_list.append("char buffer[BUFFER_SIZE];\n")
    str_list.append(f"{prop}(buffer, '{letter}');")
    str_list.append("TEST_ASSERT_EQUAL_STRING(expected, buffer);\n")
    return "\n".join(str_list)
