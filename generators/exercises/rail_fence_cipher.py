FUNC_PROTO = """\
#include "vendor/unity.h"

#define BUFFER_SIZE 80

extern void encode(char *buffer, const char *msg, int rails);
extern void decode(char *buffer, const char *msg, int rails);
"""


def extra_cases():
    return [
        {
            "description": "decode with seven rails",
            "property": "decode",
            "input": {
                "msg": "AGGWRHNAEROTOESTRADWETHCTTRENAAVOTHEAOECTRESIRMKEINNNEWOOENESANO",
                "rails": 7,
            },
            "expected": "ANANCIENTADAGEWARNSNEVERGOTOSEAWITHTWOCHRONOMETERSTAKEONEORTHREE",
        }
    ]


def gen_func_body(prop, inp, expected):
    msg = inp["msg"]
    rails = inp["rails"]
    str_list = []
    str_list.append("char buffer[BUFFER_SIZE];\n\n")
    str_list.append(f'{prop}(buffer, "{msg}", {rails});\n')
    str_list.append(f'TEST_ASSERT_EQUAL_STRING("{expected}", buffer);\n')
    return "".join(str_list)
