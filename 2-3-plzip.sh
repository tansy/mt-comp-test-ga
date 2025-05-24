#!/bin/sh

ARCH=silesia.tar.1G

sh comp-plzip.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.lz* | sort -r

echo
sh dec-plzip.sh
