FUNC_PROTO = """\
#include "vendor/unity.h"

// Returns 1 if queen can be created, otherwise 0.
extern int can_create(int row, int column);

// Returns 1 if queens attack, otherwise 0.
extern int can_attack(int white_row, int white_column, int black_row, int black_column);
"""


def gen_func_body(prop, inp, expected):
    macro = "TEST_ASSERT_TRUE"
    if expected is False or isinstance(expected, dict):
        macro = "TEST_ASSERT_FALSE"

    def describe(queen):
        row = queen["position"]["row"]
        column = queen["position"]["column"]
        return f"{row}, {column}"

    if prop == "create":
        queen = describe(inp["queen"])
        return f"{macro}(can_create({queen}));\n"

    if prop == "can_attack":
        white_queen = describe(inp["white_queen"])
        black_queen = describe(inp["black_queen"])
        return f"{macro}(can_attack({white_queen}, {black_queen}));\n"
