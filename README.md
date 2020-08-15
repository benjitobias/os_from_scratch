# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 14-checkpoint

### GOAL: Organise our code a little bit and then learn how to debug the kernel with gdb

At this point we techincally have a kernel running even if it only prints 'X'. Now it is time to stop for a moment and organise the code into folders, create a scalable Makefile for future code and think strategy.

Since most code from here will be C, we'll take advantage of qemu's ability to open a connection to gdb. First let's installed a cross-compiled gdb.

```
cd /tmp/src
curl -O http://ftp.rediris.es/mirror/GNU/gdb/gdb-9.2.tar.xz
tar xf gdb-9.2.tar.xz
mkdir gdb-build
cd gdb-build
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
../gdb-9.2/configure --target="$TARGET" --prefix="$PREFIX" --program-prefix=i386-elf-
make
make install
```

`make debug` in the Makefile builds `kernel.elf` which is an object file (not a binary) with all the symbols we generated on the kernel, thanks to the `-g` flag on gcc. Examine it with `xxd` to see some strings or even better with `strings kernel.elf`

We can take advantage of this cool qemu feature. Type `make debug` and, on the gdb shell:

* Set up a breakpoint in `kernel.c:main()`: `b main`
* Run the OS: `continue`
* Run two steps into the code: `next` then `next`. You will see that we are just about to set the 'X' on the screen, but it isn't there yet (check out the qemu screen)
* Let's see what's in the video memory: `print *video_memory`. There is the 'L' from "Landed in 32-bit Protected Mode"
* Hmmm, let's make sure that `video_memory` points to the correct address: print `video_memory`
* `next` to put there our 'X'
* Let's make sure: print `*video_memory` and look at the qemu screen. It's definitely there.

You may notice that, since this is a tutorial, we haven't yet discussed which kind of kernel we will write. It will probably be a monolithic one since they are easier to design and implement, and after all this is our first OS. Maybe in the future we'll add a lesson "15-b" with a microkernel design. Who knows.

### Notes
I couldn't actually get the gdb that we'd compiled to work properly. I was getting a known error.
Eventually I just installed gdb-multiarm and used that.
On top of that, I ran `qemu-system-i386 -s -S -fda os-image.bin` and then `target remote localhost:1234; symbol-file kernel.elf` in gdb to attach
