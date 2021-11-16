# Installation

Install the essential build tools, the QEMU emulator, and the GCC ARM64 cross-toolchain to test your code.

```shell
sudo apt install build-essential qemu-user qemu-user-static binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu
```

The makefile in the exercise directory should be able to handle the rest.

## Special note for Windows users

Use Windows Subsystem for Linux 2 with an Ubuntu image to do the same steps listed above.