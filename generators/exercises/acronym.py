FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 40

extern void abbreviate(char *buffer, const char *phrase);
"""


def extra_cases():
    return [
        {
            "description": "all lowercase",
            "property": "abbreviate",
            "input": {"phrase": "point of view"},
            "expected": "POV",
        }
    ]


def gen_func_body(prop, inp, expected):
    phrase = inp["phrase"]
    str_list = []
    str_list.append("char buffer[BUFFER_SIZE];\n\n")
    str_list.append(f'{prop}(buffer, "{phrase}");\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
