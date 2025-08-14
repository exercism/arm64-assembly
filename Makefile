# This makefile creates a target to build and test each exercise using the provided example
# implementation. The exercise target depends on a list of other targets that
#   1) Copy the main test file and adjust it to include all tests,
#   2) Copy the example implementation so that it is used,
#   3) Copy the Makefile and unittest framework,
#   4) Build and test the exercise.
#
# Use `make [slug]` to build and test a specific exercise. Simply running `make` builds and
# tests all available exercises.


# Macro to create the rules for one exercise.
# Arguments:
#   $(1) - slug
#   $(2) - slug with dashes replaced by underscores
define setup_practice_exercise

# Copy the test file and removes TEST_IGNORE
build/exercises/practice/$(1)/$(2)_test.c: exercises/practice/$(1)/$(2)_test.c
	@mkdir -p $$(dir $$@)
	@sed 's#TEST_IGNORE();#// &#' $$< > $$@

# Copy example implementation
build/exercises/practice/$(1)/$(2).s: exercises/practice/$(1)/.meta/example.s
	@mkdir -p $$(dir $$@)
	@cp $$< $$@

# Copy Makefile
build/exercises/practice/$(1)/Makefile: exercises/practice/$(1)/Makefile
	@mkdir -p $$(dir $$@)
	@cp $$< $$@

# Copy the test framework
build/exercises/practice/$(1)/vendor: $(wildcard exercises/practice/$(1)/vendor/*)
	mkdir -p $$@
	cp exercises/practice/$(1)/vendor/* build/exercises/practice/$(1)/vendor/

# Build and test the exercise.
build/exercises/practice/$(1)/tests: \
		build/exercises/practice/$(1)/$(2)_test.c \
		build/exercises/practice/$(1)/$(2).s \
		build/exercises/practice/$(1)/Makefile \
		build/exercises/practice/$(1)/vendor
	$$(MAKE) -C build/exercises/practice/$(1)

# Top-level target for an exercise. The target above always runs the executable, regardless of any
# changes. Having the tests binary as a separate target in between allows make to skip anything
# that hasn't changed.
$(1): build/exercises/practice/$(1)/tests

endef

PRACTICE_EXERCISES := $(notdir $(wildcard exercises/practice/*))

all: $(PRACTICE_EXERCISES)

# Instantiate the macro for each practice exercise to create targets for each exercise.
$(foreach exercise,$(PRACTICE_EXERCISES),$(eval $(call setup_practice_exercise,$(exercise),$(subst -,_,$(exercise)))))

list-practice:
	@for exercise in $(PRACTICE_EXERCISES); do \
		echo "$$exercise"; \
	done

clean:
	rm -rf build

help:
	@echo "Available targets:"
	@echo "  all            - Build and test all practice exercises (default)"
	@echo "  <slug>         - Build and test a specific exercise given by its slug"
	@echo "  clean          - Remove all build artifacts"
	@echo "  list-practice  - List all practice exercises"
	@echo "  help           - Show this help message"

.PHONY: all clean help
