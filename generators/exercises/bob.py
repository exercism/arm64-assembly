FUNC_PROTO = """\
#include "vendor/unity.h"

extern const char *response(const char *hey_bob);
"""

def gen_func_body(prop, inp, expected):
    hey_bob = inp["heyBob"].replace('\t', '\\t').replace('\n', '\\n').replace('\r', '\\r')
    str_list = []
    str_list.append(f'char str[] = "{hey_bob}";\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", {prop}(str));\n')
    return "".join(str_list)
