FUNC_PROTO = """\
#include "vendor/unity.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define BUFFER_SIZE 16

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

extern size_t append(int64_t *buffer, const int64_t *list1, size_t list1_count, const int64_t *list2, size_t list2_count);
extern size_t filter(int64_t *buffer, const int64_t *list, size_t list_count, bool (*function)(int64_t));
extern size_t map(int64_t *buffer, const int64_t *list, size_t list_count, int64_t (*function)(int64_t));
extern int64_t foldl(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t));
extern int64_t foldr(const int64_t *list, size_t list_count, int64_t initial, int64_t (*function)(int64_t, int64_t));
extern size_t reverse(int64_t *buffer, const int64_t *list, size_t list_count);

static bool is_odd(int64_t x) {
    return x % 2 == 1;
}

static int64_t plus_one(int64_t x) {
    return x + 1;
}

static int64_t multiply(int64_t acc, int64_t el) {
    return el * acc;
}

static int64_t add(int64_t acc, int64_t el) {
    return el + acc;
}

static int64_t divide(int64_t acc, int64_t el) {
    return acc == 0 ? 0 : el / acc;
}
"""

def array_literal(digits):
    return '{' + ', '.join(str(d) for d in digits) + '}'

def describe(case):
    description = case["description"]
    property = case["property"]
    return f"{property} {description}"

def gen_func_body(prop, inp, expected):
    str_list = []

    if prop in ['foldl', 'foldr']:
        initial = inp['initial']

    function = None
    if prop not in ['append', 'reverse']:
        function = inp['function']
        if function == "(x) -> x modulo 2 == 1":
            function = 'is_odd'
        if function == "(x) -> x + 1":
            function = 'plus_one'

        if function == "(acc, el) -> el * acc":
            function = 'multiply'
        if function == "(acc, el) -> el + acc":
            function = 'add'
        if function == "(acc, el) -> el / acc":
            function = 'divide'

    if prop == 'append':
        list1 = inp['list1']
        list2 = inp['list2']
        if len(list1) > 0:
            str_list.append(f'const int64_t list1[] = {array_literal(list1)};\n')
            list1_with_count = 'list1, ARRAY_SIZE(list1)'
        else:
            list1_with_count = 'NULL, 0'
        if len(list2) > 0:
            str_list.append(f'const int64_t list2[] = {array_literal(list2)};\n')
            list2_with_count = 'list2, ARRAY_SIZE(list2)'
        else:
            list2_with_count = 'NULL, 0'
    else:
        list_ = inp['list']
        if function == 'divide':
            initial = 5
            list_ = [2, 5]
            if prop == 'foldl':
                expected = 0
            else:
                expected = 2

        if len(list_) > 0:
            str_list.append(f'const int64_t list[] = {array_literal(list_)};\n')
            list_with_count = 'list, ARRAY_SIZE(list)'
        else:
            list_with_count = 'NULL, 0'

    if prop == 'append':
        str_list.append('int64_t buffer[BUFFER_SIZE];\n')
        call = f'{prop}(buffer, {list1_with_count}, {list2_with_count})'

    if prop in ['filter', 'map']:
        str_list.append('int64_t buffer[BUFFER_SIZE];\n')
        call = f'{prop}(buffer, {list_with_count}, {function})'

    if prop in ['foldl', 'foldr']:
        call = f'{prop}({list_with_count}, {initial}, {function})'

    if prop == 'reverse':
        str_list.append('int64_t buffer[BUFFER_SIZE];\n')
        call = f'{prop}(buffer, {list_with_count})'

    if isinstance(expected, list):
        if len(expected) == 0:
            str_list.append(f'TEST_ASSERT_EQUAL_UINT(0U, {call});\n')
        else:
            expected = array_literal(expected)
            str_list.append(f'const int64_t expected[] = {expected};\n')
            str_list.append(f'TEST_ASSERT_EQUAL_UINT(ARRAY_SIZE(expected), {call});\n')
            str_list.append(f'TEST_ASSERT_EQUAL_INT64_ARRAY(expected, buffer, ARRAY_SIZE(expected));\n')
    else:
        str_list.append(f'TEST_ASSERT_EQUAL_INT({expected}, {call});\n')

    return ''.join(str_list)
