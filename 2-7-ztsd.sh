#!/bin/sh

ARCH=silesia.tar.1G

sh comp-zstd.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.zst* | sort -r

echo
sh dec-zstd.sh
