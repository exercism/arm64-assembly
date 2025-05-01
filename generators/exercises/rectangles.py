FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>

extern int rectangles(const char **strings);
"""

def extra_cases():
    return [
        {
            "description": "very large input",
            "property": "rectangles",
            "input": {
                "strings": [
                    "      +-----+--------+    +-----+ ",
                    "++---++-----+--------+---++-----++",
                    "||+--++-----+-+-++   |   ||     ||",
                    "|||  ||     +-+-++-+ |   ||     ||",
                    "|||  ||     | | || | |   ||     ||",
                    "||| +++-----+-+-++-+-+---++-+   ||",
                    "||| |||     | | || | |+--++-+-+ ||",
                    "||| +++---+-+-+-++-+-++--++-+ | ||",
                    "||| |||+--+-+-+-+| | |+--++---+ ||",
                    "||| ||||  | | | || | |+-+||     ||",
                    "||+-++++--+-+++-++-+-++-+++---++||",
                    "||  |+++--+-+++-+--+-+| |||   ||||",
                    "+++-+++++---++--+-++-++-+++---+|||",
                    " |+-+++++---++--+ || || |||   ||||",
                    " |  +++++---++--+-++-++-++++  ||||",
                    " |   ||||   |+----++-++-++++--+++|",
                    " |   |+++---+|    || || ||    || |",
                    "+++  |||+---++----+| || ||    || |",
                    "|||  +++----++----++-++-++----++-+",
                    "+++---++----++-----+-++-++----++  ",
                    "                      +-+         "
                ]
            },
            "expected": 2063
        }
    ]

def gen_func_body(prop, inp, expected):
    strings = inp["strings"]
    str_list = []
    str_list.append('const char *strings[] = {')
    str_list.append('    // clang-format off')
    for line in strings:
        str_list.append(f'    "{line}",')
    str_list.append(f'    NULL')
    str_list.append('    // clang-format on')
    str_list.append('};')
    str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {prop}(strings));\n')
    return "\n".join(str_list)
