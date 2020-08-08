# os_from_scratch
Fresh start of os_dev using https://github.com/cfenollosa/os-tutorial

## 11-kernel-crosscompiler

### GOAL: Create a development enviornment to build your kernel

For now this step can probably be skipped but a cross-compiler will be needed in the future when jumping to higher level languages.

[Why do I need a cross-compiler](https://wiki.osdev.org/Why_do_I_need_a_Cross_Compiler)

Instructions are adapted from the [OSDev wiki](https://wiki.osdev.org/GCC_Cross-Compiler)

#### Required packages

Install required packages
 * gmp
 * mpfr
 * libmpc
 * gcc

We need `gcc` to build a cross-compiled `gcc`.

Once installed, find where `gcc` is (`which `gcc`) and export it:
```
export CC=/usr/bin/cc
export LD=/usr/bin/cc
```

We will need to build binutils and a cross-compiled gcc which we will put in `/usr/local/i386elfgcc`, so let's export some paths now.
Feel free to change
```
export PREFIX="/usr/local/i386elfgcc"
export TRAGET=i386-elf
export PATH="$PREFIX/bin:$PATH"
```

##### binutils
```
mkdir /tmp/src
cd /tmp/src
curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz # If the link 404's, look for a more recent version
tar xf binutils-2.35.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-2.35/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX --with-sysroot 2>&1 | tee configure.log
make all install 2>&1 | tee make.log
```

##### gcc
`
cd /tmp/src
curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
tar xf gcc-10.2.0.tar.gz
mkdir gcc-build
cd gcc-build
../gcc-10.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
make all-gcc 
make all-target-libgcc 
make install-gcc 
make install-target-libgcc
```

That's it! You should have all the GNU binutils and the compiler at /usr/local/i386elfgcc/bin, prefixed by i386-elf- to avoid collisions with your system's compiler and binutils.

You may want to add the $PATH to your .bashrc. From now on, on this tutorial, we will explicitly use the prefixes when using the cross-compiled gcc.

### Notes

I got stuck trying to compile all-target-libgcc

`configure: error: cannot compute suffix of object files: cannot compile`

I tried loads of things, the one thing that seemed to work was compiling binutils with the `--with-sysroot` flag mentioned [here](https://wiki.osdev.org/GCC_Cross-Compiler#Installing_Dependencies) 
