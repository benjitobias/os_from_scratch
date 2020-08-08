#!/bin/bash
CWD = $(pwd)
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
cd $CWD
