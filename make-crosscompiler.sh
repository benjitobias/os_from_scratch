#!/bin/bash

CC=/usr/bin/cc
LD=/usr/bin/cc

PREFIX="/usr/local/i386elfgcc"
TARGET=i386-elf
PATH="$PREFIX/bin:$PATH"

CWD=$(pwd)


echo "[#] Making and entering /tmp/src comlile directory"
mkdir /tmp/src
cd /tmp/src

echo "[#] Making binutils-2.35"
curl -O https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz
tar xf binutils-2.35.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-2.35/configure --target=$TARGET --enable-inetwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX --with-sysroot 2>&1 | tee configure.log
make all install 2>&1 | tee make.log

echo "[#] Making gcc-10.2.0"
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

read -p "[?] Update ~/.bash PATH? [y]/n " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "[#] Updating PATH in ~/.bash"
    echo "export PATH=$PATH" >> ~/.bashrc
fi
cd $CWD
