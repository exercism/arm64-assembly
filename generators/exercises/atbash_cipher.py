FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void encode(char *buffer, const char *phrase);
extern void decode(char *buffer, const char *phrase);
"""

def extra_cases():
    return [
        {
            "description": "encode boundary characters",
            "property": "encode",
            "input": {
                "phrase": "/09:@AMNZ[`amnz{"
            },
            "expected": "09znm aznma"
        }
    ]

def gen_func_body(prop, inp, expected):
    phrase = inp["phrase"]
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'{prop}(buffer, "{phrase}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
