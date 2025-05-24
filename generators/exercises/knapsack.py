FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

typedef struct {
    uint32_t weight;
    uint32_t value;
} item_t;

extern uint32_t maximum_value(uint32_t maximum_weight, const item_t *items, size_t item_count);
"""


def array_literal(items):
    return str(list(items)).replace("[", "{").replace("]", "}")


def item_literal(item):
    weight = item["weight"]
    value = item["value"]
    return [weight, value]


def gen_func_body(prop, inp, expected):
    maximum_weight = inp["maximumWeight"]
    items = inp["items"]
    str_list = []
    if len(items) > 0:
        str_list.append(
            f"const item_t items[] = {array_literal(map(item_literal, items))};\n"
        )
        str_list.append(
            f"TEST_ASSERT_EQUAL_UINT({expected}, {prop}({maximum_weight}, items, ARRAY_SIZE(items)));\n"
        )
    else:
        str_list.append(
            f"TEST_ASSERT_EQUAL_UINT({expected}, {prop}({maximum_weight}, NULL, 0));\n"
        )
    return "".join(str_list)
