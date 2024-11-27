FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

extern int value(const char **colors);
"""

def gen_func_body(prop, inp, expected):
    colors = inp["colors"]
    str_list = []
    str_list.append('const char *colors[] = {')
    for color in colors:
        str_list.append(f'  "{color}",')
    str_list.append(f'  NULL')
    str_list.append('};')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {prop}(colors));\n')
    return "\n".join(str_list)
