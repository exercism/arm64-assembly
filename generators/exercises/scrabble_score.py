FUNC_PROTO = """\
#include "vendor/unity.h"

extern int score(const char *word);
"""

def gen_func_body(prop, inp, expected):
    word = inp["word"]
    return f"TEST_ASSERT_EQUAL_INT({expected}, {prop}(\"{word}\"));\n"
