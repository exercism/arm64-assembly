FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdint.h>

#define BUFFER_SIZE 16

extern void convert(char *buffer, uint64_t number);
"""

def extra_cases():
    return [
        {
            "description": "three digit prime",
            "property": "convert",
            "input": {
                "number": 829
            },
            "expected": "829"
        },
        {
            "description": "large positive",
            "property": "convert",
            "input": {
                "number": '9223372036854775905U'
            },
            "expected": "PlingPlangPlong"
        }
    ]

def gen_func_body(prop, inp, expected):
    number = inp["number"]
    str_list = []
    str_list.append(f'char buffer[BUFFER_SIZE];\n\n')
    str_list.append(f'convert(buffer, {number});\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
