FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

#define INVALID -1

enum nucleotide {
    ADENINE,
    CYTOSINE,
    GUANINE,
    THYMINE
};

extern void nucleotide_counts(int16_t *counts, const char *strand);
"""

def gen_func_body(prop, inp, expected):
    strand = inp["strand"]
    if "error" in expected:
        a = 'INVALID'
        c = 'INVALID'
        g = 'INVALID'
        t = 'INVALID'
    else:
        a = expected["A"]
        c = expected["C"]
        g = expected["G"]
        t = expected["T"]
    str_list = []
    str_list.append(f'int16_t counts[4];\n')
    str_list.append(f'{prop}(counts, "{strand}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({a}, counts[ADENINE]);\n')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({c}, counts[CYTOSINE]);\n')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({g}, counts[GUANINE]);\n')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({t}, counts[THYMINE]);\n')
    return "".join(str_list)
