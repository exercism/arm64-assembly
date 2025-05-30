FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 100
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t spiral_matrix(uint32_t *dest, size_t size);
"""


def gen_func_body(prop, inp, expected):
    size = inp["size"]
    str_list = []
    if size > 0:
        str_list.append("const uint32_t expected[] = {")
        str_list.append("    // clang-format off")
        for row in expected:
            str_list.append("    " + ", ".join(map(str, row)) + ",")
        str_list.append("    // clang-format on")
        str_list.append("};")

    str_list.append("uint32_t actual[MAX_ARRAY_SIZE];")
    str_list.append(f"const size_t count = {prop}(actual, {size});")
    if size > 0:
        str_list.append("TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), count);")
        str_list.append("TEST_ASSERT_EQUAL_UINT32_ARRAY(expected, actual, count);")
    else:
        str_list.append("TEST_ASSERT_EQUAL_UINT(0U, count);")
    return "\n".join(str_list) + "\n"
