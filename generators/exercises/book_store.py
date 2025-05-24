FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern uint32_t total(size_t basket_count, const uint16_t *basket);
"""


def array_literal(numbers):
    return str(numbers).replace("[", "{").replace("]", "}")


def gen_func_body(prop, inp, expected):
    basket = inp["basket"]
    str_list = []
    if len(basket) > 0:
        str_list.append(f"const uint16_t basket[] = {array_literal(basket)};\n")
        str_list.append(
            f"TEST_ASSERT_EQUAL_UINT32({expected}, {prop}(ARRAY_SIZE(basket), basket));\n"
        )
    else:
        str_list.append(f"TEST_ASSERT_EQUAL_UINT32({expected}, {prop}(0, NULL));\n")
    return "".join(str_list)
