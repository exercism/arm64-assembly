# Installation

## Ubuntu

The essential build tools can be installed using

```shell
sudo apt install build-essential
```

If you are not running on ARM64 hardware, install the [QEMU][] emulator and the GCC ARM64 cross-toolchain using

```shell
sudo apt install qemu-user qemu-user-static binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu
```

## Windows

Use [Windows Subsystem for Linux][] with an Ubuntu image, or set up a Linux virtual machine.

## macOS

A Linux virtual machine can be launched using [Lima][].

[QEMU]: https://www.qemu.org/
[Windows Subsystem for Linux]: https://docs.microsoft.com/en-gb/windows/wsl/about
[Lima]: https://lima-vm.io/
