AS = aarch64-linux-gnu-as
CC = aarch64-linux-gnu-gcc

CFLAGS = -g -Wall -Wextra -pedantic -Werror
LDFLAGS =

ALL_LDFLAGS = -pie -Wl,--fatal-warnings

ALL_CFLAGS = -std=c99 -fPIE $(CFLAGS)
ALL_LDFLAGS += $(LDFLAGS)

C_OBJS = $(patsubst %.c,%.o,$(wildcard *.c))
AS_OBJS = $(patsubst %.s,%.o,$(wildcard *.s))
ALL_OBJS = $(filter-out example.o,$(C_OBJS) $(AS_OBJS) vendor/unity.o)

CC_CMD = $(CC) $(ALL_CFLAGS) -c -o $@ $<

PLATFORM = $(shell uname -m)
ifeq ($(PLATFORM),aarch64)
	MAYBE_QEMU =
else
	MAYBE_QEMU = qemu-aarch64 -L /usr/aarch64-linux-gnu
endif

all: tests
	@$(MAYBE_QEMU) ./$<

tests: $(ALL_OBJS)
	@$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $(ALL_OBJS)

%.o: %.s
	@$(AS) -o $@ $<

%.o: %.c
	@$(CC_CMD)

vendor/unity.o: vendor/unity.c vendor/unity.h vendor/unity_internals.h
	@$(CC_CMD)

clean:
	@rm -f *.o vendor/*.o tests

.PHONY: all clean
