
# Kernel-Compiler

A simple modified forked script to compile a minimalistic linux kernel with busybox support.



## Appendix

For Manjaro and Arch users install only:

Change line 20 

make defconfig >> make CC=musl-gcc

Requirements Only For Arch and Manjaro users:

sudo pacman -S musl kernel-headers-musl

## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.


## Deployment

To deploy this project run

```bash
  sudo ./kernel_compiler_with_busybox.sh
```

