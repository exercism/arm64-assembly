# Exercism ARM64 Assembly Track

[![Build Status](https://travis-ci.org/exercism/arm64-assembly.svg?branch=master)](https://travis-ci.org/exercism/arm64-assembly)

Exercism exercises in ARM64 Assembly.

## TODO

### The Profile (A, R, or M)

What ARM64/ARMv8/AArch64 profile are we using? Probably should be A-profile.

### The Core

What core will we run in the test runner?

Many ARM64 cores are different, like the [Cortex-A53](https://www.arm.com/products/silicon-ip-cpu/cortex-a/cortex-a53) compared to other cores. Probably could use that one as a basis for the runner, or the [Cortex-A72](https://www.arm.com/products/silicon-ip-cpu/cortex-a/cortex-a72).

### Scratchpad

- https://qemu.readthedocs.io/en/latest/system/arm/virt.html (A53 and A72 are supported for theoretical QEMU/GDB based tests)

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data)