FUNC_PROTO = """\
#include "vendor/unity.h"

extern void find_anagrams(const char *subject, const char *candidates[], int num_candidates, int* is_anagram);
"""

def gen_func_body(prop, inp, expected):
    if prop != "find_anagrams":
        raise ValueError("Only property 'find_anagrams' is supported")
    str_list = []
    subject = inp["subject"]
    candidates = inp["candidates"]
    num_candidates = len(candidates)
    candidates_list = ", ".join(f"\"{c}\"" for c in candidates)
    str_list.append(f"const char *candidates[] = {{{candidates_list}}};\n")

    expected_bools = ["1" if c in expected else "0" for c in candidates]
    str_list.append(f"const int expected[{num_candidates}] = {{{', '.join(expected_bools)}}};\n")
    str_list.append(f"int result[{num_candidates}] = {{0}};\n")
    str_list.append("\n")
    str_list.append(f"find_anagrams(\"{subject}\", candidates, {num_candidates}, result);\n")
    str_list.append("\n")
    str_list.append(f"TEST_ASSERT_EQUAL_INT_ARRAY(expected, result, {num_candidates});\n")
    return "".join(str_list)

def describe(case):
    description = case["description"]
    if description in ["allergic to everything", "not allergic to anything"]:
        item = case["input"]["item"]
        return f"{item} {description}"
    return description
