FUNC_PROTO = """\
#include "vendor/unity.h"

extern int is_pangram(const char *sentence);
"""

def gen_func_body(prop, inp, expected):
    sentence = inp["sentence"].replace('"', '\\"')
    if expected:
        macro = "TEST_ASSERT_TRUE"
    else:
        macro = "TEST_ASSERT_FALSE"
    return f"{macro}(is_pangram(\"{sentence}\"));\n"
