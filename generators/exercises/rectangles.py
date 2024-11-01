FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

int rectangles(const char **strings);
"""

def gen_func_body(prop, inp, expected):
    strings = inp["strings"]
    str_list = []
    str_list.append('const char *strings[] = {')
    for line in strings:
        str_list.append(f'  "{line}",')
    str_list.append(f'  NULL')
    str_list.append('};')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {prop}(strings));\n')
    return "\n".join(str_list)
