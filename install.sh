set -e

brew install gmp mpfr libmpc
brew install gcc4.9

export CC=/usr/local/bin/gcc-4.9
export LD=/usr/local/bin/gcc-4.9

mkdir /tmp/xv6-build
cd /tmp/xv6-build

wget http://ftpmirror.gnu.org/binutils/binutils-2.21.1.tar.bz2
tar xjf binutils-2.21.1.tar.bz2
cd binutils-2.21.1
./configure --prefix=/usr/local --target=i386-jos-elf --disable-werror
make
sudo make install
cd ..
i386-jos-elf-objdump -i

wget http://ftpmirror.gnu.org/gcc/gcc-4.5.1/gcc-core-4.5.1.tar.bz2
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
cd ../..
i386-jos-elf-gcc -v

wget http://ftpmirror.gnu.org/gdb/gdb-7.3.1.tar.bz2
tar xjf gdb-7.3.1.tar.bz2
cd gdb-7.3.1
./configure --prefix=/usr/local --target=i386-jos-elf --program-prefix=i386-jos-elf- \
    --disable-werror
make all
sudo make install
