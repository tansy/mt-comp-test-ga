#!/bin/sh

#cd lbzip2-master

sh build-aux/autogen.sh || ( sed -i~ 's/AC_PREREQ..2.63../AC_PREREQ\(\[2.64\]\)/' configure.ac && sh build-aux/autogen.sh )

libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
autoreconf -i
./configure
make -j && cp ./src/lbzip2 ../lbzip2
