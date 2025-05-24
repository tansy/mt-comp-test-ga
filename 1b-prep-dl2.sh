#!/bin/sh

echo
echo "######## $0 ########"
echo

[ -f bzip2-1.0.8.tar.gz ] || \
    wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
[ -f pbzip2-1.1.13.tar.gz ] || \
    wget https://launchpad.net/pbzip2/1.1/1.1.13/+download/pbzip2-1.1.13.tar.gz


[ -f pigz-master.tar.gz ] || \
    {
    wget https://github.com/madler/pigz/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz pigz-master.tar.gz
    }


[ -f lzlib-1.15.tar.gz ] || \
    wget http://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.15.tar.gz

[ -f plzip-1.12.tar.gz ] || \
    wget http://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.12.tar.gz


[ -f xz-master.tar.gz ] || \
    {
    wget https://github.com/tukaani-project/xz/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz xz-master.tar.gz
    }

[ -f libarchive-3.4.2.tar.gz ] || \
    {
    wget http://www.libarchive.org/downloads/libarchive-3.4.2.tar.gz
    }
[ -f pixz-master.tar.gz ] || \
    {
    wget https://github.com/vasi/pixz/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz pixz-master.tar.gz
    }

[ -f zstd-dev.tar.gz ] || \
    {
    wget https://github.com/facebook/zstd/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz zstd-dev.tar.gz
    }

[ -f zstdmt-master.tar.gz ] || \
    {
    wget https://github.com/mcmilk/zstdmt/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz zstdmt-master.tar.gz
    }

[ -f lbzip2-master.tar.gz ] || \
    {
    wget https://github.com/kjn/lbzip2/archive/refs/heads/master.tar.gz && \
    mv master.tar.gz lbzip2-master.tar.gz

    ARC1="http://mirrors.slackware.com/slackware/slackware-current/slackware/a/lbzip2-2.5-i586-4.txz"
    ARC2="http://mirrors.slackware.com/slackware/slackware64-current/slackware64/a/lbzip2-2.5-x86_64-4.txz"
    ARCH=`arch`
    if [ "$ARCH" == "x86_64" ]
        then ARC="$ARC2"
        else ARC="$ARC1"
    fi
    F=`basename "$ARC"`
    [ -f "$F" ] || wget "$ARC"
    }

