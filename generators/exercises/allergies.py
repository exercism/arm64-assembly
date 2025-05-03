FUNC_PROTO = """\
#include "vendor/unity.h"

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

typedef enum {
    EGGS = 0,
    PEANUTS,
    SHELLFISH,
    STRAWBERRIES,
    TOMATOES,
    CHOCOLATE,
    POLLEN,
    CATS,
    MAX_ITEMS
} item_t;

typedef struct {
    int size;
    item_t items[MAX_ITEMS];
} item_list_t;

extern int allergic_to(item_t item, unsigned int score);
extern void list(unsigned int score, item_list_t *list);
"""

def gen_func_body(prop, inp, expected):
    str_list = []
    score = inp["score"]
    match prop:
        case "allergic_to":
            item = inp["item"].upper()
            if expected:
                str_list.append(f"TEST_ASSERT_TRUE({prop}({item}, {score}));\n")
            else:
                str_list.append(f"TEST_ASSERT_FALSE({prop}({item}, {score}));\n")
        case "list":
            item_list = list(map(lambda item: str(item).upper(), expected))
            item_list = str(item_list).replace("'", "")
            item_list = item_list.replace("[", "{")
            item_list = item_list.replace("]", "}")
            if expected:
                str_list.append(f"const int expected[] = {item_list};\n")
            str_list.append("item_list_t item_list = {0};\n\n")
            str_list.append(f"{prop}({score}, &item_list);\n")
            if expected:
                str_list.append("TEST_ASSERT_EQUAL_INT(ARRAY_SIZE(expected), item_list.size);\n")
                str_list.append("TEST_ASSERT_EQUAL_INT_ARRAY(expected, item_list.items, item_list.size);\n")
            else:
                str_list.append("TEST_ASSERT_EQUAL_INT(0, item_list.size);\n")
    return "".join(str_list)

def describe(case):
    description = case["description"]
    if description in ["allergic to everything", "not allergic to anything"]:
        item = case["input"]["item"]
        return f"{item} {description}"
    return description
