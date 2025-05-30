FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stddef.h>
#include <stdint.h>

#define MAX_ARRAY_SIZE 800
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t rows(uint64_t *dest, size_t count);
"""


def extra_cases():
    return [
        {
            "description": "thirty seven rows",
            "property": "rows",
            "input": {"count": 37},
            "expected": [
                [1],
                [1, 1],
                [1, 2, 1],
                [1, 3, 3, 1],
                [1, 4, 6, 4, 1],
                [1, 5, 10, 10, 5, 1],
                [1, 6, 15, 20, 15, 6, 1],
                [1, 7, 21, 35, 35, 21, 7, 1],
                [1, 8, 28, 56, 70, 56, 28, 8, 1],
                [1, 9, 36, 84, 126, 126, 84, 36, 9, 1],
                [1, 10, 45, 120, 210, 252, 210, 120, 45, 10, 1],
                [1, 11, 55, 165, 330, 462, 462, 330, 165, 55, 11, 1],
                [1, 12, 66, 220, 495, 792, 924, 792, 495, 220, 66, 12, 1],
                [1, 13, 78, 286, 715, 1287, 1716, 1716, 1287, 715, 286, 78, 13, 1],
                [
                    1,
                    14,
                    91,
                    364,
                    1001,
                    2002,
                    3003,
                    3432,
                    3003,
                    2002,
                    1001,
                    364,
                    91,
                    14,
                    1,
                ],
                [
                    1,
                    15,
                    105,
                    455,
                    1365,
                    3003,
                    5005,
                    6435,
                    6435,
                    5005,
                    3003,
                    1365,
                    455,
                    105,
                    15,
                    1,
                ],
                [
                    1,
                    16,
                    120,
                    560,
                    1820,
                    4368,
                    8008,
                    11440,
                    12870,
                    11440,
                    8008,
                    4368,
                    1820,
                    560,
                    120,
                    16,
                    1,
                ],
                [
                    1,
                    17,
                    136,
                    680,
                    2380,
                    6188,
                    12376,
                    19448,
                    24310,
                    24310,
                    19448,
                    12376,
                    6188,
                    2380,
                    680,
                    136,
                    17,
                    1,
                ],
                [
                    1,
                    18,
                    153,
                    816,
                    3060,
                    8568,
                    18564,
                    31824,
                    43758,
                    48620,
                    43758,
                    31824,
                    18564,
                    8568,
                    3060,
                    816,
                    153,
                    18,
                    1,
                ],
                [
                    1,
                    19,
                    171,
                    969,
                    3876,
                    11628,
                    27132,
                    50388,
                    75582,
                    92378,
                    92378,
                    75582,
                    50388,
                    27132,
                    11628,
                    3876,
                    969,
                    171,
                    19,
                    1,
                ],
                [
                    1,
                    20,
                    190,
                    1140,
                    4845,
                    15504,
                    38760,
                    77520,
                    125970,
                    167960,
                    184756,
                    167960,
                    125970,
                    77520,
                    38760,
                    15504,
                    4845,
                    1140,
                    190,
                    20,
                    1,
                ],
                [
                    1,
                    21,
                    210,
                    1330,
                    5985,
                    20349,
                    54264,
                    116280,
                    203490,
                    293930,
                    352716,
                    352716,
                    293930,
                    203490,
                    116280,
                    54264,
                    20349,
                    5985,
                    1330,
                    210,
                    21,
                    1,
                ],
                [
                    1,
                    22,
                    231,
                    1540,
                    7315,
                    26334,
                    74613,
                    170544,
                    319770,
                    497420,
                    646646,
                    705432,
                    646646,
                    497420,
                    319770,
                    170544,
                    74613,
                    26334,
                    7315,
                    1540,
                    231,
                    22,
                    1,
                ],
                [
                    1,
                    23,
                    253,
                    1771,
                    8855,
                    33649,
                    100947,
                    245157,
                    490314,
                    817190,
                    1144066,
                    1352078,
                    1352078,
                    1144066,
                    817190,
                    490314,
                    245157,
                    100947,
                    33649,
                    8855,
                    1771,
                    253,
                    23,
                    1,
                ],
                [
                    1,
                    24,
                    276,
                    2024,
                    10626,
                    42504,
                    134596,
                    346104,
                    735471,
                    1307504,
                    1961256,
                    2496144,
                    2704156,
                    2496144,
                    1961256,
                    1307504,
                    735471,
                    346104,
                    134596,
                    42504,
                    10626,
                    2024,
                    276,
                    24,
                    1,
                ],
                [
                    1,
                    25,
                    300,
                    2300,
                    12650,
                    53130,
                    177100,
                    480700,
                    1081575,
                    2042975,
                    3268760,
                    4457400,
                    5200300,
                    5200300,
                    4457400,
                    3268760,
                    2042975,
                    1081575,
                    480700,
                    177100,
                    53130,
                    12650,
                    2300,
                    300,
                    25,
                    1,
                ],
                [
                    1,
                    26,
                    325,
                    2600,
                    14950,
                    65780,
                    230230,
                    657800,
                    1562275,
                    3124550,
                    5311735,
                    7726160,
                    9657700,
                    10400600,
                    9657700,
                    7726160,
                    5311735,
                    3124550,
                    1562275,
                    657800,
                    230230,
                    65780,
                    14950,
                    2600,
                    325,
                    26,
                    1,
                ],
                [
                    1,
                    27,
                    351,
                    2925,
                    17550,
                    80730,
                    296010,
                    888030,
                    2220075,
                    4686825,
                    8436285,
                    13037895,
                    17383860,
                    20058300,
                    20058300,
                    17383860,
                    13037895,
                    8436285,
                    4686825,
                    2220075,
                    888030,
                    296010,
                    80730,
                    17550,
                    2925,
                    351,
                    27,
                    1,
                ],
                [
                    1,
                    28,
                    378,
                    3276,
                    20475,
                    98280,
                    376740,
                    1184040,
                    3108105,
                    6906900,
                    13123110,
                    21474180,
                    30421755,
                    37442160,
                    40116600,
                    37442160,
                    30421755,
                    21474180,
                    13123110,
                    6906900,
                    3108105,
                    1184040,
                    376740,
                    98280,
                    20475,
                    3276,
                    378,
                    28,
                    1,
                ],
                [
                    1,
                    29,
                    406,
                    3654,
                    23751,
                    118755,
                    475020,
                    1560780,
                    4292145,
                    10015005,
                    20030010,
                    34597290,
                    51895935,
                    67863915,
                    77558760,
                    77558760,
                    67863915,
                    51895935,
                    34597290,
                    20030010,
                    10015005,
                    4292145,
                    1560780,
                    475020,
                    118755,
                    23751,
                    3654,
                    406,
                    29,
                    1,
                ],
                [
                    1,
                    30,
                    435,
                    4060,
                    27405,
                    142506,
                    593775,
                    2035800,
                    5852925,
                    14307150,
                    30045015,
                    54627300,
                    86493225,
                    119759850,
                    145422675,
                    155117520,
                    145422675,
                    119759850,
                    86493225,
                    54627300,
                    30045015,
                    14307150,
                    5852925,
                    2035800,
                    593775,
                    142506,
                    27405,
                    4060,
                    435,
                    30,
                    1,
                ],
                [
                    1,
                    31,
                    465,
                    4495,
                    31465,
                    169911,
                    736281,
                    2629575,
                    7888725,
                    20160075,
                    44352165,
                    84672315,
                    141120525,
                    206253075,
                    265182525,
                    300540195,
                    300540195,
                    265182525,
                    206253075,
                    141120525,
                    84672315,
                    44352165,
                    20160075,
                    7888725,
                    2629575,
                    736281,
                    169911,
                    31465,
                    4495,
                    465,
                    31,
                    1,
                ],
                [
                    1,
                    32,
                    496,
                    4960,
                    35960,
                    201376,
                    906192,
                    3365856,
                    10518300,
                    28048800,
                    64512240,
                    129024480,
                    225792840,
                    347373600,
                    471435600,
                    565722720,
                    601080390,
                    565722720,
                    471435600,
                    347373600,
                    225792840,
                    129024480,
                    64512240,
                    28048800,
                    10518300,
                    3365856,
                    906192,
                    201376,
                    35960,
                    4960,
                    496,
                    32,
                    1,
                ],
                [
                    1,
                    33,
                    528,
                    5456,
                    40920,
                    237336,
                    1107568,
                    4272048,
                    13884156,
                    38567100,
                    92561040,
                    193536720,
                    354817320,
                    573166440,
                    818809200,
                    1037158320,
                    1166803110,
                    1166803110,
                    1037158320,
                    818809200,
                    573166440,
                    354817320,
                    193536720,
                    92561040,
                    38567100,
                    13884156,
                    4272048,
                    1107568,
                    237336,
                    40920,
                    5456,
                    528,
                    33,
                    1,
                ],
                [
                    1,
                    34,
                    561,
                    5984,
                    46376,
                    278256,
                    1344904,
                    5379616,
                    18156204,
                    52451256,
                    131128140,
                    286097760,
                    548354040,
                    927983760,
                    1391975640,
                    1855967520,
                    2203961430,
                    2333606220,
                    2203961430,
                    1855967520,
                    1391975640,
                    927983760,
                    548354040,
                    286097760,
                    131128140,
                    52451256,
                    18156204,
                    5379616,
                    1344904,
                    278256,
                    46376,
                    5984,
                    561,
                    34,
                    1,
                ],
                [
                    1,
                    35,
                    595,
                    6545,
                    52360,
                    324632,
                    1623160,
                    6724520,
                    23535820,
                    70607460,
                    183579396,
                    417225900,
                    834451800,
                    1476337800,
                    2319959400,
                    3247943160,
                    4059928950,
                    4537567650,
                    4537567650,
                    4059928950,
                    3247943160,
                    2319959400,
                    1476337800,
                    834451800,
                    417225900,
                    183579396,
                    70607460,
                    23535820,
                    6724520,
                    1623160,
                    324632,
                    52360,
                    6545,
                    595,
                    35,
                    1,
                ],
                [
                    1,
                    36,
                    630,
                    7140,
                    58905,
                    376992,
                    1947792,
                    8347680,
                    30260340,
                    94143280,
                    254186856,
                    600805296,
                    1251677700,
                    2310789600,
                    3796297200,
                    5567902560,
                    7307872110,
                    8597496600,
                    9075135300,
                    8597496600,
                    7307872110,
                    5567902560,
                    3796297200,
                    2310789600,
                    1251677700,
                    600805296,
                    254186856,
                    94143280,
                    30260340,
                    8347680,
                    1947792,
                    376992,
                    58905,
                    7140,
                    630,
                    36,
                    1,
                ],
            ],
        }
    ]


def gen_func_body(prop, inp, expected):
    count = inp["count"]
    str_list = []
    if count > 0:
        str_list.append("uint64_t expected[] = {")
        str_list.append("    // clang-format off")
        for row in expected:
            str_list.append("    " + ", ".join(map(str, row)) + ",")
        str_list.append("    // clang-format on")
        str_list.append("};")

    str_list.append("uint64_t actual[MAX_ARRAY_SIZE];")
    str_list.append(f"const size_t size = rows(actual, {count});")
    if count > 0:
        str_list.append("TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), size);")
        str_list.append("TEST_ASSERT_EQUAL_UINT64_ARRAY(expected, actual, size);")
    else:
        str_list.append("TEST_ASSERT_EQUAL_UINT(0U, size);")
    return "\n".join(str_list) + "\n"
