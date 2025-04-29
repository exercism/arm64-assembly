FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdbool.h>
#include <stdint.h>

extern bool answer(int64_t *result, const char *question);
"""


def gen_func_body(prop, inp, expected):
    question = inp["question"]
    macro = "TEST_ASSERT_TRUE"
    if isinstance(expected, dict):
        macro = "TEST_ASSERT_FALSE"

    str_list = []
    str_list.append("int64_t result;\n")
    str_list.append(f'const char *question = "{question}";\n')
    str_list.append(f"{macro}({prop}(&result, question));\n")
    if not isinstance(expected, dict):
        str_list.append(f"TEST_ASSERT_EQUAL_INT({expected}, result);\n")
    return "".join(str_list)
