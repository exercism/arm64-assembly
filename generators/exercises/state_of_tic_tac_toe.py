FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

enum state {
    ONGOING,
    DRAW,
    WIN,
    INVALID
};

extern int gamestate(const char **board);
"""

def gen_func_body(prop, inp, expected):
    board = inp["board"]
    if expected.__class__ == dict:
        expected = 'invalid'
    str_list = []
    str_list.append('const char *board[] = {')
    for line in board:
        str_list.append(f'  "{line}",')
    str_list.append(f'  NULL')
    str_list.append('};')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({expected.upper()}, {prop}(board));\n')
    return "\n".join(str_list)