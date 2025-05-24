#!/bin/sh

ARCH=silesia.tar.1G

sh comp-bzip2_w32.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.bz2* | sort -r

echo
sh dec-bzip2_w32.sh

echo "####"
sh comp-bzip2_w64.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.bz2* | sort -r

echo
sh dec-bzip2_w64.sh
