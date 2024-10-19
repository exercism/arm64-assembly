FUNC_PROTO = """\
#include "vendor/unity.h"

extern int is_isogram(const char *phrase);
"""

def gen_func_body(prop, inp, expected):
    phrase = inp["phrase"]
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}(is_isogram(\"{phrase}\"));\n"
