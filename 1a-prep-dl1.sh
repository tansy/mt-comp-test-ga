#!/bin/sh

NULLDEV=/dev/null
#NULLDEV=nul # windows

echo
echo "######## $0 ########"
echo

ARC="silesia.tar"
[ -f $ARC ] || \
    wget https://github.com/DataCompression/corpus-collection/raw/main/Silesia-Corpus/silesia.tar.gz && \
    pigz -dk $ARC

ARC2=$ARC.1G
[ -f $ARC2 ] || \
    (
    ln -s $ARC s
    cat s s s s s s | head -c $((2**30)) > $ARC2
    )

cat $ARC2 > $NULLDEV
