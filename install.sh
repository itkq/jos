echo Installing gmp and gcc with homebrew ...
brew install gmp gcc

set -e

export CC=/usr/local/bin/gcc
export LD=/usr/local/bin/gcc

rm -rf /tmp/xv6-build
mkdir /tmp/xv6-build && cd /tmp/xv6-build

echo Installing i386-jos-elf-objdump ...
if ! $(which i386-jos-elf-objdump > /dev/null); then
  curl -OL http://ftpmirror.gnu.org/binutils/binutils-2.21.1.tar.bz2
  tar xjf binutils-2.21.1.tar.bz2
  cd binutils-2.21.1
  ./configure --prefix=/usr/local --target=i386-jos-elf --disable-werror
  make
  sudo make install
  i386-jos-elf-objdump -i
  cd ..
else
  echo i386-jos-elf-objdump is already installed.
fi

echo Installing i386-jos-elf-gcc ...
if ! $(which i386-jos-elf-gcc >/dev/null); then
  curl -OL http://ftpmirror.gnu.org/gcc/gcc-4.5.1/gcc-core-4.5.1.tar.bz2
  cd gcc-4.5.1
  mkdir build
  cd build
  ../configure --prefix=/usr/local \
      --target=i386-jos-elf --disable-werror \
      --disable-libssp --disable-libmudflap --with-newlib \
      --without-headers --enable-languages=c \
      --with-gmp=/usr/local --with-mpfr=/usr/local --with-mpfr=/usr/local
  make all-gcc
  sudo make install-gcc
  make all-target-libgcc
  sudo make install-target-libgcc
  i386-jos-elf-gcc -v
  cd ../..
else
  echo i386-jos-elf-gcc is already installed.
fi

echo Installing i386-jos-elf-gdb ...
if ! $(which i386-jos-elf-gdb >/dev/null); then
  curl -OL http://ftpmirror.gnu.org/gdb/gdb-7.3.1.tar.bz2
  tar xjf gdb-7.3.1.tar.bz2
  cd gdb-7.3.1
  ./configure --prefix=/usr/local --target=i386-jos-elf --program-prefix=i386-jos-elf- \
    --disable-werror
  make all
  sudo make install
else
  echo i386-jos-elf-gdb is already installed.
fi

echo All done!
