#!/bin/sh

NPROC=$(command -v nproc)
NCPU=$($NPROC)
[ $((NCPU)) -gt 1 ] || NCPU=1

USE_SYS_PROGS=1
#EXEX=.exe
UNAME=Linux # UNAME=$(uname); if [ "${UNAME:0:5}" = "MINGW" ]; then EXEX=.exe; fi
MT_TEST_PWD=$(pwd)

usage_dl2()
{
    echo "file $1 not found; donwloading with 1b-prep-dl2.sh"
    ./1b-prep-dl2.sh
}

echo
echo "######## $0 ########"
echo

## bzip2
FIN=bzip2-1.0.8.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    make -j$NCPU && cp bzip2$EXEX ../
)
BZIP2_DIR=$DIR

## pbzip2
FIN=pbzip2-1.1.13.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    make -j$NCPU LDLIBS=$MT_TEST_PWD/$BZIP2_DIR/libbz2.a && \
        cp pbzip2$EXEX ../
)


## pigz
FIN=pigz-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    make -j$NCPU && cp pigz$EXEX ../
)

## pixz
FIN=pixz-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./autogen.sh
        ./configure --without-manpage
    fi
    make -j$NCPU && cp src/pixz$EXEX ../
)

## plzip
PAK=plzip
#if [ -z $(command -v $PAK) ] || [ $((USE_SYS_PROGS)) -eq 0 ]; then
if true; then

FIN=lzlib-1.15.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./configure
    fi
    make -j$NCPU
)
LZLIB=$DIR

FIN=plzip-1.12.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./configure CPPFLAGS=-I../$LZLIB LDFLAGS=-L../$LZLIB
    fi
    make -j$NCPU && cp plzip$EXEX ../
)
else
    cp $(which $PAK) .
fi
unset PAK


## xz
PAK=xz
if [ -z $(command -v $PAK) ] || [ $((USE_SYS_PROGS)) -eq 0 ]; then

FIN=xz-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./autogen.sh && \
        ./configure
    fi
    make -j$NCPU && cp src/xz/.libs/xz$EXEX ../
)
else
    cp $(which xz) .
fi
unset PAK


## libarchive

FIN=libarchive-3.4.2.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"

DIR=${FIN%%.tar.gz}
LIBARCHIVE_DIR=$DIR
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./configure
    fi
    make -j$NCPU
)


## pixz
PAK=pixz
if [ -z $(command -v $PAK) ] || [ $((USE_SYS_PROGS)) -eq 0 ]; then

FIN=pixz-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"

DIR=${FIN%%.tar.gz}
(
    cd "$DIR"
    if [ ! -f config.status ]; then
        ./autogen.sh && \
        ./configure --without-manpage --includedir=$MT_TEST_PWD/xz-master/src/liblzma/api/lzma.h
    fi
    make -j$NCPU LZMA_LIBS=$MT_TEST_PWD/xz-master/src/liblzma/.libs/liblzma.a LIBARCHIVE_LIBS=$MT_TEST_PWD/$LIBARCHIVE_DIR/.libs/libarchive.a && \
        cp src/pixz$EXEX ../
)
else
    cp $(which xz) .
fi
unset PAK


## zstd-mt
FIN=zstd-dev.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
ZSTD=$DIR
(
    cd "$DIR/lib"
    make -j$NCPU
)

FIN=zstdmt-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
(
    cd "$DIR/programs"
    ln -s ../../$ZSTD zstd
    make zstd-mt LIBZSTD=zstd/lib/libzstd.a -j$NCPU && cp zstd-mt$EXEX ../../
)


## zstd
PAK=zstd
if [ -z $(command -v $PAK) ] || [ $((USE_SYS_PROGS)) -eq 0 ]; then
#
FIN=zstd-dev.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
ZSTD=$DIR
(
    cd "$DIR/programs"
    make zstd HAVE_LZ4=0 HAVE_LZMA=0 HAVE_ZLIB=0 NO_LZ4_MSG=1 NO_ZLIB_MSG=1 NO_LZMA_MSG=1 -j$NCPU && cp zstd$EXEX ../../
)
else
    cp $(which zstd) .
fi
unset PAK

## lbzip2
PAK=lbzip2
if [ -z $(command -v $PAK) ] || [ $((USE_SYS_PROGS)) -eq 0 ]; then
#

ARC1="http://mirrors.slackware.com/slackware/slackware-current/slackware/a/lbzip2-2.5-i586-4.txz"
ARC2="http://mirrors.slackware.com/slackware/slackware64-current/slackware64/a/lbzip2-2.5-x86_64-4.txz"
ARCH=$(arch)
if [ "$ARCH" = "x86_64" ]
    then ARC="$ARC2"
    else ARC="$ARC1"
fi
F=$(basename "$ARC")
[ -f "$F" ] || wget "$ARC"

tar -x -Ixz -f "$F" usr/bin/lbzip2
mv usr/bin/lbzip2 lbzip2 && rm -Rf usr

./lbzip2 -V > /dev/null
ret=$?
if [ $ret -eq 0 ]; then
    true
else
rm ./lbzip2

FIN=lbzip2-master.tar.gz
printf "\n## $FIN ##\n\n"
[ -f "$FIN" ] || usage_dl2 "$FIN"
tar xzf "$FIN"
DIR=${FIN%%.tar.gz}
LBZIP2=$DIR
(
    #unzip -q lbzip2-master-ac-1.zip
    cd "$DIR"
    lbzip2-autoconf-make.sh
)
fi

else
    cp $(which lbzip2) .
fi
unset PAK

