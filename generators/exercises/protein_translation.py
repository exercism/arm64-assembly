FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void proteins(char *buffer, const char *strand);
"""

def gen_func_body(prop, inp, expected):
    strand = inp["strand"]
    if isinstance(expected, dict):
        expected = ''
    else:
        expected = ''.join(amino_acid + '\\n' for amino_acid in expected)
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, "{strand}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
