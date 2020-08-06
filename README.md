# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 06-bootsector-segmentation

### Goal: Learn how to address 16-bit real mode segmentation
We did segmentation with [org] on lesson 3. Segmentation means that you can specify an offset to all the data you refer to.

Special registers `cs`, `ds`, `ss` and `es` for Code, Data, Stack and Extra (i.e user-defined)

Beware: they are _implicitly_ used by the CPU, so once you set some value for, say, ds, then all your memory access will be offset by ds. [Read more here](https://wiki.osdev.org/Segmentation)

Furthermore, to compute the real address we don't just join the two addresses, but we _overlap_ them: `segment << 4 + address`. For example, if `ds` is `0x4d`, then `[0x20]` actually refers to `0x4d0 + 0x20 = 0x4f0`

We cannot `mov` literals to those registers, a general purpose register must be used
### Notes

