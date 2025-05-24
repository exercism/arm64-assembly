FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 256

extern void encode(char *buffer, const char *string);
extern void decode(char *buffer, const char *string);
"""


def extra_cases():
    return [
        {
            "description": "long run",
            "property": "encode",
            "input": {
                "string": "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
            },
            "expected": "123z",
        },
        {
            "description": "long run",
            "property": "decode",
            "input": {"string": "123z"},
            "expected": "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz",
        },
    ]


def describe(case):
    description = case["description"]
    property = case["property"]
    return f"{property} {description}"


def gen_func_body(prop, inp, expected):
    string = inp["string"]
    str_list = []
    if prop == "consistency":
        str_list.append("char buffer1[BUFFER_SIZE];\n")
        str_list.append("char buffer2[BUFFER_SIZE];\n\n")
        str_list.append(f'encode(buffer1, "{string}");\n')
        str_list.append("decode(buffer2, buffer1);\n")
        str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer2);\n')
    else:
        str_list.append("char buffer[BUFFER_SIZE];\n\n")
        str_list.append(f'{prop}(buffer, "{string}");\n')
        str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
