#!/bin/sh

ARCH=silesia.tar.1G

sh comp-zstdmt.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.zst* | sort -r

echo
sh dec-zstdmt.sh
