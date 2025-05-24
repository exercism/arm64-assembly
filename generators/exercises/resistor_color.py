FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern int color_code(const char *color);
extern const char **colors(void);
"""


def gen_func_body(prop, inp, expected):
    str_list = []
    if prop == "color_code":
        color = inp["color"]
        str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {prop}("{color}"));\n')
    elif prop == "colors":
        color_array = (
            str(expected).replace("'", '"').replace("[", "{").replace("]", "}")
        )
        str_list.append(f"const char *expected[] = {color_array};\n")
        str_list.append(f"const char **color_array = {prop}();\n")
        str_list.append("size_t size;\n\n")
        str_list.append("for (size = 0; color_array[size]; size++) {\n")
        str_list.append("}\n")
        str_list.append("TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);\n")
        str_list.append(
            "TEST_ASSERT_EQUAL_STRING_ARRAY(expected, color_array, size);\n"
        )
    return "".join(str_list)
