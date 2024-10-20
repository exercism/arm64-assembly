FUNC_PROTO = """\
#include "vendor/unity.h"

#define UNEQUAL_LENGTHS -1

extern int distance(const char *strand1, const char *strand2);
"""

def gen_func_body(prop, inp, expected):
    strand1 = inp["strand1"]
    strand2 = inp["strand2"]
    if expected.__class__ == dict:
        expected = 'UNEQUAL_LENGTHS'
    return f'TEST_ASSERT_EQUAL_INT({expected}, distance("{strand1}", "{strand2}"));\n'
