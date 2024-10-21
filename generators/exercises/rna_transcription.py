FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void to_rna(char *buffer, const char *dna);
"""

def gen_func_body(prop, inp, expected):
    dna = inp["dna"]
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, "{dna}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
