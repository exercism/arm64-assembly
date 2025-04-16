# Installation

## Debian / Ubuntu

gcc and make can be installed using

```shell
sudo apt install gcc make
```

If you are not running on ARM64 hardware, install the [QEMU][] emulator and the GCC ARM64 cross-toolchain using

```shell
sudo apt install qemu-user gcc-aarch64-linux-gnu
```

## Windows

Use [Windows Subsystem for Linux][], or set up a Linux virtual machine.

## macOS

A Linux virtual machine can be launched using any suitable virtualization solution (e.g., [Lima][]).

[QEMU]: https://www.qemu.org/
[Windows Subsystem for Linux]: https://docs.microsoft.com/en-gb/windows/wsl/about
[Lima]: https://lima-vm.io/
