FUNC_PROTO = """\
#include "vendor/unity.h"

extern int is_valid(const char *isbn);
"""

def gen_func_body(prop, inp, expected):
    isbn = inp["isbn"]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}(is_valid(\"{isbn}\"));\n"
