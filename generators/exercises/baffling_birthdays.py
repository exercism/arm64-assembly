FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdbool.h>

extern bool shared_birthday(const char **birthdates);

// estimated probability of shared birthday
extern double estimate(int group_size);
"""


def gen_func_body(prop, inp, expected):
    if prop == "shared_birthday":
        str_list = []
        if expected:
            macro = "TEST_ASSERT_TRUE"
        else:
            macro = "TEST_ASSERT_FALSE"
        birthdates = '{"' + '", "'.join(inp["birthdates"]) + '", NULL}'
        str_list.append(f"const char *birthdates[] = {birthdates};")
        str_list.append(f"{macro}({prop}(birthdates));\n")
        return "\n".join(str_list)

    group_size = inp["groupSize"]
    return f"TEST_ASSERT_FLOAT_WITHIN(0.05, {expected}, estimate({group_size}));\n"
