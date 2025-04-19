FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void proteins(char *buffer, const char *strand);
"""

def gen_func_body(prop, inp, expected):
    strand = inp["strand"]
    if expected.__class__ == dict:
        expected = ''
    else:
        expected = ''.join(map(lambda amino_acid: amino_acid + '\\n', expected))
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, "{strand}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
